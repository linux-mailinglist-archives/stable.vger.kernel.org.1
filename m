Return-Path: <stable+bounces-66136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0958094CCFE
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB81E28332D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F5190047;
	Fri,  9 Aug 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O61ovpLh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E51BA41;
	Fri,  9 Aug 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194639; cv=none; b=XSH5Ocuy7SyE77wGNraUgJsNXEJ3Bu8O+SJluGr7eEcbhhLa2d1opwmlpVqRWQGrYQYCNIZ/QXMPuQEIkjTisWQEEgffcwg5RubpQl/OvysE/O3go+1NmGjI7nOLTnapJGDritu8ScXq2GLxThFRW6G4u44AptTWTedkWQVta/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194639; c=relaxed/simple;
	bh=duwoxd5DCeXDR1pcj0bjE0ARP+pxtx2z1iiAJBe/2s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8yJpB5B6zhi43DJk9rU2vgF8VvWSqo2uMfyVzZuVRs80xq+QNLM2LP4JFl6PZru1fcmB1y9BtmQ9ras1O8czSSiSD27uOYWXpIr290lo1x5bCgaKf3FigxJv+j0pjUzIdqTvTnasxTo4pCDHPgYszhj25yGLNYlp99fCQgFIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O61ovpLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1377C32782;
	Fri,  9 Aug 2024 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194639;
	bh=duwoxd5DCeXDR1pcj0bjE0ARP+pxtx2z1iiAJBe/2s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O61ovpLhmU3aYVG+fTj5zSgAtkLDCsMQhNKTfcAhOtLiGZb00+QulUTMIW0Pad7N4
	 mrS8snHfevKZj7KD3yF1IasTLQoEI1FijzQUDp4Wu6ZViDrP8v8SlB22NeAVnqZkAl
	 2266AxxO2RqXXC/9AIk2Yu0nLiOxhjt4lKfUNSTMhMktyy54ytJuTkx5CoVpO+xUo3
	 LsQe/cjs+bFsXPrf61q56CWeXBqXebzzCF1kycwt3HSij6E5VE7jO2RBMjZEm8H97o
	 WiCfDwDiH76CE6DnWyoHk6J0terixB/CLbHD1L0DAAMlHEWefasRAZXy3EOkdKNe9p
	 BGHnc9Xl/iNYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] selftests: mptcp: join: check backup support in signal endp
Date: Fri,  9 Aug 2024 11:10:32 +0200
Message-ID: <20240809091031.2703339-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080720-baritone-outspoken-6a54@gregkh>
References: <2024080720-baritone-outspoken-6a54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=matttbe@kernel.org; h=from:subject; bh=duwoxd5DCeXDR1pcj0bjE0ARP+pxtx2z1iiAJBe/2s4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtd0IkNcWiN6lVN/9PlxHgPD0szfoGaDdg5M1G Ap15TsHpTqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXdCAAKCRD2t4JPQmmg cwbDEADnNQq1FcihFnhQ4VZzmzIPx4eaW8jC1H89xrhd/9hdWjuA1qU6EctLrxtfZSlYaCcxlRW XTzi6nRnzKk+Krc8AEZR+ZjS6TumI74gruzGP03Av1ng8TGM6OYsZTPc4vDRgKf3EtuNGic3Siw OFC3GP48pszHyx0orLPpax8PNKIDWFcp7UvKWIyJ0koip3MlO7X1xRGCwM0yZuGk53PObi3NqFo EO62/PKeS4oin3a74fffs1EsGpG3HqjO/FCurDGCIlD9rQnI+tMbAk7pf/0FYSKHMkHk1Zn1zmr uEwGOFr+J3xKMfuQG+AQCVouUvqBPVmpR93hx0RGuE/xmQy6b+LZCVHiM2MVq4H7aFpmjJ3TLJ/ GYj4uB5bJpm6DZGH/pcNew3B1ydwwLh26PfrdSZKMtvDFQH78WOuCEKpqKqOhtM1b/c38cgOXfN srHMz6sK23Dg0697hQveIpAVljsQgqz4q4eMeTonYaYqr4/qvcnX3cbu3aU3W/xTZOY8QNkFO60 KUIdJZnp9ZXHT843ad0NgQ25ECbOxYaDN1d0aVVe5vuLQ5yT6+03BO+yT/ReRpPkzWD+DxLaEoU Kl/kYypCjtSYwVflB4EUsR1wxZSMlTxLB20ILxe7UIKs/Q9/lnbHpjSEvCiNhY0sVgljTqAWwV0 cMnCZuYCrURgI7g==
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
  e571fb09c893 ("selftests: mptcp: add speed env var") and commit
  ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific
  tests"). Adaptations have been made to use the old way, similar to
  what is done around.
  Also in this version, there is no "single address with port, backup"
  subtest. Same for "mpc backup both sides". ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 182323b1acc5..145749460bec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1586,12 +1586,21 @@ backup_tests()
 	chk_prio_nr 0 1 1 0
 
 	# single address, backup
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+	chk_join_nr "single address, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0 0 1
+
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
-	chk_join_nr "single address, backup" 1 1 1
+	chk_join_nr "single address, switch to backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0 0 0
 }
-- 
2.45.2


