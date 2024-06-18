Return-Path: <stable+bounces-52659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FA90C9DD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E690D286A21
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762E181330;
	Tue, 18 Jun 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSuHCjSR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E16433C2;
	Tue, 18 Jun 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708238; cv=none; b=H71MzvDFCJhsiTqHoakLOnaRR/gfW/783GDN//1M4h3ULjtwlgyR1MY3311BPrFUwOVH8xd18mdeLX55YvIqz3pJwH75h8Q+flXgzwPA2N3yUb1h7mJWr7tH7CVMIjy6ZJwooCz9P2i5KKrZNsOrWt5BAgBh3vY7iJJIjpdnJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708238; c=relaxed/simple;
	bh=Pg/zoYaHg6Nq0pH4fdzRzo24b6q6TdTVnb8ny9dQAlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tle5ScorZYrjZVDQ1ina8gaNKRd5vfHpNV/mJCMx9k7QGNrOUsEvq/YJcH/AaESZbuvEOOc9lWKDlaJgozP1erIilsTv/cRM5U1UvP+GMjEMfcFihy8t3TvlgqKOAg5qsoEq7LabAygfxgsxJbcyM1O8Q5dSeZnLd0NdgccnWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSuHCjSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C633AC32786;
	Tue, 18 Jun 2024 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718708238;
	bh=Pg/zoYaHg6Nq0pH4fdzRzo24b6q6TdTVnb8ny9dQAlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSuHCjSRAE2xcFyojGYm+CvMfUqlEZw4fF8UqMDfQPwyBnLoVSAtezDTsniaDl/Hk
	 /tpu/G/lWMXVHSnChXih1Z5C4kO1YZ00Djby8gJBDHLus0N8RmOOTrmV8OrUllxa7l
	 HWL7fzAGl+TADJrJmE52gAxyCl0R2luJgkcAjWadBn2AHc0MHpKoBArXY+04HfVFJK
	 PW1wg441qfM0bYfQpc0OxCwJ24N51JLmx7OQmaz3+pquEIPs69CBo3MyU8/LUlPWS/
	 PtAkRh+/PjbYWA99MREzGBVG8cikEUNcuQxsgWOSgRBI+N1SLd9GEiviYLeJNCDY1j
	 f492eynMWy1UA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
Date: Tue, 18 Jun 2024 12:56:52 +0200
Message-ID: <20240618105651.469961-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061737-stove-fence-8c34@gregkh>
References: <2024061737-stove-fence-8c34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=matttbe@kernel.org; h=from:subject; bh=QiFRrM8UaXyOozJVHuKQPE0G4468ghV+G+vOScTrNuo=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcWfzQWM2vnCpsFtnT35qlwSfb/3C8xIuhbNa5 KTOLIGGjgSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnFn8wAKCRD2t4JPQmmg c5CZD/9N0GaDAHD7kfJr+eYBK/QuW2OYEBCZtddoKjPtRUZJPxI/ubVtG15psLaCKoNW25ojmga bHapo1J1m2CTWaSVBOktbPpAwcODSgNwbThsSvz46DEZb+aq6MNAFHKrGMUE9r9kLTF9eBXWDcN fTkN3TK7bl7A/2PMB1wUjmEzPdS1aCmHRWOVIAgmB16pOQdbjqPOnekVfRHO4LOPdDy21rCdDI3 FR2iXgJIWsHhIk2ujRoBOmMf3iQ/u2w6QoNvXikPVnRWqw62537OHqyatxfa1JxRRMxa0Bptnsu 8BMsHYy7QtMgF848LxSihTxyQyD4d6aP6/yCTkQPAD/wzmHEya3OHe/npmrERiOeH+ttSswvD30 47fNFOUXiBIAUMax4WZ1iXffH951GWwQk77KEeA7lkA/PD3VbWV15Ako66IKxIOIPPw2d0sNwUI mCcWBSQdTb+OKwvoiiDGM5j+AtQjK7aE8VCFDebinrGhG+DcvgNVBN89fODMgljLK140N1IC94L LdOdcsYyNY45g2AG1lNEl4yHKVILod8MHhsdpxGNqTAaH6V9ZhC4YCq7yrt8wCYgRgtUkTcIZrc BudHlHSMsqLzU1YgYV3Bvk2IUn1wO/Xgj/kgvEP6XNqaxr3iYI+E61yKC7pbiMKPQbJpX8liaTp kp/yRtnndqjP9sA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: YonglongLi <liyonglong@chinatelecom.cn>

commit 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9 upstream.

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-2-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c because the context has changed later in
  multiple commits linked to new features, e.g. commit 86e39e04482b
  ("mptcp: keep track of local endpoint still available for each msk"),
  commit a88c9e496937 ("mptcp: do not block subflows creation on errors")
  and commit 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking"),
  but the independent lines that needed to be modified were still there.
  Conflicts in the selftests, because many features modifying the whole
  file have been added later, e.g. commit ae7bd9ccecc3 ("selftests:
  mptcp: join: option to execute specific tests"). The same
  modifications have been reported to the old code: simply changing the
  IP address and add a new comment. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c                          | 5 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 651f2c158637..d78ef96a88cc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -757,8 +757,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			removed = true;
 			msk->pm.subflows--;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
+		if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a68048f1fc5a..3cf4f9f05956 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1307,7 +1307,8 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	# broadcast IP: no packet for this address will be received on ns1
+	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
-- 
2.43.0


