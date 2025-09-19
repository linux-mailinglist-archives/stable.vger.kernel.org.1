Return-Path: <stable+bounces-180713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E982DB8B8F9
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1C61CC3E95
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEB2E0B4B;
	Fri, 19 Sep 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0K+JyL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A042E0921;
	Fri, 19 Sep 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321519; cv=none; b=GL4aYo1Mty/e32pERSYhAvktlHVo06Bm1xyefn7lWJr3tNMxta0qqilpW0YwC1nuPtctYBxGYcBxt/uanPDZNGuxtNvK8/ItJwWBovhc+AxKrt06Sr30TaHYqq+U6MbonFiJmVBvALvqIISsPhYJ01WYoLnitgPUtuO+PHrca8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321519; c=relaxed/simple;
	bh=b6clr2qvnYAkxpKplu9ZTxNVwliKvXTRMmCQ+0H88K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsD1NepDkK1g7NhUf6WzYm1VGxHkASiBw0Eg4RMDzdavgpT66GzFjwjPjmG+VKO+8KxYfcvBizbyvRojGdzhnrjH2EkA0pXHCXGL5jA/6xmn2rTfO+fJNTTn+Ds8KxDn34Nd7pWtZOS5LrEtOE2dLdlFZwQN/PELH6O4iHO9M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0K+JyL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE1C4CEF1;
	Fri, 19 Sep 2025 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321519;
	bh=b6clr2qvnYAkxpKplu9ZTxNVwliKvXTRMmCQ+0H88K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0K+JyL8dOU7R93VuDNaNU+Y6YkTbkQ5WtaWAiC3rcKJgiRHsb/MqSTrLko/C9m0P
	 VN9Dy30ufnhT0J4aobuiRasqSNE12y8u3XH2hv9mlk9PeYIm4wyapuyr2jSez+Eaka
	 lgK1/enoHGf6hZ6PlkuVeP+A50DJ7DLl9VmyE+c2mhO9kXnUnTbQYA+8WDJtOkB3l+
	 Jgt+P4XDWS95Ka227blDqWh03O7yhda2dtejtQF5NAEqgopldvIKRkvMU1P8U0ysWR
	 CDHwXYYkSPYejkgJ30CcELfCsAvNF5rtYInTgdUKXnUJ+8RoTMn5BVDhtfqc0NsvYe
	 frwtPldwCjf8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/2] selftests: mptcp: userspace pm: validate deny-join-id0 flag
Date: Sat, 20 Sep 2025 00:38:22 +0200
Message-ID: <20250919223819.3679521-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919223819.3679521-4-matttbe@kernel.org>
References: <20250919223819.3679521-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4468; i=matttbe@kernel.org; h=from:subject; bh=b6clr2qvnYAkxpKplu9ZTxNVwliKvXTRMmCQ+0H88K0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLO3o5fa31pXurb6+7fTbpOLLxpw/rs9XOuD5P8TGz9V lhaeV0K7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI28MM/4u/n6y5tHeSJyOv 5tfcPde+TTny/mD9ac9ryuvczKdcmP2PkWHdLIttCs81kqc/01m0YXZ2/QNOMVFhLxaNUvNWN9O j/7kB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 24733e193a0d68f20d220e86da0362460c9aa812 upstream.

The previous commit adds the MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 flag. Make
sure it is correctly announced by the other peer when it has been
received.

pm_nl_ctl will now display 'deny_join_id0:1' when monitoring the events,
and when this flag was set by the other peer.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-3-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in userspace_pm.sh, because of a difference in the context,
  introduced by commit c66fb480a330 ("selftests: userspace pm: avoid
  relaunching pm events"), which is not in this version. The same lines
  can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 763402dd1774..234c267dd2aa 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -194,6 +194,13 @@ static int capture_events(int fd, int event_group)
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
 					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
+					__u16 flags = *(__u16 *)RTA_DATA(attrs);
+
+					/* only print when present, easier */
+					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
+						fprintf(stderr, ",deny_join_id0:1");
+				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index c5d7af8e8efd..4e966a9e3738 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -196,6 +196,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
 	if [ -z "$client_evts" ]; then
@@ -227,23 +230,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
 	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
 	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	client_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$client_evts")
 	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
 	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
+	server_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		test_pass
 		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
-		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}), server (c:${client_serverside} - s:${server_serverside}), nojoin (c:${client_nojoin} - s:${server_nojoin})"
 		mptcp_lib_result_print_all_tap
 		exit 1
 	fi
-- 
2.51.0


