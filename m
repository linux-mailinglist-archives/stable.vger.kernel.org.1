Return-Path: <stable+bounces-75559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F1973523
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D0E1F25EE9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B51190056;
	Tue, 10 Sep 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aKGyUEmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60A18FC9F;
	Tue, 10 Sep 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965087; cv=none; b=lPQjzEo0tjqNm+/03VSKPLVGCn66/xDlJ1jJJjAWA/chlChAl2FbPQuCffubmHYLlP7ucK6jlLW238mvXIL+k/eEqu/5WB5uWgQ1tvRaPMMGZeYVxc/8hTygrBfViryxgbQYcuXcHJOaR+/1fLgHs8ruh6C9XMWMjSpoUMPINao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965087; c=relaxed/simple;
	bh=IBBnYYlfsny63xncUVgp1fJnKZeSvUQYxU32GyKrlgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juROkmt/tCpaiA6orJchicYKMBH2TaCOanu/2Hf4UxfSkXdn1EYAYYuMYHrvgTfh2QkOcG8/piMJWPlR5OmLZ44djaKoYFBHgfxhI7glNtcbSNGnkEcmC0zNSV7wJqhHaKlKO6b4Thz8q/D5OP/o2zbCSkwbf3s7xSWLomgY9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aKGyUEmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E3C4CEC3;
	Tue, 10 Sep 2024 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965087;
	bh=IBBnYYlfsny63xncUVgp1fJnKZeSvUQYxU32GyKrlgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKGyUEmPcI/29z3JHC17ci+b60dajExFPQBZNnAuK2AjfyFQKSD5mtaVBTHSAxYWE
	 qluY4jj1LDDDc7QsTpRir31+IRblGKQq9Z5ynuLMcK4srZe5n9hmFVO1250vXE7H7x
	 A2PCZiJnCFLagFe7gD4zWtz4UCBc1snb2MMofs2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/186] devres: Initialize an uninitialized struct member
Date: Tue, 10 Sep 2024 11:33:48 +0200
Message-ID: <20240910092600.065240991@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 56a20ad349b5c51909cf8810f7c79b288864ad33 ]

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 8a74008c13c4..e3a735d0213a 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -577,6 +577,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0




