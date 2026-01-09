Return-Path: <stable+bounces-206449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB10D08D1C
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A76E3049C4D
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E833BBC0;
	Fri,  9 Jan 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6u/lY3j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1D33A715
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956860; cv=none; b=Sv+rlv5M53EesFJyP3YCj8s0WocIOZjQYcLX5TqSJ5Rkq3/sV65BSYqGG3+1gPn1P/7HSb3l1KJfAP0OD0o7O87+scJlbKf2LrHEiqTCsA666f74CB3YWueiui2vvO2cACWCHXr/vzn6M8jeKZse5Kzj2jSjL19oYrEYU53ah4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956860; c=relaxed/simple;
	bh=bClo26dKQKfmtH6wmORSjwie/4l4DK0i8SN38XFShIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbPhx7VPQoV9AuAg9f2iZ5TFnLuKSD5Yh7uC4wGG3XJBeMdNy1O6wbAgAeFObzrWrRgRNpK9H86y4Sogo6Urv82W/MSwJzKqNbYcGfOhFqxT3EXd6FYESbkV8uqqkO/hcyeNz/tngFrkPq8LHnK4OME+hN4rCat694tze1FZLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e6u/lY3j; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c0f13e4424so400142085a.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 03:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956858; x=1768561658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=TU9j/uh00oUvoSbKk1EpMWbOL9bMUXBoZ4jgrRKvemasoDSBZI/uNH1YvFaqsp7sWs
         08FDorrvtvncicVydlLCeMm29UU5wenfnPHqFUUGc8Fb4cwSR5EU3CRgWbyGrwg/gMt2
         U7NqhMNjmeEW8cd3KYJbPN+kGbP6QBRztjwiyN4PKFUFbmaujDy1bZvsaanzTPQDjLRl
         PPzV7g+TfXQ5qhd3haaciWNgUBLKmJamH1j0o6zJlAFyPkzoViZSFWFkOlMyINmFthV0
         VEhklDg3YfmhWhtWfyWJVYtl1VOdsOhg8SCg0XAtG7zMloe74XkYjMyieNrwDILPGqky
         4xhw==
X-Gm-Message-State: AOJu0YwViIvi2wN3uXmB7vipkes6eXSAOypzqiU/xGVsSx5oCK1BmdJ7
	+U+n6JvlCOY5LlmwdhpyxdG3TW9MsrGX1aKKal2iVf+OxOQQHX2lzblvT40AOgQ75BqxVNVHQl7
	jmxrv+bFn+mi1YwBN5RFiCzLazFjO+P0Wfu5GDoJvktkBVGduMLX0bWDIh+b9zRnMJ76W6eVEcK
	iiFfWY+PIq2msqG8tMUNMESwbLt29TMlBlApzcChXylAEg2/4GjkAer6qM37KBHSBhIEvCxf8G5
	WGM+faHNo0ai28tcJj7Gg==
X-Gm-Gg: AY/fxX7D19bduYeU9sqUQDqpLUNJKwGbHELrsvRtmSz0/FmuyYusy3RzA3mITGjdYhH
	nsYwv4am3NXsS5e4pH1D+CCyZ+YUajxdlVXE/uLpv+soci7bRkMUk1+ISfxsYdJbzPkQ1lWXIve
	rlwyEuXBByWCO4/GMsTRDx4wR0ZQ00BCLnuHxlfOcgqBNgx+l0g3ldGqBNYr+XNz5YUKDBwskw9
	2uPfLQtYdLeU9EBD/Gv7oEAiiCJT7m0KAg6PizVrBdklGZVQWvQc3eCwbSMqqXRmucAh+l/n7VD
	Kp3kvEKqPuck9J/b9ldHGxpV+yvJg+fDZ6gvIWTFoPtmGADbISd1anXwwzzU1TVNuuYUreud13C
	drYGKHt+3gYUnfGBrWCYrmt2JXzvzJ/3fQnaAyu+GwhW3oyxC047sd0uaaZNkU8nJJqNVO3tuJE
	Sy7ISk4z4YtxfBJ4IH99uCsoaazhKXLuA7hwUO/AEVUkMQs0bTZQ==
X-Google-Smtp-Source: AGHT+IE5G7j+YwjUIR2m5x3dqFyAwLupF7d7EyfN5P0unIS+muAYyB5i1G2JkD0LHu/yOFClmlEYUathzqDn
X-Received: by 2002:a05:620a:410d:b0:85b:cd94:71fe with SMTP id af79cd13be357-8c38939d0b3mr1219417885a.33.1767956857557;
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c37f4bf167sm117493685a.4.2026.01.09.03.07.37
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae56205588so4697214eec.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767956856; x=1768561656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=e6u/lY3jiyHaefD2gMMsIPSsetyln1ny1Vsbu96XaS/t3uXU5mJx/Y3BE/Iky4nuAY
         UtQyGqLngUqAUmrqwPviYJrWPfxzG2YA5XCDj7DdZu9T+ws1CXYSjs5NA7spnr+eOXYY
         09Q2GES7lXRiWZPf8YNJLcQqaE1fWiXgsVRbc=
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081340eec.1.1767956856243;
        Fri, 09 Jan 2026 03:07:36 -0800 (PST)
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081297eec.1.1767956855605;
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1775fe27dsm8783818eec.29.2026.01.09.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
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
	Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v2 v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri,  9 Jan 2026 10:20:11 +0000
Message-ID: <20260109102011.3904861-1-harinadh.dommaraju@broadcom.com>
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
[Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
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


