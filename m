Return-Path: <stable+bounces-213786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHg4Ialmg2nQmQMAu9opvQ
	(envelope-from <stable+bounces-213786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E839E8D59
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4E83301651E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E68423168;
	Wed,  4 Feb 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEHyXQDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF82D4B68;
	Wed,  4 Feb 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217506; cv=none; b=sMoPLbrDe7Fr3wvPC42+ucbBgQ3M34w3hzcwvMozOJU27/HO0Naf/eoht1HU7AVfla3nCKcqLhmVbz0HUAV2zfKlcVXD9j/c1rKwuUx1BtNvMtAVayHMP4gclBsVJCv8cB/YU/Ot/RMfvzj3KLH7uOG0a/kTN3ajg+ZGCKg+GKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217506; c=relaxed/simple;
	bh=CXiFkfg8bnJcx624FXdyKOa+jDmugCObGK8wXeLjsLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK2zxZSBYsTVNJA/9sIrBWvLP0yrPZPq5BIsNLbC2Ymhjfgvf1TN6O3CgmBvLeo8nIghuXV8VsCfd1zJ2C33kMwroYau1X+yWhG/zaa89lgpUYax5EjKnZyBSQG/yB/rbu0TEQ/Y3LFsHWPWiAVy/j8uyPtG7qqCLm07QPYo5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEHyXQDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F1AC116C6;
	Wed,  4 Feb 2026 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217506;
	bh=CXiFkfg8bnJcx624FXdyKOa+jDmugCObGK8wXeLjsLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEHyXQDBS50NURf2Xa64IrwXDmhXuGcoiEvNHJQAsWYgryWa6H2GEi6jWE8YG5mHt
	 +TN9X8FTuSMp1Qp//olXoxMjFKHp8MmuydwjzQYzIhqCM3VdYywWYpjCUKjloeLn+3
	 INM9iGb91xTG2UzP29ztbEPU+uxzWMeaYZGB0Ywg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/280] dmaengine: omap-dma: fix dma_pool resource leak in error paths
Date: Wed,  4 Feb 2026 15:36:49 +0100
Message-ID: <20260204143910.901339386@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213786-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,iscas.ac.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E839E8D59
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 2e1136acf8a8887c29f52e35a77b537309af321f ]

The dma_pool created by dma_pool_create() is not destroyed when
dma_async_device_register() or of_dma_controller_register() fails,
causing a resource leak in the probe error paths.

Add dma_pool_destroy() in both error paths to properly release the
allocated dma_pool resource.

Fixes: 7bedaa553760 ("dmaengine: add OMAP DMA engine driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20251103073018.643-1-vulab@iscas.ac.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/omap-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 27f5019bdc1ed..7755a79b429f4 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1811,6 +1811,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
+		if (od->ll123_supported)
+			dma_pool_destroy(od->desc_pool);
 		omap_dma_free(od);
 		return rc;
 	}
@@ -1826,6 +1828,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
 			dma_async_device_unregister(&od->ddev);
+			if (od->ll123_supported)
+				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
 		}
 	}
-- 
2.51.0




