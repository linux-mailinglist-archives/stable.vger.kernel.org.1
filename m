Return-Path: <stable+bounces-165646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EEB17050
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA191691C8
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB202C08AD;
	Thu, 31 Jul 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLe/2p4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C32BDC38;
	Thu, 31 Jul 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961058; cv=none; b=FmkylcbBwzniQSCjjVEu/oVDCTz7hRM4GkkCbgwDHy5bpUdnHpW8Mng9ZVTnLwXOgUI2lfVnakuxBzAG1DDs/NV+TrHjqPUPixU9bJu4ke0MI54kbQw4q/l/Utv2IsfBvGKT50oADyEghXWlyG2z7lzWBpof+zsE3ttP7YqvDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961058; c=relaxed/simple;
	bh=QIi4OnFPyi1q9PY3zHhv9AGFDh6nq9BB6EBl5oXwrDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLxRqbKZeqJ5p40P6njjdD334WECQLL/B19bRR0ZoG5G8ttm0uLtYWfUZuxO39i9ovI4kQxodixRyFGv4HnkAd/HqH/MdnFnqkPZ+v8ShM6yEFIu/06y/xY8czU5NMzJR+50kLHnM8JTbQhBENzSwlF2t9k0SEI0/zDUSeYbJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLe/2p4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFEC4CEF6;
	Thu, 31 Jul 2025 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961058;
	bh=QIi4OnFPyi1q9PY3zHhv9AGFDh6nq9BB6EBl5oXwrDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLe/2p4QhhfRgR67Vcu5zTqsledMv0Q994nx+Cw3t4xwpblyAAXjUQw5xAFYo/4k9
	 GFqLxSGYxUQk60yfVjYSamtVqxZkUuTesCzEKNsNpZ7jbDJLmesu3lBLn0d1ZRIrUy
	 sPpAumPfKJxIGqqyHor9qyGUeS5SCKd1WpHSgN9HaMPzYu/TvGhenwYnkge/3qx6KL
	 H3Weu+TjlkqBLQ6ziNzd4EgFEMoRNRHvnYpUZOOt22WwMK4HzEfItLPS5ogKky9V57
	 OziFxak9QKXnr/H2jevtnoWdUqejiLVWiTXc3ayvdxFLwcI4YEVsXXvzwT6FpC7z4V
	 S+kvVFeJZV/mw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/6] selftests: mptcp: add missing join check
Date: Thu, 31 Jul 2025 13:23:55 +0200
Message-ID: <20250731112353.2638719-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=matttbe@kernel.org; h=from:subject; bh=Tm6WUpa0BQKwE7MrXJ0pzaot8s0NlBN6lvVjqNU5XS8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g/y/HJkqq919pfvrsu2nZ137VGv0vV32iD/PqpRTt 8OP7p14oKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiS+4xMny16JNMO/8ioiZo h+PrVq5jDllMOm+28F/7rPm+6+Y5S1NGhj5zzs7XJsv2irIFJN6ZfOr5oY59szfv+P8mvVHEgcu Xjw0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 857898eb4b28daf3faca3ae334c78b2bb141475e upstream.

This function also writes the name of the test with its ID, making clear
a new test has been executed.

Without that, the ADD_ADDR results from this test was appended at the
end of the previous test causing confusions. Especially when the second
test was failing, we had:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
                                  add[fail] got 2 ADD_ADDR[s] expected 3

In fact, this 17th test was OK but not the 18th one.

Now we have:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
  18 signal addresses race test   syn[fail] got 2 JOIN[s] syn expected 3
   - synack[fail] got 2 JOIN[s] synack expected
   - ack[fail] got 2 JOIN[s] ack expected 3
                                  add[fail] got 2 ADD_ADDR[s] expected 3

Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in mptcp_join.sh, because commit 86e39e04482b ("mptcp: keep
  track of local endpoint still available for each msk") is not in this
  version and changed the context. The same line can still be applied at
  the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 145749460bec..06634417e3c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1138,6 +1138,7 @@ signal_address_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal addresses race test" 3 3 3
 	chk_add_nr 4 4
 }
 
-- 
2.50.0


