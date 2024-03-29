Return-Path: <stable+bounces-33734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17589200A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165B9289D0E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67B4F887;
	Fri, 29 Mar 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE2IDlBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE91C288;
	Fri, 29 Mar 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723871; cv=none; b=Dti3HyqLaHK0d4CqJstC42wCFO4K/u6Q7lKr8yfMNEYpgEau9EHsgHbc/x4mwyPNJZELbSn7pEcGKaip1aifyHdNnSPdZBwYWN4cPMd0bW9TolJ5D5Z4DgwRSL3ekF6SI72/DFTafb+1iGsb/6rg+WE979ujz8+ZO9in8FHbVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723871; c=relaxed/simple;
	bh=p6bKSFEP4zGZYycN36toi+5UqTy9rKrRPNUigF912MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEhe0LN/VGCZ3akPhgNUgoVPyCuBY1i4thc7iquU2FWq1hqtTzAfBMNWiCJ7o3tWZZD9GxDds/2mTx8eO2jbkHmvMs1oJiuzjTNMyHPmPuBv/TrjwkKnOO8n3bQlGeZdirk0/VgPbaMr37/neHaFR1jzs2kT+F1Dn0BIcUaJRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE2IDlBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB5AC43390;
	Fri, 29 Mar 2024 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711723871;
	bh=p6bKSFEP4zGZYycN36toi+5UqTy9rKrRPNUigF912MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KE2IDlBajOeZFHKgq72qyYLgo3F/CifdixeiUqXCo09NgTIK0Sb769JZagg6kccSy
	 om/lGw0oLBSHuyI3MAfRR72hg/DZIM6U8a2zFuBkEDePNjYvMAKIhk3cxvZtx8zAGi
	 CXQjLS+ftAa6AAZM2EkiqW4htRsCX4t7ilITinW6hCeFu7uJiX+tEi4xzMUDkDfvtp
	 vEJk+jHVnxmKFX2iuxGXu3ISpaLJ0SpntSUS2e2bSzyIpqs8x5+lqbFyRskFdCcWCF
	 3AJykoCyvYfzyJBDt24+XeYEWHVO2suJZHVAt1PBjbf6tvZ9mSOAXfgXEdRHY4efYd
	 Ncmr4KH8UHNtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
Date: Fri, 29 Mar 2024 15:51:05 +0100
Message-ID: <20240329145105.1637785-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024032713-identity-slightly-586d@gregkh>
References: <2024032713-identity-slightly-586d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=matttbe@kernel.org; h=from:subject; bh=1CWB7pgE6SS9sV6vHVm59PijAn+MSrEr+qO/BB1X+c8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmBtVZMAQlObfiHVGoHknc1f90YxbleVgV8LDcf LzSL/yivIiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZgbVWQAKCRD2t4JPQmmg c4lYEACs4ZRd2vCtZdq9SEGfxGlFnYBNQDrT38P9brGj49sZ7cWN7WoO/6NfqZ8B80IUiFsIgiT GmdS7/jBAekC8jDyXrc/81BKzNAcMIIioV0kG27KrFEI8t+7T53AHczA7D40ACgUbjEVekIoYBj 4hS+nzvfBO00Rolfx79ZV4aixzzLnFQ+Tu4qbr3HDKLboiKr4CS1Nr6a+bhK0RUqEXVKJfwVYoF dN9SMet7ZSYX5mvJx5MJD3JJkP3Qo7FuPHZXNToy9lXE1KjV0GWjQKpKa+EiwisMYY0FSuWIELm JeQVcjIp+NSTyie/LRs0WqNr/XhWkyDlgy++6WfJ1NLrAJ1lFn+Fg2jkf55g67gcLtnmE2qE8yt JhyWIWHAwee+vLqeAhSV/0Z+P6O+JTGybEQzYGCQPPh+ucLXX1E66jveCx1CZdvxxTGhyloQ0Jf HDyA2oEXac5FB+DNL3gnE4qVR6C96JVMaTGehhEPjZD13z0aa7TGGETh09t/EaimeC2zeGtYc2u 4feEdNJ/iCck+xm82J5bf3toI704rK1uo5zanl/0AbOJWBjRJAGssl7xg96RV0zOfv/1USfixcP fK/irRfnguQlzD9uDKXKUjtAmpZiMEFeNcuosAzwz2FGmV4LnIq48/THq8VArR0SO9VmHc5Ibc0 e0N7NmP2iXj50GA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The test counter 'test_cnt' should not be returned in diag.sh, e.g. what
if only the 4th test fail? Will do 'exit 4' which is 'exit ${KSFT_SKIP}',
the whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} instead.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Fixes: 42fb6cddec3b ("selftests: mptcp: more stable diag tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 45bcc0346561daa3f59e19a753cc7f3e08e8dff1)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Conflicts in diag.sh because the commit ce9902573652 ("selftests:
   mptcp: diag: format subtests results in TAP") is not in v5.15 tree.
   These conflicts were in the context for an unrelated feature.
 - Compared to the conflicts seen with the same patch in the v6.1 tree,
   there was an extra one here in v5.15 because the commit f2ae0fa68e28
   ("selftests/mptcp: add diag listen tests") is no the in this tree: it
   moves the assignation of 'ret' in '__chk_nr()' under an extra check.
   The conflict was easy to fix, simply by changing the value of 'ret'
   from the previous location.
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 57a681107f73..a8178a9c1e10 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -53,7 +53,7 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 	fi
@@ -88,10 +88,10 @@ wait_msk_nr()
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 	fi
-- 
2.43.0


