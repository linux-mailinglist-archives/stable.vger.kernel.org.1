Return-Path: <stable+bounces-55786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F4916DF4
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B10AB252B6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1245172BC2;
	Tue, 25 Jun 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekhc5X8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28A172786;
	Tue, 25 Jun 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332566; cv=none; b=m+Irq7lehXpqZy+Ns95Z0f20x8CgrwP8uKek8gcC+ulYu0idrBShv8+TD3HJUwqeJaqlonjsqlsYFbzDN53il5/aQsyxKumUeSNIFZda2lob8eRxBqdUbCjoj6BtFRkIAb82sBPiB46+NvaMwgTzZpbRYxxSuRjLO37dNgXDr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332566; c=relaxed/simple;
	bh=xDPMbH4FyPNyy4/xjS+OdTO9iGRD3pdnXo6o1gzHvuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M60gFYox03IVkyY93miEmzToJ/mOykHO3M03sBCLmJUvtKAg7RDfBy38CuVdAOy2yQbVQc9nPCrdFF6wxlRF+4XvS0zD7RFSrHhfJupC0HswxuNr4z0TgMD8oXBTRJcrTcbKA0NGA8B6cPuhAKf3UPyz9LufVSS/fAEZDtRBPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekhc5X8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5BC32782;
	Tue, 25 Jun 2024 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332566;
	bh=xDPMbH4FyPNyy4/xjS+OdTO9iGRD3pdnXo6o1gzHvuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekhc5X8kBiFVBBfjyJTANwyHJNijQiU52ZCx44QLDkX4tasie03Id0ym+AqJlAys7
	 xhQAWE6jZGa0qHLvtHPhm6zMNRdO6NMz+z7y4ZAK9ioay3dFB4JiViTOWr6RqO0mzQ
	 s0U+l3Oh+dDbZxAhlwFmUQq2PMmGvRNa8z6l+WpP3Fb3AmqpdbiiER+birzv5qECT5
	 UvetAtYmOpiDX9YvZS1i2Q7bCLvVi7PaHoW4qQgrjlMi3nSJuemVF1MK+eHbk8plUn
	 XOYnCtTXEpHHYY0SqFT4gWCBPbZT1FrUQcX3eoIWDAn+4gHFR/8YToNNUQPHPZxQC1
	 qxk+4qj/XPIvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/2] selftests: mptcp: print_test out of verify_listener_events
Date: Tue, 25 Jun 2024 18:22:11 +0200
Message-ID: <20240625162209.3025306-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024062405-railway-unpack-e903@gregkh>
References: <2024062405-railway-unpack-e903@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=matttbe@kernel.org; h=from:subject; bh=+yijt30K5JTkGJa4CxhzAPrz1ECixQcBGpIW/jCCJ/o=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmeu6xfyvswxRGew7QB2cmFumNTz1Qr/Urn6ckq GUCym49ilGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnrusQAKCRD2t4JPQmmg c7p1D/9RVNuVCrLw5uKobnr7w91zlGR3VufhQLJCvIueiBkZ/9i4cK1CCD1XpMlqSXVSgCphwwJ GluInDAu2wstBFeH8g07gAJtp5Zt5aXgiAkYwAXhOSOc6GcoUvXcWC4gBuf2ciNbMVJONyKscyg SgZCmLO9f4I+JI95+7G6f9JmX4Y9THXF0GyX4MYM6WeZ4mN9wX6fZ70NMuUfdoY15/e5PJMAgdm 9nJzvy0MkE73dB+FkRaJWx/pRYNbEKlql64tQy+Pf5l9TT4c+BRUZBfgJpvFK4T5ApPiHyEPBcy ZKpu6B1mYITFmCO614jNltczHRDFeoVtBNrtF3WngHE7hp3n8tSpjgI5bC6K7IoOWIbT9G7Q/om OSfihasJ2Rvha9iC5sxM6VPI6s0slQyp150RIG/shFqOscu0/uqwLLoQZmJZ/uhduEKQ7htswxb VG/0R/tpTy1E6MNILgsbejlQSmWO5FexRKK53TkosnDg0HUqkFE1hDsNEMibjyGxnKE2OGy9ii9 vevauCyvJJym8I58jbFoqYorGexQFWSA/kIz8FIPu/hwfgN0LwFVmpUhSQcK8oPZpaP04rMVrp+ Wj9bucX0GSCspKCBOBXFEV9ekp/DRcDIuyWEj0SVNPGNK/m/NgqP6RGlaii0frJIhfPvNJ1Rc4b +VkXimP6v+OrN9Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 8ebb44196585d3c9405fba1e409cf2312bca30ac upstream.

verify_listener_events() helper will be exported into mptcp_lib.sh as a
public function, but print_test() is invoked in it, which is a private
function in userspace_pm.sh only. So this patch moves print_test() out of
verify_listener_events().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-12-4f42c347b653@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e874557fce1b ("selftests: mptcp: userspace_pm: fixed subtest names")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 4c62114de063..305a0f6716c3 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -917,12 +917,6 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
 	type=$(mptcp_lib_evts_get_info type $evt $e_type)
 	family=$(mptcp_lib_evts_get_info family $evt $e_type)
 	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
@@ -954,6 +948,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
+	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -970,6 +965,7 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
+	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
-- 
2.43.0


