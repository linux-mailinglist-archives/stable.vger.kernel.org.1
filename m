Return-Path: <stable+bounces-225976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNEHEeRRuWkoAgIAu9opvQ
	(envelope-from <stable+bounces-225976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:06:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4222AA773
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6EA31EBFF3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFB3C73FE;
	Tue, 17 Mar 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ezk9mQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE83C73DA
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752405; cv=none; b=GtLGUOYUDsJRGwdFiavaXJcYAglvZM4rklLeHw65XNtsX4RZes0EDxqDsQdvvjuOL2lUDmufEMqoa4rDWHR/MnxfCiH8zhbzZGU7KMfefnaWHXjjS1O/26QKLz+iz/M25Hwt0YGgylVHc37QB6BjNuB4ONJ0CWLjY+MjQC4gfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752405; c=relaxed/simple;
	bh=ZqBSIj4E2eK/RbcxcBUpYxbOUh98sQxWniwHtbYMcaI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G9AH6HsrjUXZEIWsUci+DoZtwK/smnAPsFvPFVDC8ftwZV7VdnpUEGohRpz1ekl9AtGqMejEpiVstw+f7B9eXMmILsxI7SNbd0fnesUkjvI20QkgrmbEthlil4HobhmR8sTcQu6voJVJ5rwl9vK+uAkBQKmUwOqQQ6Um29qb9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ezk9mQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC763C19425;
	Tue, 17 Mar 2026 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752405;
	bh=ZqBSIj4E2eK/RbcxcBUpYxbOUh98sQxWniwHtbYMcaI=;
	h=Subject:To:Cc:From:Date:From;
	b=0ezk9mQfeX8e/kpQ2d8UzOM2g0T1pBbFzRvA8dGj88RKNrSGMyjuRTqPaA5GK7M41
	 2tSRv1+7oDmqF4JzeYH8L/+hrEU49ZX578fv89gdfKFrLsc94tq9U5XvSLbpY+llJS
	 GRDhiyBvXK1sHnIvvBqBTBDUkTo8Ph+SyyxmX3M0=
Subject: FAILED: patch "[PATCH] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()" failed to apply to 6.12-stable tree
To: mhiramat@kernel.org,shicenci@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:00:01 +0100
Message-ID: <2026031701-glider-ominous-ade9@gregkh>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225976-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: CC4222AA773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5ef268cb7a0aac55521fd9881f1939fa94a8988e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031701-glider-ominous-ade9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef268cb7a0aac55521fd9881f1939fa94a8988e Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Mar 2026 23:04:11 +0900
Subject: [PATCH] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()

Remove unneeded warnings for handled errors from __arm_kprobe_ftrace()
because all caller handled the error correctly.

Link: https://lore.kernel.org/all/177261531182.1312989.8737778408503961141.stgit@mhiramat.tok.corp.google.com/

Reported-by: Zw Tang <shicenci@gmail.com>
Closes: https://lore.kernel.org/all/CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com/
Fixes: 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 025af57ad3ed..bfc89083daa9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1144,12 +1144,12 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	lockdep_assert_held(&kprobe_mutex);
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
-	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
+	if (ret < 0)
 		return ret;
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret)) {
+		if (ret < 0) {
 			/*
 			 * At this point, sinec ops is not registered, we should be sefe from
 			 * registering empty filter.


