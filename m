Return-Path: <stable+bounces-65572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B47B94A9C3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81A91F2AC89
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C978C93;
	Wed,  7 Aug 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJDj35eB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957861674
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040143; cv=none; b=aeC/zITvRxAUvDEp6cVNZWtWG1SAALTazhwvjnkLyqzVZuvpofRYcR6GkFbW3n+Fc7Up4qgCjRXQ8PLuHcYx+23yz9NXBhqhvLt063d3PAu4zvh0f+FhhL+2ei/y+7hC67Wg1bYxg2e2PLV5JqNlrdH+9+3XcqZIOlO19fbk73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040143; c=relaxed/simple;
	bh=fe0M6VMAuIsGEs0eHD+TwNszZMHTOJFhUmO6KbcOhec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VC4ONHlk7NwZYsTkHrN5Fl2OA79FHK3da9Byux3HG54upm1jYme/+wZR5rSZHOJPtrJ5nHa+bQnlkxZQ1D59JxnQOSs1miz7HJ5i2CJYfGmhJIqr0ZBb2S/F8/nP7VWKyQlCVWnwyDNanEhIZMMyv39Q+bjeyvcjpqgCNgZ6UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJDj35eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7885C32781;
	Wed,  7 Aug 2024 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040143;
	bh=fe0M6VMAuIsGEs0eHD+TwNszZMHTOJFhUmO6KbcOhec=;
	h=Subject:To:Cc:From:Date:From;
	b=hJDj35eB+JSKJIaNzdMx1WfEKFTwIhPlzIqEJ7Bt4DrcAMdznc4OkK7E2uqufncEM
	 8uwE7NpGg0yLdv6ObFgLpLALw0cpS6NUllx/t4HzygeQAmsXqv71/MY1aYKf2pEj9Y
	 hceqcE/qXxtm9Yrz26k/wXdphfMbjDzVQs6FLdq8=
Subject: FAILED: patch "[PATCH] selftests: mptcp: fix error path" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,davem@davemloft.net,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:15:39 +0200
Message-ID: <2024080739-imperial-modular-7da5@gregkh>
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
git cherry-pick -x 4a2f48992ddf4b8c2fba846c6754089edae6db5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080739-imperial-modular-7da5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

4a2f48992ddf ("selftests: mptcp: fix error path")
571d79664a4a ("selftests: mptcp: join: update endpoint ops")
0d16ed0c2e74 ("selftests: mptcp: add {get,format}_endpoint(s) helpers")
3188309c8ceb ("selftests: mptcp: netlink: add 'limits' helpers")
29aa32fee7d0 ("selftests: mptcp: export ip_mptcp to mptcp_lib")
40061817d95b ("selftests: mptcp: join: fix dev in check_endpoint")
7f0782ca1ce9 ("selftests: mptcp: add mptcp_lib_verify_listener_events")
8ebb44196585 ("selftests: mptcp: print_test out of verify_listener_events")
663260e14668 ("selftests: mptcp: extract mptcp_lib_check_expected")
339c225e2e03 ("selftests: mptcp: call test_fail without argument")
747ba8783a33 ("selftests: mptcp: print test results with colors")
e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")
aa7694766f14 ("selftests: mptcp: print test results with counters")
3382bb09701b ("selftests: mptcp: add print_title in mptcp_lib")
9e6a39ecb9a1 ("selftests: mptcp: export TEST_COUNTER variable")
fd959262c1bb ("selftests: mptcp: sockopt: print every test result")
c9161a0f8ff9 ("selftests: mptcp: connect: fix misaligned output")
01ed9838107f ("selftests: mptcp: connect: add dedicated port counter")
6215df11b945 ("selftests: mptcp: print all error messages to stdout")
2aebd3579d90 ("selftests: mptcp: simult flows: fix shellcheck warnings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a2f48992ddf4b8c2fba846c6754089edae6db5a Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 27 Jul 2024 11:04:02 +0200
Subject: [PATCH] selftests: mptcp: fix error path

pm_nl_check_endpoint() currently calls an not existing helper
to mark the test as failed. Fix the wrong call.

Fixes: 03668c65d153 ("selftests: mptcp: join: rework detailed report")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9c091fc267c4..55d84a1bde15 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -661,7 +661,7 @@ pm_nl_check_endpoint()
 	done
 
 	if [ -z "${id}" ]; then
-		test_fail "bad test - missing endpoint id"
+		fail_test "bad test - missing endpoint id"
 		return
 	fi
 


