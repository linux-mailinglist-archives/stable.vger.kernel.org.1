Return-Path: <stable+bounces-72739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFC968CCD
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001211F2330E
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758661AB6FC;
	Mon,  2 Sep 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh7czBmh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FC1AB6E5;
	Mon,  2 Sep 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297926; cv=none; b=BQ4gnmwP1upvP6y7s14n0dYmoicRev9VEG2Q3rEfwWjB25hLfofwi0ORXh+r/Z/z+VKrn/YqDfPsWo0V70Ch4h96When4KHeJARAPDMiS6k+AvtRl+SFrvD0w9+zvOdeCSY0+e7SmaTVPlVQtIF0Q+RJDjw+Un7xMt/07PT2p9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297926; c=relaxed/simple;
	bh=HfEJ0Z05Kx9lyhLN3PaWIl9Ko9x3cx47r0Izb7al174=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNiaNSnHuhdhOB+PB/O0BDECUgnTNo9TATAzBd+jcmACcuN+nzWwyLfqBcpzs0Tr4SH9cEvL3JUtZETO5W2uUEGjlEVZ9z6y5fZYaCYVbER//hKpKflN9qRLBxAG4BsLhBE+/1ZwdTAy9o8Etpafv5oLYE/g6wH3w5wiF3VoL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh7czBmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85740C4CEC9;
	Mon,  2 Sep 2024 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297926;
	bh=HfEJ0Z05Kx9lyhLN3PaWIl9Ko9x3cx47r0Izb7al174=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eh7czBmhyyQ1OIXKyRjvjD1D2rQ+QBAbNGKzcCL8sw+UeBKE3BdqNADjZd/i4Z6Bq
	 h4mawc017W8g+NgAGIn38aCZUXZlhkaH/bPAmSIezB8IqdHTWlqb4ReAQmYfV9OCE8
	 ZP3XFOcQUeV2llYRfHe8gomlu7q0/xbCqWqnC/zfPJIdmFbgnlHUpqQKz2gAhJCxxY
	 0JaJEkO/l7+/akA6nPK0JaHZscY5zHRrNg7VLNYeX2Qh+VrJMdseGbnj7XZvyX7+3v
	 LSXsU1S+tbF66WqzmWNyd8qLPWlQFnADTNWQKSrT7CRx0uok99nmiY3N8DwLTl9wpA
	 LECSdLRlkQU0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.10.y 1/6] selftests: mptcp: add explicit test case for remove/readd
Date: Mon,  2 Sep 2024 19:25:18 +0200
Message-ID: <20240902172516.3021978-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=matttbe@kernel.org; h=from:subject; bh=U+jI+zB7yyY7VVqn/y5l2bv90xABV+gkSkncZtwgTQI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT8wRWd1RXk6xMQfvU5l+yPRD1h9mul0ySwD FQtC6uEr5yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/AAKCRD2t4JPQmmg cwzLEAC53z2DyMTXM82wq8QuNxeEGlXObeS69CeW/KC40dWnxd+eH1ssxyVdix9lsVhSDHGGtE6 p17QsQBJ4erIaU0KZmerxVYodjeTAy+OYA7BxtY76aTW4ZrqEOUN/LVrkPEYBhWrG2mE5eNByPp KpUXY829AeiLRU4QhI/uuZ8uc+5bNqVYBh3ly+BlgC7jMw8Py4Sv6vVjCxiSolqkuX3mSZJgTrG 5TZFnLzImnRtrD4TWGRIIvUhherkqSlzV1tFyi6IOgN8xKkQL8QkZ+mG+q2bygJ7SSsHNsGYvKN wCsptcs9uEIDbJ89E38EE6PELKZAbJvU6jWF9zjjF7zKvubP2XUJv2YSe70x+8vP3XEydkHvMIZ GFa/gvjdKUvHHtXmyPydxnV6jpd2aspM/7fnpQMf0rpnjKzoD0EO4/aS/hewwSYmA+2gFIvPchQ bU6uEYP1JrnukznB8umSXCSn7AZjGepdXtJS5Bv18YohxYvATZZRyWX5xW9sRJ9PFvp30AhgYUe 0Q2FPdN5G9/e2W1nM7StvMWIZMOmIdq8YOhQbgj+4hmtVkezNbo5RUN3twGtTLJ5SmxAYSV79Vd NfuLXTXEVsBIhOVEnM/W/ZPAd/8N0sJ5prNmXeZwPm1qXY9ur8BlQPYk1Kbo6z+BtMdOs79s17F eN0I+f2N8FVG5qg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit b5e2fb832f48bc01d937a053e0550a1465a2f05d upstream.

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c0ba79a8ad6d..fb2d8326109e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3626,6 +3626,35 @@ endpoint_tests()
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns1 10.0.2.1 id 1 flags signal
+		chk_subflow_nr "before delete" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "after delete" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 2
+		chk_mptcp_info subflows 1 subflows 1
+		mptcp_lib_kill_wait $tests_pid
+	fi
+
 }
 
 # [$1: error message]
-- 
2.45.2


