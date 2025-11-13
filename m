Return-Path: <stable+bounces-194701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51FC58767
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6E4A7068
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBD2EACE2;
	Thu, 13 Nov 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKvFdi9k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AF25EF9C;
	Thu, 13 Nov 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047411; cv=none; b=Yg0lcWVCy3s0EwsZvdDmGrGkYfsl6OE9tmNw3wSB9+e9QYl1GdG3wydFOlB0s0DYE+iNWum1GfGY1gASly7VDFoR3sBRKwHiIO3LrGHZ7wPp9hIVSWUpIOXMOI+Q6x1INZYrwkDQXwzPGly1a5GHebLI4O9gt+REwRKQ5k3dL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047411; c=relaxed/simple;
	bh=d9PhCmAQbrZluboZNdUsSmy8Hk+VX5BfUP3Vl7V4KDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9gG9ZlcoB3mPP/dQ+CCesmeC9sQpltscvA1qY5UqpHqvgzSUxxovb3vnCLvpATbkgamKQXZgBg0y0Y7J6RejM0WuWnPAHRE7cbSBPE4VyUYmMWXoQVv+8ZbcSNIkMdhPkaIo5AtbI+inUieDKHHvwySaYF6OaJe8oZcSOaCiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKvFdi9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F84C4CEF5;
	Thu, 13 Nov 2025 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047411;
	bh=d9PhCmAQbrZluboZNdUsSmy8Hk+VX5BfUP3Vl7V4KDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKvFdi9kKpHn6Ew12/6uzHcqEJl0iYi56H0x2bCOunD0Q9kwG+UvUX1DwGLczx0QI
	 R/hvzCNTxeE+SfJC57JNbJOUIDyWK/81xrWNKF91l6DpTaamuOwpTfMzqjx1N5OCRB
	 JdcZ+RsyIy1clIlAYB6aPmHpCtyFxMJzo71ygub4So7lE6Kqzg/7b9hErwJV/MaUXj
	 0+Xc7ms1YF4IYQQxuBa2C9Epvz+1vQIA1s+kvRtn+AMfK+m82GgscT4bEMzr5kJ93G
	 EZxhD39Ute+39TjU/vfg3nDctTNp8Ty1lpB22jvgohJ0EkFibcqxcvgPS46V8cVmnS
	 JUETJt2+VuizA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
Date: Thu, 13 Nov 2025 16:22:57 +0100
Message-ID: <20251113152256.3075806-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102646-unwary-premises-4a2c@gregkh>
References: <2025102646-unwary-premises-4a2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; i=matttbe@kernel.org; h=from:subject; bh=d9PhCmAQbrZluboZNdUsSmy8Hk+VX5BfUP3Vl7V4KDo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFv18MuMlm+JNd407DpCcZkRF8uZFOf0zSD8dGVkevt KqLn9nTUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGX1Qz/dGxqpM3qC3eq38gJ MNobw7yHWewa0yuXddndrzqVH0ncYvif9OzVxPmaui3lYpcsDzy1vrhKPj5bxtt06yQV39tNBvE MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

[ Upstream commit e84cb860ac3ce67ec6ecc364433fd5b412c448bc ]

The special C-flag case expects the ADD_ADDR to be received when
switching to 'fully-established'. But for various reasons, the ADD_ADDR
could be sent after the "4th ACK", and the special case doesn't work.

On NIPA, the new test validating this special case for the C-flag failed
a few times, e.g.

  102 default limits, server deny join id 0
        syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 2

  Server ns stats
  (...)
  MPTcpExtAddAddrTx  1
  MPTcpExtEchoAdd    1

  Client ns stats
  (...)
  MPTcpExtAddAddr    1
  MPTcpExtEchoAddTx  1

        synack rx              [FAIL] got 0 JOIN[s] synack rx expected 2
        ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 2
        join Rx                [FAIL] see above
        syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 2
        join Tx                [FAIL] see above

I had a suspicion about what the issue could be: the ADD_ADDR might have
been received after the switch to the 'fully-established' state. The
issue was not easy to reproduce. The packet capture shown that the
ADD_ADDR can indeed be sent with a delay, and the client would not try
to establish subflows to it as expected.

A simple fix is not to mark the endpoints as 'used' in the C-flag case,
when looking at creating subflows to the remote initial IP address and
port. In this case, there is no need to try.

Note: newly added fullmesh endpoints will still continue to be used as
expected, thanks to the conditions behind mptcp_pm_add_addr_c_flag_case.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251020-net-mptcp-c-flag-late-add-addr-v1-1-8207030cb0e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied to pm_netlink.c instead of pm_kernel.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ I took the version from Sasha from v6.1, and fixed an additional
  conflict in pm_netlink.c, because commit a88c9e496937 ("mptcp: do not
  block subflows creation on errors") is not in this version and changed
  the code around: check_work_pending() is now called directly, followed
  by a return instead of a goto. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index df46ca14ce23..e94b78a8b0ef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -532,6 +532,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		check_work_pending(msk);
 	}
 
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk)) {
+		check_work_pending(msk);
+		return;
+	}
+
 	/* check if should create a new subflow */
 	if (msk->pm.local_addr_used < local_addr_max &&
 	    msk->pm.subflows < subflows_max &&
-- 
2.51.0


