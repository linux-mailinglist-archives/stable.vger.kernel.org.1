Return-Path: <stable+bounces-73012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B743396B9AC
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7450D284BE1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC851D0141;
	Wed,  4 Sep 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCoNJXNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC8126C01;
	Wed,  4 Sep 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448126; cv=none; b=EHEDgxyjwl8bXT9136JGlaRr1Rf5tLNzKuxSZJUo67C1YQv6kjEk7UD+Qmu2oArHYcg8zkJrCMZgDK+/LiEhPksux5lT8ZfQ6YMf0IJYUX8gYd9YXx19l0CdtvH0dJyrgC39sy09588H7xZ0WUYRvCiBo7lWifjxNqibMYBoMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448126; c=relaxed/simple;
	bh=o8QEhEUDjRNIlLmzv9Nr3D3NlbmlLPSQU4tjgz436lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU+BEHWoBfsKoIg/u+lRfTkYaCYVzl1dCWWDE4AKZt+vuFQOPRgwoHLlWqvFeRHxsyBH+h43EipyL8hif9Ht7Oz25aW/rGBMWsRf+3WTvCi6rQ1Qj9g6K7KShXqhXS3JMA+mZ8NFMyJdxKLXGuuOwLmb9Z1wHxr24jCYbEUPjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCoNJXNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276AFC4CEC2;
	Wed,  4 Sep 2024 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448126;
	bh=o8QEhEUDjRNIlLmzv9Nr3D3NlbmlLPSQU4tjgz436lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCoNJXNvG9kfcB++/Ds01zsT0LZvlf8Xp403OvpgfTJyf999Q3lvMFE/VRiBlBGo6
	 YtCmVMUmZNgmo389XoZ5HC0ISv6a3kC7tJtdV2LH1t+bEQ0zx8pW7eR5pA1Sj+DL0I
	 VuglAr6W2blsUCaDVL3VAVFvgqchqF6VbeS9e+DXv5/nwcItk09VyxF79SMZhc0u0a
	 cpqb0HMKc5QY/hCb6Fe5XvwkeEGlATy3aZGz813hMDzezaMSCO79tav8ED2EmUqioO
	 cWHx0ipt92ABYtCWl1frAxHVjtDFYl06+xWDgxUCgVbo/9hwycY5okENMvJPHjS2+S
	 giz4mfLnLzOyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check re-adding init endp with != id
Date: Wed,  4 Sep 2024 13:08:31 +0200
Message-ID: <20240904110830.4089238-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083019-resurrect-iodine-5ad6@gregkh>
References: <2024083019-resurrect-iodine-5ad6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=matttbe@kernel.org; h=from:subject; bh=o8QEhEUDjRNIlLmzv9Nr3D3NlbmlLPSQU4tjgz436lw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D+u0VHhub6V0V59kdlUK11psHv9dKE0JHh0h Pzi8s0Z40aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg/rgAKCRD2t4JPQmmg cwsOEADkvUqgHy5V577VZqCVMj0TVzGeVPGX4YjN3rtS7inoP0KmpGGP9Wdkzs5X5jit5cMXkKB ayJdKfX5jyE6JMVWipJJWwS6ggpsjxh5HPrR1DqVcfJpc0sGvsHDkDj0fwkFMtpovc1Xu2wlXuF BZPwNesFU3jIOg/xBZynbV7+zO7dNkVvgrY6PVdDHELrF1R4V1o2le276ygsEjiU3R7y8ks0Jpn x5gxSWFh5dj1zHexH6UfeVCUptoYNpFFZEyqjgP7ygc6dc/ZNwspBt4YfRkN3cic3sCs+EjNPkS yzYNlnX9Dkbzz5w6zQeVIjb14YSB6hpgs2/uN3RYHxunAwQxI5FiAitdwgGb/n2C+grlbWUmSgc sC5GCr4EaJjVBpf3K4XovwO2OoTtWTNHSVUocPaxpZlbVGoumJ/bWrZC5xcH4/DdWBBLbGpgm9x pMH4Dc7Ls5kxjfEJoyGYlNoyX59eNBUXWgepVthLbYBr6uyJQ/5FW/xqRE2X0MamnPbm334fnKY btsL8Yb0gY/aXM11fFEaBP1/R21NHNXoOH1rTJ++g2dar+c5ShzTu5dAIY1R9hXBYrCs5j8mG7b chCWUoQgeGhnFgH9WIm0771RYt0N+RqrywjRfYJ/nIMKS2t6UXFjhtYUaBhsT1LoXiS1LvfsIlO +D6GtkI51pUvRLQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 1c2326fcae4f0c5de8ad0d734ced43a8e5f17dac upstream.

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID, but the kernel should still use the ID 0 if it corresponds
to the initial address.

This test validates this behaviour: the endpoint linked to the initial
subflow is removed, and re-added with a different ID.

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 57ede4c6af5e..7682a7e2cb51 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3301,11 +3301,12 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 2 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 		local tests_pid=$!
 
@@ -3321,11 +3322,19 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
 		kill_tests_wait
 
-		chk_join_nr 3 3 3
-		chk_add_nr 4 4
-		chk_rm_nr 2 1 invert
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
 	fi
 
 	# flush and re-add
-- 
2.45.2


