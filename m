Return-Path: <stable+bounces-210569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIHXNjyob2kZEwAAu9opvQ
	(envelope-from <stable+bounces-210569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:07:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48E4717B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6A9424C7
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB244A720;
	Tue, 20 Jan 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAqEB1q+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F186323
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921463; cv=none; b=fooNtTCzr3qJvST9PwfRiTL3+ExiaQtxtpMw+7Es8jZfCsrPirtNo8bz1PHDfSvWagh+tmzipK0PmmiGtxj/M+fJOh/Hjjj0ixKzv7sVnO6LK79wjfF8JQayhJAmxhqxEcPaCAzf4yp6ZqRQG53P3k6TnQc724zN16s4zAWp9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921463; c=relaxed/simple;
	bh=nMAsCLMqZfR1eCMjF+tcvjczTGUxhVDmNdnf+q3DhTo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=euS16euEVG9rMCL8ydaOvfDqY0pZhZKXW+7iXjoQw2Oyvrih0yIbG3am+jivOUgGTeGId6yrOn4TfZah3ueqX05FNA23Cpru10rPO8LM8neMVW6hWXIR1pnr+efEvusDs7eQ/t4rWJuJP3rpuk7hghQCVGoxVBWUiO9tRGLYOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAqEB1q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A834AC16AAE;
	Tue, 20 Jan 2026 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768921463;
	bh=nMAsCLMqZfR1eCMjF+tcvjczTGUxhVDmNdnf+q3DhTo=;
	h=Subject:To:Cc:From:Date:From;
	b=CAqEB1q+KjC746/FGRr/3rPCIv/xIAm4/THIEEmz9wm1hDpAV5WCv6qpZQe7p+VAE
	 3NTfWtNc7JT+INOp62aC2IBqbK5moOQHDeRpsFYfDW6xT3QXASd/P15XCB1h2Fax2b
	 u8twzja7KNQsH9c1PJojbVkN/AF4eC0JzeBcVnSo=
Subject: FAILED: patch "[PATCH] dmaengine: stm32: dmamux: fix OF node leak on route" failed to apply to 5.10-stable tree
To: johan@kernel.org,amelie.delaunay@foss.st.com,pierre-yves.mordret@foss.st.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 16:04:06 +0100
Message-ID: <2026012006-slacks-unfrozen-a0c6@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210569-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,st.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EF48E4717B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b1b590a590af13ded598e70f0b72bc1e515787a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012006-slacks-unfrozen-a0c6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b590a590af13ded598e70f0b72bc1e515787a1 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 17 Nov 2025 17:12:53 +0100
Subject: [PATCH] dmaengine: stm32: dmamux: fix OF node leak on route
 allocation failure

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
Cc: stable@vger.kernel.org      # 4.15
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251117161258.10679-12-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 791179760782..2bd218dbabbb 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -143,7 +143,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&dmamux->lock, flags);
-		goto error;
+		goto err_put_dma_spec_np;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -165,6 +165,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	return mux;
 
+err_put_dma_spec_np:
+	of_node_put(dma_spec->np);
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 


