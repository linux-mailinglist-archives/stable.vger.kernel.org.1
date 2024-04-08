Return-Path: <stable+bounces-36979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FD89C391
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0963B2CF76
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0C80020;
	Mon,  8 Apr 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2MyvWXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5278286;
	Mon,  8 Apr 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582901; cv=none; b=hDL2Ynm5dPRsvjicwoev9eKF3X5zAqkjfZs01xi5Y7y2AWNXbM4BbHr0eopo2rWNpWSNh+0hM024nlZ1FetrkBwMh/wt0jy+7wNwFrNzxgnHBzP0m/xB9J1w4KFEstX6Tl2y0fbqmFfBeg87SHuW07I2joAOE9EwhYBy8ugCyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582901; c=relaxed/simple;
	bh=fgfTGo0BxIgykw9kaDiGGc+QVB/zzE0uNZJzB05uQgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4bGhkonNJt6jJENkQnJf2urcYnd2yW0kYLhBjbSsImJLO6XH8vr4MTsV1o4PHwhIPuYtSMqmeXsEPi8GSA1xbo1Q+wLpYRiBy3n1wMi+XmfiaNDgG+h+Brwtxu5isavfeZ/4wPAKKKUwnhDT6QzFP2q+0V78KDMIVOOhNcUztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2MyvWXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C843C433C7;
	Mon,  8 Apr 2024 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582900;
	bh=fgfTGo0BxIgykw9kaDiGGc+QVB/zzE0uNZJzB05uQgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2MyvWXRHJl46x3qSc4p0KXneW7tv2oIDF3JXktU+GH7EViDr1nL1uGcOyNv8nIJB
	 uDcH8qGXuieqk2ZtcPTFM2UhHIK62Ynd9LSQ+R4rOPhjrpFyMI07y0X5VcjfJs23qo
	 DVLTEQ6AvNvc4JBGGYNQAkRbBj2z2Bmdyi97ROK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH 6.8 115/273] tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.
Date: Mon,  8 Apr 2024 14:56:30 +0200
Message-ID: <20240408125312.873315390@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit d91ef1e1b55f730bee8ce286b02b7bdccbc42973 upstream.

Jianguo Wu reported another bind() regression introduced by bhash2.

Calling bind() for the following 3 addresses on the same port, the
3rd one should fail but now succeeds.

  1. 0.0.0.0 or ::ffff:0.0.0.0
  2. [::] w/ IPV6_V6ONLY
  3. IPv4 non-wildcard address or v4-mapped-v6 non-wildcard address

The first two bind() create tb2 like this:

  bhash2 -> tb2(:: w/ IPV6_V6ONLY) -> tb2(0.0.0.0)

The 3rd bind() will match with the IPv6 only wildcard address bucket
in inet_bind2_bucket_match_addr_any(), however, no conflicting socket
exists in the bucket.  So, inet_bhash2_conflict() will returns false,
and thus, inet_bhash2_addr_any_conflict() returns false consequently.

As a result, the 3rd bind() bypasses conflict check, which should be
done against the IPv4 wildcard address bucket.

So, in inet_bhash2_addr_any_conflict(), we must iterate over all buckets.

Note that we cannot add ipv6_only flag for inet_bind2_bucket as it
would confuse the following patetrn.

  1. [::] w/ SO_REUSE{ADDR,PORT} and IPV6_V6ONLY
  2. [::] w/ SO_REUSE{ADDR,PORT}
  3. IPv4 non-wildcard address or v4-mapped-v6 non-wildcard address

The first bind() would create a bucket with ipv6_only flag true,
the second bind() would add the [::] socket into the same bucket,
and the third bind() could succeed based on the wrong assumption
that ipv6_only bucket would not conflict with v4(-mapped-v6) address.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Diagnosed-by: Jianguo Wu <wujianguo106@163.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240326204251.51301-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_connection_sock.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -294,6 +294,7 @@ static bool inet_bhash2_addr_any_conflic
 	struct sock_reuseport *reuseport_cb;
 	struct inet_bind_hashbucket *head2;
 	struct inet_bind2_bucket *tb2;
+	bool conflict = false;
 	bool reuseport_cb_ok;
 
 	rcu_read_lock();
@@ -306,18 +307,20 @@ static bool inet_bhash2_addr_any_conflic
 
 	spin_lock(&head2->lock);
 
-	inet_bind_bucket_for_each(tb2, &head2->chain)
-		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
-			break;
-
-	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					reuseport_ok)) {
-		spin_unlock(&head2->lock);
-		return true;
+	inet_bind_bucket_for_each(tb2, &head2->chain) {
+		if (!inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
+			continue;
+
+		if (!inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,	reuseport_ok))
+			continue;
+
+		conflict = true;
+		break;
 	}
 
 	spin_unlock(&head2->lock);
-	return false;
+
+	return conflict;
 }
 
 /*



