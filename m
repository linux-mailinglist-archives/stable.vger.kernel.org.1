Return-Path: <stable+bounces-242310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBTXLCeJ9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340F4ABE30
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C055300A7DD
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3A37DEBB;
	Fri,  1 May 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvY8cu+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0572622
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633523; cv=none; b=Nn/QGevGHPrr25iH+urlovaP3vES/d0+1sfOwWPcHmBpzhLlakO+6X2AQ/g1l56hmmtRSkv9SVwD92iaNm7cyN10p89PX6a4CcCkLiSxpsjif7X5u/ZcTFcm1OGacx5X47GFt3/ZwQlKsTXKqItZeFx5glzAJ0T8p3+AbYKAgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633523; c=relaxed/simple;
	bh=LpQoK4ysuVrHu+H3k1jeDdCGeHJoxb8im1ekC6mAgSk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WiF3CajSm8qhILVEJQfKF5h9UlgwS0oAf0/pb8ZdrvcpgLhrQboKaBYs6PbQW6RCw/MAz0Y/k9QvJpMlWoWnnJ+Mz6Cjlh2ngLZyBUiOzftTntOM+skb04H+JZUW9den0yxu4ZSuClik1I+nSK9eZcFy1GoDmmfhR54ITQYavuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvY8cu+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3675C2BCB4;
	Fri,  1 May 2026 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633523;
	bh=LpQoK4ysuVrHu+H3k1jeDdCGeHJoxb8im1ekC6mAgSk=;
	h=Subject:To:Cc:From:Date:From;
	b=jvY8cu+6RTeOMX/vyXAM6Y41+Cxvjt47D95TgOJD5T543EGkNAG4+eMniIXRTcHOG
	 bRSkFk3mPl8XBe8NNVoh24ajmltp4ef8OGv2BbZbQRHv92S46gXhYLdK4GujbkcZR6
	 QU5gy4cdQe5Cijuu5UJnYWyFwMWaZd5t8KMqSabE=
Subject: FAILED: patch "[PATCH] selftests/landlock: Fix socket file descriptor leaks in audit" failed to apply to 6.18-stable tree
To: mic@digikod.net,gnoack3000@gmail.com,gnoack@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:05:13 +0200
Message-ID: <2026050112-second-frenzied-c947@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3340F4ABE30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242310-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[digikod.net,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9143d790337a0d066c2d632c802f69b981e6c23a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050112-second-frenzied-c947@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9143d790337a0d066c2d632c802f69b981e6c23a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Thu, 2 Apr 2026 21:26:03 +0200
Subject: [PATCH] selftests/landlock: Fix socket file descriptor leaks in audit
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

audit_init() opens a netlink socket and configures it, but leaks the
file descriptor if audit_set_status() or setsockopt() fails.  Fix this
by jumping to an error path that closes the socket before returning.

Apply the same fix to audit_init_with_exe_filter(), which leaks the file
descriptor from audit_init() if audit_init_filter_exe() or
audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260402192608.1458252-3-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 1049a0582af5..6422943fc69e 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -379,19 +379,25 @@ static int audit_init(void)
 
 	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
 	if (err)
-		return err;
+		goto err_close;
 
 	/* Sets a timeout for negative tests. */
 	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
 			 sizeof(audit_tv_default));
-	if (err)
-		return -errno;
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
 
 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
@@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err)
+		if (err) {
+			close(audit_fd);
 			return err;
+		}
 	}
 
 	/* Filters might not be in place. */
@@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
 
 	err = audit_init_filter_exe(filter, NULL);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
 	if (err)
-		return err;
+		goto err_close;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }


