Return-Path: <stable+bounces-66070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC794C197
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC0B21BE5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC618F2D0;
	Thu,  8 Aug 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTh3XQBp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA718E77D;
	Thu,  8 Aug 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131522; cv=none; b=uSljVKyowevgA+sNRumHNwdHSj9T7/8wvM9Hjbp0u2mGWjkAIb6KQfOUWHFItJKH34EbAB9MImQFk7ZcDIBvKcJTgwC/NuQkS6DCCpTpe2Btzr3iK85avQyIXmemOhFNVF3eUECzjFMTyfUMRDA7/e1bSNOryUQ53OAgKXWGVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131522; c=relaxed/simple;
	bh=bihk6AFbVw0h/o9JWnp679a266rdhdNu51Bv1BDFUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaUeReauFPr/I7PdmeHvTVsc5n4KF3vIGX/WPhOhMBUOWn6b0RsTaGCdQLHU0UPtfgiSVUZbyJ9VlAx5lxv+yretQLEPxCWvvzwQ10SKy0ppG1pj/MO9BpaTWrjBR0xt+lGn1ur8zpOuGW4vDAYLF7pc1RCCQRap+w9cB9zCy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTh3XQBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101BFC32782;
	Thu,  8 Aug 2024 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131521;
	bh=bihk6AFbVw0h/o9JWnp679a266rdhdNu51Bv1BDFUX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTh3XQBpxBmw5Jzfc9l43/LSXnSNLwrZv90mHw/k2azeVKcy4e7oKMKjC2uMubXy1
	 EpYIDEaokHkmjutGv6YCOEFjbEAnicPg/am/0Ovi5SmQZt8/KgEJp87aw7QlQmY8ZZ
	 A5dVoh+hrth28nrGj4hisxsyuFUdI/4LMS7W1yhVS5bH6sXXpBlTirm38qVd6ycfDT
	 mESZTSF7VBsYR207AMvzQGQbTwYv6aPBCsobn0iVqbbf9VgZULk1/mKxZ/9JgU/dy+
	 zNHNrFhUVtgfgAUGsxXuyInFkXxEzcyWSvJM6UxAtiqoRLGTlXKZnAYhcaBJTWY7dV
	 TaexTAgc+yELg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check backup support in signal endp
Date: Thu,  8 Aug 2024 17:38:30 +0200
Message-ID: <20240808153829.2319257-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080719-salutary-trump-0d64@gregkh>
References: <2024080719-salutary-trump-0d64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4186; i=matttbe@kernel.org; h=from:subject; bh=bihk6AFbVw0h/o9JWnp679a266rdhdNu51Bv1BDFUX4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtOZ10GPcu+OaJvujzh6m9yS2YC3GIizrFcPXs HWWJodUxm+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrTmdQAKCRD2t4JPQmmg cwZ7EACDwFi4MyS3+FYl3G0Q+Gdfg42uI1PgOYUoIQYnwYs4cvcCITEk3wVmwB8QTyBOfbzpm75 aYfjAmO/Bav4Cm+QIhOfnWrWIBOzY5TvI592pPIqcaRPiSY+AJ8HMDYyRjyISJ0lF+G8nLDQe+N kq2t0SJJhG6URltLiqUb6JUM/96rK6L0R4lsbugrqTeqcrmHjfpU5kXhrMw9UphxgEYFJ50q64D e76/QeUVtEcs2PtoZXGj914qumGyBSYOeTwLv33ZHoRv2HOPVToupwcnr2Wp0EJfqXNt/CM5zGH EI7KklXwBrFaDbR7vwHAw4h+72ZZ3jihsLK3d+VcDFr/CjxLsPkJqwauF2Ojzj2OIehx+1tr8rA ui0USYySTkoyUNQTda6sbAdlBVzOmfeuWkdxyxNHexJY6ZVsvtwFmb5oWDtbk3hIbA28N2afeOj G/7rxn4VxFBguEewRNLV0+67eBuODV52DxKIIB4JVojYOooDC+nOnrzYbNcH+TFSO7C395MPGni iM5SJdr8usiOSDKC/jvFYKLfsF6+cnQMPq6G+spaXhL6gIyjCKCL370MvkLQqDnnrAkk7rOwGBv 3Is8V+IbplqLtDguTNTcRnK/O4UrPTwFwq7Xgmk0l5NiLRG7wS2fYqSXHuXPazJZYxYqifFXN3e LLzo7Q/DNq43C0Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit f833470c27832136d4416d8fc55d658082af0989 upstream.

Before the previous commit, 'signal' endpoints with the 'backup' flag
were ignored when sending the MP_JOIN.

The MPTCP Join selftest has then been modified to validate this case:
the "single address, backup" test, is now validating the MP_JOIN with a
backup flag as it is what we expect it to do with such name. The
previous version has been kept, but renamed to "single address, switch
to backup" to avoid confusions.

The "single address with port, backup" test is also now validating the
MPJ with a backup flag, which makes more sense than checking the switch
to backup with an MP_PRIO.

The "mpc backup both sides" test is now validating that the backup flag
is also set in MP_JOIN from and to the addresses used in the initial
subflow, using the special ID 0.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh because 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). Adaptations
  have been made to use the old way, similar to what is done around. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index daa437df8115..a28310764654 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2664,6 +2664,18 @@ backup_tests()
 
 	# single address, backup
 	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_prio_nr 1 0 0 1
+	fi
+
+	# single address, switch to backup
+	if reset "single address, switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2678,12 +2690,12 @@ backup_tests()
 	if reset "single address with port, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1 0 0
+		chk_prio_nr 1 0 0 1
 	fi
 
 	if reset "mpc backup" &&
@@ -2696,11 +2708,20 @@ backup_tests()
 
 	if reset "mpc backup both sides" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
-		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+
+		# 10.0.2.2 (non-backup) -> 10.0.1.1 (backup)
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		# 10.0.1.2 (backup) -> 10.0.2.1 (non-backup)
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		ip -net "$ns2" route add 10.0.2.1 via 10.0.1.1 dev ns2eth1 # force this path
+
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 0 0 0
-		chk_prio_nr 1 1 0 0
+		chk_join_nr 2 2 2
+		chk_prio_nr 1 1 1 1
 	fi
 
 	if reset "mpc switch to backup" &&
-- 
2.45.2


