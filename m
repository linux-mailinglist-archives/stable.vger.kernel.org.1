Return-Path: <stable+bounces-210739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIjYJkDFcGkNZwAAu9opvQ
	(envelope-from <stable+bounces-210739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:23:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365056B1D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 099333E17DD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6493451D6;
	Wed, 21 Jan 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrUn9P1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFF45BD4B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998041; cv=none; b=qNBEuAPHOd1niyW0n0KiL+rCKFm9qAF/GTo5Bozv3S7tcyYD8BudwTAvyNe8w5M1xRBx1G4WAoTtvkuLQBEfJRomYeCFuFmTm9/72ygz9sjwFJRPRd2BgGHEVJaGZIdVBuTT6ODE11D+t+Ugb5W4IJXpQn7LQ34rqmQe+JMzKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998041; c=relaxed/simple;
	bh=PkeZAL3A4isxUpt4Z2YuTADEgBJWd8om64/ENtpYKY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtmSU1WAVno899Fykido0d/KrPYGaD/UKaATe2OnAyAwKDmruTRaR1d6Fh2aXWU8QJOX9s1QkBzVdO0ejEzYbOsNvCWQ6UNLaYNnNzFNCYfLdcbFFL0LufILOdZ+w2B4O1CbxSBergatRrl/Ybwx3xj6Xx/u0zjLRj7GFzMUjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrUn9P1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64636C116D0;
	Wed, 21 Jan 2026 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768998041;
	bh=PkeZAL3A4isxUpt4Z2YuTADEgBJWd8om64/ENtpYKY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrUn9P1KHZvmK3EypWqevNg6FrqiJinEym0ztALqBntK0SOAtXCRtmZBFIcpUE3RJ
	 7UcU5AVTNX/cboXyk4kw8yqPu51pat8QjVKWjxU463esliBkQUj9U9O62JDjezLhCj
	 vYPsZUG5a4aIyjFglJpllKaL+QikwqNhIdLKhyrIADmuCAbLXl9Kq1SNJgdcejn03E
	 JyW9Ak37EtCt+UVRTKIajAOKCoVBKtUceVqfHMN2DYXiySoUVqa2lhIbwNmh1dEDDx
	 xznMw3tnX6kfxZ1RPpj6zNTb9Z0IdcEXeQoDM0SEHNijSwfRzRNgn+3p4MD+fw9jz5
	 aIkjWwkgO99CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dmaengine: stm32: dmamux: fix device leak on route allocation
Date: Wed, 21 Jan 2026 07:20:38 -0500
Message-ID: <20260121122038.1526229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012057-fondling-fraternal-7292@gregkh>
References: <2026012057-fondling-fraternal-7292@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210739-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,st.com:email]
X-Rspamd-Queue-Id: 4365056B1D
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
index ee3cbbf510065..f0329f872aa85 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -88,23 +88,25 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
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
@@ -131,7 +133,6 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", i - 1);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "can't get dma master\n");
-		ret = -EINVAL;
 		goto error;
 	}
 
@@ -158,6 +159,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
 		mux->request, mux->master, mux->chan_id);
 
+	put_device(&pdev->dev);
+
 	return mux;
 
 error:
@@ -165,6 +168,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 error_chan_id:
 	kfree(mux);
+err_put_pdev:
+	put_device(&pdev->dev);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.51.0


