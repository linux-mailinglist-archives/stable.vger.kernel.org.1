Return-Path: <stable+bounces-77414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A45985D01
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F851F22337
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7ED1D7E45;
	Wed, 25 Sep 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3WcDHSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E551D7E3C;
	Wed, 25 Sep 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265679; cv=none; b=NdLGRSyhx/kk7aywYJVJvk8yDrwQgjfRud9WkIc/KIpqrotQ2Z82S4H5fPU2hvU4C4ZSJ9+sH4thNZxdYR+f5mTWy/TgtVAxZnIYfDI1Xw472jrP2tyCy/J6aEFQEIPIDn9ygJdQsjKVaaOrq0hBzIrOr+/WuCrzAzPZV1p7Ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265679; c=relaxed/simple;
	bh=IUv1tIoJR84HoODyOk7lB+rahWRJkrUfc2DKrwX3hnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g98GWIIUlTZk3AC2pn30ZGk5u+BhNw8Nj9uoFR+bE5hY+PEfHsfOICrN5gFFyTVP6zRHPOjhh1WxHiZOV6+7l1vRV0gs283PzUrHNFwFqNjQpR0AepA+a8ciT2HOQ2/Fjo18Ba/TH80J7cquvj1B7anya9BfmOUZoAwkIlwwJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3WcDHSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA454C4CEC3;
	Wed, 25 Sep 2024 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265679;
	bh=IUv1tIoJR84HoODyOk7lB+rahWRJkrUfc2DKrwX3hnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3WcDHSY3JfBllKeU52NQTWRQmr0xUJZCt72D6LsaTkNANXREocFUkancD60h+jFw
	 EfNPr+XyDG/+erOCXgk4P2cYx0O5TzXmnN5oA7GnR/NZaniW6Q6Td8e6T1yzcs2Ub3
	 kAUbV/PW8ySRVIDT6KDs6ebG1k4GuWGPX95J5i6xVOuoWIEULXJJMzj8y9jT/IFw6t
	 dP3u9xtWgBdPEdWLZGms197e1OXAHPb+5wI38FavKu0pYy7weO74Qw0mKVbapURx8r
	 WA6xtb6HNePOT6rErabDEYTI00BJdaEq5V1dToyU5nfqoOyH+AxYJF/so8IF3VqWtl
	 VNmdEue9DhNiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 069/197] net: tls: wait for async completion on last message
Date: Wed, 25 Sep 2024 07:51:28 -0400
Message-ID: <20240925115823.1303019-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 54001d0f2fdbc7852136a00f3e6fc395a9547ae5 ]

When asynchronous encryption is used KTLS sends out the final data at
proto->close time. This becomes problematic when the task calling
close() receives a signal. In this case it can happen that
tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
final data is not sent.

The described situation happens when KTLS is used in conjunction with
io_uring, as io_uring uses task_work_add() to add work to the current
userspace task. A discussion of the problem along with a reproducer can
be found in [1] and [2]

Fix this by waiting for the asynchronous encryption to be completed on
the final message. With this there is no data left to be sent at close
time.

[1] https://lore.kernel.org/all/20231010141932.GD3114228@pengutronix.de/
[2] https://lore.kernel.org/all/20240315100159.3898944-1-s.hauer@pengutronix.de/

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f50..bbf26cc4f6ee2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1201,7 +1201,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 	if (!num_async) {
 		goto send_end;
-	} else if (num_zc) {
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */
-- 
2.43.0


