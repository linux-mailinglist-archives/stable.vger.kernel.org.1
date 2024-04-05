Return-Path: <stable+bounces-36019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3BF899551
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F61F22FF8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877E22616;
	Fri,  5 Apr 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jb1Jeum"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C61803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298550; cv=none; b=TSC98vEdUH8ow3atpDyes0gIywFB59yhi3J6aAai3njWwmJYKPYRFd2YmVU+9CJvCoOczH9PrCaf2jd2yb4CizgEHQROyg5wd2mP5U4kIfLQfArDSKG+NAPIT0o42CznBAMAgZZ7EGSVMyjAK2X1ejAxsoFy9+X/em+LGYL9trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298550; c=relaxed/simple;
	bh=4qySMGmJ3ODb5brLcq6/9p2LEoTRiVELLG3IRpvkrv0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uj+j3WQpmwttlYkjkXD3WQPSY2Vgmi46mSZOGGeMkNZTBBBVIPyFzU//WzEvcPoUFY796GbY4RbR5GEzbAf5rIK+K515MAOC7Mnzy6uBHB8yzUIyrEoJUNrGs/GiKOrHhYTVzGYpBPVfjyCSk1TfYFTCje1KV88z9e18bvnZE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jb1Jeum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F15C433F1;
	Fri,  5 Apr 2024 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298550;
	bh=4qySMGmJ3ODb5brLcq6/9p2LEoTRiVELLG3IRpvkrv0=;
	h=Subject:To:Cc:From:Date:From;
	b=1jb1JeumzZIRFY+1LyO45P6zF92otFvH+GQHZ3xT6JpeRSiztUQzy+UhLp1iQqGJY
	 bnQyps435S+S+Hyk9E8nPFAoLkbvrYM/HrQlZjQd3qxyVfTxuul2C9tlFDqgR//V6b
	 7VxlsrtObEb7WPrNL9F520HudGuUMEfiy7cUWbTE=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: fix dev in check_endpoint" failed to apply to 6.1-stable tree
To: tanggeliang@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:29:07 +0200
Message-ID: <2024040506-skinny-unsuited-f487@gregkh>
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
git cherry-pick -x 40061817d95bce6dd5634a61a65cd5922e6ccc92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040506-skinny-unsuited-f487@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40061817d95bce6dd5634a61a65cd5922e6ccc92 Mon Sep 17 00:00:00 2001
From: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 29 Mar 2024 13:08:53 +0100
Subject: [PATCH] selftests: mptcp: join: fix dev in check_endpoint

There's a bug in pm_nl_check_endpoint(), 'dev' didn't be parsed correctly.
If calling it in the 2nd test of endpoint_tests() too, it fails with an
error like this:

 creation  [FAIL] expected '10.0.2.2 id 2 subflow dev dev' \
                     found '10.0.2.2 id 2 subflow dev ns2eth2'

The reason is '$2' should be set to 'dev', not '$1'. This patch fixes it.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240329-upstream-net-20240329-fallback-mib-v1-2-324a8981da48@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5e9211e89825..e4403236f655 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -729,7 +729,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
@@ -3610,6 +3610,8 @@ endpoint_tests()
 		local tests_pid=$!
 
 		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 


