Return-Path: <stable+bounces-41820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0A8B6CD3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BE928477A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5C10788;
	Tue, 30 Apr 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbNBTWxT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F51C8D7
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465942; cv=none; b=qN3/AXc6bnb6EVn7fsVRPriVwCrcmhy/rgj42fiBni5vKlTH6ryym2GaBCTHuf/ePBNWCsKBQcb69nCmbxuJ5Nc8AffJs3R97T+w909+OdL51XUbYfRyzCn9DPzdReIC3VVLfEQ4xjA4Avtpv3Jel3W+Qq3juV5lJ/q4j3C/6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465942; c=relaxed/simple;
	bh=CchJ+tIVl0NZlFN/7Ev94oxKjWVBAzjbNzZiwXsFf4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNV8KE3g9m3GlyvqHHaGjamL9TCuSDbsCQNIqoba3umIg1rw46ji0KgPw2ArhlEzBuywW6mTdDWS+leH8A5qFygtPJnQzaHzq3HDrTeqNnu6BKbY4n6rdbBlWgPGn6hSixRIWnQINY4RO9AWf39JPfqm7S81UxMLQmBJacr4KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbNBTWxT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so5068753b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714465940; x=1715070740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua9wk0GDoWgSF9X8luuE8yZyVrPP6lCWVNvKZNP+VyM=;
        b=WbNBTWxTIBZFn7xtORjBvuUaxrTensyVNBIeRQ6LdZRzsfbUJ/J1k0BLQBKfRZKGsy
         DbLmOr13n4zpTVx/i8/w9sNRUFnwqknmM8ABH6DpNboYah7/km2edulwmYBKe/GbjNut
         Qg3vsUrCo2RUcP+q45sRfiMbPCPGRHdGOPyCTNVOsuTXU2EsU+otGenttHbaNn0vDXX6
         RItxPNV/eHuk7FaCCrZ/vdwTjBqH9/FQtdWnpSiGZhHmfoI1LcUVey7XFf7j6bbhfJHr
         fDdXwEUlt2HjVVmR3myRlDbzi6qMArSWVVWz75qbBtOEQlgk505O6Kc/mfSyL765CmPa
         0jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714465940; x=1715070740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ua9wk0GDoWgSF9X8luuE8yZyVrPP6lCWVNvKZNP+VyM=;
        b=S8USbK8MtxXCcF1pG+WlByhyAuP2lClz2ascZA0YnuBc+bNfM9vgKBdiDFd92mqZ0D
         sRgLS4srCLLx1+Zdv5hyMggU+tRPv/C/2FvAvd5Brm9zEZZahzY2O7nt09nTPuMmCFge
         aipEpzpU+hi4xFPR8KMGqQsmAr4Gt7KrQyk0ssVPNc5yNF3i1oAnRiLM5kiSj8/aVVRq
         CrbnMFeSLkgy+LzIoWxELPL7T9wzeJIHn5Lt48Y8CwIv5SRZNJQLtdeal9TAn08CdKZx
         ZCSfbFIJaroGxJCmM8FWWg3P+BqblqwB7omYaQmyYWq6ZYDV9qBF1LpZ8WbcaSNiBg4C
         GzAw==
X-Gm-Message-State: AOJu0YzzthYElmzS6E2EpNjg8kTvPeCVziZH3AbsCePb/U/0EqGnGC6m
	86lA0cxVvtVDNpVjybK55EDnYrfA7hqy8gWC6deigu8TooGQmUKzW2dcADJJ
X-Google-Smtp-Source: AGHT+IG5RWnpDwG2tjSRYUxQt4IAS/YYByi4ISYo5NcNFRI/uAgBW6B8pLi7XR0XNT/Zlwqi+8zHQg==
X-Received: by 2002:a05:6a20:975b:b0:1a7:8a02:3058 with SMTP id hs27-20020a056a20975b00b001a78a023058mr9259390pzc.12.1714465939705;
        Tue, 30 Apr 2024 01:32:19 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b001e434923462sm897382plh.50.2024.04.30.01.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:32:19 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] udp: preserve the connected status if only UDP cmsg
Date: Tue, 30 Apr 2024 16:31:19 +0800
Message-Id: <20240430083119.3157760-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042919-purge-pegboard-b8f1@gregkh>
References: <2024042919-purge-pegboard-b8f1@gregkh>
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
index 0b7e76e6f202..16ff3962b24d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1125,16 +1125,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
index b5d879f2501d..8c9672e7a7dd 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1453,9 +1453,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -1467,7 +1469,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
-- 
2.34.1


