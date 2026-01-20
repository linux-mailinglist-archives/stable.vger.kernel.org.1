Return-Path: <stable+bounces-210565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIm9OmKmb2lDEgAAu9opvQ
	(envelope-from <stable+bounces-210565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:59:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051B46EF6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E42C56D4BA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C340FD9D;
	Tue, 20 Jan 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dP8Bdf9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C40287257
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921451; cv=none; b=TFwnomHqwRNFRxmp1tD99hW5y6KMDrwREbEcYV0lqjFABzeEloClOga93zcxw+hbj3lEim/JXfdjHSSqd53hYQxESOLId9C+JDjKZxpK8kXlU2pzWLqNN1SRqPBrRwK2HuTA3Vm9p0TXrWaNM88JUbHBZHSxbK+ICVXukOMya98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921451; c=relaxed/simple;
	bh=NbWnFgxU32wuhVhdmqzVg7bmCv9zlhYTCU5xIgmxMsg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S8bBznHH2u0hACXb5EDybRjDhsTPNSMxISidh7scjcMq2LJoITij5bg5nDBW0YZZOLkB7eYMiHmXSAY/hwLcRHDL5i9MqRDXLu/Ncof4ZqwFz7h0/i73FqslZ14M1kZRD1ELGj/95fBTWkHAg2Ut8EoEbyhixAZWSyB/nqeutyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dP8Bdf9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BCC16AAE;
	Tue, 20 Jan 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768921450;
	bh=NbWnFgxU32wuhVhdmqzVg7bmCv9zlhYTCU5xIgmxMsg=;
	h=Subject:To:Cc:From:Date:From;
	b=dP8Bdf9/T1FOiRv0FJ4TrIRWqGg6Q6d+LAGy6rxFTgp6OhuqO6sYKc0mbz8EyYYML
	 uv6BITIcVq4FYTSywZDI303kLLR+5j3gp7tLA0anyBFLvhHNx8P7fYsbw0qTXtfojO
	 1CDI3jnS0vRFQE/3AFWbPcuHaPXO6+FfQLEtuyos=
Subject: FAILED: patch "[PATCH] dmaengine: stm32: dmamux: fix device leak on route allocation" failed to apply to 6.1-stable tree
To: johan@kernel.org,amelie.delaunay@foss.st.com,pierre-yves.mordret@foss.st.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 16:03:57 +0100
Message-ID: <2026012057-fondling-fraternal-7292@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210565-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 3051B46EF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dd6e4943889fb354efa3f700e42739da9bddb6ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012057-fondling-fraternal-7292@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd6e4943889fb354efa3f700e42739da9bddb6ef Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 17 Nov 2025 17:12:52 +0100
Subject: [PATCH] dmaengine: stm32: dmamux: fix device leak on route allocation

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

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 8d77e2a7939a..791179760782 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
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
 


