Return-Path: <stable+bounces-263296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzqkEyUYMGqjNQUAu9opvQ
	(envelope-from <stable+bounces-263296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:20:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7568794D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:20:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2fT5lIL6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263296-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263296-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 613913001025
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DD4028CC;
	Mon, 15 Jun 2026 15:20:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE63F99EC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536801; cv=none; b=ivjX/O9AkAlbwWre2JI3dvVnKSoujZYcfkgx4xXfVhrPlwA147A/lpkAp6VnvTuMNkbKVfddQNoXVM/QNv+SM9OfXIDaVtS9BLMLXcnTy9zANUFEFNWwNzAQjAYZrzS8iq/CrRiJis+wQ7H/yoJRbeJ8HInnp54YnG5l34u7ClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536801; c=relaxed/simple;
	bh=0wAdmgHA1iyujJiDKp4ATUTu1o5YJq6cUWniSUCVVVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g59XUljkfGhZ+o7BhKbBmno/YlH0VHDebBtLQzfGyKfnavMPNCriQL5FVZ2hCWVtHb97fp4EcOaA9yR/OICPGku0k5CYdPmn1TZBGw8GOceO5m/v/gVSNRTthOiHkUGiFY/tIvGM3GrdNTI3bvYrPXsQtPj5LzsPgeZj4KU4IPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fT5lIL6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388C61F000E9;
	Mon, 15 Jun 2026 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536800;
	bh=2lGYBvwbHklYPMkCmpuXTaBGI8B5niKj4KWLiNf2vvI=;
	h=Subject:To:Cc:From:Date;
	b=2fT5lIL6CZkApP2rpjIxmdUDeA6XCICtu+BGMBGXyK5Y7m7hRe//MaQ7KCO+pTYP3
	 glyACoCm10Y7HSyEugMy+mSX5MZ7Z3BNUZ25c3dzy5DSV4r8i+1eXp/LKv5H84DEOs
	 Us0KXRChTYjUa9QenDTnXhJ1qMESRFgPr0xTUJTU=
Subject: FAILED: patch "[PATCH] futex/requeue: Prevent NULL pointer dereference in" failed to apply to 6.1-stable tree
To: eilaimemedsnaimel@gmail.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:45:30 +0200
Message-ID: <2026061530-freefall-hardware-b907@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263296-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:tglx@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8C7568794D


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 74e144274af39935b0f410c0ee4d2b91c3730414
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061530-freefall-hardware-b907@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74e144274af39935b0f410c0ee4d2b91c3730414 Mon Sep 17 00:00:00 2001
From: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Date: Tue, 2 Jun 2026 09:12:04 +0000
Subject: [PATCH] futex/requeue: Prevent NULL pointer dereference in
 remove_waiter() on self-deadlock

When FUTEX_CMP_REQUEUE_PI requeues a non-top waiter that already owns the
target PI futex, task_blocks_on_rt_mutex() returns -EDEADLK before setting
waiter->task.

The subsequent remove_waiter() in rt_mutex_start_proxy_lock() dereferences
the NULL waiter->task, causing a kernel crash.

Add a self-deadlock check for non-top waiters before calling
rt_mutex_start_proxy_lock(), analogous to the top-waiter check in
futex_lock_pi_atomic().

Fixes: 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Signed-off-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b597cb3d17fc..1d99a84dc9ad 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -643,6 +643,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 				continue;
 			}
 
+			/* Self-deadlock: non-top waiter already owns the PI futex. */
+			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
+				ret = -EDEADLK;
+				break;
+			}
+
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);


