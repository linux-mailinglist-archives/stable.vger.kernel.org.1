Return-Path: <stable+bounces-21460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A926085C904
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65066284D26
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D271534F1;
	Tue, 20 Feb 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ESxxqjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94189152DE0;
	Tue, 20 Feb 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464490; cv=none; b=H2xGU068XLl8WeiN/LFvsuIoHQilNEG5MqJity2GdqY8XTv05koxhAIWzfavmZLSftVJJPab2h7a4CmWHXRoNFx5IRzEN0tibM7iKgohxNk6420mSTu0gJ3M2wd1CPfnk3QIrvhnevJoxAHKHhUiVhRVP6Xw/Ts47GyPlGW7bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464490; c=relaxed/simple;
	bh=9HbC5SLzrSVNZNeGBDoqjcvJ1ojXMQcPuimAAuqGjvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYuH/lrinaQhAeTkVNiMfABp9rNcAfiOGr+IUUzEl4c0KXVQcXFTt3FPFXXfVp+/ovTsljAgM2goERmEg9BlXZ/u9cL3BJn7onTyBsVJ/i69pZAmSg/E2lCCLINpIwM+KgFeYJITouJ5/JdJxAZ7hJHVVSgUaT9v4EruJ7ZsMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ESxxqjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00108C433F1;
	Tue, 20 Feb 2024 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464490;
	bh=9HbC5SLzrSVNZNeGBDoqjcvJ1ojXMQcPuimAAuqGjvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ESxxqjV0a3l4B5St08BuXXeM0I48qCn4d184IYDEtY7H/1Xw1KMXcse1Sc2l/xGL
	 EbJnX1dfVD4DGkc9X9O8Li5YWTC6InkI/vbLG3hI+iYKDJX+LEw0qOgoFOnaQy41lH
	 Ojn1WgPXjiTSYGZCoR7+dC2AwH61YcRL0wKdIjsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 042/309] selftests: forwarding: Fix bridge MDB test flakiness
Date: Tue, 20 Feb 2024 21:53:21 +0100
Message-ID: <20240220205634.503305901@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 7399e2ce4d424f426417496eb289458780eea985 ]

After enabling a multicast querier on the bridge (like the test is
doing), the bridge will wait for the Max Response Delay before starting
to forward according to its MDB in order to let Membership Reports
enough time to be received and processed.

Currently, the test is waiting for exactly the default Max Response
Delay (10 seconds) which is racy and leads to failures [1].

Fix by reducing the Max Response Delay to 1 second.

[1]
 [...]
 # TEST: IPv4 host entries forwarding tests                            [FAIL]
 # Packet locally received after flood

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20240208155529.1199729-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index e4e3e9405056..ebeb43f6606c 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1065,14 +1065,17 @@ fwd_test()
 	echo
 	log_info "# Forwarding tests"
 
+	# Set the Max Response Delay to 100 centiseconds (1 second) so that the
+	# bridge will start forwarding according to its MDB soon after a
+	# multicast querier is enabled.
+	ip link set dev br0 type bridge mcast_query_response_interval 100
+
 	# Forwarding according to MDB entries only takes place when the bridge
 	# detects that there is a valid querier in the network. Set the bridge
 	# as the querier and assign it a valid IPv6 link-local address to be
 	# used as the source address for MLD queries.
 	ip -6 address add fe80::1/64 nodad dev br0
 	ip link set dev br0 type bridge mcast_querier 1
-	# Wait the default Query Response Interval (10 seconds) for the bridge
-	# to determine that there are no other queriers in the network.
 	sleep 10
 
 	fwd_test_host
@@ -1080,6 +1083,7 @@ fwd_test()
 
 	ip link set dev br0 type bridge mcast_querier 0
 	ip -6 address del fe80::1/64 dev br0
+	ip link set dev br0 type bridge mcast_query_response_interval 1000
 }
 
 ctrl_igmpv3_is_in_test()
-- 
2.43.0




