Return-Path: <stable+bounces-20553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB69B85A80E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63244B2570B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740338F98;
	Mon, 19 Feb 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWH9dCWe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2B3D55C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358507; cv=none; b=AxYV4GwACl0qowLrKApZ6E27A8NO0mkHdzwzBOFGZDwpSEyjl+eKe5sEHgqipdcTVxvtplr3Vy+P51CDEHVnNqPUDzRNCNd90TmWaxXLwd7Cphqro3dAGH7MRDRVnxsFLb2LBCrUWPhisVWmPHzMSpjiSGWBgSvMB50Bvi+c0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358507; c=relaxed/simple;
	bh=58N0F71vhgHE3OCFz0s6fw6OfHohZl/d6SWmBSvL1+k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RvbL2Bb598hjZsvyyHcWMt8De5uLhswawoNDTHY7/X4kvxovNvtInlznNSFXfTgQJA6HJJyx5u8ZnlbWvVRMg/Kl/q6Mrf6OQu755xKCh9fiAzdrDkyKTePmSEslZjiVwPifQfh6AIpuj5//bOhj91dHCvfG9wZNrCcEbTMOTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWH9dCWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95080C433C7;
	Mon, 19 Feb 2024 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358507;
	bh=58N0F71vhgHE3OCFz0s6fw6OfHohZl/d6SWmBSvL1+k=;
	h=Subject:To:Cc:From:Date:From;
	b=iWH9dCWeXXKpEjUnYzsVYYozVxRQreEribRvvle0Ta7XWQXFyBlWWRuq5MQCWuxHt
	 h3rDpjTBXkaM2luzwIpvli4Tc972X90qS4Lsu6zXLJMeQLDiVsKaaE5sYOknF+Z/Dt
	 sd2pImgyXS46cn9thVHZ/tq/ho31B2whiejci85A=
Subject: FAILED: patch "[PATCH] selftests: mptcp: add missing kconfig for NF Filter in v6" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:01:43 +0100
Message-ID: <2024021943-wriggle-repair-49dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8c86fad2cecdc6bf7283ecd298b4d0555bd8b8aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021943-wriggle-repair-49dd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8c86fad2cecd ("selftests: mptcp: add missing kconfig for NF Filter in v6")
b6e074e171bc ("selftests: mptcp: add infinite map testcase")
39aab88242a8 ("selftests: mptcp: join: list failure at the end")
c7d49c033de0 ("selftests: mptcp: join: alt. to exec specific tests")
ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific tests")
e59300ce3ff8 ("selftests: mptcp: join: reset failing links")
3afd0280e7d3 ("selftests: mptcp: join: define tests groups once")
3c082695e78b ("selftests: mptcp: drop msg argument of chk_csum_nr")
69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
f98c2bca7b2b ("selftests: mptcp: Rename wait function")
826d7bdca833 ("selftests: mptcp: join: allow running -cCi")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
26516e10c433 ("selftests: mptcp: add more arguments for chk_join_nr")
8117dac3e7c3 ("selftests: mptcp: add invert check in check_transfer")
01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
cbfafac4cf8f ("selftests: mptcp: add extra_args in do_transfer")
922fd2b39e5a ("selftests: mptcp: add the MP_RST mibs check")
e8e947ef50f6 ("selftests: mptcp: add the MP_FASTCLOSE mibs check")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c86fad2cecdc6bf7283ecd298b4d0555bd8b8aa Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:48 +0100
Subject: [PATCH] selftests: mptcp: add missing kconfig for NF Filter in v6

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table for IPv6.

It is then required to have IP6_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-3-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 2a00bf4acdfa..26fe466f803d 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -25,6 +25,7 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IP6_NF_FILTER=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_ACT=y


