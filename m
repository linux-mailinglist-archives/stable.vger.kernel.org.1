Return-Path: <stable+bounces-247558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFv9IODbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:40:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5F54B87D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFC923018409
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DE3E3DAF;
	Fri, 15 May 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QctgYyIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F6625
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834000; cv=none; b=CC4lKogSUXLjseSUDaRmcsHppwnE6aWchF5XQ83ndp49RLAiNqne5wOz+GJhakotzYtk/NU6CQu1xM+l2Rlrhzap6H3qKPEpu/AUuRDIspRLbwFu24yE6vnJk5DLJJep1sCi3qGoEBPnQLqqVnTl9TtJaBaHlBfX14/gOJ1jJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834000; c=relaxed/simple;
	bh=IFM0SHToStY58K/ZIblXpxT00y7c0uhfLBsmZXk8lyY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JExhHRfaW674SyxptFAWGv1DbNaMzoOlDKFci+WIJhjdD5ztJZ6JpDzEJJEL3dLlQI6i7ZOStbkkUpcZPDiuCA4NcAjDgd0iUF4rWG9ZoNK0iOsvPU87CbacjmK+AwdE6pyLwbHu/WgHVYG6bp2JQ+HYuAwggnSLxhztpjqbBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QctgYyIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F5C2BCB0;
	Fri, 15 May 2026 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834000;
	bh=IFM0SHToStY58K/ZIblXpxT00y7c0uhfLBsmZXk8lyY=;
	h=Subject:To:Cc:From:Date:From;
	b=QctgYyIoaD5TfC2nxLYJRc9odFoOt6oUIGpKBFPwVMBKg/FqpqU0hq+4kzorr93Pq
	 msoFdbI4fE52R+raCv9s5dv8qR5rXnJwX4a/V3PGhbIac5aL1Jk/uUCQ70UGTR1Y9B
	 2N/+aHZ8t6mGI3fo+ZpJBRdRVB/XFYvqMKVR0mOM=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,khairul.anuar.romli@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:33:13 +0200
Message-ID: <2026051513-viselike-slam-7aa8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25A5F54B87D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-247558-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 964ee9793760e825b5c011741b4e3cfe06c87efc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051513-viselike-slam-7aa8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 964ee9793760e825b5c011741b4e3cfe06c87efc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:13 +0200
Subject: [PATCH] spi: cadence-quadspi: fix controller deregistration

Make sure to deregister the controller before dropping the reference
count that allows new operations to start to allow SPI drivers to do I/O
during deregistration.

Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Cc: stable@vger.kernel.org	# 6.17
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ead419e896e..50ef65fc5ded 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2020,13 +2020,13 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	ddata = of_device_get_match_data(dev);
 
+	spi_unregister_controller(cqspi->host);
+
 	refcount_set(&cqspi->refcount, 0);
 
 	if (!refcount_dec_and_test(&cqspi->inflight_ops))
 		cqspi_wait_idle(cqspi);
 
-	spi_unregister_controller(cqspi->host);
-
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 


