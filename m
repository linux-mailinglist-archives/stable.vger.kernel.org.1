Return-Path: <stable+bounces-226668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KW1OsuNuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9965C2AF6F6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBE393045674
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85132F75B;
	Tue, 17 Mar 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZt4eeJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159B31E841;
	Tue, 17 Mar 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767735; cv=none; b=AAoSEiNnVHyHjSIhaHGW5zQXRVJH1GIkH67ChSOifiVd0UfecQ+f0Mwin3sY71Ya8qPqBz75tQomrYbdbxA72j8ce1o2RNvKv/K1HM6eV3OnNHzZd3qdJPm2oy6vA2dFCIw3rpZtvHD0H1cX3r3fQAyzvzwCVJFJHg/cOv85cpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767735; c=relaxed/simple;
	bh=8rNOdbJ+Zoqg/PUFtitkaAMGiiLlLvLn2OMH3bXvV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os9ibzbuSC2zfwW+/NEhK6/pLZwn8NeOlPZ+4r/eDh++xJU4DLVpdI1SNJb1OyA/P9DWPo1kxsIAVSRB7rVzCPMjTGx3lwhu3+ZXkeKiJzryjHEkJBs+iI2Tmpn2D8H7nfCZgwHoC/FV9Lah1KAnN3vjGsDxT9O72toxVLAYy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZt4eeJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4772C2BC86;
	Tue, 17 Mar 2026 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767735;
	bh=8rNOdbJ+Zoqg/PUFtitkaAMGiiLlLvLn2OMH3bXvV1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZt4eeJ8QVwh2t0oT0h/0subOvCbg5s0h2mkLkeXNIJ4nATkCRS5k6Zhp3Jr6YFIy
	 qzrf9HscRDALc3RdNhY7zyev6Sz8AUeWGu48QWV2j6TMjuHZ9YZkS6cUI9/IacfZFg
	 T3H3esZwHWX1ePUKIxQrp87FqRQ7RMQRpVQP+J8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+25ba18e2c5040447585d@syzkaller.appspotmail.com,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.18 139/333] USB: usbtmc: Use usb_bulk_msg_killable() with user-specified timeouts
Date: Tue, 17 Mar 2026 17:32:48 +0100
Message-ID: <20260317163004.515452578@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226668-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,25ba18e2c5040447585d];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,harvard.edu:email,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9965C2AF6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 7784caa413a89487dd14dd5c41db8753483b2acb upstream.

The usbtmc driver accepts timeout values specified by the user in an
ioctl command, and uses these timeouts for some usb_bulk_msg() calls.
Since the user can specify arbitrarily long timeouts and
usb_bulk_msg() uses unkillable waits, call usb_bulk_msg_killable()
instead to avoid the possibility of the user hanging a kernel thread
indefinitely.

Reported-by: syzbot+25ba18e2c5040447585d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/8e1c7ac5-e076-44b0-84b8-1b34b20f0ae1@suse.com/T/#t
Tested-by: syzbot+25ba18e2c5040447585d@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 048c6d88a021 ("usb: usbtmc: Add ioctls to set/get usb timeout")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/81c6fc24-0607-40f1-8c20-5270dab2fad5@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usbtmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -727,7 +727,7 @@ static int usbtmc488_ioctl_trigger(struc
 	buffer[1] = data->bTag;
 	buffer[2] = ~data->bTag;
 
-	retval = usb_bulk_msg(data->usb_dev,
+	retval = usb_bulk_msg_killable(data->usb_dev,
 			      usb_sndbulkpipe(data->usb_dev,
 					      data->bulk_out),
 			      buffer, USBTMC_HEADER_SIZE,
@@ -1347,7 +1347,7 @@ static int send_request_dev_dep_msg_in(s
 	buffer[11] = 0; /* Reserved */
 
 	/* Send bulk URB */
-	retval = usb_bulk_msg(data->usb_dev,
+	retval = usb_bulk_msg_killable(data->usb_dev,
 			      usb_sndbulkpipe(data->usb_dev,
 					      data->bulk_out),
 			      buffer, USBTMC_HEADER_SIZE,
@@ -1419,7 +1419,7 @@ static ssize_t usbtmc_read(struct file *
 	actual = 0;
 
 	/* Send bulk URB */
-	retval = usb_bulk_msg(data->usb_dev,
+	retval = usb_bulk_msg_killable(data->usb_dev,
 			      usb_rcvbulkpipe(data->usb_dev,
 					      data->bulk_in),
 			      buffer, bufsize, &actual,



