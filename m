Return-Path: <stable+bounces-81571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB5994631
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCF628694E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B71DFD9A;
	Tue,  8 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdLwnxd5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0821DFD8E;
	Tue,  8 Oct 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385531; cv=none; b=deDm7bSpJD9d16AKB9ZrKclujU+MZNvCQdjKaA4Y8YxfpYTLV/PTkkP4/Ker0gDwlKW35cnPj94QQLryngodYKiI4baROLhTVr2eChDbYpLm660ZsQwRSgeWAj1yMwxGVAmCxMqGLFkm0GBt7046b2xZf2IOPRzT62xySkHVaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385531; c=relaxed/simple;
	bh=mSK/tD+BAnWk+pvXOR9WpkVpN2TCVM22yMkgEFX/05I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvXZ6DfvJ207CLKgLCG/eBO84Crm66/NrScvVps2BfHFQaENDLRcnDCGtyotrhjTykI8w1unHRflbB/h5RP8ce1dipm0Ln6WM28e+hRwNj2XoN97W+QWyNvajIINFvqHZu1B/Y+xfaqftC8VkGAQJ3/InaVo6XrX78ME9VeD/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdLwnxd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73B2C4CECE;
	Tue,  8 Oct 2024 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728385531;
	bh=mSK/tD+BAnWk+pvXOR9WpkVpN2TCVM22yMkgEFX/05I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UdLwnxd5HbfbqZs9ib+ABdPnE5XpM0FH/3sdjQ7yOBMWWGfYIpijzgRers3/bxNAk
	 DNSh3SKqWD88Pc5PgbiZQ/7Upz8dupURTwl+uYhXSZQsvakudwCKI4QknSoTJAjXfq
	 3FFu3Q82Q1ZBbnay1LX5VJfXUuFwyuLg3BlGRCuqV5Q+moW2VabKsW87FPcNNxPQpz
	 FRFrwYD6T85XwJXrMgTLiZEmDbKvmRChjvlLrKpQrYUkGZXm2uNY2n1kPfZvum6cfE
	 bpTeEBJu1CELwloUmdcGjDQsQXO0eRo9Y6fJnklK5KikiuC3geNCX3y7vhCqVPjtGy
	 JSVH9Q6GWwzbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Oct 2024 13:04:55 +0200
Subject: [PATCH net 4/4] mptcp: pm: do not remove closing subflows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-net-mptcp-fallback-fixes-v1-4-c6fb8e93e551@kernel.org>
References: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
In-Reply-To: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mSK/tD+BAnWk+pvXOR9WpkVpN2TCVM22yMkgEFX/05I=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGcFEeugOYizzAHqrnJSwnGJtz2T+QU8eXvkiA7vlv43jcCoR
 YkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJnBRHrAAoJEPa3gk9CaaBzDhMP/2oV
 QZoJkvOtQrz7yPCxD3/UPqMMVMY2eZE7QnG9orhqq1qz9yGhlRQrLCw/6B8rclb/IgUUOJGgsdc
 C0VLDo1kOyWqDrI4YrbUvL/bYos+OiE+9fuungdpe7oADdv1jIWEL09sHA8qef4H49QbMIlihsI
 RH5XMAZ/vUAvvMjPTFxoHvRoC51jmWi/1qr2ToQ1lqMS+z5sk8ftO/W16jfvfJlCxGCY6tg4ze1
 WD4qIGLLmVmqIrAtzFc54gmbJameCeDBq/6oN8HFXhvvw3ckx7Jvi1wAJjLowegWTPyBN9JrmiX
 0JOz+oymvau6EW/4MFQ9jOpArulPk4zYH/M06WN+O1H1HpLA2DKH4ricDFoHoMX9cHFJ9omZUTs
 X6KZc4T6rEcCw4cFJfGsnNnynZgkLn7WCZBeenrZOR8eM8Bfb/dQxsxhHbPl8TzgXjue6jNB50i
 r4Q4qyFnfm6xk60XhbKorCoKB9lBzui8aJJFKTG72UgJ8HIssS+MTUzvUzL1+vB/SiZa4lBMpzS
 Sxbx8fd316b1KJ2ehuZAuaotHkAJ380cWqv6PL7Bz4JA5O2kbjkDw9gq6YtSWFBgKPQ6OgiGJ6e
 gFeEJjC6qkDwPfhLJaSZe7ogv7I3pLCE9U47qlsUR41j8vw64HzrYKbde4vC5M6WendorsjbirH
 BB4rY
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In a previous fix, the in-kernel path-manager has been modified not to
retrigger the removal of a subflow if it was already closed, e.g. when
the initial subflow is removed, but kept in the subflows list.

To be complete, this fix should also skip the subflows that are in any
closing state: mptcp_close_ssk() will initiate the closure, but the
switch to the TCP_CLOSE state depends on the other peer.

Fixes: 58e1b66b4e4b ("mptcp: pm: do not remove already closed subflows")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 64fe0e7d87d7323583ef9ee5909c833a78e727c2..f6f0a38a0750f82bc909f02a75beec980d951f1f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -860,7 +860,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
-			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+			if ((1 << inet_sk_state_load(ssk)) &
+			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
 				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;

-- 
2.45.2


