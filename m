Return-Path: <stable+bounces-263246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id csvbBIINMGpCMgUAu9opvQ
	(envelope-from <stable+bounces-263246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:34:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3A687384
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=c6p5gznF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263246-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263246-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DE92307599E
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E613F7A9B;
	Mon, 15 Jun 2026 14:27:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595C3ED3BC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:27:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533640; cv=none; b=bq6NrUef/vvJ/xVT7fKzZfzZvm3RsmZWSQhZtvSWooi5XmDQPPxErtQhQ3hGXPxrI1DLIhaVUqlE1rmGsqTgtMn37lXkOW6WgyBUgky5jWpHEtAuf3doXjrI62zGz7LTQcgJtGqQwQbpZYVVv8ncVSDD9nh6LQmTkJyCmR5G9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533640; c=relaxed/simple;
	bh=W613WYRcTGVjWg7HGGBevYBG8FLJIeuGAk/PTVRupTQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uh29kiihCEzdb3t+y23pfkpfN0DTAf3jeUmqO7MAbohinn7roUFQ5B2JAXTEVa430QQeDFRT5c3tu1hOPcUbynOacLHmgPM6VFucogWjeSZK33+/k72mPM9LZR8UgMaa9XLqiQpzX/ltQUtFos1FThPxiSgbVrno1NPKCFyHKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6p5gznF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A01D1F000E9;
	Mon, 15 Jun 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533639;
	bh=dsLOJzEbb4bMr5Qn8HJmBS4Z2gjnDRTazH5Hw2x798w=;
	h=Subject:To:Cc:From:Date;
	b=c6p5gznFxs3CtkSOPYbrHttsZJ2E6pWg+8iQDwbO+r8F1qhSqaYged/kvneYQFBcl
	 SRv14x7f4lmLPC7smcXeHQrGLScds2cm9LTVdMEQdFV4AVOscfOOZqxEH7QOYJCipg
	 HDlObmslZgK6R8aPUnMTR07xmPvyfldRXHnL1UAY=
Subject: FAILED: patch "[PATCH] selftests: mptcp: add test for extra_subflows underflow on" failed to apply to 6.1-stable tree
To: cuitao@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:26:08 +0200
Message-ID: <2026061508-freeway-cruelly-dade@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263246-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cuitao@kylinos.cn,m:kuba@kernel.org,m:matttbe@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,kylinos.cn:email,vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DED3A687384


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 06fd2bec7aebf393288e4b78924482fe170caabc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061508-freeway-cruelly-dade@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06fd2bec7aebf393288e4b78924482fe170caabc Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Tue, 2 Jun 2026 22:14:13 +1000
Subject: [PATCH] selftests: mptcp: add test for extra_subflows underflow on
 userspace PM

Add a test to verify that when userspace PM fails to create a subflow
(e.g. using an unreachable address), the extra_subflows counter is not
decremented below zero.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-6-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5acd12021e6e..4b3f71e66609 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4100,6 +4100,10 @@ userspace_tests()
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
+		# check counters are not affected by errors at creation time
+		userspace_pm_add_sf $ns2 10.0.12.2 10 2>/dev/null
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi


