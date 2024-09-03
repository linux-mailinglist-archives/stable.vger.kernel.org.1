Return-Path: <stable+bounces-72802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5519699EF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDA52814D4
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0219F430;
	Tue,  3 Sep 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB6BCdyx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC117C9B3;
	Tue,  3 Sep 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358740; cv=none; b=IlFomgvp1WKe/EQiSKHAKFwudH7ZnIP91WjeZVV3QVyRTtj4TPLdAd+qD9GDrvA1CvjbSPJiQ166mAMdAKkEndRFHRXvjkoZosNdazLQ5WUwH3/1r97lGQ9lFsiZeWnTtkmDEP4rgn0LMIdhBFONBeF5cWGlgBblTwK4LbO//ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358740; c=relaxed/simple;
	bh=Rsc+zCSRTuSDqOPMGWDtufrL2CbobKBlpKKsvFZ54xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkyfn5EJW2/+5z/CNkrihJqcODAkNsVQW9VD46e7maB2dpmEXO+1Czh7LWR9gZG9ce5L1WkHV1Zcln3C/ezYw8HwxwJFz03VCQdcGVsc3yZfj3BJ180oRcNo1LZ/eXG/u/NNBomPLcBY8UEfaRznvGG1oX9TSCP+mbHac6ht3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB6BCdyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619FC4CEC4;
	Tue,  3 Sep 2024 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358740;
	bh=Rsc+zCSRTuSDqOPMGWDtufrL2CbobKBlpKKsvFZ54xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IB6BCdyxjVQ83VOuK76wOUY9yPOWKEBkd9jfQcZncmSd2t7QFf4ACf7XxIH16F/b5
	 VcPJWxRRrltAPBZwc5hZUInrnnxpu4AOMloqaFQbRBf1Camj8c/nNBX5OxzsVeM35F
	 44DClI9LYwqB8gNRxLQkZSOzj//3/9+CNF51GQGqxgxB7I4gLS/qE9mA+ghmSISnTW
	 GlPAECAowFU97eRDWl9vQ3arAtZxGZgKNCGQGkjrp06JlbZArous1h7V5Q6R1lK3BC
	 eIIpvN4IVyfhXDOUMqsWs7bnVeTCQMkhiN74IlQyA5Kz2uy5M6AEHEkD5uHU7g1Gls
	 vAVw+AmT+m1Ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: join: cannot rm sf if closed
Date: Tue,  3 Sep 2024 12:18:46 +0200
Message-ID: <20240903101845.3378766-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083052-unedited-earache-8049@gregkh>
References: <2024083052-unedited-earache-8049@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591; i=matttbe@kernel.org; h=from:subject; bh=Rsc+zCSRTuSDqOPMGWDtufrL2CbobKBlpKKsvFZ54xE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uKFT+jfr+13FHD+yTJHEGo1dw5vQ+OTXmMuK uzu84oLaLCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbihQAKCRD2t4JPQmmg c6NzEACuryiYXQ+aByV6USdhvQDU1MZPrfW1Z/BppoHd1J73h9Kdml6DWMjDjfhqKEJCLR7MsGN xbLzL7zbgpk0NYgiGkqu/m38TSNXi0bC0GkPnN7L/wukPhmsu//TB/gMXOJv08f1oMTsQg1RzNS VigAj8vijAeEMag3pyI/6vw0BMyNS7ET271uAXHzPgWdFmAOzepKxlDDAxyhhMMH4Xa2aMErGYW WiYohmr613Bud7udjmZp4Q+sVoTMVeAL5eQShHHGyw/cXdLMYlnSMFh662a/I4r8XGzS7wHy3fz 9l/UOhwC+TB2KvvcCLMDpNjGrMJZ4nn1qOSBTc0H1ywgU8YhArxzqvdrYY6aA7dqabfurolH+Gx kB4ZMk/P/51lqYZ+TkV4xr4Ub1/zez2lyAQWHrwqNL8GJiw3LgxxRVcVCsbx8z7WSpLrSLzbcpf o/tQ7bS76kurNXqvH+gwHGuLfPiEx01Encz5MhsqoejVa7Ry9Wy+dodyz7kcSo0iDWboq9B1Hd3 4LGAMuR+iehC3KHwv72LuJxItA2c3HOEqr7pbBEPeDNtLyTD7CcB+FBxXnvGw63P+b0rdD70bww e2BCXXkt0snb3LgC9JJ/wdLV4Hj5lwqtcqX0sbzdo35T14afa2MMBIWDU1p630W9V5DShmNkjHb 5JjzPs/SYL3dODQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit e93681afcb96864ec26c3b2ce94008ce93577373 upstream.

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by the in-kernel PM. When the
userspace PM sends a RM_ADDR notification, the in-kernel PM will
automatically react by closing all subflows using this address. Now,
thanks to the previous commit, the subflows are properly closed on both
directions, the userspace PM can then no longer closes the same
subflows if they are already closed. Before, it was OK to do that,
because the subflows were still half-opened, still OK to send a RM_ADDR.

In other words, thanks to the previous commit closing the subflows, an
error will be returned to the userspace if it tries to close a subflow
that has already been closed. So no need to run this command, which mean
that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-2-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, due to commit 38f027fca1b7 ("selftests:
  mptcp: dump userspace addrs list") -- linked to a new feature, not
  backportable to stable -- and commit 23a0485d1c04 ("selftests: mptcp:
  declare event macros in mptcp_lib") not in this version. The conflicts
  have been resolved by applying the same modifications except in the
  parameters given to userspace_pm_chk_dump_addr helpers, which are not
  used here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a338ad9b779c..176790507019 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3513,11 +3513,9 @@ userspace_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_subflows_total 3 3
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
-		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
-		chk_rm_nr 2 2 invert
+		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3537,9 +3535,8 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
-		chk_rm_nr 1 1
+		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-- 
2.45.2


