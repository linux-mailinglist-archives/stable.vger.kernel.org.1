Return-Path: <stable+bounces-254872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA12HbsrGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68905F1893
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D0130E3787
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3653E5A03;
	Thu, 28 May 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F06sWa4g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74A3BE164
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968612; cv=none; b=tDKiK9m+B+f/88SlYGQpmHXW57r9aEihuM0c5ZDVC/s3YQvnXgpVohZsf9e60qRcqU+PSdUoETr0sOnXrN6SGffh5qo7R0IStXDMWqnuUZLZ8MgJyIGrmVq2DICndCJMmPx7CR7Ld41OPyKN9XqsffKX/vMK/9JbKTEKDXpugzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968612; c=relaxed/simple;
	bh=RlH7yzlV1cZKKv0IZTo41uDqkOBfwl6wnfiZKnp//2M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jsrrhlbG1XvgzPWprigVGk+jA+O1+vvwktkt3rZ2uVvSaCIJpl2ANoWKWsziQlVymdnyHDqX09oyf4MyxJ7K6LaSxI4LoQkfidWk3pDqm0UxMWOal+Fl0HGY8I8A26Ku0Tu8kxPaZhbQwmJU3CGUBeNFHL3hav2J1ypSIHsgRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F06sWa4g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3392D1F00A3D;
	Thu, 28 May 2026 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968610;
	bh=SrBZQ/GT5BAlTnhszjJe8/MMlSRHKB28AEptJ0zWmH0=;
	h=Subject:To:Cc:From:Date;
	b=F06sWa4gSBqJin2v9lZi5/eUWIfI9RbziuM2R2LiOt3+Kt6MZn4074pB+WiU1K4qt
	 KfauePKytxwA6pCahQNqwKTmAuBRh5ibQstRJuC+JqE7lg1BrQs1fTvoz5GjX7/DjS
	 bqIEi7kn2Ep0gBVN5vAlJB4c3cbXZI5rAlG38uN4=
Subject: FAILED: patch "[PATCH] spi: qup: fix error pointer deref after DMA setup failure" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:42:37 +0200
Message-ID: <2026052837-task-immovably-904e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254872-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,msgid.link:url,sashiko.dev:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C68905F1893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a7e8f3efd50a165ba0189f6dc57f7e51a7d149db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052837-task-immovably-904e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7e8f3efd50a165ba0189f6dc57f7e51a7d149db Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 12 May 2026 09:43:34 +0200
Subject: [PATCH] spi: qup: fix error pointer deref after DMA setup failure

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer (or attempting to release a channel
a second time) on later probe errors or driver unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=4
Cc: stable@vger.kernel.org	# 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074334.914735-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 45d9b4cb75e4..50bb7701b9d5 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -996,8 +996,11 @@ static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 


