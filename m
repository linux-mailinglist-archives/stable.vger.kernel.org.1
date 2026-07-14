Return-Path: <stable+bounces-274421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FqORFcxdVmqV4AAAu9opvQ
	(envelope-from <stable+bounces-274421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:03:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA8756C53
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:03:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NjtS0MuC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274421-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274421-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9EE83004F22
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A04A33FD;
	Tue, 14 Jul 2026 16:03:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAA3890E0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044999; cv=none; b=VIJ51WfGMM1J0UrQOw23Ztv3ufbjO+HuqM/cpjfWEsmc5AJnNXGuJ425A3nPJJFDheR95v1AaecP19jK/kqd/og96n0TyTaWgOfuxqx7nIMsYTF2V4phizhaSJW1vrJUclrMhrdp0t1rcudSCqo+C3JWrvK0rt2l/UcFaMJ5dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044999; c=relaxed/simple;
	bh=pl43eLdtLTOWabdWe15SfHykiW/0YdsfBLg6nxcmOik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MkkAnChzscgTaqV9fuuQwcBcsDFXumO70llfUCWgF8KImhm36E2Q38oUbHsKr0DpydgYVElOQWi3PUeKndBtwz+X8VinmdKOtoilAS44FMvDrAA34kERGIYu3lvBGWLIlmxXZgg7l491FUEeL25vj7JE7iXL5t3FjtfX4Ips4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjtS0MuC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE721F000E9;
	Tue, 14 Jul 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044998;
	bh=0rvcIAKKftIzkSst2LNG2RqfI4cKZ/Gi4r+SJ0OYbOU=;
	h=Subject:To:Cc:From:Date;
	b=NjtS0MuC7eNqQvco3u0l959Zm30PKUTzuUyZ7XGrhuZxmxoi0ZSr/lwh0goSbbcyL
	 o63OsgoVuOuBXUDS/5KHyqNaddRq5yVD+B96dl85etREZnmEBaJkNI21C5Wc8bjLEN
	 u7dR+XfvZTH6ECa4asds3P3yjW/CVH38TS6R34gM=
Subject: FAILED: patch "[PATCH] usb: gadget: f_printer: take kref only for successful open" failed to apply to 6.1-stable tree
To: raoxu@uniontech.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:03:12 +0200
Message-ID: <2026071412-chop-overreach-6861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-274421-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:gregkh@linuxfoundation.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ACA8756C53


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071412-chop-overreach-6861@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Fri, 26 Jun 2026 14:46:17 +0800
Subject: [PATCH] usb: gadget: f_printer: take kref only for successful open

printer_open() returns -EBUSY when the character device is already
open, but it increments dev->kref regardless of the return value. VFS
does not call ->release() for a failed open, so every rejected second
open permanently leaks one reference.

Move kref_get() into the successful-open branch.

Fixes: e8d5f92b8d30 ("usb: gadget: function: printer: fix use-after-free in __lock_acquire")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/80295742B820DA9B+20260626064617.4090626-1-raoxu@uniontech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..837f753d0cae 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,12 +363,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	kref_get(&dev->kref);
-
 	return ret;
 }
 


