Return-Path: <stable+bounces-124472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DDA61C22
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BEA1899FE2
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D17205E2F;
	Fri, 14 Mar 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehL159X4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62873204C3E;
	Fri, 14 Mar 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983123; cv=none; b=JW2X7z1jKl0SW4dEKsO16Al/YWPnLf4M+djrXbmOC3rB3yVtoNzHo7jCdGrW4pHG2H6BfHVkMpiQXiLrgCFCWXTI87AWadNBpM6Ms7l//ezpSUOs+F8JJb+I+DzIC+6zM+8Ajvi6HMO2suM6lXAX7mz64JfeewUzwCSyzk1BjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983123; c=relaxed/simple;
	bh=qoKytUUZn3dTKFNk2UikNnI4GujOFaD6WSrrTxrgd5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peH149QhFaiZZnSllkeUiA03MaSwcUYELtKHoBYmlwZdDpIVDASr8Ya29efmc+PV1d+cGa80Pk05lfBpzFcABP+y/608u30TbLwpt9h/gUgaksTGLPaNH1kdQTiDbhl8VpGboMxQpi/6gLVQz99sLVVk0ppLRS8nynD/fHcMzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehL159X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F987C4CEE3;
	Fri, 14 Mar 2025 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983122;
	bh=qoKytUUZn3dTKFNk2UikNnI4GujOFaD6WSrrTxrgd5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehL159X45Qz3+Ts7b8cBWZ/Ta0ojOp2xh+ydbGnAiPDd0+IxpnQuPr82yV9zW1OMu
	 Fc0/JNffzaK74d5BBR4HpFKDq0QRg76lUPbshJfunrRRsUsNz2KZkgoSnxU9E6oJ3G
	 hSVKUuLQ1z4KnjXGUXPT7n4qvTHpT+ZhTp3/nd8L7nIFilzbtzwMJA4x5pm8d6Yggy
	 zjBoipOz8d1rQMGr3tepiiZWArF0E+9TIFn7YgzjkpIV6JP2gGBtOYsbnUpMbTn14X
	 6R+wes95koltANxb4cNpTY1Nc65IJkl5tvJw0f8Sx6XxcPHl+mJB6izXieG2Yg5Ctk
	 yHNUbBphd5raw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Mar 2025 21:11:31 +0100
Subject: [PATCH net 1/3] mptcp: Fix data stream corruption in the address
 announcement
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-1-122dbb249db3@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Arthur Mongodin <amongodin@randorisec.fr>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4JhzmJYBMFawka53x2AFEn9Yetrnj935S45BTp3HhP4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn1I2HV0yvAEkN7GhQp4TmUbyUcK2Nlhqw8+FdP
 ArPaKxzo5mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9SNhwAKCRD2t4JPQmmg
 c7zCEADnUdR1ZyuTGGgM0FDgAM4PwHNuxao0GtNXVaG6/rWV1+YSSEjjYe+RqcyBIccCx7fYSu7
 U/sJkbU7YPhiEYc7kbK22Etn/VYTKTHytS4ovsrSPR9a+xa+3W1CxxftaAPK5g8It1xZF2X19y0
 c5QXuWyj9P20enafotxSQfTFjiTrqze86LLohcuk0k2W4ZPz6EYgT5QlTmlPwly7oKT5UbvxUCH
 nqYEtY0iiw0uIO+IgTzGhc0L7seP18wIszRHvxRIXk2MNdnX6Eujuy05fU4Tx3Va7GohWp0GIZu
 iznzE+C/SthZdWppZ3zY5LeL8oB78bdKHM6xESTHpcQsMraaXMWZeOm775SPtcyatFqpvBkl6tw
 VitU/U5J4xFx4OBxq8XYQanO8puB6FcjEi5+jNdGGbcvea2ufebUkcZsfNYNp1qKXxMynSzwbci
 /QAAQkxforZqCWflnbv9UfHIv9xBSYhnbon+kdboKKQKMDz52KkSBfRKAlBQm/agoomRdQDAQ1S
 IPEExNT5sFBK6Pk6aBZvUUW/UJGVPUhPEvT6WeRmRLupzrMLcHi7d+MHgljGvvJopqI67C10H8f
 6vby2u7+qhzHD8AJbJt/6sPpeYssjVot+8Ql5GEFeivLrdWuhg9zeHg8P0ioAzX3UF9GsDR9Xy5
 XW6iOrGaTOf2fTQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Arthur Mongodin <amongodin@randorisec.fr>

Because of the size restriction in the TCP options space, the MPTCP
ADD_ADDR option is exclusive and cannot be sent with other MPTCP ones.
For this reason, in the linked mptcp_out_options structure, group of
fields linked to different options are part of the same union.

There is a case where the mptcp_pm_add_addr_signal() function can modify
opts->addr, but not ended up sending an ADD_ADDR. Later on, back in
mptcp_established_options, other options will be sent, but with
unexpected data written in other fields due to the union, e.g. in
opts->ext_copy. This could lead to a data stream corruption in the next
packet.

Using an intermediate variable, prevents from corrupting previously
established DSS option. The assignment of the ADD_ADDR option
parameters is now done once we are sure this ADD_ADDR option can be set
in the packet, e.g. after having dropped other suboptions.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Arthur Mongodin <amongodin@randorisec.fr>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
[ Matt: the commit message has been updated: long lines splits and some
  clarifications. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fd2de185bc939f8730e87a63ac02a015e610e99c..23949ae2a3a8db19d05c5c8373f45c885c3523ad 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -651,6 +651,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
+	struct mptcp_addr_info addr;
 	bool echo;
 	int len;
 
@@ -659,7 +660,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
 		    &echo, &drop_other_suboptions))
 		return false;
 
@@ -672,7 +673,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	else if (opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
 	if (remaining < len)
 		return false;
 
@@ -689,6 +690,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		opts->ahmac = 0;
 		*size -= opt_size;
 	}
+	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);

-- 
2.48.1


