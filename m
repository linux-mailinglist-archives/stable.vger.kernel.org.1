Return-Path: <stable+bounces-73009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD796B99C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22B01C214AF
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73421CF7A4;
	Wed,  4 Sep 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPKAVMZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C71CC887;
	Wed,  4 Sep 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447992; cv=none; b=U9bSqTs2sXvda5ba7/SF0GbHk1EKO6T6i0AwfkEviOCUAp5JPO0GxnfoAM8po4QRKjY/Nw9+GEE1tB9oDShbtgcY0l0pA0B5EvYSMI4ZIj0bC2IqwNyNI0eT4Ny3fYQ8H1jqpP7Dh3u0oZ3CLTYNkFikfDqCzsVRjRUAR5ulnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447992; c=relaxed/simple;
	bh=BjhpgeNOaDoe9TbeeEdgwNkpIWZQkOmB7o4hPoyqNwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkByxRVTKftSjDdlZsIF9gF20wZXtV7Rh4dEAH0SMS9eD/5/Jjr5Nzql2JCZo+TP4jL/azwDNN9dnynwbD+KDg/TNxkVF43Y5FLZtA4S0gZ26R0XgnEId8ZWMCB40aI5IZU/GFnaf48I25s//TppUt2oalOdZ4TxkI3JiAjP5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPKAVMZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F6C4CEC2;
	Wed,  4 Sep 2024 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447992;
	bh=BjhpgeNOaDoe9TbeeEdgwNkpIWZQkOmB7o4hPoyqNwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPKAVMZ1w4FZJUEas6IqVMcuLcrplPeIbzCTcxjnJIOwU6v0+pg/8vYes+sy/haQ+
	 0VbsVumHV215AoNa6NsMMXf1vFoueTkGrkdlrZghKXa7hVHke+h7dmqWu/YlRx3dAB
	 U6SXe/wyECPjAxEbS1L9+Gd9Pj7GKGqOWOyeXQm125jrW/q/YlL7niYSi0xdK7lFe7
	 z02UZoi3vF/R1hyIakQJM/BcACKBdUccdIP8R8WRWaTHtGT5IHv137S8ezKsT4vHtl
	 U8Qm3d6rNC4BZnJyfT/uzrvZcYMynMzDwz446y1S0p+dwN7Jg6Uoyi4YetUiMrsCq9
	 RouYG7oI/9ygg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y 1/2] selftests: mptcp: add explicit test case for remove/readd
Date: Wed,  4 Sep 2024 13:06:12 +0200
Message-ID: <20240904110611.4086328-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082618-wilt-deafness-0a89@gregkh>
References: <2024082618-wilt-deafness-0a89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=matttbe@kernel.org; h=from:subject; bh=ScaNQ3X7skUQGD8xSIqf3NdCsCplyKVXMHD8AW2Unz0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D8j4x2m/jcXExw9M2yZFIdSFhLhbUA6IXce2 KdGLxU87a2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg/IwAKCRD2t4JPQmmg cwYcEAC3yT2Gxqe19WtjGBfGVHQnULx+//DGd2vbgWfqS0w2zBVfPSbwtt3S06rqqVEWELInldo 3SKb4RD935B/hIlxRTqpv7DCPbPe3kPt5Bda2g4HaRge98R4vhKgLDXq7sFLpvUkuQkJCLpSj6t Kl+Efb76XUGqQojwaQgO5/uLnQJy8R7KD7xdvpWNki9onhMiF8piqZOxiKZrFQinzbAfeX6fbIy MLgpkczcb4htkXtZTl4v9D4Q91NhJk41J2RESmt2EyjprbFK58nFRvsUPqPi90xLu6Yo1AXKvOi aiXqMnmYolvy0eg3kxYuRCNBziwqI9kBxnRa7/cU4IF+Y7Hp/BnjSV3ZID+gSeVzejxnNl/dP5h HA4O+new+OVVUOpf44W0S5WW/wddh7B3MaT7J/hAILq3JYn+rwM4ZSRRoJiBc3Os7pufr0rovqK pcNv5OKjwpAb2mjEVl/ncNueeroPU1GeHlvNhkJeSbfyz7ScwZkHYQVOZeWRZHUyaR1pkiLseJ+ Mz9J1awc4WKl13helmVOa18NjFl26Cw349PCqDmNHksYUpRYvso3lDTBRMRDWium40yqfjTIFBT j/inIVmDsxAMZNNNEk7fjijYrcFe1i00qVW4vNOYPJg2oAMW+Jl4ApDx8wRS/DXPV624fEZXRJf cwprRLvw/HpsAcA==
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
[ No conflicts, but adapt the test to the helpers in this version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no pm_nl_check_endpoint helper
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c54df4a6627c..549b230238ca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3297,6 +3297,29 @@ endpoint_tests()
 		chk_join_nr 3 3 3
 		chk_rm_nr 1 1
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 2
+		kill_tests_wait
+	fi
+
 }
 
 # [$1: error message]
-- 
2.45.2


