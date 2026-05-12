Return-Path: <stable+bounces-245651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JuoDh06A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD1522956
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A19F7317F1BA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAAD3A59BA;
	Tue, 12 May 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYzciFdh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E23A8393
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594545; cv=none; b=HW0dy/FTqKZqI0U29BwN3Mm1HDZfJq6a+5gpzlVGium32/jSGMoKk5A8VpziuJ0IIv+5pj1YurMvEKS+lbYFdWwxdIk9lMqdADLU2GWJIpzD5KAQbGzVsGRjiu9PUT1z/grJUg2oPm8hMaUDbTM7pHYms6A/EeC/c/bjan/wzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594545; c=relaxed/simple;
	bh=AUHfxirK4YU0pfheFjyvy40pBXlmeGOV1MC1IwyLuwg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VlfFIBjALBzjpkWB29CRu17xoASd3oarQ3HRNdSEhH+4rJ4EOoQwi4qIV7tmhBajleWerovAW3AFx9hCyNEUL2YSafTz573TLQOr/0yWJsTnitqAUE2EFgA6cW7Ics5lQedCMgUwGPAprUdxziMWYXa+4lUBmbhqwn4P6TBq+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYzciFdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2C2C2BCF6;
	Tue, 12 May 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594545;
	bh=AUHfxirK4YU0pfheFjyvy40pBXlmeGOV1MC1IwyLuwg=;
	h=Subject:To:Cc:From:Date:From;
	b=bYzciFdhAsxfveYhAe5CL1m/u6i56pcy3HAWeVQ5M/oxUplxKAd8kxAW5tg7RfPd9
	 y8dcmdSHKbGSFV4Kb8URxF90thQVuLSb9fONyOPXHfNYMJNrWwlPmgxuXVbglxyHw9
	 8HeT27czBTstJQl7vZV9+59zYa2EmZQqITxlZ8yc=
Subject: FAILED: patch "[PATCH] eventfs: Use list_add_tail_rcu() for SRCU-protected children" failed to apply to 6.18-stable tree
To: devnexen@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:59:33 +0200
Message-ID: <2026051233-marauding-delete-836e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BDD1522956
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245651-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,goodmis.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,goodmis.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f67950b2887fa10df50c4317a1fe98a65bc6875b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051233-marauding-delete-836e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f67950b2887fa10df50c4317a1fe98a65bc6875b Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 18 Apr 2026 16:22:50 +0100
Subject: [PATCH] eventfs: Use list_add_tail_rcu() for SRCU-protected children
 list

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260418152251.199343-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..8dd554508828 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -706,7 +706,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
-			list_add_tail(&ei->list, &parent->children);
+			list_add_tail_rcu(&ei->list, &parent->children);
 	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {


