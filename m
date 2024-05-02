Return-Path: <stable+bounces-42964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315618B9B7D
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA87282D82
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD7584A3F;
	Thu,  2 May 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MxtNZwP0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBD824AB;
	Thu,  2 May 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656029; cv=none; b=PYrjzvhYJrJYhrs8WEOfXza79R+ZPd2NouhBrloWA8l/pdw6U+0WjEIvRv1LpzOxpZrOTpihk58oDWzMzZfAY+LYg1fzrUDXq4Fkg1kbiazMBt/CjGU9NRJfTVKwCOBOhTZcyzjwbGjCltXsTqSOzU8eGxJndhYWxWHYbYoTsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656029; c=relaxed/simple;
	bh=3uHsgWZTrL/IXcpPKrV8afjNRpKD9N10PimzAu5WZ40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Srl7ilJHZBm1f+xzBi0M1LHpsznqF7gf2njXVFZmDkewu47huIa7cCnFEMVVWN+kTbO4gKdIQ6u0H+9/4S+f96BG4J81G4bckCUi8aXBTwE01ycRJEESIa8qxPYSpW126VE1UZtCCztAMbuFMYQy0bpbCxSpvhA35sdOI+uVKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MxtNZwP0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/VaCqMDL7p2NjINVVUIkM6kvbFvFFu2XNtolIuWclck=; b=MxtNZwP0MaJhFLB2Sekgvr1mHs
	ijlFM8yBRxvZvEXbZDBztwj0cnPDISW3Rehl28INZauHzWuPgDhfENHo3zNvN+dp+2c1fBx8HfF9m
	i4tUd2RMIvWWAG7n+ZVCangnlGpB/5jXucciFOEyIi/yvcgcP9i8vOwiCWW928LPIDzAdTTVjy7VV
	jregaE+JYxXbmHVlhKnEER0a+ciPXvsvZ4NOUbx0IyG0UhM28GHksSxho4YuqN8gccUt78xYYVmRX
	G9oOXF5TlInwc/5bb4AUhzO6/n2ICcsVHWZbQDIAmPzEyykqiGS0+3lgWuy+ILDPVLXCgVOq5M/5P
	zfogWTvg==;
Received: from 179-125-75-252-dinamico.pombonet.net.br ([179.125.75.252] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s2WMG-002zu5-MV; Thu, 02 May 2024 15:20:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	kernel-dev@igalia.com,
	stable@vger.kernel.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net v3] net: fix out-of-bounds access in ops_init
Date: Thu,  2 May 2024 10:20:06 -0300
Message-Id: <20240502132006.3430840-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_alloc_generic is called by net_alloc, which is called without any
locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
is read twice, first to allocate an array, then to set s.len, which is
later used to limit the bounds of the array access.

It is possible that the array is allocated and another thread is
registering a new pernet ops, increments max_gen_ptrs, which is then used
to set s.len with a larger than allocated length for the variable array.

Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
max_gen_ptrs is later incremented, it will be caught in net_assign_generic.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stable@vger.kernel.org
---
v3:
  - Use reverse xmas order in local variable declaration.
  - Use netdev multi-line comment style.
  - Target to net tree.
  - Cc stable.
v2:
  - Instead of delaying struct net_generic allocation to setup_net,
    read max_gen_ptrs only once.
v1: https://lore.kernel.org/netdev/20240430084253.3272177-1-cascardo@igalia.com/
---
 net/core/net_namespace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f0540c557515..9d690d32da33 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -69,12 +69,15 @@ DEFINE_COOKIE(net_cookie);
 
 static struct net_generic *net_alloc_generic(void)
 {
+	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
+	unsigned int generic_size;
 	struct net_generic *ng;
-	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
+
+	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
 
 	ng = kzalloc(generic_size, GFP_KERNEL);
 	if (ng)
-		ng->s.len = max_gen_ptrs;
+		ng->s.len = gen_ptrs;
 
 	return ng;
 }
@@ -1307,7 +1310,11 @@ static int register_pernet_operations(struct list_head *list,
 		if (error < 0)
 			return error;
 		*ops->id = error;
-		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
+		/* This does not require READ_ONCE as writers already hold
+		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
+		 * net_alloc_generic.
+		 */
+		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {
-- 
2.34.1


