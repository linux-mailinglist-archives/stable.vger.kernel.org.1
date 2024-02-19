Return-Path: <stable+bounces-20555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACD85A813
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79202823B8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70713B18D;
	Mon, 19 Feb 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k8PQqRzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C543A8CC
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358608; cv=none; b=OeFn7tx8nJOeGLj5loyuxBSN+b6n6XdW559C9RM4QzV+K9djcGjr9EWOVDC/ybBNdx3tJyC8eMq7IvxewWYKt8u7JXKN9avPjC5B+gEnwRgtx51nnI/Q50mMolekzsaadOvzkSqWhhtiatGRlwCX435L5QCDMTtkQF1RHUF/RqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358608; c=relaxed/simple;
	bh=CF6HtWYv7L5gYsUkCGa8r+AqdFllDVPS+gkUkBUN3cg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BHmzn1zmNL7Ids4FxFxwFBEM4p82LGikoJat7OLrzrR9CQSziFfXHcoMtWYcbaPxZR13PSGhAFtPatBdtsoh+BbCl0a1nUcWVSeNywuOCfsaelGhtSGLHVuzVNCNtSBjHPvqUeZfHsOqy4Gj1N3vULdUtUPW6cNW2+Tib3P5QI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k8PQqRzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A590DC433F1;
	Mon, 19 Feb 2024 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358608;
	bh=CF6HtWYv7L5gYsUkCGa8r+AqdFllDVPS+gkUkBUN3cg=;
	h=Subject:To:Cc:From:Date:From;
	b=k8PQqRzCZLYvuXBY6Cv0+GldRkSOTNcgkbCdHVXS8dpS6HN6RPC9SNctNhbmjgmim
	 peXE/iQnK+E7YTr23YlCrDkJXtmGyB9JgwAv3hR3ecexVIJTXCCUUcDi4g5gmlvZz0
	 sTkrPBLtl82QI5MyLm/idIE6M+h+dv6RwjlUpCFE=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: stop transfer when check is done" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:03:17 +0100
Message-ID: <2024021917-nuzzle-magenta-7de4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 31ee4ad86afd6ed6f4bb1b38c43011216080c42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021917-nuzzle-magenta-7de4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

31ee4ad86afd ("selftests: mptcp: join: stop transfer when check is done (part 1)")
80775412882e ("selftests: mptcp: add chk_subflows_total helper")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31ee4ad86afd6ed6f4bb1b38c43011216080c42a Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:53 +0100
Subject: [PATCH] selftests: mptcp: join: stop transfer when check is done
 (part 1)

Since the "Fixes" commit mentioned below, "userspace pm" subtests of
mptcp_join selftests introduced in v6.5 are launching the whole transfer
in the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds in slow environments.

Note that old versions will need commit bdbef0a6ff10 ("selftests: mptcp:
add mptcp_lib_kill_wait") as well to get 'mptcp_lib_kill_wait()' helper.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org # 6.5.x: bdbef0a6ff10: selftests: mptcp: add mptcp_lib_kill_wait
Cc: stable@vger.kernel.org # 6.5.x
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-8-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3a5b63026191..85bcc95f4ede 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3453,7 +3453,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3475,7 +3475,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow


