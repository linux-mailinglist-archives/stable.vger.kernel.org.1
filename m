Return-Path: <stable+bounces-94022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CB89D2881
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3917F280DE3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557461CF5D2;
	Tue, 19 Nov 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLFjFazM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B21CC174
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027609; cv=none; b=GDkq6zjJrxhrHdMpckoQXoYvWNMcJ/AfEfd6QBOQtza794DAJzKzJ868hPdlj7OLrHd8DPVg1syCMyrSBfX4Z/VklCWKVDnlhqi6rMKiN6mjts0wnrQd4timw9tFLLhoLYZfTaffmGxoV3vRFQwXoBSH+V569L7tt2OAOzHB2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027609; c=relaxed/simple;
	bh=1qKwVbmX5Ou6evD6a4lvWH9L5fty0WdZIC9J3nu2ULg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyknB3efvQlRIElQhpxoCz3Ti6tK6ZaylVp7tRypK6MT4vrtVgFRI8oB8bukF4wAKZcItFYmM6Y1DhUMWht/UmYXv3T6VbA9phX8m+/HLuojXvLrEuIn2VzT6vjQ38OgvY9In057Kfu1emuPdnlfB8EIyA4v8Om2YfDaRyiyKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLFjFazM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B71EC4CECF;
	Tue, 19 Nov 2024 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027609;
	bh=1qKwVbmX5Ou6evD6a4lvWH9L5fty0WdZIC9J3nu2ULg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLFjFazMN1LcPCVoHgXUo0sWhUOKHvBypp2ZG6tH5huxLgrdzXSqRMtIIrF2GONpO
	 7CY03dR/Tqh0kkI4Zj6+uyk+nnyO89lg2VE8xzqP9+FdykWZWHG5veKojVJshAFF3w
	 ChnXfoAWzhQ5aVJJpcUdjC2B5+YUhLvmisG10O2tM5NjcDguM7VLtU2kjWHzrosqQT
	 /VG9HjT3rFRvdgJq12SKwM4i8eR20o+GDtShQwmQJ3s7P8Y15G8wfUl+jzzPkCdUu5
	 ZkXJQWv5Y8tojvK9I4TDQYY9ze7GiLshyVwx+XQwWiqAPzIhHjjXZSLRS5m12a+j2H
	 XI7G16AYV1wlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/7] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Tue, 19 Nov 2024 09:46:47 -0500
Message-ID: <20241119083547.3234013-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-10-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: ce7356ae35943cc6494cc692e62d51a734062b7d

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>


Status in newer kernel trees:
6.11.y | Present (different SHA1: 8cccaf4eb99b)
6.6.y | Present (different SHA1: 4e86acecbba9)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:38:07.302555583 -0500
+++ /tmp/tmp.UE8LSqsrXJ	2024-11-19 08:38:07.300507479 -0500
@@ -1,3 +1,5 @@
+commit ce7356ae35943cc6494cc692e62d51a734062b7d upstream.
+
 Additional active subflows - i.e. created by the in kernel path
 manager - are included into the subflow list before starting the
 3whs.
@@ -15,21 +17,29 @@
 Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ Conflicts in protocol.c, because commit f410cbea9f3d ("tcp: annotate
+  data-races around tp->window_clamp") has not been backported to this
+  version. The conflict is easy to resolve, because only the context is
+  different, but not the line to modify. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/protocol.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
 
 diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
-index 95a5a3da39447..48d480982b787 100644
+index 78ac5c538e13..1acd4e37a0ea 100644
 --- a/net/mptcp/protocol.c
 +++ b/net/mptcp/protocol.c
-@@ -2082,7 +2082,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
+@@ -2057,7 +2057,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
  				slow = lock_sock_fast(ssk);
  				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
- 				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
+ 				tcp_sk(ssk)->window_clamp = window_clamp;
 -				tcp_cleanup_rbuf(ssk, 1);
 +				if (tcp_can_send_ack(ssk))
 +					tcp_cleanup_rbuf(ssk, 1);
  				unlock_sock_fast(ssk, slow);
  			}
  		}
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

