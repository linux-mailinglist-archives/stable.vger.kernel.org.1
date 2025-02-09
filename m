Return-Path: <stable+bounces-114462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52BA2DFA6
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF47A21E2
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6611DFE00;
	Sun,  9 Feb 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0B1cGCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB41D934D;
	Sun,  9 Feb 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123761; cv=none; b=JqO2Qx7/9wjfjvmrlvoW5/rzT4qUC7ES7+whja8/0WDGpp6QMwt5pwnHmk0YlnK/1ddnGPw0u9Cc5wTZ7EuLyY7neiqPbSEbZHZvTxmiEDhTkwcFUrSvscjk1rhe9lE1ZW5EDhmESdJ3TDBdfsq8U2f+Ubq5OKjTHholsDjWR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123761; c=relaxed/simple;
	bh=jvNmqTMXYfZzcKdmg3kdzxbKknvUW03AALmgKm5bQQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqPlPqHU93Dpws41F+PHWrbXm7yMcRKrOaJ0UoNZ9NEtKV6W/hESxudFi7OsMSp8qpQ7YqYWVK4x4j20DRp81fXcAKJ7sOc895g+4IsagqaHiXysXcyjNHMNsNUgacz7yHfgXt1artCQJ90SprIS29BB6kjriwTRD+DKO+Bi8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0B1cGCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2417FC4CEDF;
	Sun,  9 Feb 2025 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123760;
	bh=jvNmqTMXYfZzcKdmg3kdzxbKknvUW03AALmgKm5bQQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=o0B1cGCLJZKkuL8iiEYauP6x1/XBoY7j7u8Q006ZEfwYV3Q21z5vy4SAYnTPS+A7c
	 DOt31TtFZKVRuzxfjzNaw0WtGyfPS03wmWALmV4EDNrv3DBhjmu8Zb3KE5LnjM6tPP
	 wFssk1EJDys5HZjJYDx2FrYoMHmePqhmZ8kDeQUpJuKmrZ+neIjoZL3SAutM9MrRz5
	 Tg9V+Y5+cmJ6s2G3snq0/5DVD8vAbf/I2h0Ur/lFpObVev6aAosDGLmpaSU9vd+HBz
	 +LLpsXhHeV3IfL/XjgfCyrbsloTiiVogVXtE/1XmZjfccSPA2Koy4JO5D8ujmNx7Fk
	 YokiJ2FsjbEUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: prevent excessive coalescing on receive
Date: Sun,  9 Feb 2025 18:55:56 +0100
Message-ID: <20250209175555.3406593-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=matttbe@kernel.org; h=from:subject; bh=Pjhklwv00D3MSzBXw+QmZPHMGYwQc9ZH7mvCmYMiOhs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOwrL5lk18pbSXnLbYXL9UIDvP1BwgiDpmr7Y K/tAl8j92KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jsKwAKCRD2t4JPQmmg c6+fEACKHbUh9Td/Ck46dTY8dsAxgPrQzKvtwC9eUZE84t838CeRlhsZKlANzQZ8vtby749oxXu K/rkpEq34aohaCmGPTwuypKJDWL7iDD0OJxDbCbAiZMkIrhVEU8R10hnMqszN7hDStl9lL2KJNl H+oDYdOiY9Ns/sz0WtrDNOzTrfWE3lfFw0lECdo4uZhFMfZe1JjQsIsL5FW/5eu0L7MkHrraXPZ 5zp3by+7weF/OsjXyN13iiHisdGsRCAE6/9DzwKa3DHf5yh0MehcvAW0X+gpNIKvpF6N3XcccR9 lNebkMfbCLZSft7af1J3JR6n65RvqO9mtXvRM5oZmIf0FaoebnPPB7aeqkTd5XnK4EMkJOZS7wT DBSh/qJiWdvpfxw6RW3CVeg/Q7pF3dkm9hAgfDme6ikorhHqXPDTDYPG0HPiWcgQQ4iajeYP/oJ 8BXT5QdjFQCxRyiuvPJnkPXjHvSQF35sZAo9m2QS4EMYSuZh1aiblPbgkiRzQPhvUd6KtGQug9D kb+KpcVtHXCvrhsNNk08H5i/vK4sQ2wcBzWmcBOAiMQBpc9Jahy7IcW5Wn3quUins5vRSnSqzfG racFBcgTcXfI+PM2OUatEPpty/7qYP42GsF1h8DQK6FviuJF0So2e9YbEG1K9ROCHip01HMmVjf OYEihLMKDto7i/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - We asked to delay the patch. There were no conflicts.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8558309a2d3f..51b552fa392a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -125,6 +125,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.47.1


