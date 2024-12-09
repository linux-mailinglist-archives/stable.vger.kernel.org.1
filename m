Return-Path: <stable+bounces-100165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC09E93EA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C21627EE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B122371B;
	Mon,  9 Dec 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaOtwx72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7F215182;
	Mon,  9 Dec 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747309; cv=none; b=noMoK5Didh0D2mdUqXAFL4csfRAdb/f1/cJeA2Z/9HnD2Q13iJxjPwlITrgOpkq/nP84Caja32Y5PSaIMSdq8XAD/s/Htf6hH51UeqN+UjgoM2nbCUWo7zLZuOEuBzU0OBymGZu0WPb5+tFni2e/tiSk/FMA7a9+w5ns9xv/Uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747309; c=relaxed/simple;
	bh=96qekPURRT9CPv7EaITNBsfs8R1g6rJjI3dvF1dWY50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QnDU0Z9y77RafOV6mjXNBWPBhwitrJBSsKXCjdFN7gDO6IMPO6uGidSiFsFir3HX/akCkgrPYMlf2W0bTNo2BnUjZaXP+brgNir03ILOPbduQycbxcrPfy8b8hxNqKmh2eoYdt4j3dUff0nKD5/JVoSWHDDvwhuwIAYPrmfS33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaOtwx72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB2C4CED1;
	Mon,  9 Dec 2024 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747308;
	bh=96qekPURRT9CPv7EaITNBsfs8R1g6rJjI3dvF1dWY50=;
	h=From:Date:Subject:To:Cc:From;
	b=IaOtwx72TJOM8FmSNwX9UPVH33o/eXVfCbayMh3fN6atkwilJHVARJleAOMnuV+zU
	 Tfu9/eYaSCYjjMl9m5aB7Yr0tJaYJbQD5OicivPISp4E/33izR6WjF0Ar5ZfM1qCUo
	 1ZVyvQqc905YetYJk+Rw+EIah2UIwI+ILuObDe8dw5P0r4WZzrA867zmx19ymhgb+c
	 cD1Wny0HMD62CK5FiXAhMPG27a2efDeiClTTT+dYgbADPwPJPqmO+0yeed5QmtWxTu
	 LBN5VK+6/8t3PTpQnogsFuZAJj1mRf8JdlKotZqC/vPcaxPne6WCD7FsQ+9kV8Heuw
	 MfqmehcqC704A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Dec 2024 13:28:14 +0100
Subject: [PATCH net] tcp: check space before adding MPTCP SYN options
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF3iVmcC/x3MQQqEMAxA0atI1gZsUaFzlcGFxlSDTKc0Ikrx7
 haXf/F+BuUkrPCpMiQ+ROUfSpi6AlrHsDDKXBpsY1tjG4eBd/zFnSLSyrShxpEY9QrY9a41rvd
 +6jwUHxN7Od/3FwqD4b4fGSO2xnAAAAA=
X-Change-ID: 20241209-net-mptcp-check-space-syn-5694196ffb5f
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Christoph Paasch <cpaasch@apple.com>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 MoYuanhao <moyuanhao3676@163.com>, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nPCn6NBI0G48CtFzPs6PjBztA1k4CjQRRvkUc0fG6I8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnVuJpMV9nONeuraPornfimYUUzwPN62jJQcYJ7
 Jpiiz37qnKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1biaQAKCRD2t4JPQmmg
 c0gQD/9ubKh62pWZgyumVBXpB07M57FiRTzFtYqJK7sFEpJU4CQy+zAFuAL1hjOudhbgM3Jr0bo
 Ppx+sEY0hoRzyyrxWl1da5OrPBfdMXH74ikF0seJ/AQDFgYSo9hYRq/6lAewKi35aTLcXRiwbYy
 IfUTVDeJSFITAJjw/xFZSkulEolusrg7sH4ZbBJNfiEBTTA6QbpvswNe19nHi9rOlzJT63n9u71
 HXXZPERhYx+7F0kXA93W2P9sUQTOt6JcZRheYbqZgLFcYR3/zK1ebhRRequygHiPZ9tLZlyC2CA
 Mw2mceD66DMYtZ5d/+ZeJlkYGztW8lpRnZPq9O8x3JbZzpcdRE7znn2qHgWZ+GblnEY75mAxUsU
 6nce6vT083NnOHD7XkGzsxnT6gLFOOaheu6jyWxJlk1Lh7YMZuRYwPpk9sTiuu67mxHnSktSNM9
 RhbFT1I2rZEeDsF9RdrBspFu1852OavD5hHv/gvNhy+bkfvFc+qPWNo1f9FDI9yWrZtnFRr5U3+
 uE7OY8KlzsbiB+Wf2xpH0OgrWcppCrCCXYCsFJ1AAk2tB4NjwLeppDUaV2IYZGT8N/NugzW36LL
 ZIaeQP/CjkNRXH3N1TuP50A7jcgnlduVSY56ZYyANULlUuXdzjcMeThkjMgTAZOzqntvJ+n0biQ
 dBqbqdTyE2aLdiQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: MoYuanhao <moyuanhao3676@163.com>

Ensure there is enough space before adding MPTCP options in
tcp_syn_options().

Without this check, 'remaining' could underflow, and causes issues. If
there is not enough space, MPTCP should not be used.

Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
Cc: stable@vger.kernel.org
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
[ Matt: Add Fixes, cc Stable, update Description ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5485a70b5fe5a6039d19f4321c3c2ec8ecc6ffea..0e5b9a654254b32907ee9739f3443791104bd611 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -883,8 +883,10 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		unsigned int size;
 
 		if (mptcp_syn_options(sk, skb, &size, &opts->mptcp)) {
-			opts->options |= OPTION_MPTCP;
-			remaining -= size;
+			if (remaining >= size) {
+				opts->options |= OPTION_MPTCP;
+				remaining -= size;
+			}
 		}
 	}
 

---
base-commit: 09310cfd4ea5c3ab2c7a610420205e0a1660bf7e
change-id: 20241209-net-mptcp-check-space-syn-5694196ffb5f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


