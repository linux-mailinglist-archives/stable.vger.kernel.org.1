Return-Path: <stable+bounces-227496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNEkODUMvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:58:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BB2D79C4
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39AD4303933C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D199346AF0;
	Fri, 20 Mar 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qltiLraG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5F2E06ED
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997107; cv=none; b=BcjJ7GjqFPEiEZmGJ/lSlO4hfz6LCtGO1hixbza8aoEswInoBIZJpACKPUcx5TCdUku+jYf8m5VyNBp7N+Ki+i/Z5p+vTyk0D9BK5gMh78xEStz+IJ8JROmn3BPqPFFFE7OTrexOdhb+FJZQFSNSOpaQLSQYCH9ZR8WhFixNjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997107; c=relaxed/simple;
	bh=2NJtAXs0wRVODULdCUoFfU0gAok0KPF24BxDaWy2S8s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iuG6qCvIDjnizxIIwS9BUGv9qW9ETwe1J4auKdApudzt39cm/6YJUFMGFU7drCfTmhqlqygiOQyhaG76u7O4Y7pMwmUOVAth57UDAjTjxKGoS0p0pafcS0fuGPXzp4MwMfFhvnmt76md7VFVPI1BFxLHYJxB/hWBK5Kmu6ESeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qltiLraG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46557C4CEF7;
	Fri, 20 Mar 2026 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773997106;
	bh=2NJtAXs0wRVODULdCUoFfU0gAok0KPF24BxDaWy2S8s=;
	h=Subject:To:Cc:From:Date:From;
	b=qltiLraGxeGwBn41kHjeGey+uMH9Ip/gTyCoZEKAUXqyywQQjE2n+7iJnGucrZETZ
	 ZnM7bz2bi6sdfE+l4Pm/ITRUHPmIigvnyCTSAAlwRCGXuN6+/7O+NCgYLycXgY2LVx
	 kcqTZbe9HWUNxnipEOinU+dWetvy0l59wZEbm+hs=
Subject: FAILED: patch "[PATCH] net: macb: Reinitialize tx/rx queue pointer registers and rx" failed to apply to 6.1-stable tree
To: haokexin@gmail.com,horms@kernel.org,kuba@kernel.org,quanyang.wang@windriver.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:58:02 +0100
Message-ID: <2026032002-habitual-dolly-4a11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227496-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,windriver.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.910];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 5A7BB2D79C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 718d0766ce4c7634ce62fa78b526ea7263487edd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032002-habitual-dolly-4a11@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 718d0766ce4c7634ce62fa78b526ea7263487edd Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 12 Mar 2026 16:13:59 +0800
Subject: [PATCH] net: macb: Reinitialize tx/rx queue pointer registers and rx
 ring during resume

On certain platforms, such as AMD Versal boards, the tx/rx queue pointer
registers are cleared after suspend, and the rx queue pointer register
is also disabled during suspend if WOL is enabled. Previously, we assumed
that these registers would be restored by macb_mac_link_up(). However,
in commit bf9cf80cab81, macb_init_buffers() was moved from
macb_mac_link_up() to macb_open(). Therefore, we should call
macb_init_buffers() to reinitialize the tx/rx queue pointer registers
during resume.

Due to the reset of these two registers, we also need to adjust the
tx/rx rings accordingly. The tx ring will be handled by
gem_shuffle_tx_rings() in macb_mac_link_up(), so we only need to
initialize the rx ring here.

Fixes: bf9cf80cab81 ("net: macb: Fix tx/rx malfunction after phy link down and up")
Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Tested-by: Quanyang Wang <quanyang.wang@windriver.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260312-macb-versal-v1-2-467647173fa4@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4bdc7ccab730..033cff571904 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5952,8 +5952,18 @@ static int __maybe_unused macb_resume(struct device *dev)
 		rtnl_unlock();
 	}
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+		macb_init_buffers(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
+		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+			if (macb_is_gem(bp))
+				gem_init_rx_ring(queue);
+			else
+				macb_init_rx_ring(queue);
+		}
+
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}


