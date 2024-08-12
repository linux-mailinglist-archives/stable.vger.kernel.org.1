Return-Path: <stable+bounces-66755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143F94F1C6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8752842CD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658E186E33;
	Mon, 12 Aug 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAd7Xb1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B051474C3;
	Mon, 12 Aug 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476667; cv=none; b=urIqhS0cO+00ajbF/Sl6Unv/tHOa9FFTj3AZMdqQBmQr0StyKhMLG3qvkt87rEdZBCpqNoTZO5lPj1AvfbPCR0zClrj2aPiq0GQ5FiO7OJTq9Z45WEvgqYwcybqA1niztC4+sodStq67FD/6wXR/EYGkCEsEXKJv64ObIY4YvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476667; c=relaxed/simple;
	bh=6hz0Q3mMnY9oJgh1v4GgRI6fwPbfWcHKLfCScW+bfy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX7FcvRmf8Uk5mBFtU9Z2hWYI+OBkBYoyx5jnHXL/7U5/YKVeohMtJCVkW44XB8/R8b6eDJmeyHyk5kX+6jZlW7w1SAI+OPCnoM23JoWVvX/aM8FRghFHmiMFjOdjjBeC5hZB7lYZFSijYDzXse69H5582aNq7NKYtpjDN1rCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAd7Xb1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD53DC4AF10;
	Mon, 12 Aug 2024 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476667;
	bh=6hz0Q3mMnY9oJgh1v4GgRI6fwPbfWcHKLfCScW+bfy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAd7Xb1vO8j0iqPe9o8GQja1NbwFrqNDhMmvBXruPqo70i2Y2Qc8BU/43oYbYmk2V
	 vidP4Vwiq90KnYQdiKGmHxutk6yNd+2EkhumP7SVvsYbgKmiHHrA5hFeRrdeM24xmr
	 XbVHr+TKc9ZREFL43ZGMfigYvz7CEgSGZpLwozrGKWaSeOuPL/MGoDo4PVZJ0xidFo
	 rErcdcHUHeTERHEaY/x4W41uV/FDxtDtPNCmnQdu/O/MkBvI4z0mgUGtXmE5pQe1y9
	 K+7iCbo6zAIhCsSMtRZ1sCfIj+K5ZdC38jws26Vv6Ao+QDVrvork7KGGkUKq33j/BH
	 USL0+XN03IcoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 5/5] selftests: mptcp: join: test both signal & subflow
Date: Mon, 12 Aug 2024 17:30:56 +0200
Message-ID: <20240812153050.573404-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733; i=matttbe@kernel.org; h=from:subject; bh=6hz0Q3mMnY9oJgh1v4GgRI6fwPbfWcHKLfCScW+bfy0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiqrqO5fJJiB/b9ez0smT0dHDx3f9ObS1Gkin qh/egAAazyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroqqwAKCRD2t4JPQmmg c/xXD/sHB6A+SM4k3gG1BK3C+ZfFgdZQxopNlRakoxeRULajgoFel+kCwsGkcOJBpz3flMzBEkD CdltHpL9psrbxfaULHmFD/kjHj/gP/16Yzd9yLNj/dcOCjDd1vlLzPSstgghBiipR7+3hkAVN9a pxYqZKbPnEQEqKN/IP/2Z57mF1kuOHAYwrO4Y1ZuZvjGogpQALe692aCdTMvO0yNrXbveW02O/4 jRfoOLJpZTPEYda4mwQWgTghk/G3xjhJV4q7ymGXPFdqY+hwwJzMFQ0coyO7cN1nfcsdNgJUsCx QTkX/ncu7Y/oHcLHDp9hyNRslFbMj7A/xA1ZEM/rds5QDGj228LlLRKFJUO9dvVOKtImBWLD6fT KVaaD2gbFdh72OUSQjqBQn+hf3WNcvBku5I2Z1j0Rt+TLzFU21CzWrY7L7M6+gIZ1ZNademmRtd z+Fefq//w62ZZOiJP/O272Ku/0X4HbgwF2689B5JPtUl5TCdfDlRWpeHfNtIcZ9M2LYPbbBHe+I mXqKjfa8RywTPjAMe+NtV7edaoeJ6eLGFZb5lfcCzhvn8pWNbn2fXhMADTBST9/aNJgNrnKUmu0 lFviPiUg6mgZHWv35NzLrF6U6ATflF4L3WV0e6T+OuQTrXTgDhlkWdMlNdc0w02cXdvYWimosEM 6fwOhBIpWSfdErA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4d2868b5d191c74262f7407972d68d1bf3245d6a upstream.

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-7-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ede3661607ef..b16b8278c4ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2133,6 +2133,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-- 
2.45.2


