Return-Path: <stable+bounces-257262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO4uIr8ZG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:09:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7760EFEB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC22304FA66
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9CE332EA7;
	Sat, 30 May 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yE+yPxYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01932BF24;
	Sat, 30 May 2026 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160385; cv=none; b=BwiPibXOzm21QaYCV/BsnxlO8mx0YUy+af1gQNFCESUruqFtBEaFNGZxEK+kNvzbNMgH5G2gVlTZ3uS9hcF7Pw4MKCKFJZ2FyPk6uwHEcIyPXW7UfRervR/zvsfXPmdyTZw4RS+75jJL+7RE9cpnDaNKUUJuRKz1x4Px0svGHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160385; c=relaxed/simple;
	bh=TzfUeY+FoCNnREGcOhoGkOpQ0ra4nGmLbJQlFUM54MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdcK/uGjoIcaXxoEVP3GyxUn9AI3gKlQtD/oL/HRZJ1Gf6b81hnqP576Ka30WlwlRGQhjHE61iyha4tglttk8G+nMcuZXwmmHkqrqlXHh8cJh24Dej82cPjaPSDsCm9/gy6JZhdNQEbUPFn3Waq6QEYhqF1OFY+q5PRmfL5mFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yE+yPxYC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C77F1F00893;
	Sat, 30 May 2026 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160384;
	bh=ZVsApRoxsHy6mc0nHH6nFZL87gCzJAuzjkoThdgy0mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yE+yPxYCJCI3RrjUsfpuA0Euk3EETv5XqW5mm7Cx4nNwiKAkk933QwXh/5i6w9qRa
	 MNcCFimArb1ZGc2cH2UDXQ8X5HFSWX3GkbxGs8HNI9CE3Jl5zfpDYSdHS/hxKS96Uz
	 94UrqtfbGvrVGAoC5yNtmtrveENEMU3yFyjdB6Dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pete Zaitcev <zaitcev@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 306/969] usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
Date: Sat, 30 May 2026 17:57:10 +0200
Message-ID: <20260530160308.877560317@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257262-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EAC7760EFEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit b38e53cbfb9d84732e5984fbd73e128d592415c5 upstream.

Just like in a previous problem in this driver, usblp_ctrl_msg() will
collapse the usb_control_msg() return value to 0/-errno, discarding the
actual number of bytes transferred.

Ideally that short command should be detected and error out, but many
printers are known to send "incorrect" responses back so we can't just
do that.

statusbuf is kmalloc(8) at probe time and never filled before the first
LPGETSTATUS ioctl.

usblp_read_status() requests 1 byte. If a malicious printer responds
with zero bytes, *statusbuf is one byte of stale kmalloc heap,
sign-extended into the local int status, which the LPGETSTATUS path then
copy_to_user()s directly to the ioctl caller.

Fix this all by just zapping out the memory buffer when allocated at
probe time.  If a later call does a short read, the data will be
identical to what the device sent it the last time, so there is no
"leak" of information happening.

Cc: Pete Zaitcev <zaitcev@redhat.com>
Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/2026042011-shredder-savage-48c6@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usblp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1166,7 +1166,7 @@ static int usblp_probe(struct usb_interf
 	}
 
 	/* Allocate buffer for printer status */
-	usblp->statusbuf = kmalloc(STATUS_BUF_SIZE, GFP_KERNEL);
+	usblp->statusbuf = kzalloc(STATUS_BUF_SIZE, GFP_KERNEL);
 	if (!usblp->statusbuf) {
 		retval = -ENOMEM;
 		goto abort;



