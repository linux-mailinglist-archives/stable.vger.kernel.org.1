Return-Path: <stable+bounces-190036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4AC0F536
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BABE460E8E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859530EF90;
	Mon, 27 Oct 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx+IRf82"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47D3101CD
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582538; cv=none; b=QbX7FAurgDcFeOkBlVLSg2TLOffakm0e7NouvfJHiNuL3GV6AhR9Dy7KPevJ2iWGZOlTdzhcVjzsU28NzI5nBO1TuWQ+X5J5vbUcq1qCo13vXSuJlu70Ua4q1G/XeEDF26OfP/oskVdOOYZ9NG9XX3EOYBvEwJ/AoOIcGrF8YHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582538; c=relaxed/simple;
	bh=ar9CgaIixK+ONIh9qGbem7oPOmVK7TK+LA4aicrp/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAVCeUA5FURc68EPpmQODqB1L9kK7+JVbe9LkBlhfLfa08fnjQ+7neBPBcWSMCJIONRVEDxyY/F0oth7FP9Ue8qJkoVZ4L9YB3o82t3w/U4cwJnjztXohRFy0CeG/yyZNhb6aN7uZvPPeyiVglZOliUrcGbGqs6Q6pGAN2OckjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx+IRf82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF080C4CEF1;
	Mon, 27 Oct 2025 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582538;
	bh=ar9CgaIixK+ONIh9qGbem7oPOmVK7TK+LA4aicrp/6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jx+IRf82HM+buX4dIpJtMNzgOcE7JDv0dcgZEPnAruThI03kcEFym5qZat69pwMCe
	 Av9x1QAJtqmEwmp77rMVqgyDsiYWLhZbiPeBA0LBQGL1XFOVqPmzN9JZxXtifjyVfF
	 RvpnL2iFlfduy5xh5ZkuDCbkZGN5ll5tqmfco0cG3jR6nvRV+kd23lpahXpmrJmqHy
	 XcJmoNBIpArfrYjy+C2andIc2j5LX+SfwXZoFvq8fwiD9yR82L+RTeKMAEhp8vg+W2
	 FWDrJ+0SZ+KMX1qRdfZWFl8bcxccEaux6cv4eujvdfczsGSEjA6utsFtIhLGbvyJzl
	 10OSkVSzYDtPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
Date: Mon, 27 Oct 2025 12:28:55 -0400
Message-ID: <20251027162855.577684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102638-brewery-wanting-8089@gregkh>
References: <2025102638-brewery-wanting-8089@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9d2c38421f7a2..7fd6714f41fe7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -619,6 +619,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 subflow:
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk))
+		goto exit;
+
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {
@@ -650,6 +654,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
+
+exit:
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
-- 
2.51.0


