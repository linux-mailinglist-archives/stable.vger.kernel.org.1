Return-Path: <stable+bounces-210561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNI3FvjHb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:22:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C6495F9
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E28C3CBFF5
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677994418CE;
	Tue, 20 Jan 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKIGiTKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A40426ED0
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921366; cv=none; b=luPfpRf7SZEVXjkLaaRzP+PnzWcvUM0rYQbM8ft4Nt1wy2n0E6PfNRnkXUgNfIl97kNEP8+SfzNPE2uVT3kyL/DNB/RsChOOO84j6L4nlggQhhdkgISDMhrVuTw59im4Pepz9pwCaKpFYG73t6S/vMLuEu4ugUJkwnQcMJXYxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921366; c=relaxed/simple;
	bh=5o7zXfDSPKqUv55aleWyXZQqBry5vSLmREmiYug+tWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aGsk+Sa1zw+PCKMUwcpRtVRz/bwO4GICLf1WuJRWV6SAwIJbozyMj/WEFmFLfEFcUw9phj5eIagBNgHasV5g2BAguAXAy9+6IWE5cF6t5DTMX3d46xMIzE+yT9UuPdrLnGDDijlokabIzX3rS45KUJiLIm90CTPiDBRU6Rv19aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKIGiTKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B29CC16AAE;
	Tue, 20 Jan 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768921365;
	bh=5o7zXfDSPKqUv55aleWyXZQqBry5vSLmREmiYug+tWI=;
	h=Subject:To:Cc:From:Date:From;
	b=EKIGiTKe9NF4JhCcFnPf/WCtQBNJb3tmjnb637P7R8FUOfdCfh49Yon0YL6tyDdI6
	 aEfgfz9G5tT4a892a30WmdB4LoZC3Z8oqlOKz0xe8/ZMVBtsgdC75QaSHaYPAk9woo
	 QJR02x+Q+2tcVM3LL1v4CWtNlLd9AN2VOtVkaxAc=
Subject: FAILED: patch "[PATCH] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources" failed to apply to 6.12-stable tree
To: zhen.ni@easystack.cn,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 16:02:43 +0100
Message-ID: <2026012042-outlet-negotiate-95fe@gregkh>
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
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210561-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:dkim,nxp.com:email,gregkh:email,msgid.link:url,easystack.cn:email]
X-Rspamd-Queue-Id: E26C6495F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b18cd8b210417f90537d914ffb96e390c85a7379
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012042-outlet-negotiate-95fe@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b18cd8b210417f90537d914ffb96e390c85a7379 Mon Sep 17 00:00:00 2001
From: Zhen Ni <zhen.ni@easystack.cn>
Date: Tue, 14 Oct 2025 17:05:22 +0800
Subject: [PATCH] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources
 failure

When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
the error paths only free IRQs and destroy the TCD pool, but forget to
call clk_disable_unprepare(). This causes the channel clock to remain
enabled, leaking power and resources.

Fix it by disabling the channel clock in the error unwind path.

Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20251014090522.827726-1-zhen.ni@easystack.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a59212758029..7137f51ff6a0 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -873,6 +873,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
+	clk_disable_unprepare(fsl_chan->clk);
 
 	return ret;
 }


