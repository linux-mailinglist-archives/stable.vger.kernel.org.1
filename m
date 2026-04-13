Return-Path: <stable+bounces-236039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEYxMnTf3GnrXgkAu9opvQ
	(envelope-from <stable+bounces-236039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:20:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B453EBD22
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD6C930087F8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7E3C3BED;
	Mon, 13 Apr 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0pR6WHNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F13BD63E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082787; cv=none; b=htvzKcs0SwS8NN7/PpCmQfb0hm4MmqrZX4axo72cu9lsDmz/xOmX1v2y/Xd1gTsoRs8pF3fIG1awlX4PmzI7L+kfUAiQKWGhNwkKJ3+pfG64TfoIgDruYYhBFkZKDVRkvM3EQzHeErNYnoQLYgOkxXaVp/q6f8glsV7U5E1KTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082787; c=relaxed/simple;
	bh=RFls+Or6uVdTL1pWrwQRHdipWKixQcazPsdm7yXzj+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b75ju4s6SJ3OyX89aoiJy6pWWlsT/3NkFjhJITBbMuqxh+5SJndkdR88dSRqsnwoLntcu+51Ipp8qzQoBRM3dvYuPcOcxTJfJaxDewU43ShGt3qC82OYoGjAI777UkJMf6n5z+FA1g5fDTd4jQvm8POSiLmvwLjWeS76ru3C5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0pR6WHNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F9C116C6;
	Mon, 13 Apr 2026 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082787;
	bh=RFls+Or6uVdTL1pWrwQRHdipWKixQcazPsdm7yXzj+Q=;
	h=Subject:To:Cc:From:Date:From;
	b=0pR6WHNq7v6cTJpVW97R+FnKnd8wcgpaqQ/FyGwRJLnnpkg/HgsPZUX4kXM7ELKxI
	 DX1wJ9wySucJRGl2yDUr+vuo607ZrWp2yp8f8M+V0WUPjtHj2IUuZi7DKDYOfPdMqO
	 azeaKFi4gj26+AkSSAh1Lq5ncUCibNVbECrL4WuY=
Subject: FAILED: patch "[PATCH] net: lan966x: fix page pool leak in error paths" failed to apply to 6.6-stable tree
To: devnexen@gmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:19:44 +0200
Message-ID: <2026041344-expedited-sizing-f2df@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236039-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50B453EBD22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 076344a6ad9d1308faaed1402fdcfdda68b604ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041344-expedited-sizing-f2df@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 076344a6ad9d1308faaed1402fdcfdda68b604ab Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sun, 5 Apr 2026 06:52:40 +0100
Subject: [PATCH] net: lan966x: fix page pool leak in error paths

lan966x_fdma_rx_alloc() creates a page pool but does not destroy it if
the subsequent fdma_alloc_coherent() call fails, leaking the pool.

Similarly, lan966x_fdma_init() frees the coherent DMA memory when
lan966x_fdma_tx_alloc() fails but does not destroy the page pool that
was successfully created by lan966x_fdma_rx_alloc(), leaking it.

Add the missing page_pool_destroy() calls in both error paths.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260405055241.35767-3-devnexen@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 74851c63e46a..10773fe93d4d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -119,8 +119,10 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(lan966x->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
 		return err;
+	}
 
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
@@ -957,6 +959,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
 		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+		page_pool_destroy(lan966x->rx.page_pool);
 		return err;
 	}
 


