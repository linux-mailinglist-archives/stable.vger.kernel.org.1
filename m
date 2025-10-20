Return-Path: <stable+bounces-188154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30921BF22FA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A264EABAE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358926E146;
	Mon, 20 Oct 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMb/Hms4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4826F28A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975061; cv=none; b=I32qhhYFkv8elgcf4+Lb6Ogw6xxfXet146FwYFC3gH6jKYmbUIL8H/YNiBF6R1QUJ8C8CRgxc/lZPBxDnK2IwMuxGioPwqTr2V+zId89oYdSNs3IDCqyUBd/J18M6RIRTP4XeSjbQqkcHM/5A47poCNOAY1wfzLBdQgUZKV2vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975061; c=relaxed/simple;
	bh=T0qsKKlWturpRhPq3i54knz/eqWONSroV4o8f0Twoxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYkin+HO9/tnVwDA0ygOyExXqQkI8JLYF9U8kJ1MAp0KWaqD+b182uoVsgnEcD+XN9C67msmEf3daLWU7YSCbdzKVKyMhwB+Zql2+ugvN4vT6FZxhZb7G71vdZaASZFdJZ3YQ2qxknMN4bljZHc9XkmapG3qdtNWjgIdInLECS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMb/Hms4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293E3C116B1;
	Mon, 20 Oct 2025 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975060;
	bh=T0qsKKlWturpRhPq3i54knz/eqWONSroV4o8f0Twoxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMb/Hms46lkBlpD/WQNiEFclKZUkN0zSM6a8WhZuUaTIDcEw9J7UfwKde/x4cPLzK
	 GRBOWfIZhyi+h8VRwDvHj2VIIAeqj8ksQUtI16piqSLAl9GCZy1Yah0Zr+4w4MGsQT
	 D0xanT4UteS5pQRHqsqCiND2a9GiUz7utq2p8aL8gGPA0no5v8NPw7nPDeAN1cCROy
	 3uw7etOl6pVIDmlh4G7w6oZBAGNBRsCIbHypUekXlah9N3o8OCJA/eH8aX7SIRen/+
	 Ch6NJO7Yo5mFcqrQbxrsgVHZSw6019bGlIK8tY07su/+CQMk+uCj5Kqx46Q2FD296r
	 8VOhKY7ox9rbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 8/8] mptcp: reset blackhole on success with non-loopback ifaces
Date: Mon, 20 Oct 2025 11:44:09 -0400
Message-ID: <20251020154409.1823664-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020154409.1823664-1-sashal@kernel.org>
References: <2025101604-chamber-playhouse-5278@gregkh>
 <20251020154409.1823664-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 833d4313bc1e9e194814917d23e8874d6b651649 ]

When a first MPTCP connection gets successfully established after a
blackhole period, 'active_disable_times' was supposed to be reset when
this connection was done via any non-loopback interfaces.

Unfortunately, the opposite condition was checked: only reset when the
connection was established via a loopback interface. Fixing this by
simply looking at the opposite.

This is similar to what is done with TCP FastOpen, see
tcp_fastopen_active_disable_ofo_check().

This patch is a follow-up of a previous discussion linked to commit
893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
mptcp_active_enable()."), see [1].

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 9e1f61b02a66e..0d60556cfefab 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -387,7 +387,7 @@ void mptcp_active_enable(struct sock *sk)
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		dev = dst ? dst_dev_rcu(dst) : NULL;
-		if (dev && (dev->flags & IFF_LOOPBACK))
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&pernet->active_disable_times, 0);
 		rcu_read_unlock();
 	}
-- 
2.51.0


