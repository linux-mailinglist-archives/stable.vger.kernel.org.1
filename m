Return-Path: <stable+bounces-41822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC698B6CDC
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4A1F23D32
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45C1272C7;
	Tue, 30 Apr 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlZ2bmgl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97641126F2C
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466115; cv=none; b=GDnENJ4fNOaJkq+oP6cVqG+ceUe1i0yqIB323q1+3w8baL3lCh5vTUq6Em4FQb6Lvn7fZ9IwAEVyZqilT7o+/qSmev17iRh84uho1thfIMhdIVcfnVxdmIExYUWwSl6h44yIn5iDgT2kYh67km+gMgfDolz60mFutJgVba8L4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466115; c=relaxed/simple;
	bh=XeJt08sNNzciVAbwTUyQTSF3SVMmiCesSyK3aBxbRzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMvyjTA142PJrowv7rCPU09lR37tf83q1KQ6T1LLR44d3ZKKk6s61Mj+SWBOPzA73aq7ON1xm4XUaBeUf+lp7vk4wbO0kdvx4Gg/rSBWNa6X4VDZsvrFu8AuZlIAKgh+HGMisVDm7yujLE7dVQmS8GS+/ztNxcQXbiBD7pXOQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlZ2bmgl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca546d40so45627535ad.3
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714466113; x=1715070913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kuftSWepjSsRWogXOOvi4E15qzfGIBFc4/KnkM1vqQ=;
        b=WlZ2bmgl/j4v6rU5jzwgE9HZNp8RpICe+ONd9Zz8BUfgYOt4RXKCNOqlJBmAf/hR8N
         /JM5AlkL40S4yfYv/qdsup3ubeoWfI//mWPTyvukxgcMSh31aw5vu41BvHoyFN81/DgN
         /KVy+AkjLfbwmMiqGU0MUOSbNzgcV8XdgPPktZ9X9SKCmCNNA3RQ6/AsnXtfllopAuqL
         SLtzgkMk6lX36JQTyUf8xxYbDpuYaLcIeIZa0GUyNiKsqUt9Mzy8j4mozBRWgfhLv10x
         w052XY60P9dk3SA2WZJbq7LvY4fxbl1Azzzy5Thv7vXhqnz3i+rMBwzwl2ooJXO0yPQb
         zU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466113; x=1715070913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kuftSWepjSsRWogXOOvi4E15qzfGIBFc4/KnkM1vqQ=;
        b=QQ9JL+z0JPQkk14grKC28fvJ8AX5QHj7dO24sTetyxmfAk7e3zsYre1ven6pMDP0zQ
         xHvayrI8eXZA468AVVE3AwsOj/177Z/2Yguxt/lSGDk9FqOLLVjGl3YvVUBp+8J6oBX9
         OR9QwiSxyCfFaCUKVDFsalWPW0YLURTHRtB5kjKXSDjsBPfoVoBWsVIeiqwQGncknX1Y
         1V8oIiQNnT18iL9qjScVDAzKofCoFIDMdgNpqeEYVQmqIk1LK5R2E5T31RWX/wdSp/a7
         5LnygOZA190dpj/60eOEcJ7fK4sXnrs9mD4z7kMfiYn1zIF6zN+KCBK4Hltuj5f1kFlA
         bsSQ==
X-Gm-Message-State: AOJu0YzP9Zqd9boB6ynmTsm/YrYY8sXS6ZgnZ7CRxnsMBKMH3BCL5aVW
	ocpVukkL1C7dJuUqn5XD5b6lODPM6ltSTSKLOg5DiWy8U8L87JMA9Cj1s79j
X-Google-Smtp-Source: AGHT+IH1BdAUX/P48W+uA5Hpt82NRmilf5TDgJK5Bm5afU/OP99SGeiONDsZHv/fpac8vdrVliUadg==
X-Received: by 2002:a17:902:8d8c:b0:1ea:cb6f:ee5b with SMTP id v12-20020a1709028d8c00b001eacb6fee5bmr1835194plo.38.1714466113044;
        Tue, 30 Apr 2024 01:35:13 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b001ddc83fda95sm21768101plg.186.2024.04.30.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:35:12 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] udp: preserve the connected status if only UDP cmsg
Date: Tue, 30 Apr 2024 16:34:28 +0800
Message-Id: <20240430083428.3158188-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042919-strobe-squatted-ad63@gregkh>
References: <2024042919-strobe-squatted-ad63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 680d11f6e5427b6af1321932286722d24a8b16c1)
Signed-off-by: Yick Xie <yick.xie@gmail.com>
---
 net/ipv4/udp.c | 5 +++--
 net/ipv6/udp.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02f6329c106..d0387e5eee5b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1139,16 +1139,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5a2abd179e08..256de135191f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1479,9 +1479,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, &fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1493,7 +1495,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
-- 
2.34.1


