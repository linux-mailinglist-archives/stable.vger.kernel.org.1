Return-Path: <stable+bounces-73024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8C96BA15
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDE9B28632
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ACC1D0140;
	Wed,  4 Sep 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQHxoK+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A671D0976;
	Wed,  4 Sep 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448556; cv=none; b=LV7ad4UkF61kwXpxZ1Jn3ebTQ4JLJCQ+xt8YDZ3wX9iVXyZzlQaSOaDU3n2a+kA2N9mhSp1Ae+Yuiy68eK1Yfi4aQMqXa2ah33EqvbVIZ19HbrXqagkaKa7b287umLW5Kix/1yn1yYizmIW6LUBCPpps23wsFa4KGzf/5YDZ5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448556; c=relaxed/simple;
	bh=FAFLbHTTBQD6IIVaBMJz74h35fL2BM6CL3lul3lrF3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8KlrQd7TMivYtgg1Y2Dt8Dwp+4n+SiJEjmBS2AfNqFo+Dd2B07fDyFxS5T1Pcwj5RxTCSWyyG1fSz2g2pR8VknTMY7DW2cs5xmiVtRsXXMW+/6S0oq9dE3CmOIh7shmuOXXhUowxn7ITAaY6W2HQMJe78daB5283x6IsojKP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQHxoK+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EF3C4CEC2;
	Wed,  4 Sep 2024 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448556;
	bh=FAFLbHTTBQD6IIVaBMJz74h35fL2BM6CL3lul3lrF3w=;
	h=From:To:Cc:Subject:Date:From;
	b=YQHxoK+OIsQ6+3QcRn0pyxgI48S1Ccpmp4B0hH8Zm3x1npg0lX2VGeH9CmusxvcTM
	 OLBW9aMZdMY0xMUKl6ubksosJ11M5dWbBhNdiGP7u4UwONvNI+zLWn2vWI3LXI0VOF
	 e72lVoG+a11hylyajjdPcrSVL1vzxgn0HqZdLA9YVTPcLczlOc11h4cAClKUrbNi5K
	 THTMbarGCv/kckps99vdlEbrLLHipWlDYqEoPUf3xHGdgv3umRowQiq7FsrHz6zLKe
	 VvzueMkpCOrzt1OYyf9SlH1XfCpC/ctBK6JgMRGG3dVTMm84Eg65oNz6mWyDa5zToQ
	 GW3ePWyep4o8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: cannot rm sf if closed
Date: Wed,  4 Sep 2024 13:15:48 +0200
Message-ID: <20240904111548.4098486-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3794; i=matttbe@kernel.org; h=from:subject; bh=FAFLbHTTBQD6IIVaBMJz74h35fL2BM6CL3lul3lrF3w=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EFklylmSaVmfHfwQOyHhdGbkzPmSORDVegSV eifndqeUUiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthBZAAKCRD2t4JPQmmg cwKKEACTmgm61CoGLmt3uyXA6tJla5bKCuJVF+TR7xzNsqX0TvSSeFKu8aUUub+pEQR1c4SI2aD thuqIKsbVgqSFBNWC5zpT+au9KvKdxN0YLVX5k6tgfROnclXcvG/vQB8TmWHI8ud1U7KH/SX7OE zOrlbWgpsR3wuD36BK65LTF1AcOrMcstBwOCDtPP8wAH3/II8IlKC3Ffhe/HPXemj/Nwfn+x/wz OOcFC7wrJwyasRtA7aQEIg0TtHmsHQruaMeJRyYCVDzVIxC3M7djm+enyHr5NrfVUQPRwhnduQl W3IwHvzECBGnreJ0P+pxCILkehU+opbgM8RoRlHM/B3FdfQ6iVXlMtD7hjH/cn/34NMavCJeEpX 11cT3hcdj2VBLVA35dRfooRrPND39axuoFPNSECJJbgUIvvoPXX+xa2/6kh5HfM4nCwPlw+UjtA yad/lw+C1MG7hGNa9Q8a0Gz3BZfCk7pTTKsNofF8mS2ykx7UQ9OlGyezH47lNMXt4L501nPY+iM vSMazQY3dWNbU66KDKAO4Ps0j6M+zbVyqobGPghmPdzW7wwufGWNRzdbURnPBYFZeCJni3sMILC F50dvLPk+hKkcVinGmXptv0d2psv3mU4IoRJSpn5+MRJGQxirQZuu3GB3MsnASlNdqZKA60D2Tq f/Zzg2flyMXrv6w==
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

Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-2-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
[ It looks like this patch is needed for the same reasons as mentioned
  above, but the resolution is different: the subflows and addresses are
  removed elsewhere. The same type of adaptations have been applied
  here. The Fixes tag has been replaced by better appropriated ones. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 20561d569697..446b8daa23e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -984,8 +984,6 @@ do_transfer()
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
-							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
@@ -1051,7 +1049,6 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3280,7 +3277,7 @@ userspace_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_rm_nr 1 1 invert
+		chk_rm_nr 1 0 invert
 	fi
 
 	# userspace pm create destroy subflow
@@ -3290,7 +3287,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 1 1
+		chk_rm_nr 0 1
 	fi
 }
 
-- 
2.45.2


