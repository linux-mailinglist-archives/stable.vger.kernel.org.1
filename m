Return-Path: <stable+bounces-73011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7D96B9A3
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077D51C215D8
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B561CF7C0;
	Wed,  4 Sep 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY++3b93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E41CC887;
	Wed,  4 Sep 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448041; cv=none; b=q8RV31L1r/4F8AfX9B5eW+sG0+Y5brEhFkwfwMyDmZ1/aCaOlIKfwh8L/E8pbm/NEjtb+nU2F6vyOo8iZXPMOGTG0J0aiSXb4xkRZi15ZLEWSw7mUdItKPskDDbLmcHTY3xnzoGgvcggVM5TwPQXuYHMvkRxEkq6Z2TARmZ02TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448041; c=relaxed/simple;
	bh=m4LY4icWUla+3qO49fBxLJBzBxzNOh3Eq9q1mLADZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okhq5xMGiXo3cUptukFFU0ua3XMAlwC5XlX6vBW7DRDLkN7bL+sk2KY5hSaU8j4w6UuuDNvh+0Br9IQByjyzoG9MMFmMF+eHXcQvrpVsKOTQ+xOLWJ4EbnoIBdZ2tqLMeQBwbq+tjQDBvrax1+/Y+pUVAXGRp1wq0fpX5hQJzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY++3b93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6A5C4CEC2;
	Wed,  4 Sep 2024 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448041;
	bh=m4LY4icWUla+3qO49fBxLJBzBxzNOh3Eq9q1mLADZmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY++3b93/5jIweHqAQhvLJkVmg7D8Kp8QhdD8EugqH99XXjJ3Isyo22K9v1MtN87v
	 RR2tWOnbl/yNsjUw8AmdZKfK7pjic94K606aDrHm/WOvHnzxhnMZjUyy8+QNgpY4hV
	 F01t6PnSfTKp6RnB/azHuS8iONkf2qYWDHYey2yi07AEWKs9x2vEIjxst8M91n2opu
	 SaNVLZItUjqeXfK8dn42GUlhmgIBI9GQN7uwjqOc/8nuhfJwpxuooCTBCNiZjNBf3K
	 ZimdOqE6QaD51O7+wfVAdPJ19bm5FxJCW0ZKy97A214agz3R3ywJ79ruHfwOacT3ok
	 +Q8furowpAXQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check re-using ID of unused ADD_ADDR
Date: Wed,  4 Sep 2024 13:07:06 +0200
Message-ID: <20240904110705.4087459-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082626-habitat-punk-904d@gregkh>
References: <2024082626-habitat-punk-904d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3134; i=matttbe@kernel.org; h=from:subject; bh=m4LY4icWUla+3qO49fBxLJBzBxzNOh3Eq9q1mLADZmI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D9ZOvEXbjm5SO4WdJWDdiTBqKBy0h+ajRZ3H IlkuRGZ/SaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg/WQAKCRD2t4JPQmmg c03aEACoQA6c+yjNgNcDWP1CyUdz4pbqM92YPSpYxpVnk35bVr7Uq2kHbdLP3meLKadPyIlOdYB g5Z5oPb2+qEsj+HajaLwkSpBjM3nLlwuCYVGfhNAWkQOo3msku94tkuV9woBoRKn4yDRnl9C9k/ fSisn/xvtDt+7j0opoEQWdjRoYajGhhGdSD8DJVsIVjID3QTw2w/FttHbLEvfD1hXIwUMFO1H9E DJUYOUSMxnm/2OhJLgAmB/7KZ4+xI3dU2i1TDmsGtoQoqKZ7+XyUNUFT92iCYJ8j3tzobmJa9sS OgFpPOP1LiikvMZkJDSVAmQUa/zuRqmxwfE7f5WAKKnl23zCkIN6SBvRBuY8JQRDFH/zINDcYTZ fFSW8DPUuQ6yz3S3eZU//yuXi6WFV5BNJxPK9eo5o/zMRuYVgRwLOqFv6ivsZvRDpKkRk+1fo/W KGxVRVLAI+jmiSex6ZQeYn84DTr0FiqP+gZVmN2juTdXpqChSWh5kpBIrG0nRS3ZiUaIJpN6bjT cvYnD/euGS5Z4tcySGU0a1Fb6RblVrWP4ISEsLor6Aed7dywGGtwt8rcass1WfnyXznNf7lrhpW x0tMVcf1gyRKxeSSFcYXnWTqRbSgBAYRt0ByYPAy7943OgUjZ1gbqTU+a6LgpaHpGQ+fc8mPiL7 JnYPvOQdjHum04Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit a13d5aad4dd9a309eecdc33cfd75045bd5f376a3 upstream.

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-2-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0d2f30affe1b..57ede4c6af5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3301,9 +3301,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 		local tests_pid=$!
 
@@ -3311,13 +3313,19 @@ endpoint_tests()
 		chk_subflow_nr needtitle "before delete" 2
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 2
+		chk_subflow_nr "" "after re-add" 3
 		kill_tests_wait
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 	# flush and re-add
-- 
2.45.2


