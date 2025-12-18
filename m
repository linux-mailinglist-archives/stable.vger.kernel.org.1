Return-Path: <stable+bounces-202917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E3CCA1E5
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A9A30269B7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116042F83CB;
	Thu, 18 Dec 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR68igvG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0C2FF14F
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026787; cv=none; b=Gv4HJL1gpc+BazFTe7HYEgb+7iBCmjYTzwwth+Y9NIa87oHlEqH3vfIZZbz8aUxdJ2i0NA9ZdoL0Jrb8R0o5Aj2QTAbu6cDjK0SL1CQdDX2fGRf4A+Fb/qQnTzI0A2dxiTljf62aAVRX8/IzCOZpS7VH4qT93HCe+N9C26Kr87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026787; c=relaxed/simple;
	bh=WyvPve5LAklKO1fh6O+R/c1D7j2AerWk5OXJqsIwmsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZR9HkvMtJj2SsFl+4yP4Y2rcD4R5a3TeyO0508gPMdIPBvvzUioek0FyBmHkUmtngC9KOUoz+y/81I1khuM+ZGBsHr0V3kjn2x2kHjykAjDUBzHDTVhuy+RXpOPFirhWH7Yl9rKlCJA3bgFE7Oby652jrwmA+Y4vtZmQ59tJPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR68igvG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7d481452588so15907b3a.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026786; x=1766631586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ue5x/b3wE4VR3QWVURKRvM1AZio0rSlcZc+u9XE/0k=;
        b=HR68igvGDvwNSFIYkmtguxQl1/Vx5asDPIGt5adBK10eJS/PxJ0oXVlYENeO69BtK0
         GtsPMRqLgkbX5jzqOlW/fAWTsbcNyEDGfygWzUxXgoDKxSo09KwQTxrnm3YVkh1/2wwL
         2GaB7VMS5ZnCWU3PJXmEorAw/FD0c8nzUJZUd69fxBI2adAJjoXQOXtj6npIAotH6jZA
         5bf9vd4SlHn+kGbXJYs8b1Hk6MRNPvKCYv7GiaEB3lLkgKKA/QX8JZM4MZo193YHIz6k
         7VIMyaHuGk8S7ROoebHc188c4bMXtIGTNR9oG48A4lMTcLzeMG5S+snbpz1zW8Ce1AHp
         G30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026786; x=1766631586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Ue5x/b3wE4VR3QWVURKRvM1AZio0rSlcZc+u9XE/0k=;
        b=T2gGePyuen0AYEwEJFPzcjDRKLiLuAgPB2r0W5YHgQkS8A+en11MjTx5cEtyebsZab
         uZecCXizG5KqNq0QetdPsz1TRPsgAis+KP8OBIBN0IKI7s61jibQYtXKMRz6cXrcLiya
         yaQwmVl0tyqCPizBEqvbuHOopZy+HKyco/3Rvr1f4E1/QBVAGNKqc+T6U00aRKBouPWd
         xEOKzTcTHGYwXWJQgHvayXPfk8+Bx5L6pe/Ig4eqxUjBziGYPatRMgdnLZtn7jeRJnAo
         9M4r7kaz8UqpQ4QH6aCVXEIOOZpUqQA8R4Qa2/banqxO0TZ1aI4ZpKIU+a/0VvAugw4V
         ShNA==
X-Forwarded-Encrypted: i=1; AJvYcCURJc8VXinNN7eZ6DAaF2KlVx8oj/1UaUn3Cra9xmNijUIXI1kxazlQcet1amWb7p3792hdTUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2Yl/ckQLTUcyQnzZU0vbSlw/28GrTeUVuWpy6+12PEM4TcgQ
	oMkN7Mpgg7oMN90So5o7/9jHrbEgMjJEBV5qmr6awzVWw7L4BTCSKnC0
X-Gm-Gg: AY/fxX49b6ttja6URWY1HoTvAI0WQqkkctqU7bUbQ1svqYTSES8wEEdzR2c3vd0ZSF+
	XRIoNTPqiDBjvxG7x/FVks2WXNYQ4w8BrpeDHfgSLg7lB5PZFqrg3kisl0quNR+pZklkG3ECuC/
	O7BNgOC+/sCDc73b9zPCqMgdjJaNJN9TnZpeub537DGzl+atE2TyIgL+L46zUSaDlrxNIRnUdHB
	vvVffB6ONtIu2ZGK1d1iLW0eV6dteL6zXODOgW3JThfGVtxoFSXDkxZKrVs40K7++U/NZ5x3Sw5
	eZ3Kt2gMEOOJuVjzQaehoHYvvNfgB5onv5PkccwR6sALIurKJT0f2u209SKf+laDqbd8XqZ/tSx
	x1RsQPJkuVxHCElA36ip7P6FzT8NCDgMELYRv0zS3H65h+LMi620xqLtKcZHRqJwJvsBZmm0Gue
	/T8U7vteUfZbaFs0pJV8GHrFFqkNDSIxDa25wGV/y3UyU7kUtsp8R6lBHEqSeiucA7Ftq1bgqp
X-Google-Smtp-Source: AGHT+IGeJ+I3A3UGPKjnq4HN6ND6861/cZnOg8n9srw8IdydNPC11hCj3XY9cF8qTnRop/yukfUIkQ==
X-Received: by 2002:a05:6a00:989:b0:7a2:855f:f88b with SMTP id d2e1a72fcca58-7fe53bbbe23mr551826b3a.3.1766026785647;
        Wed, 17 Dec 2025 18:59:45 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14a5727fsm800985b3a.69.2025.12.17.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:59:45 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Thu, 18 Dec 2025 11:59:22 +0900
Message-Id: <20251218025923.22101-2-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218025923.22101-1-pioooooooooip@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
the code used to perform release_sock() and nfc_llcp_sock_put() in the
CLOSED branch but then continued execution and later performed the same
cleanup again on the common exit path. This results in refcount imbalance
(double put) and unbalanced lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, 
while keeping the existing DM_DISC reply behavior.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


