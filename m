Return-Path: <stable+bounces-210259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA34D39E93
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA1F30024CF
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D86270ED7;
	Mon, 19 Jan 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch8uM8nv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61926E175
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804476; cv=none; b=SvrbYrmfz2Y6dbBs1LgnuZ9Dmblst7608ka2tkMAuHq98XKzISGzRV5x6hWVCkf44gilcqA2A1eqhig/UmO/D76zDm5CFJdZutc29Ge5HYkv9WRhkxWhVe8Dt9Ji3wWv0gu+XYJQc8LS8RK4nv0FEs0FnZxm3zVS5t1Oid9SJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804476; c=relaxed/simple;
	bh=ZAFtvc1Z7KU3XRunl8wn48JhlkoHpQ1IjxvalaK9BBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o1OCbiT7RbEbOO//WgVHJ4RohBGuQ1Ebb6GHrXuchicVubon5D9ayCMioNwmVPRHkjDyXbeRTODtGRefvj4IVU/VQZjVM+jHLCsRjL/s1rT5tZFzpZVcRNgPbFrq5iexQl/L1wl40gXCymSl5FzboWoab/86FEubrCMgfZiYx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch8uM8nv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso2025387b3a.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 22:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768804475; x=1769409275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ypBHDBNdyMjE+aygf+T74/TrmyZiWsKZCNBe7Qtqw=;
        b=ch8uM8nvq6mgzWZBSY63W9wXbv673n8s2vZ9x1E58JxVRX6IzSmmIxkaiW3ptZgs5O
         OCfg4sKKRctElWlt/y1Bh8dMGhfX0+PwK3X97I0Y9GPc4dh59M4xnSo9cdI2KXRPXZRL
         xVlQl5mqjxMW0jjfBCRkYTyL9w9J01Mghy1lmBxFFIisoDQ1RDRsVQRS1Qp/2DpuQnga
         ujG+7V1Ag/bxHUQCM02p/Z+fUzqqNd94dXXAol1aVLjMXKBkwtANFjyupmzzRUcA7/fc
         wHjWF8BfizGw7ZdNIVY2Kz69On0rEcyCIw8z27raa54fyY7ikJEV+h/vteWVQuLKO6LL
         xRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804475; x=1769409275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ypBHDBNdyMjE+aygf+T74/TrmyZiWsKZCNBe7Qtqw=;
        b=tymgccSkvpnzwgwlxLIcHD2JSm++mJ5ulfJ7lD0stSVszmzk+t/Vv1DOM64FU6RDbl
         Agqr6pmZDbe9FoYjI0MQk0U8EMMHAvuULyP3d9L+qAwUbHfA2Cmf9FXZJRmGb/OFzBMq
         wKoNy5YCLTU7Wu4FdCVZ9l87FdLQ/NCuKIYOq+neXNCldNHzR3pQmGm5xU9pM5nf6vhm
         e1AY7Sz2fD4I0dBdnAInT6Dl+sDoIrKClcQw3MyZo6JQu8XMxuhj4DM3dvUmD46NdGtV
         GaOp+uZRpu6ts5dymxSUNvaLMtqvS95IrTkDif8PVvbHir7snVyqP6ydxJys3UBDUCCc
         6gLg==
X-Forwarded-Encrypted: i=1; AJvYcCXS+NuD6vukTrBNv5jHbiBXYYPnrV7bdrMV68Np7WLmN50STiZTKXEhqKETBEkfuJ18n4fFrbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUlJUHj6BaEj/q56bmcGyJquQu+K+oAEag7DLAa3c7BogHuue
	iF64rWDCoT4xSkre9qFqiq8+T/1wpb3nvhLZdHMM+FpPU6cKTzyCdpoK
X-Gm-Gg: AZuq6aKXTZljvR9h3qD8GPc2u6Rsv4hvXGXyXa714SpDC/rvg76gtol2B/CFhXbFY5F
	cC5BD98hUM1hlYxtbeda0r2AePX7tHVVRM/cCIgcIWvSIpIVHYIOSVK2lING8n4eVZYt6iK5+/U
	5rg6h5og72YsvddwPX/AEBSnvjiuoHcnSBjNBYFW3RUAbGrL5Dw3hlKqdEqRsrCXNpaXYH/5brc
	ghKstq4xazkWCeDr/JdRkZAb14MkQG7EaFat/HvpUcQznNdxCa2cOrukHA98TKawr48RKEl5tv4
	rGVz8aP1gvxgHWZ2wRQ/TU2KOnRxaIO9OZm1VjzZF0ygmNvNURobeYjBW5+IENMujNJLn/ra32k
	qNiMBKR0WcY2W6CvVH53IBrAeay2x5/un0IBbot56z4fDOgGfnglVPkJnKM7rRHdAShvELQ3ArF
	UI1Yhf3uJH1/Mw4jLIQ8YBDWrRveIiCc8Fqmvbp4nDpDfejgY0
X-Received: by 2002:a17:90b:4ece:b0:34c:fe7e:850c with SMTP id 98e67ed59e1d1-35272ec4ac9mr8480444a91.1.1768804474729;
        Sun, 18 Jan 2026 22:34:34 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121a65sm8184664a91.13.2026.01.18.22.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 22:34:34 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+999115c3bf275797dc27@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] netrom: fix double-free in nr_route_frame()
Date: Mon, 19 Jan 2026 15:33:59 +0900
Message-Id: <20260119063359.10604-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nr_route_frame(), old_skb is immediately freed without checking if
nr_neigh->ax25 pointer is NULL. Therefore, if nr_neigh->ax25 is NULL,
the caller function will free old_skb again, causing a double-free bug.

Therefore, to prevent this, we need to modify it to check whether
nr_neigh->ax25 is NULL before freeing old_skb.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+999115c3bf275797dc27@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0029.GAE@google.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/netrom/nr_route.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..9cc29ae85b06 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -752,7 +752,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	unsigned char *dptr;
 	ax25_cb *ax25s;
 	int ret;
-	struct sk_buff *skbn;
+	struct sk_buff *nskb, *oskb;
 
 	/*
 	 * Reject malformed packets early. Check that it contains at least 2
@@ -811,14 +811,16 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	/* We are going to change the netrom headers so we should get our
 	   own skb, we also did not know until now how much header space
 	   we had to reserve... - RXQ */
-	if ((skbn=skb_copy_expand(skb, dev->hard_header_len, 0, GFP_ATOMIC)) == NULL) {
+	nskb = skb_copy_expand(skb, dev->hard_header_len, 0, GFP_ATOMIC);
+
+	if (!nskb) {
 		nr_node_unlock(nr_node);
 		nr_node_put(nr_node);
 		dev_put(dev);
 		return 0;
 	}
-	kfree_skb(skb);
-	skb=skbn;
+	oskb = skb;
+	skb = nskb;
 	skb->data[14]--;
 
 	dptr  = skb_push(skb, 1);
@@ -837,6 +839,9 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nr_node_unlock(nr_node);
 	nr_node_put(nr_node);
 
+	if (ret)
+		kfree_skb(oskb);
+
 	return ret;
 }
 
--

