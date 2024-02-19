Return-Path: <stable+bounces-20554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EF85A812
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84283B2109F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A343A29A;
	Mon, 19 Feb 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ExfG7PZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68433A267
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358599; cv=none; b=VOYIwIG15q7fvTZZ7w0yFNFY/s/lf23J1cbZFYZIf0chPQ1rkPL83I2sYXf3J1t3e5//nm1TR9toPYyKe8w9S6VDNBuwHWgrl9qzyeafrQ0BhjAUKwQtjYF3lN7U+TcD66rEuuHAqNgxq46kexrEQCuyLbKmgKcGhSW9LtTtmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358599; c=relaxed/simple;
	bh=4nhWxMDcUxLMoj3CDGhPsVIQHMJrWf2aWrLC1kdahPg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SjchGA9PexwEN1ZdED3uJOpO12nzks+Oh52Vr1FyIZkx8nyLNwyKj+zy2IZSfboh+t/JDSrzmjmtR8a2n0g9nCBfQGFhJXQSnMz+vGqHCD2qt8dCw//qnnsEQNNn1rBqunKxbNgY64S2OqOVjDh2FksHDgqzatnafM733E4vYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ExfG7PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06410C433C7;
	Mon, 19 Feb 2024 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358599;
	bh=4nhWxMDcUxLMoj3CDGhPsVIQHMJrWf2aWrLC1kdahPg=;
	h=Subject:To:Cc:From:Date:From;
	b=0ExfG7PZG52ODi7zR13UbioUhVlx406V1CHuFu27KqOQdmbdku0w6yxLfj38MySP9
	 iDz8MXYoge9Gbmd1t/8vPv25np7DGKhRyRaYsOmh3tIfs5fgqlQkkSpkdXPzkVb8fQ
	 lHEMDkmjAv+hcHpouYHO0enxTWV1LzUTJN1ss1Q4=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: stop transfer when check is done" failed to apply to 6.7-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:03:16 +0100
Message-ID: <2024021916-striking-evoke-4847@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 31ee4ad86afd6ed6f4bb1b38c43011216080c42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021916-striking-evoke-4847@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

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


