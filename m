Return-Path: <stable+bounces-253968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HAbFEgLfEWohrgYAu9opvQ
	(envelope-from <stable+bounces-253968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 19:08:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7B5BFFB8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 19:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16CCD3010277
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81531F98E;
	Sat, 23 May 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP2eDj/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13445234964;
	Sat, 23 May 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556095; cv=none; b=BSDNAjGvNUf+ONnzsESLLvgKDkeceFd0Nc/qbTqfYlre7t3KLLY+lO8LTiF15Hi75orETH3sd7K4ZNHkCYy/gDIyAmPP3M0YdRRo1YNXABpto6g8+xErn2BaWYvIEGYexqiJd+lSdJoxLasxXDjJZqJeZ5e30exlFuG+2VRGPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556095; c=relaxed/simple;
	bh=AwUn65WtnvpxJdXOV4zgj7rt2f13Aa1fWDB7cP/g/Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTYoGxyYY9ucCw4YMxzV/8zOm5HNQluB01f9XlAHEVVk/hvIFYPCeKhfK1dJTq1NJ+mr4v9lk05tDTmdm3d4XyDVGYEgGXo9g/gxJtyP98A784q0XN3573qbG2JlOll0GnJoY8K6T0Kwysjfl/esT9VyL7HFD9n4dB00xL89GH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP2eDj/b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B71F000E9;
	Sat, 23 May 2026 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779556093;
	bh=+pDxvvoSTetKX61i03vTYrjg0RcES5ijTwT3/7ptNAo=;
	h=From:To:Cc:Subject:Date;
	b=hP2eDj/b0T93I4L9adtPKTN1e2oyhWLI6PPXax2of1QB6mifm53IYhNgo4oR3EL1a
	 YC1XSBU5diSaanOQDfLnarKbBt3d5YObX08XA2y9Qtm9mDtQGRA/OMb1QE1k2ObFL9
	 FICnok1u6bzpSxoW77+8OHLYrvOtQxu2bCPpr539cbOExyDRfZAVIZEAwn4OOUcyzt
	 mIQ5or97CmP3/Oi4IOOgEAWRbopP9Fum7HF1vd9W40bozrO0JQXoi5TrjImcQwUSh1
	 s1yKNWM+WaAxXlZfXC39qdBbNvDM9AvpnDuaxGlbvzO28+BF6SkDuZtdF9+8Ql0ET2
	 zW8WpwrhAzQhQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wQppb-00000004W1p-0z6n;
	Sat, 23 May 2026 19:08:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joseph Bursey <jbursey@uci.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: iowarrior: fix use-after-free on disconnect
Date: Sat, 23 May 2026 19:05:23 +0200
Message-ID: <20260523170523.1074563-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253968-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,ad2aac2febc3bedf0962];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Queue-Id: B8C7B5BFFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Submitted write URBs are not stopped on close() and therefore need to be
stopped unconditionally on disconnect() to avoid use-after-free in the
completion handler.

Fixes: b5f8d46867ca ("USB: iowarrior: fix use-after-free after driver unbind")
Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Reported-by: syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a0ce39b.170a0220.39a13.0007.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---

I happened to see a reply to this syzbot report today and took at look
at the driver. Turns out my fix from 2019 was incomplete.

Johan


 drivers/usb/misc/iowarrior.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 22504c0a2841..88c6d1d1da11 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -905,13 +905,15 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	/* prevent device read, write and ioctl */
 	dev->present = 0;
 
+	/* write urbs are not stopped on close() so kill unconditionally */
+	usb_kill_anchored_urbs(&dev->submitted);
+
 	if (dev->opened) {
 		/* There is a process that holds a filedescriptor to the device ,
 		   so we only shutdown read-/write-ops going on.
 		   Deleting the device is postponed until close() was called.
 		 */
 		usb_kill_urb(dev->int_in_urb);
-		usb_kill_anchored_urbs(&dev->submitted);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
 		mutex_unlock(&dev->mutex);
-- 
2.53.0


