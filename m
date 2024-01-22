Return-Path: <stable+bounces-14580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8AD83817D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ACB28D98E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A232110A;
	Tue, 23 Jan 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIhKyUuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6827E9;
	Tue, 23 Jan 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972146; cv=none; b=jxUW2KWRh/LRKsNvs7AfLI0eNNa53tCaayeA5ly8pqPDeCtNJiAfk8rb3dfHPeaX1f8pYWQ9vvVd4f17FN94FFDR6jgiOQqWl/0WIVoJZ7wL9JBQV+DmKD6Kup0yJFNRVMlQhvunSCV3uFc4dE+X+A1+C4/nIuC9Kf7dxobvy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972146; c=relaxed/simple;
	bh=YfEPMrL6/6f+PIakmXTzqL7sRyem2aTqhf/D+GPpl1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbxJJk0nON+Ju2VrEVNxxt1Sqoc6iXUs+TQXHaXP316ML/cbQ9ne8n+vBDVMFM1lurCbM7c7hBYXrJ80VL5VXv6kYk8pcf8CrxIrLRG/3KDm32bS2T+qzXj34ct54znQidX8dhHWgxn+FlGIkyjM49hW/vr1SEWFgVSCGLVRDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIhKyUuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A2C433C7;
	Tue, 23 Jan 2024 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972146;
	bh=YfEPMrL6/6f+PIakmXTzqL7sRyem2aTqhf/D+GPpl1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIhKyUuUbVGqGMnzdGecKtdkM34FDXPxZ7d3nIuzxk2PqMJQ5G7gzZEY+O8Nz2Ubi
	 myRmi2gC5tSEESMawZ+Wv4smX/qZ5Nt/pHvQP3pRcllrXWS0kfANdWdkSC7irHDf9G
	 7zcs8OTgctw/C9/nXXdwhLoyRO34tZ9jnQ0adQhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 075/374] powerpc/powernv: Add a null pointer check in opal_event_init()
Date: Mon, 22 Jan 2024 15:55:31 -0800
Message-ID: <20240122235747.228746641@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 8649829a1dd25199bbf557b2621cedb4bf9b3050 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 2717a33d6074 ("powerpc/opal-irqchip: Use interrupt names if present")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231127030755.1546750-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index d55652b5f6fa..391f50535200 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -275,6 +275,8 @@ int __init opal_event_init(void)
 		else
 			name = kasprintf(GFP_KERNEL, "opal");
 
+		if (!name)
+			continue;
 		/* Install interrupt handler */
 		rc = request_irq(r->start, opal_interrupt, r->flags & IRQD_TRIGGER_MASK,
 				 name, NULL);
-- 
2.43.0




