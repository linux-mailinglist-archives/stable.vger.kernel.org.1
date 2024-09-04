Return-Path: <stable+bounces-73019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B196B9C9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C32285C21
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973B1D0DDD;
	Wed,  4 Sep 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY7Rv9lT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1D1CFECB;
	Wed,  4 Sep 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448332; cv=none; b=hgJ5w7t3m0Rlvhyvv6TkStWYkRY5/e98vkL/W2QZj2rcdCSQb6o8feWqRrC8J1KbGeO42p8OlaWMioCAlk8cmgHf2wwsxeRPl83+epzkFbdtJdOpd/k1pxXMkGTPHcfB//f4HSFD8De1IdIpHkGmGfbd6zjhCe3xuaqV+kSLJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448332; c=relaxed/simple;
	bh=Mn9Xq1RALqOe66V8qfJCgdhBbnJirvfcNwkjgFWIvu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmH1pPq5SKSQvoK/Rb71690yxNZVpJ6aGaOcsm3D4+L5elPQmhX2Iwv+c8oEZ+iMASidHbmFNgWDdtXfv6C9R809YIW6DmDqAUHUA5EUpu2FYYXXCKOXJPUPa+tQE97WHyuMyieXQ/7QSbXEsr7HbwGtRD21mso2KUi/ht/HFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY7Rv9lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35905C4CECC;
	Wed,  4 Sep 2024 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448331;
	bh=Mn9Xq1RALqOe66V8qfJCgdhBbnJirvfcNwkjgFWIvu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lY7Rv9lTnjXzbfe3iGcalPiKlQ5yTcO5DQAmytt0MaQMYzOeeVg0jfc/K3EW59aao
	 5FeLrNVBWbgrKkKeuPGI5TSmuBrGjz7Fus0hhr0KOiuSnDvnmjtuyaO5dDxbJBxUtX
	 rMygPIZ+AfDVUoatNdj7plqbNRoehEONbK4+0wt60FRDMKJT/ZwfyeS3csV5+pstLG
	 73NmOt3QXvfpvD6enrw8C95ndxbuKX8rbf00JtL/abVa89OU/A3suvmjM2749mCQho
	 h3RH+aizvEItAtyuKlvij7iwyn+OI6p6FcVEpwbX82EXdYX6bg72KiqMBVDfiutcjB
	 UU1bhQCXb+Wag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check removing ID 0 endpoint
Date: Wed,  4 Sep 2024 13:12:02 +0200
Message-ID: <20240904111201.4093743-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083009-escapable-arguable-125f@gregkh>
References: <2024083009-escapable-arguable-125f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=matttbe@kernel.org; h=from:subject; bh=Mn9Xq1RALqOe66V8qfJCgdhBbnJirvfcNwkjgFWIvu4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2ECB1D/az6HnvWAjr5zNFwdCg4+FmOaDfvp4u Pd/6toL6pyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAgQAKCRD2t4JPQmmg c7GLD/9r8jxmdKoH4rFlo4czNlkdzh+K0eBmwd/C1DAVqKYsgrCkjDj0H3qu9EsIaBS3BxWx1TF GNxI17mBV7PtgEIuHvINkonamJwe7A4K1mt50HnxH0t1stqBWitYMjWhvtUBa/slo8wG+uszmmc 3BLMqMpPBHz95z1rtbA8bN0U3ckIYVA1TCE7Z+wCDicl1K5YIIyYLGc/LXDZrokPn+v2dSUwaJ3 ihQdCDkYT4OGeaVsfNGUQMXU4jjC7cyRlTP4Qc/ip1IjY+R/8r/SQZ89InGNO0Bp0fq1HXTLSd2 gmbFRFMsqB2TEvmQolZaaa019V/bpz5yij7ux+pg9CwpeSSMjePsFSwJtOzPXawy608VTNL0Db3 C5ma2HC7o9DOwmQ5pSNU0KPOoCpbkS5VXYy6wDULxWFD3ZtQ3OxqRwbr3ciuDUcsnAP7Qj4CPBf 9WPMLl3n8F0bq6PbW1r2giT6UQteuD0+aK3GHJmkf+SzOoiV3hC7cLeC7hGo0E3NnNyBrF0kAZ9 gzQbnh5xq5fQwJGsBB6JO55V8f0yFCApWzLDgqj5bqkecPlKzKXGu1wRlz+yzuRrFLGeAnfH6V2 pWRNnPOpYRlc8mR+FGbPKSRNLJ/QHDkvfFapzT8HcsLEL8s6Z/+kLeDujgNx34qxelx9rwV/Fs3 aoMxZBYGaiqHMxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 5f94b08c001290acda94d9d8868075590931c198 upstream.

Removing the endpoint linked to the initial subflow should trigger a
RM_ADDR for the right ID, and the removal of the subflow. That's what is
now being verified in the "delete and re-add" test.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7682a7e2cb51..ea1c7992336d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3268,19 +3268,20 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 0 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr needtitle "after delete" 1
+		chk_subflow_nr needtitle "after delete id 2" 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 2
+		chk_subflow_nr "" "after re-add id 2" 2
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_attempt_fail $ns2
@@ -3292,10 +3293,18 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "" "after no reject" 3
 
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "" "after delete id 0" 2
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add id 0" 3
+
 		kill_tests_wait
 
-		chk_join_nr 3 3 3
-		chk_rm_nr 1 1
+		chk_join_nr 4 4 4
+		chk_rm_nr 2 2
 	fi
 
 	# remove and re-add
-- 
2.45.2


