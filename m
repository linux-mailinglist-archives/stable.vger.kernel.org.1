Return-Path: <stable+bounces-210737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLQZAv3EcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:22:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E296856AEF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2B179A9B42
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689783446DE;
	Wed, 21 Jan 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFPtUGSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082392BE057
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997754; cv=none; b=TRQFgfy026cyjiXklOgk8gcqvfICR71e0qMiUgU9SgNaecFLjMsKrlJtuAukdhLNfXpF4mWMQrxlTyCT7Ba/86XHflc1m69TKHmYZFy42XPy3nzajgB6U2BRmXUJkksGyDWJ3bpouGi+KE/BYKlZ2P5nVtS7vdBjXt6cPYsQ588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997754; c=relaxed/simple;
	bh=+AINEGkwhqDOPKQwtu0hG+f47mL0ba/y19OprUduoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgBlDHKCFojQ8UpzmALB6DK2HPFgS3t0expkVJTtrMgIgCo8Q1smLwB9ThhNYtq8v6O+rq8bFRS1RNUm7cpTeIOSKFOJIIo85+1UGB7TfyWZBuD7AF+8Ten3/uPy8UDkhx4ffqSwIPJv9tBsmDHfXy8+XuMzwzv0l8f8DuWcspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFPtUGSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08D1C116D0;
	Wed, 21 Jan 2026 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768997753;
	bh=+AINEGkwhqDOPKQwtu0hG+f47mL0ba/y19OprUduoh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFPtUGSXL0+JeOLOd7IgmcEClByD6FsZfUVY/1H1LmYzX5u8q+O0leVsFYizbZtSk
	 qweq50Mu5m/9FddzouHALwQn0bWtrrCbHq+ouG0UwKJ/h9VYo3dWe25CzMVRq3P0xf
	 1ksXH9rrhdYIDB8n2YzgzY8IpRaHGWh/08komQMOKUqHsRSirvwq+HftHrbyT7aOre
	 LG5jXh34O8MBuqlvH+V9OQQtolHd8mPR0BnRkkgYhc281DnB2jgAbRo3NNapKsgIO1
	 ol87jWk7JwNNjsPJq1XZq6+QPiJSunl0Ij45D9KXneeuKMKmpIPVC7g/LHbDGMCqhw
	 Ts2KRrEFekOwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dmaengine: stm32: dmamux: fix device leak on route allocation
Date: Wed, 21 Jan 2026 07:15:50 -0500
Message-ID: <20260121121550.1523155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012056-swifter-dispersed-4902@gregkh>
References: <2026012056-swifter-dispersed-4902@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210737-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E296856AEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit dd6e4943889fb354efa3f700e42739da9bddb6ef ]

Make sure to drop the reference taken when looking up the DMA mux
platform device during route allocation.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org	# 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251117161258.10679-11-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/stm32-dmamux.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 8d77e2a7939a0..7911797607824 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -90,23 +90,25 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
 	struct stm32_dmamux *mux;
 	u32 i, min, max;
-	int ret;
+	int ret = -EINVAL;
 	unsigned long flags;
 
 	if (dma_spec->args_count != 3) {
 		dev_err(&pdev->dev, "invalid number of dma mux args\n");
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	if (dma_spec->args[0] > dmamux->dmamux_requests) {
 		dev_err(&pdev->dev, "invalid mux request number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		goto err_put_pdev;
 	}
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux)
-		return ERR_PTR(-ENOMEM);
+	if (!mux) {
+		ret = -ENOMEM;
+		goto err_put_pdev;
+	}
 
 	spin_lock_irqsave(&dmamux->lock, flags);
 	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
@@ -133,7 +135,6 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		ret = -EINVAL;
 		goto error;
 	}
 
@@ -160,6 +161,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
 		mux->request, mux->master, mux->chan_id);
 
+	put_device(&pdev->dev);
+
 	return mux;
 
 error:
@@ -167,6 +170,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 error_chan_id:
 	kfree(mux);
+err_put_pdev:
+	put_device(&pdev->dev);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.51.0


