Return-Path: <stable+bounces-70197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395195F0F0
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28FC1F225D9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E1185933;
	Mon, 26 Aug 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiNmN24e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556621714BC
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674129; cv=none; b=j9st72K1ObdOI4IagxuVelIrNim1KiCMxrH9zNU91qa0GyuYMyfaE0VtI8Mn/wFuwreCSXsKOy25xc3d7ckvFU9jsqkT8zYpOF45RStZlPctXZ+Kz8BH0arRdutJHbGtHuLETH91usRbgu3acsOyR8CPBmk5dB1M1FAYoWzQMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674129; c=relaxed/simple;
	bh=40R9dEeV24oBzAT+aVVYBB1i4FeL9m973xpJBdk1KMk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SbBn/5tSb5p5gq9hG1FRLdKmCC0GVhQjmVRbhKXTG99DkOf8PKiiKd+EXmw+ZzZQOsZEw4ruPaZpTwRZ2dSxC45dCGSrqh92r5O1iBu0o5Mc16Rwb4m9C5FR4B4zCAkFYDO0yh9tXszHn/V4AT7ADm7Ski8F88rWsJ5c1Iyv2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiNmN24e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58FCC4DDEA;
	Mon, 26 Aug 2024 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674129;
	bh=40R9dEeV24oBzAT+aVVYBB1i4FeL9m973xpJBdk1KMk=;
	h=Subject:To:Cc:From:Date:From;
	b=IiNmN24e/b7bsoYescPjSwqobtIsJ+LzCwHvqJEGHYFZ3+NKaNSTKZbVuf+TSS2UX
	 XE4xyZMWTSmXO5ZjeWTL/cMX74ZBTIY6vucFyxVmllqqqk7OucBxeAubsdw71LGAHJ
	 wQS7gd88XMVtFMkcbL5xVBSQi6w+UfY5GUEVznW0=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: validate fullmesh endp on 1st sf" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:08:46 +0200
Message-ID: <2024082645-hurled-surprise-0a7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4878f9f8421f4587bee7b232c1c8a9d3a7d4d782
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082645-hurled-surprise-0a7c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")
d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc cmds fail")
0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
6c160b636c91 ("selftests: mptcp: update userspace pm subflow tests")
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
8697a258ae24 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4878f9f8421f4587bee7b232c1c8a9d3a7d4d782 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:31 +0200
Subject: [PATCH] selftests: mptcp: join: validate fullmesh endp on 1st sf

This case was not covered, and the wrong ID was set before the previous
commit.

The rest is not modified, it is just that it will increase the code
coverage.

The right address ID can be verified by looking at the packet traces. We
could automate that using Netfilter with some cBPF code for example, but
that's always a bit cryptic. Packetdrill seems better fitted for that.

Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-13-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f609c02c6123..89e553e0e0c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3059,6 +3059,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3


