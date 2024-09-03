Return-Path: <stable+bounces-72794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD69699C1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32C2B25669
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083A1AD25C;
	Tue,  3 Sep 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf7UJBLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E51A4E9D;
	Tue,  3 Sep 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358106; cv=none; b=d1KRru9Xobgn4coSgyYBuvglIOcbBd6w5LjpVWHhrCEX7T7zl3AVUxhu+6agG4XkDy0OLg0BMeXfTvRdhnOb7EOxoNZr8czaLWD6CvShGROW/XD8ixpfsTexAt/98ezcGyh95+2gFF052JFDDIZQ2U/hCl1suHRvAJdaJz4m/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358106; c=relaxed/simple;
	bh=YDUAGoreZMhWbHrXJ2ejXtenow1Sp55e6Ka0MDTS7Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okRQ0gPrMxPT7lMRWwe26QMueCrUyV3/1shydZuGhbroM2vMZ21QUQmGrk/DkBMYb6zd6DwKNGWSA2P3bP8xiMi2rCpD/4fZAlxFywx9oketcX8mYgHu8o/QbSiShB+8xtCrkdFAl0lCcKepIuL4bxJno81qjsPcTSmv3PWHevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf7UJBLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CEFC4CEC9;
	Tue,  3 Sep 2024 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358105;
	bh=YDUAGoreZMhWbHrXJ2ejXtenow1Sp55e6Ka0MDTS7Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pf7UJBLFqbWw663Fkc3XZYiT8FE3H+/BId1mPnInr4rrH9DubzxBRikMyJL/hQZst
	 OYPmTtAvOpSuth4xic86sQNCPVO1+ASaoSXAaRYIez5EZYwoHtwozWDJcIA4sDsgvq
	 h83arx4j0/1iGt7KBd+JPVkbvgbZ6pK1oRczMyu21SPJPFC0/ycnqI4nwiUGRmcy3e
	 dJe6Pyqm0i7th3jWjC70+KqwBFSoqsHgDl3gMu+7t4JLeQQyd4f7nF7XKF3gK8N+bP
	 dZiLjZf2qLPiIhM+WEdnmjjdoDn9bsZ3/GKGV29tAMw9hh1mp2snIdT5Aj1qIT9trJ
	 cxutVSIYcoQlQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 4/4] selftests: mptcp: join: check re-adding init endp with != id
Date: Tue,  3 Sep 2024 12:08:12 +0200
Message-ID: <20240903100807.3365691-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-capture-unbolted-5880@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matttbe@kernel.org; h=from:subject; bh=YDUAGoreZMhWbHrXJ2ejXtenow1Sp55e6Ka0MDTS7Nw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uAIKdWA8/62anLwQn+NfaNMkURj06gGQLsHm 4MwQpqu/QOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbgCAAKCRD2t4JPQmmg c8e4EADqrs2OAH8g8w3p1DMN8lE4LYQKEcD2/Q19XXgZ+nkYbqzQ/FtdzzA0eeVe4mK2c23uu1w NvsQAQNAnFfN8pL8Slr+JCn9rLK+HmZKNhleQW3JD13UsVEH5fqL+LaJbAfHGR0QofAFTkGCBzu CTVSTSoQDABe8kLV9pp3zyi/cEl4E963DtQve5R6pFTeA+vOwaWQXQahCeq+vGogWgVOc7b4YkE HzTlrykE4w9iztKDKn5SFGLjH636H9FJu/ZwVbHV5we9Qey3B/yZpkdS+3rlzMDeDdJjUw38kw9 pWChBqudTM0pDLaGTE1HblYtXpOJ13x9EYAnU5DMccZBI2sgxZRXKA879CS0tr08NRRJydWO8Gn 22tv8fzjVJSpQs4ICPQG7z3eFv+GpIwvwfPDDZ4s5BWwfa+L79nBD8e1kmVt4IbyraYLCnVwkMy ySI/AGABMRzdSTpB4tZlhKAU/XtIeien8UzsRyK7hCI/NNIE+/ymcJ1sIY7U+S+JU54Zosu9sbe WsdASf1HsLcvyEK+IraJXjtj/BHpvGV5NXcWnplypINd2U7FudhMRaYmfMAwaUCwHF4n9+V6j+I MrmwQUCM9wOAVG2HeBD1jm9UCo9b8vv6g5vrW5SwEvcdgN18u+LPiknxwDo4Q65j9ajgCaFCmYP E2ACKgs4BWxc+kA==
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cdba2607b272..a338ad9b779c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3636,11 +3636,12 @@ endpoint_tests()
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
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3662,11 +3663,21 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
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


