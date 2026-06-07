Return-Path: <stable+bounces-261579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2oiqHiFNJWoiGgIAu9opvQ
	(envelope-from <stable+bounces-261579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B16500DC
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:51:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DrmVt4Ba;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261579-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261579-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099F63064445
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7CB3254A9;
	Sun,  7 Jun 2026 10:44:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585721E98EF;
	Sun,  7 Jun 2026 10:44:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829088; cv=none; b=dgDE8J1D5aK2ptD9M8ECFN1qGcTANiT7m+MCeHaf9Mjwg1Af/bnlAkFXKOfWlQy1hSo6j5wisqtUPn8CaqLvdHABme1yN0kUyoFCwUNBuKvkNTC461Q+2+Vdx6mvWyBZmbzHVNYxzZmGLccmcxBehcoJiQO+etXk+hXVFS2D/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829088; c=relaxed/simple;
	bh=bOuAjwc1l4WNJHd4Vza77QijxH0jiOstN9qjHI4UVEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLDN7Tz6AfPqv82WS8SN1uuORn4FQDHfgMyuWhSVcCFQk/y8spCY5KYTHJPJOVXH42eN5mE0euHG8Bz39FXvG9/1traX6RCeQz8/cbncCuezBkX+MHroVw4kcXzsNXH/sH7xhoe5HWMMJbvHvGKXPw8HBR5tezK3l+H40FLOmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrmVt4Ba; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D51F00893;
	Sun,  7 Jun 2026 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829087;
	bh=uVBjch1I+AaNss7v2iyTNkbIats+EvSWneRGubj3VG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrmVt4BaqpAyWVXYFJ5ho39rLiMdU68qyyMoDMZqOLxpRqaaR/Iz+tD26/i38UqL0
	 M3glOGGK1fZtWeP29yd3vt299ptbu36X/b0tBPNmcfcMPSgwtrQprttyqDtnDD6lCJ
	 z34mMrLEsI1/V5xsrhg2srVIoWndjIXTwzkXQGi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.18 216/315] gpib: cb7210: Fix region leak when request_irq fails
Date: Sun,  7 Jun 2026 12:00:03 +0200
Message-ID: <20260607095735.498837600@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261579-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zenghongling@kylinos.cn,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C60B16500DC

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongling Zeng <zenghongling@kylinos.cn>

commit 2eae90a457baa0048a96ed38ad93090ee38c8b2f upstream.

When request_irq() fails, the region allocated by request_region()
is not released. Fix this by adding an error handling path with
proper goto labels to release the region.

Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Closes: https://lore.kernel.org/oe-kbuild-all/202605160620.ReBOadPX-lkp@intel.com/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260518022939.16881-1-zenghongling@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/gpib/cb7210/cb7210.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -1048,7 +1048,8 @@ static int cb_isa_attach(struct gpib_boa
 	if (!request_region(config->ibbase, cb7210_iosize, DRV_NAME)) {
 		dev_err(board->gpib_dev, "ioports starting at 0x%x are already in use\n",
 			config->ibbase);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_release_region;
 	}
 	nec_priv->iobase = config->ibbase;
 	cb_priv->fifo_iobase = nec7210_iobase(cb_priv);
@@ -1061,11 +1062,16 @@ static int cb_isa_attach(struct gpib_boa
 	// install interrupt handler
 	if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, DRV_NAME, board)) {
 		dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", config->ibirq);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_release_region;
 	}
 	cb_priv->irq = config->ibirq;
 
 	return cb7210_init(cb_priv, board);
+
+err_release_region:
+	release_region(nec7210_iobase(cb_priv), cb7210_iosize);
+	return retval;
 }
 
 static void cb_isa_detach(struct gpib_board *board)



