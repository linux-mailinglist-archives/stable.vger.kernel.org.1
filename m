Return-Path: <stable+bounces-14976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE348384AA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E851B23DC7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38DA62817;
	Tue, 23 Jan 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iEDbwyeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251562806;
	Tue, 23 Jan 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974962; cv=none; b=l0RCH/MWpCCZH4F+d6+8HyyoWBu9GQu4eYAG489vyDPwlJmlg/NbEJpCqjBxyr8XKmopIi/AVVMgDdhNhip5pICUq4RRkbMSyfJA+vq3ypAqiO7WMuJQbO8pPMqvx47Foq3BIAaStDAGsFbATDjtI3lXQ47ti5Z61W9poOPzJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974962; c=relaxed/simple;
	bh=eFK6QNCx+gc09KdgvD8FtJ/dlskP+TTF705f88xQrT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R21pHhtmnatJ8P+7t713XYo4AbLv+MthEuMhwZGfoHq5/m5nrKh8jY2oNhpKAG3I2t3PPE9cMTkA0+YjDvkhvjgTFMpwCkn/djbIk7rDsmoX1Y7hb8u4EHoXUsEhekt6HiUDvZdEalQleeQIah0ERfeEqDKe9NiLyg7kMjvJpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iEDbwyeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752E7C433C7;
	Tue, 23 Jan 2024 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974962;
	bh=eFK6QNCx+gc09KdgvD8FtJ/dlskP+TTF705f88xQrT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEDbwyehAxI4qqJ4CAQCSygQmWnKpYRdcZURbwANF6RIK8s4vkWVcwSFl97ph8hsB
	 xlcmU3LT1/0risX1W91usNQOAOUOl21Ko7OnqCW4nl663EvLkORnqfAIwSSl/t5MGb
	 96s9uCj6+zC5CdWocBLfjj5A4sJZ5RRMEt6VlNzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joakim Zhang <joakim.zhang@cixtech.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 170/583] dma-mapping: clear dev->dma_mem to NULL after freeing it
Date: Mon, 22 Jan 2024 15:53:41 -0800
Message-ID: <20240122235817.231188911@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Zhang <joakim.zhang@cixtech.com>

[ Upstream commit b07bc2347672cc8c7293c64499f1488278c5ca3d ]

Reproduced with below sequence:
dma_declare_coherent_memory()->dma_release_coherent_memory()
->dma_declare_coherent_memory()->"return -EBUSY" error

It will return -EBUSY from the dma_assign_coherent_memory()
in dma_declare_coherent_memory(), the reason is that dev->dma_mem
pointer has not been set to NULL after it's freed.

Fixes: cf65a0f6f6ff ("dma-mapping: move all DMA mapping code to kernel/dma")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/coherent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..ff5683a57f77 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -132,8 +132,10 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 void dma_release_coherent_memory(struct device *dev)
 {
-	if (dev)
+	if (dev) {
 		_dma_release_coherent_memory(dev->dma_mem);
+		dev->dma_mem = NULL;
+	}
 }
 
 static void *__dma_alloc_from_coherent(struct device *dev,
-- 
2.43.0




