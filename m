Return-Path: <stable+bounces-111122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE3A21D13
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2141A1885555
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C81DE2BB;
	Wed, 29 Jan 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lffxxIQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDED1DE2A6;
	Wed, 29 Jan 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153491; cv=none; b=bRM5mnoNEevk+PyrnX1BOoWNJcWi8qQxhU2dumXqyF0vgbm8bm5MIoziN85poGn/7F+n9qNhlbkD9TSkIyAIkfPAMfiEAMpEAj45rdPW2zD45XOfi9LoZFAfoXQ6sS4QICQsOyBzh+/NcC+Bv8oWUxsdLr8w6gzwgyoj7NfzTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153491; c=relaxed/simple;
	bh=UXyvtuE/CKBndTT3gNNBA7RzFyEwhwYl9+yICjuKZpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvdXDzERPGd3iVdVqJs6bzcb2QTiknTVZKwgoFC1ui9oJrQYAI9knuu8g7d4dsbQvN7dbQLP6EjpPJay9G2UplPmOs3dgpuSTVAvyUVzTU2ooqJP7QSH1X3D4AjWYwACUBi7iIZGPelXVkjoK+S/l5fHVAy7UXmHNiNDu3Us5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lffxxIQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68893C4CEDF;
	Wed, 29 Jan 2025 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738153491;
	bh=UXyvtuE/CKBndTT3gNNBA7RzFyEwhwYl9+yICjuKZpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lffxxIQefayAgHoWfgYwMoMQo/H7OeF7HFFZD74hjwOlXrYY53qUA+N0aTDCLhtGG
	 DQ0AdRUskqoAt6GyTJOviIK9xWo/51/dFJzMTfK8xmTXGFDjIiZ96TYXEGg4bIE5rP
	 hoorgx3vbtv/K36lA6+54qFTE2swPMEpmAK4oObdhm4T2Dw2MKW1/obu1HA5q/7u8M
	 0Fi8/YTc7NCARdLlZx6Mfjvlz1ONcVTLDu5urA4eXHBSaWXWwJC1a3zWncZKESUjpM
	 OFRyLOU1ZfzgVv74ZoF8PIqMay7DNIx4ze7D9uykycwjrGVF7sPx5SM7I9P+zV3qoE
	 b0WFREc9sUDLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 Jan 2025 13:24:32 +0100
Subject: [PATCH net 1/2] mptcp: blackhole only if 1st SYN retrans w/o MPC
 is accepted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-net-mptcp-blackhole-fix-v1-1-afe88e5a6d2c@kernel.org>
References: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
In-Reply-To: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UXyvtuE/CKBndTT3gNNBA7RzFyEwhwYl9+yICjuKZpQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnmh4MBPxBfqaQRw5pGyO4MBmx46jbJ4MA1sbaW
 2JRJ+zv9IuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5oeDAAKCRD2t4JPQmmg
 c/cuD/9dJfOZ0STBMl7Z934pnJjO4Ljdz/RamDilVeS6fC/i1tIYIM4XIgzV6RULiZD+vz/gQmg
 6Pd8OX38okF/8DR3VnxGkTb6RvRR7Xl47wIKPOU78DD1fnYPdCqksDkz1NWIxdQZYmTLI6kEEIC
 oQSn4gHw9nEKPtwF8WiC62BiVrbBCjOybYmhaY0ROhIUx0uWBE8NzWwOLytWX/7y13Vxf93f1A/
 Kk10++mB2igb3jAocuEHJQMc9zaILgLDbTH9ntmG//bCNjm008kVWDzMeblQI3Ekp6SBfkzNcUq
 GM9VTscGsIwSA01HgiFHoX7fMEbdKf2oUjOpkJ4DwBzzuueuJLZb+b7XnZjBBgGonHb3+OSRoBJ
 AZ/acCgBEQ6zqhFrwpKbtzY2jfYHm58ieZVYwpZJ58P5hJ+HrPPH4fK/PskgtgA5vPc8yqmrM/x
 lia9ReraT+6WTMOf2FngwFcnGXvUqRqVeSK5+gREh3VEEs0vuVp42oILJYTGnjthmWRujIEkCQ/
 rttsU+8C1popo+TY2VHnt1+Z66u1N9b8pNEEicGKH7gmdyaCMnO3IxV053E1YSYSFHE9A2T3LAt
 8683igp+pj8R2+xuvmdK/FTk1CSfji5Mxevx7+BNck2kztI77OQj4JXH0JsDqke/TaYNDTI7vVr
 +cISZJzqVOh7xNQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The Fixes commit mentioned this:

> An MPTCP firewall blackhole can be detected if the following SYN
> retransmission after a fallback to "plain" TCP is accepted.

But in fact, this blackhole was detected if any following SYN
retransmissions after a fallback to TCP was accepted.

That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
to 0, and 'mpc_drop' will never be reset to 0 after.

This is an issue, because some not so unusual situations might cause the
kernel to detect a false-positive blackhole, e.g. a client trying to
connect to a server while the network is not ready yet, causing a few
SYN retransmissions, before reaching the end server.

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 3999e0ba2c35b50c36ce32277e0b8bfb24197946..2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -418,9 +418,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		} else {
-			subflow->mpc_drop = 0;
 		}
+	} else if (ssk->sk_state == TCP_SYN_SENT) {
+		subflow->mpc_drop = 0;
 	}
 }
 

-- 
2.47.1


