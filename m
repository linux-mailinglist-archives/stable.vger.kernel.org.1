Return-Path: <stable+bounces-41815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD778B6C8D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86717283E49
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E247F42;
	Tue, 30 Apr 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laCZ3od0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1F4652F
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464819; cv=none; b=aO/Greiq/6O9kBqQtTHGFXilhHgEsnw1U9CVHtE5qlJ8dG7NOlTPazwaPX7mDq4h6dYShNA0BWZBp01kGfH9CM9gtbm1YtWiGmjud8iW4Krdyq0moTcSYsEinOt/uwtC+8ne/+gPmAqCDfWgUCImLyxt0BmX7B8D4RlRZ/ydvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464819; c=relaxed/simple;
	bh=L51dKDwGY80/3Mmr5FHebOMoDBcvQ+DUbLnfsOUV3BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vc9V+tV1z8PEPqBSTuBpmGEo6lbo6/NUoBZ5tVlo5tcpBuhkOSBHgY+mcZgRyXFkZ+ohImtq3NGZqsEb3le6KG8LsTws44o3MSukwTdWA9bdgNNkhxw/lc2T82NhOX/f3dEjXd+7Fdz3Y/uk/4Mq00jlPLmQKqTe1IVOulvGRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laCZ3od0; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23d2462c3b3so73250fac.2
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714464817; x=1715069617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3Ss8RRdIcRE2Uuhcic9mJgQVaweC2NMGLVkRoz6ZY=;
        b=laCZ3od0kMKFf7T4uoTYzgAwijN6h+ZKVJ8e4RyQGfa+4L+09pyL7guqQ+MuIPhxsl
         F2oBrLCJC/8CQDsOkhN5b1lxNZYRMz69GthamxuF8wOnyNMWKSiFGMVoF4SXX6qDEt1W
         L4jNmT5uvOxdFshdesjdlTTFi7LuhJkkbCglFzQPLX6MlaLBiijId/zt+EjVdorZEPrX
         PHr0KOEz+bH6cTx5KIklgzm0EE0sfFwTOzU82SDe6jG2IT4HkhLIXq3IXcGPPwN7bDoA
         ZapesVCQApvuGAtiOfGftxJMRxaWN+JIV0G31o93QJf1+UGNvI2PwA87Vv5+G8O5ooK8
         n03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464817; x=1715069617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB3Ss8RRdIcRE2Uuhcic9mJgQVaweC2NMGLVkRoz6ZY=;
        b=jvssPZlREK328jN7zok/Cjog2g8iMIgbXXMgfJ2E2A9Aa4sHjLK/fwX0UiCC4bDEka
         Op3rebpyfAfLGGc3csVGk6zE+AVUJhW/6GgssOQn9yw5BHIkYrAeyNnDw6ej1tNNpri+
         RPu2WyH20/PdXbV+9X9fvcWJA3d6GnHRItvxEoFmwN9+jbNRqcqnQa/xaXV/AToiPccR
         CnxjCPfM7cb+mQk6DvtseGHpD/ZL/tZWblswpTxRCq3T8WUS3bq0II570z5oxd4FBPdi
         xNRl6641yMPH1Buhc82RQ4rSxvcNzDRnM7nTCAV4KWx8ZAJzqKeSDKq49VZWIsAYvITR
         Y75g==
X-Gm-Message-State: AOJu0Yzz0vsVmeeYbktK3+ML6FK1Nwpngp0UvYW9Z/j3GUFhqVRZV+RI
	zIJMdbZeFa/OkWnasnGfIoQrX+fiAYiV1DmMf/jynojwr1s9Ocd/48DMUuIY
X-Google-Smtp-Source: AGHT+IE0DHjhuXQL0b4CWB/+pxp9B3FkHExeNOe2E17WI0kNi1IoCuLPiFxSdz29TDLlkv1Doobapw==
X-Received: by 2002:a05:6871:7409:b0:22e:8a0c:ea26 with SMTP id nw9-20020a056871740900b0022e8a0cea26mr14619994oac.44.1714464816707;
        Tue, 30 Apr 2024 01:13:36 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b006ecf00ecfe2sm21218585pfe.12.2024.04.30.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:13:35 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19.y] udp: preserve the connected status if only UDP cmsg
Date: Tue, 30 Apr 2024 16:09:23 +0800
Message-Id: <20240430080923.3154753-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042925-enrich-charbroil-ce36@gregkh>
References: <2024042925-enrich-charbroil-ce36@gregkh>
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
index 6e4b26c6f97c..abac13470405 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1001,16 +1001,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
index cf0bbe2e3a79..dd56242a3edf 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1324,9 +1324,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -1338,7 +1340,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
-- 
2.34.1


