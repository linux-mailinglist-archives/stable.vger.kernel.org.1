Return-Path: <stable+bounces-242943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ0gOi5f+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:56:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D124BAA2F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A342B300863C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54033121E;
	Mon,  4 May 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mo61/XWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA834A3DF
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884664; cv=none; b=qqgaPJEZsEUs1APJD3VndJbhLXWG76T0O4rwTvWbyOLZ/9+W6/m9qw88RfZ6VJYw2R9J4+C277qWA6Bk80N4zGthQ/Ij02mIuUWqOQMyOgcvmXqcfysZekk9ixLyP3facSADLh5QXC1vi88tcNEptfp05zdi0P1ic8TnFngP3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884664; c=relaxed/simple;
	bh=J5d8KOhopwzGWK0ZDxx/vUYIFGl58I2Nh1O4ndTpFr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t29UuyOYgFI2U56S/O+uo1G5PZPu8xGVxtV+2noCjPnJypRPs0OFI3odijQOmv5Rvdxu9QcdZgQ8eK5BnfeLZXPl9BMF3hISPj7dNkj9wDF+ndRvcMVSjA2mSMNKstFnrg8qbu+V+B/Kt174C7t2YTUMXNmnDhS9QUrniWmxHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mo61/XWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F7C2BCB9;
	Mon,  4 May 2026 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884663;
	bh=J5d8KOhopwzGWK0ZDxx/vUYIFGl58I2Nh1O4ndTpFr0=;
	h=Subject:To:Cc:From:Date:From;
	b=Mo61/XWd7g55JeulC5tujoMY5Jn3FCZyoTXzn1Ql9yCc6fPNtfTlXJIf7oCPCnMq8
	 4gW5nS++C03I28a+TjR7ioSKtAtCLCn489FncfsRcNC4oj8qZTYoCFSUhrJGIOPO7e
	 a7mwRBrDON0/yLLuF79iJjb2AbiPDxp2B89jY10E=
Subject: FAILED: patch "[PATCH] ktest: Fix the month in the name of the failure directory" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,warthog9@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:51:01 +0200
Message-ID: <2026050401-payphone-celestial-4a77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7D124BAA2F
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242943-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 768059ede35f197575a38b10797b52402d9d4d2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050401-payphone-celestial-4a77@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 768059ede35f197575a38b10797b52402d9d4d2f Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 20 Apr 2026 14:24:26 -0400
Subject: [PATCH] ktest: Fix the month in the name of the failure directory

The Perl localtime() function returns the month starting at 0 not 1. This
caused the date produced to create the directory for saving files of a
failed run to have the month off by one.

  machine-test-useconfig-fail-20260314073628

The above happened in April, not March. The correct name should have been:

  machine-test-useconfig-fail-20260414073628

This was somewhat confusing.

Cc: stable@vger.kernel.org
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>
Link: https://patch.msgid.link/20260420142426.33ad0293@fedora
Fixes: 7faafbd69639b ("ktest: Add open and close console and start stop monitor")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 112f9ca2444b..dd55eea15070 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1855,7 +1855,7 @@ sub save_logs {
     my ($result, $basedir) = @_;
     my @t = localtime;
     my $date = sprintf "%04d%02d%02d%02d%02d%02d",
-	1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
+	1900+$t[5],$t[4]+1,$t[3],$t[2],$t[1],$t[0];
 
     my $type = $build_type;
     if ($type =~ /useconfig/) {


