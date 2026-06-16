Return-Path: <stable+bounces-263646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o22kKascMWoUbwUAu9opvQ
	(envelope-from <stable+bounces-263646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AF68DB60
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XQcmDY0t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263646-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263646-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7717F3006915
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E379421EFF;
	Tue, 16 Jun 2026 09:51:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A593B637A
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603490; cv=none; b=SSztwYUSYh1EST6Zc3F0Y7dOR9XoexBz2bbxHu8KTGezI4m+qOhcJCGgKEIq6v+a8L6VGY/on+QQ6fOLgt90bI0TXf/6Ph8gvqfomPSPEuPvKc+7zgBL3m0kqoXeCsdbNhIvrORO8nkFQwjZso60eUcQjBLC1ddDQG38ppFnoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603490; c=relaxed/simple;
	bh=3nG70pZ12YXxe6qwH/olG++znl8ntl0Z5ou5wNjUKeI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kRccoC879YynfT0Ru7sXTPzWrM56QD3T1ShwfXSgZn6C3c1UnskBfzOeelcjNnSpkjaNIdXrWhrVfgiRT3ThQ0qaEiaR3hGN1vAu5fwdzPewQRa1/pg0ZRJZcwGpOhlWYbbDSHoI9jSuYNJ69Mugjj7YewaiuB5mxP2IqX5DAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQcmDY0t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C71F000E9;
	Tue, 16 Jun 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603489;
	bh=DPjl/zyCtviSLFkfzLhkB/saaBNrM4gPuZPadm1a/jc=;
	h=Subject:To:Cc:From:Date;
	b=XQcmDY0taxfBrZJPNtMYUrjCX+Qcoi1tQfiniztrIwqwChvAY6Rure0WVYQF7m6rX
	 K+PUl7z7q9XTGNLGthgZK6iyVNz+Jd3mgkI441DK1MeSdhmjKmNiAE8l9SppdSRhiP
	 Ce/3QzuB+ySbmwirCPn8Aese95jjRSSkAh36KTvw=
Subject: FAILED: patch "[PATCH] debugobjects: Do not fill_pool() if pi_blocked_on" failed to apply to 6.1-stable tree
To: koike@igalia.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Jun 2026 15:20:11 +0530
Message-ID: <2026061611-defective-unbundle-fbc8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263646-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:koike@igalia.com,m:tglx@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,gregkh:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B9AF68DB60


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5f41161059fd0f1bbf18c90f3180e38cc45a14eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061611-defective-unbundle-fbc8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f41161059fd0f1bbf18c90f3180e38cc45a14eb Mon Sep 17 00:00:00 2001
From: Helen Koike <koike@igalia.com>
Date: Mon, 11 May 2026 18:53:05 -0300
Subject: [PATCH] debugobjects: Do not fill_pool() if pi_blocked_on

On RT enabled kernels, fill_pool() ends up calling rtlock_lock(), which
asserts if current::pi_blocked_on is set, because a task can obviously only
block on one lock as otherwise the priority inheritenace chain gets
corrupted.

Prevent this by expanding the conditional to take current::pi_blocked_on
into account.

Fixes: 4bedcc28469a ("debugobjects: Make them PREEMPT_RT aware")
Reported-by: syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260511215359.3351259-1-koike@igalia.com
Closes: https://syzkaller.appspot.com/bug?extid=b8ca586b9fc235f0c0df

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..772ddabcbe7d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -711,6 +711,15 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 	return NULL;
 }
 
+static inline bool debug_objects_is_pi_blocked_on(void)
+{
+#ifdef CONFIG_RT_MUTEXES
+	return current->pi_blocked_on != NULL;
+#else
+	return false;
+#endif
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -727,11 +736,12 @@ static void debug_objects_fill_pool(void)
 
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context -- for !RT kernels we rely on the fact that spinlock_t and
-	 * raw_spinlock_t are basically the same type and this lock-type
-	 * inversion works just fine.
+	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
+	 * on the fact that spinlock_t and raw_spinlock_t are basically the
+	 * same type and this lock-type inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
+	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching


