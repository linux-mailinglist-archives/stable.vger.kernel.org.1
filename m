Return-Path: <stable+bounces-180716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33FB8B94B
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A857C7E310C
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27592D249F;
	Fri, 19 Sep 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0iVGCJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8364502F;
	Fri, 19 Sep 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322299; cv=none; b=s5z/5ueAIBPvzP9CKNR0KHZ9I3HmqUozohWhnuMRTu1OIRlXM8qTjkJsBPHqciTS3/xRQA3V/WXP70YWoMZwx3eS3NQxXSFrt9fYhaARNvcJ52jobAI+eX8BZRXbS87M1em116xz/xYiOGALhQpL5/Z2JMH1LxqBoGzOgoJzsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322299; c=relaxed/simple;
	bh=8ji9X0rLDh/Hy2xMwhr0qtVmgvReDn8OvJZn2UJbZ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2W80RN4ANjM6g/tFOfGr1Sf7En5yBOJmewPSgDxxnwb6kCSaFaaY+KH01mKuVpYhWWY0Hud/hpTg75FcUrO/vztnfH8jZud9AGlS7zIXNF1yMWQC2AcD1HPYIIkioBrVxKuvVGrY3hxOdJ/y45TPyGB6jOtONa8xLodesMh5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0iVGCJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5F6C4CEF5;
	Fri, 19 Sep 2025 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758322298;
	bh=8ji9X0rLDh/Hy2xMwhr0qtVmgvReDn8OvJZn2UJbZ3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0iVGCJk9d1ueXtVEedeC5+uKvKHNwbmWM1r9f8EYITRS9VUBLL80rNrunWJOLCR0
	 77tsB+OLioNrV+hR/7BO0cBU7GTXwH6i09dg11Hb+l1S6+jx3MFnKsY6+7KYouPP1U
	 Cp+oyafk2nePhk6mI3/9eLsOYFTahogmYM4DMohMaHZpKTRD0dQPR7rLlmjaQz2FZJ
	 2uMOe66/mibAPL3vTlIs81t0LHfrPcl7vKBk+gU2ayC+curPBBUCPCiJXNJ/kwTRGl
	 fRazHfYT+zwPrYqToQ1ttCqfGrmR7X6j6ZDdYV1WUGgZaG88GOpgNvhwhc+OZeEphA
	 Dxontcg3dFpJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/2] selftests: mptcp: userspace pm: validate deny-join-id0 flag
Date: Sat, 20 Sep 2025 00:51:21 +0200
Message-ID: <20250919225118.3781035-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919225118.3781035-4-matttbe@kernel.org>
References: <20250919225118.3781035-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691; i=matttbe@kernel.org; h=from:subject; bh=8ji9X0rLDh/Hy2xMwhr0qtVmgvReDn8OvJZn2UJbZ3k=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLO3suaN3eTW0hS88oO4c6+OQc+zwsUfD/l74uXXZ6PB Walh11h7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI/SxGhssfDOfteT73+Cc3 Pvsvx3+JP/t03SJuY3C+n6db24n+txwM/7Rubdp5U6X2kDZrpNLzw4VvvjlI6bwIn8NWNKFF72Z MGhcA
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
  can still be added at the same place.
  Conflicts in userspace_pm.sh, because of different refactoring, like
  with commit ae1fa39da991 ("selftests: mptcp: add evts_get_info
  helper"), and commit e198ad759273 ("selftests: mptcp: userspace_pm:
  uniform results printing"). The modifications have been adapted to the
  old version, without the new helpers. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 1887bd61bd9a..17e5b7ec53b6 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -188,6 +188,13 @@ static int capture_events(int fd, int event_group)
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
index cb6c28d40129..a82ac12e816d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -139,6 +139,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
 	local client_evts
@@ -173,21 +176,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
+	client_nojoin=$(sed --unbuffered -n 's/.*\(deny_join_id0:\)\([[:digit:]]*\).*$/\2/p;q'\
+				      "$client_evts")
 	kill_wait $server_evts_pid
 	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$server_evts")
+	server_nojoin=$(sed --unbuffered -n 's/.*\(deny_join_id0:\)\([[:digit:]]*\).*$/\2/p;q'\
+				      "$server_evts")
 	rm -f "$client_evts" "$server_evts" "$file"
 
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t[OK]\n" $is_v6
 	else
-- 
2.51.0


