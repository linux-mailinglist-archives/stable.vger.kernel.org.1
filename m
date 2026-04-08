Return-Path: <stable+bounces-234203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDT4KMCb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FC3C059A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C7530095E0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7577385513;
	Wed,  8 Apr 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzKwMNdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58F324B1F;
	Wed,  8 Apr 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672250; cv=none; b=sSf8eWmXC4NCSf1AoJzljQtam3WjzfpCGOKpGkdPVY7Qn+FmItKdkawODDid2aLENEOttij+DUuuOgqmF4NAfWEcOYjFEeRV+44Eah3YSLgQbIL6DYQUG4EGjtPXLpnV9bUQn3DumpqepkZnhxFWU3c3MvAgykrGnQL58oHUcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672250; c=relaxed/simple;
	bh=Ui2WlgnifI0zXH4SkZ4ritMSf8HXQhmIpdkyrUvCj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/dnW4hNcAv1Lc6iwwVNnyEGYn687tb1b9PgxzWq+d4kq2dnff/hSmKVul6Fd7t+08DPE2Ug64UaFdOuOH/5eJs5fdMNiyvHtTBe3kG1BMX06h1UX30WotHiBwtBefMOjUy9Fjb+EgEClB+Rxz91yzHuN45gBVy+7xw+qQXxTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzKwMNdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2D9C19421;
	Wed,  8 Apr 2026 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672250;
	bh=Ui2WlgnifI0zXH4SkZ4ritMSf8HXQhmIpdkyrUvCj5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzKwMNdWwa5rHj3VVZWeBR1VjBFNGAzTNW3dayr8wa6kuf6mu11tHMd0r71djmBb4
	 OcNy0KE7oFpDJtikyk0eTFD8eBhg3JDXE24ngVf8b/EpG+MYLQw0+D+Orn9PTfewz6
	 frCOaBZ+wdsbz4zao4ehTA/Z8XbYXfxH6dsE0Zyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cc9f7f4a7df09f53c4a4@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.1 247/312] comedi: Reinit dev->spinlock between attachments to low-level drivers
Date: Wed,  8 Apr 2026 20:02:44 +0200
Message-ID: <20260408175942.973026888@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234203-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cc9f7f4a7df09f53c4a4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email,syzkaller.appspot.com:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9A0FC3C059A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 4b9a9a6d71e3e252032f959fb3895a33acb5865c upstream.

`struct comedi_device` is the main controlling structure for a COMEDI
device created by the COMEDI subsystem.  It contains a member `spinlock`
containing a spin-lock that is initialized by the COMEDI subsystem, but
is reserved for use by a low-level driver attached to the COMEDI device
(at least since commit 25436dc9d84f ("Staging: comedi: remove RT
code")).

Some COMEDI devices (those created on initialization of the COMEDI
subsystem when the "comedi.comedi_num_legacy_minors" parameter is
non-zero) can be attached to different low-level drivers over their
lifetime using the `COMEDI_DEVCONFIG` ioctl command.  This can result in
inconsistent lock states being reported when there is a mismatch in the
spin-lock locking levels used by each low-level driver to which the
COMEDI device has been attached.  Fix it by reinitializing
`dev->spinlock` before calling the low-level driver's `attach` function
pointer if `CONFIG_LOCKDEP` is enabled.

Reported-by: syzbot+cc9f7f4a7df09f53c4a4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cc9f7f4a7df09f53c4a4
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20260225132427.86578-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -1000,6 +1000,14 @@ int comedi_device_attach(struct comedi_d
 		ret = -EIO;
 		goto out;
 	}
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		/*
+		 * dev->spinlock is for private use by the attached low-level
+		 * driver.  Reinitialize it to stop lock-dependency tracking
+		 * between attachments to different low-level drivers.
+		 */
+		spin_lock_init(&dev->spinlock);
+	}
 	dev->driver = driv;
 	dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
 					 : dev->driver->driver_name;



