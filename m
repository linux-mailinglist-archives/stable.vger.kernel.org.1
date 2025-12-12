Return-Path: <stable+bounces-200852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4ECB7E0A
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAB6E30456D2
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 04:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27230DEA9;
	Fri, 12 Dec 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uzj/D/Hb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BC2EDD6D
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514472; cv=none; b=Eh2bU7ekzy724qQva7l1Su0k4ma/Hzq80wj2bf3tYyWdQ3LPw3nJdBSWCW5JgDeJOMkgaxpmLenPyds1SLfNLlt8lWO9q2pU4ljcsdBfi0paPkiTNwnJUUf1QiWocPveVO2nYmMNMrMjSfhjiJQtFNSCHpabPkZS8w7HiAyS518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514472; c=relaxed/simple;
	bh=tKseG5gYSJeCAWspW2ZESEYmrC1AP47UvmldaZPNzNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqDZVxXIQVs42Yi0JCOc/MZznotH4obWLpod548wV90ElOHQOwStJ0QopIvmGozOqj4eSUZRpK1AN7Ku6Go70PxQzhPnsL5/rVHDuzYJlhotAehpYJWybJQrxtF/1lbKKOJ1Iy87+eszuKSy6xsRIxOMKyT7LZTHtjwTpeAzhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uzj/D/Hb; arc=none smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-4510974a8cdso409396b6e.0
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 20:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765514467; x=1766119267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=fE//cFOU61u60NNdGENuBgVahqeXb4+PG5wktb28WSsEYuZaz7P/h5cKtFE/GKqCX6
         oPVArUXBMf7M3vJhJy35xPP2czxOOaEPDXywIzIMA/MdZjpiL4KgZuEk9Zk7JHOle3Tv
         0ukRByorIVajheaZTKpNgFTpRqGTqrcvH2k9tkRmgWyhm3eyEMrCYhqfTwcsNnM5pPQs
         4CF5jWWNbtJ9ntSiWRnwZmx17nIPysOpVGy8+YjS+6C0iIYFFDcPDRcYzP5pSWPMdrB3
         ZQ8tRTf0rXyFmvgjeddg277Ip7pfGlvcUaiuqsYRm1ZIGTVFXHNEB1bCY0xd/0tM26P/
         aDtQ==
X-Gm-Message-State: AOJu0Yx3jjywz54TsxsL8tWjhHjyDnkMbjKRv9VUYAB8q/SuGL3ZsTa4
	8WaFD9cin4BgLvBDT4D1edEvs/GAvKVpPe+R8Xu/7GTAbHva+/ods2oDFhvJmHgG8iAG1+3UjaV
	Zdyhioxaa9j/DB+b+Oh8xWkptb8ijE48jVcdTdCokhcxYCpkkfa9Db2cmDu1EVo8vU36dTWSkVp
	0Y6WND0Qt0aGkNetTqBdO6rnw+2VuGJCzif7/HOmjv8prRx0Avlhzq02WPsugGuDla52ZrN6iEc
	HBrC5B+2ZLot9LuaOBaFg==
X-Gm-Gg: AY/fxX4a1vGKuUTPU5R9ePCQIqgIyQKhi0xrKpNf4DIUskmeJ99sA7rc5Q5CCwr4QtR
	ZSMf/E/hLC+lHzO6IeA6tTDWjq4wF+P7YkQvn5Oe1aeomsSUbOqpae3m7o7zqMlq3D8hnUM7o3H
	46u7EB2+e3vlb++f6GucDRQX9aSyV6kInSuUVhZ5SIo6Sq09Jj/Ht2dsNPZvsjcCtRRhYa703BU
	L7HdsFqeZrr7XMsHmmEa7jT7OMV+OnaVbzwiEzJqjJ7ZSxeVYq5zeemOUWDxTJhcIEJoKPn0t4/
	/1iuklibNgx9VEf0IaaYsuTuE21FZbAIqNJABoD8aHN6WgT9MqPNW+gfIaBjAg3ZWHXogiTpn0B
	vqdWxnrdzOIzoap5Gfkt8QCby3HXSwjHESxGSrgqK+S0HuEiQdu/lBi9p+xXYmHL/1UAaHGkCkt
	7y7mJJI9cFhsL2m0KKw/houhjGfzafj88z6U6A0mwTNc9HMKoFI9dy
