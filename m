Return-Path: <stable+bounces-157298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A65AE5355
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF394A7930
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712071E22E6;
	Mon, 23 Jun 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+JXHZtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C71AD3FA;
	Mon, 23 Jun 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715526; cv=none; b=NHYogV9szMVF6lS7/x+ovfji7t5XtusEIyCw4zutmHjJCHyZyeTC84GG6OLgFOu6FfnRK1FbIWuDl9BEm+/bvucbW07CWv9MmLFI5YyXoMN12uspwKExKl9HrZsw0Db13GPLQyUe0CI64qWGimJ29I+G01+dHsgpH2NiKZZGfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715526; c=relaxed/simple;
	bh=4nhZkk9lnppgTJO5dEDAifbm35WPA0c6AXshAv5pjXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMt/LMcmGUL3D5XipUgZ+qdB0o6Bd4IFvSCuDSjwXMPuCyaOG+ZAd8qM8EmogxGCjx2zlZUpzA//yEO2Y9R3+XNt2pJqPROv5dhORmI5qa9dwVQQA6t2R2zrabeEsgRWDOEOwDpeDq9+68L5ud7j7VKq52yWOMSQ84fGoFLxDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+JXHZtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7B0C4CEEA;
	Mon, 23 Jun 2025 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715526;
	bh=4nhZkk9lnppgTJO5dEDAifbm35WPA0c6AXshAv5pjXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+JXHZtc6u3sQxlqc37VP+jKrzvxC6F1v0PMBvh7FU/EekfZ7vFLffQLRcHkXqilR
	 DAtI8ihQD4jHbBvLL/pGtxXECssc8u5h5QiPi5DQj++HeYFyGAvNjrfM07J5Nb4f6V
	 Pq6nbQXkCDWDoFUKiW2orUXFkv+7RSi0qf4lOmiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Michal Luczaj <mhal@rbox.co>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 248/508] net: Fix TOCTOU issue in sk_is_readable()
Date: Mon, 23 Jun 2025 15:04:53 +0200
Message-ID: <20250623130651.353220219@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 2660a544fdc0940bba15f70508a46cf9a6491230 ]

sk->sk_prot->sock_is_readable is a valid function pointer when sk resides
in a sockmap. After the last sk_psock_put() (which usually happens when
socket is removed from sockmap), sk->sk_prot gets restored and
sk->sk_prot->sock_is_readable becomes NULL.

This makes sk_is_readable() racy, if the value of sk->sk_prot is reloaded
after the initial check. Which in turn may lead to a null pointer
dereference.

Ensure the function pointer does not turn NULL after the check.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e716b2ba00bba..e00cd9d0bec8e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3061,8 +3061,11 @@ int sock_copy_user_timeval(struct __kernel_sock_timeval *tv,
 
 static inline bool sk_is_readable(struct sock *sk)
 {
-	if (sk->sk_prot->sock_is_readable)
-		return sk->sk_prot->sock_is_readable(sk);
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	if (prot->sock_is_readable)
+		return prot->sock_is_readable(sk);
+
 	return false;
 }
 #endif	/* _SOCK_H */
-- 
2.39.5




