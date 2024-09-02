Return-Path: <stable+bounces-72742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54F968CD0
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFB1C2271B
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6819F129;
	Mon,  2 Sep 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrocUqjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB581AB6E5;
	Mon,  2 Sep 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297932; cv=none; b=I2H/iqQYiJtpRlthQsfF9TKHnB2C2nFuBmiPIubCJBYkaM+5AASZ2IdVK/xzrlU/O8cSIA8bjnjZNgombJaPP6dorM+YVexrURUcux83i1R8VJJG9TxpxGvZrpjh9NMYRGnwsJ9muqWPX8K2gZTVkU9KI2Df6DeFmhjjVNYsdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297932; c=relaxed/simple;
	bh=UEuQirwcMZ1Nt07SbxFTn7blzZQl63kub0Cvm5WliP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv/MdfQLQ/Ptqx/7KH4H4pYuQcWG/+0gEkjCeUAG1NwYQzUm01xyqjv/1Ysk8dUPH5bYb3CXXhKo3Ai28zmggagmLYovxM6cmZvBsCfGGRAxJ5T+OrYmNMAbSmn9EHkWhH3P7Y3pVuWi4o0BMc9FdpTIBnb57XvQvWp9CKU/22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrocUqjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684EEC4CEC7;
	Mon,  2 Sep 2024 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297931;
	bh=UEuQirwcMZ1Nt07SbxFTn7blzZQl63kub0Cvm5WliP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrocUqjwist7ysMjO56ENJegqZLG06soUbq+roPEVd94LmDCaSDYYLdpYLUq0KuVQ
	 m/pCGYNaXOKuKSOJrLi3/CTEsolWo67FZHD9LG/ficgT9p7PEz+GXPrUBgCL77akEw
	 WZ8KCappl3QrYRIwrDtxftSzKvfccno88s5wAwxDF0P0EyU4zMv7WGTDGVTo7Lx9wP
	 nosh5XEYU8LRR5NPPOiw+y5mJkaCjCJO0lELKIivp5AF72Cye6vsPRwlvgkRJdcTjt
	 D0FxnKv/CDghKhg7KLWBdsIHBjgv4BkBT6eQYYyt+tPrc4s6GitAso4eRVdm7Ueekn
	 wl7YXVAPD5iQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.10.y 4/6] selftests: mptcp: join: check re-adding init endp with != id
Date: Mon,  2 Sep 2024 19:25:21 +0200
Message-ID: <20240902172516.3021978-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matttbe@kernel.org; h=from:subject; bh=UEuQirwcMZ1Nt07SbxFTn7blzZQl63kub0Cvm5WliP8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT9OqOcJUf7IRJC8SvlpY6hNi0Uf7MK/vBCs jwCKLTPDMuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/QAKCRD2t4JPQmmg cyldEADgkuf/HPnz5urKPXNAzdy+eAQ8zaQV/rcE50cHKTztoAMokl67tD603GkuBpxCxvhwsAs DWMUcpcQuQSS5Crn0aA7XnJZjClPJCAwtxXTkGBLkWexabIkMbsLnPGDzeovXIFVWnWjl49ze4/ qoeknyMqKaHbRRoyCdzhume1w842S90wGa9fELvc1kAchLbI71NVRgzzqH9rUiHDclG6xldozuf /mrJsOF2XnqU3KTcu61LMD3J/W3VcJ0WxAx4wYKc6JLC6TFWJqSqYMJ9NxGKVHMK4jrmRtDSRvS xodedSsuEINYRA6UqOVgLFjj0abdnqeTgJt9yew3zuP27u097rsaoVwljYlsUtJ2WpnaSY+gdu8 Tl2977nioz1ipeg7ph5i9OaicQzP1ce7IRGNn2qfLoK5XAS3W3jDWMt0GehI6acaNn80l4S0P3c YXBmwi3Cy6Mtd2zO8rH2M0v0cMRheXfc86c0teyNOjXMPtNjWwCEZX03zEGloA3wk+Hq5+e1R4T o8O3FLm1dBaaAJMX5atX6PKqAE8TUOlLBqPnwEmTJEbmb/6Wxal+EYZ8eeqmls20F7usXN9Kx4o SYVjAiGzGOSS72xVTjXV6yHgFAuAspDIEFDncdyK7Lbays6umBDzZpnnsJGf8BgIMiVG2tnujgI GVSbwoJsA9iKPFw==
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
index 64a35f96ff92..965b614e4b16 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3630,11 +3630,12 @@ endpoint_tests()
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
@@ -3656,11 +3657,21 @@ endpoint_tests()
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


