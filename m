Return-Path: <stable+bounces-20552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C773C85A80B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069C01C23619
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABE3A267;
	Mon, 19 Feb 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1J7dYO3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE03CF76
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358489; cv=none; b=KWDvJmaYaRx0a19CyR5ZldiAktwDqeDY7TV23Pw22hh99Xe4Git8Xl+qnEpns+/oNcQzyV9QI3Uqqy07NJQobRahrNL978OVRwd9SpA5DCPOTJrfqXC7WTP4fCuSI0JLUAr03WUGWimnStAvivaeKiF/O/OJFtOdHE4SraiFJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358489; c=relaxed/simple;
	bh=BzrIxMA1XeygbtKXHijQgGt808vhCVZ/RrBU30IWNqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dfeG35uUY7OcsZqrHuHJBQ87O1jyGAtqranNNxvem1FULx+hAq6h3CJhgz/9VuOc52deume5/ubP7eruNOXlVuq7S8ebZRgTTXqSL3df6RTqyDVha3i/s3OQ5iLUiRz9QnyTOhYnJrtpVGMH3XmdHhUPBXUDiB2HaDGIJbbCTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1J7dYO3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B58C433F1;
	Mon, 19 Feb 2024 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358489;
	bh=BzrIxMA1XeygbtKXHijQgGt808vhCVZ/RrBU30IWNqQ=;
	h=Subject:To:Cc:From:Date:From;
	b=1J7dYO3TlT8zn95oDy+5ebPQHHGLitjXUN/U4r0/rdCdvX6MPje6AlXX3otOsyPRD
	 AB1zqhICj3O4TN6nNLrCV0MLlpFNOEFApwuuzsOPT6q7Rd0avjxHSnggV63WNq8qZU
	 mmfBB2sEzX0pLeJ6SCYxspV+vs3vZHJjOZ+ld1qA=
Subject: FAILED: patch "[PATCH] selftests: mptcp: add missing kconfig for NF Filter" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:01:26 +0100
Message-ID: <2024021925-lyricism-unshackle-b3ca@gregkh>
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
git cherry-pick -x 3645c844902bd4e173d6704fc2a37e8746904d67
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021925-lyricism-unshackle-b3ca@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

3645c844902b ("selftests: mptcp: add missing kconfig for NF Filter")
46e967d187ed ("selftests: mptcp: add tests for subflow creation failure")
5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
b6ab64b074f2 ("selftests: mptcp: more stable simult_flows tests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3645c844902bd4e173d6704fc2a37e8746904d67 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:47 +0100
Subject: [PATCH] selftests: mptcp: add missing kconfig for NF Filter

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table.

It is then required to have IP_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index e317c2e44dae..2a00bf4acdfa 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -22,6 +22,7 @@ CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_ACT_CSUM=m