X-Google-Smtp-Source: AGHT+IHv7IdjphxbihDBHyM0XBXzzzRNAjczBYyxQWwlAY+KKGEjcBwo1UvnddnUq2dsYImpsBev3s37+b63
X-Received: by 2002:a05:6808:2225:b0:450:b215:8f22 with SMTP id 5614622812f47-455ac965ae1mr376992b6e.55.1765514467455;
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f601e70fe0sm7135fac.19.2025.12.11.20.41.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74e6c468so12386661cf.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765514466; x=1766119266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=Uzj/D/HbJWi2EkH5T6/dgPumnDZDSsyIvSkgPtLb6vPge0pINJKG4i/6dShEJ24Bd5
         wdrYKk037nxUZfheRSgLhknTcRUb07uZOXv5+EM2JsmSQvkAjzUHtCWUscz+y9UHdUhb
         4JgaTz4QKpKNO+VTJftI9lTyXJCfS27H/Ue2Q=
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249821cf.80.1765514466108;
        Thu, 11 Dec 2025 20:41:06 -0800 (PST)
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249471cf.80.1765514465413;
        Thu, 11 Dec 2025 20:41:05 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3da25sm380483285a.44.2025.12.11.20.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:41:04 -0800 (PST)
From: HarinadhD <harinadh.dommaraju@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net,
	jakub@cloudflare.com,
	lmb@cloudflare.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	HarinadhD <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri, 12 Dec 2025 03:54:58 +0000
Message-ID: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Jakub Sitnicki <jakub@cloudflare.com>

[ Upstream commit 5b4a79ba65a1ab479903fff2e604865d229b70a9 ]

sock_map proto callbacks should never call themselves by design. Protect
against bugs like [1] and break out of the recursive loop to avoid a stack
overflow in favor of a resource leak.

[1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com/

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230113-sockmap-fix-v2-1-1e0ee7ac2f90@cloudflare.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: HarinadhD <Harinadh.Dommaraju@broadcom.com>
---
 net/core/sock_map.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 3a9e0046a780..438bbef5ff75 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1558,15 +1558,16 @@ void sock_map_unhash(struct sock *sk)
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->unhash)
-			sk->sk_prot->unhash(sk);
-		return;
+		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
+	} else {
+		saved_unhash = psock->saved_unhash;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
 	}
-
-	saved_unhash = psock->saved_unhash;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	saved_unhash(sk);
+	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
+		return;
+	if (saved_unhash)
+		saved_unhash(sk);
 }
 
 void sock_map_destroy(struct sock *sk)
@@ -1578,16 +1579,17 @@ void sock_map_destroy(struct sock *sk)
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->destroy)
-			sk->sk_prot->destroy(sk);
-		return;
+		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
+	} else {
+		saved_destroy = psock->saved_destroy;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		sk_psock_put(sk, psock);
 	}
-
-	saved_destroy = psock->saved_destroy;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	sk_psock_put(sk, psock);
-	saved_destroy(sk);
+	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
+		return;
+	if (saved_destroy)
+		saved_destroy(sk);
 }
 EXPORT_SYMBOL_GPL(sock_map_destroy);
 
@@ -1602,13 +1604,18 @@ void sock_map_close(struct sock *sk, long timeout)
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		release_sock(sk);
-		return sk->sk_prot->close(sk, timeout);
+		saved_close = READ_ONCE(sk->sk_prot)->close;
+	} else {
+		saved_close = psock->saved_close;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		release_sock(sk);
 	}
-
-	saved_close = psock->saved_close;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	release_sock(sk);
+	/* Make sure we do not recurse. This is a bug.
+	 * Leak the socket instead of crashing on a stack overflow.
+	 */
+	if (WARN_ON_ONCE(saved_close == sock_map_close))
+		return;
 	saved_close(sk, timeout);
 }
 
-- 
2.43.7


