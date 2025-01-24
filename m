Return-Path: <stable+bounces-110362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6CA1B0C4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 08:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24431168CB6
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C611DB12E;
	Fri, 24 Jan 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdtWuQAi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFA1D88BE
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737703256; cv=none; b=q7WYAKf67BXXbKYe92fWK33JQiw1pvI9N73gdi/Vhl2DUigd2oxoAfWf5vX95pqJTqjdFdUPSC3ZqJWUKcctWVQ0U/COZwKTQsu5xD7eULB2fQ7I/+k1O0fLrp36b6NELuNhku8/GWRmsBfnzWCNBkZlMW59dRrw3ozZ9zJdXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737703256; c=relaxed/simple;
	bh=sPH5XD4Ql4nTiFx2aUIrFzEBL8VQs0STJlcMk0WQEC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oen44jAMnqJ7h0DanjqUfu+hTbKCx8o2xCabUUexvAomlcvUoOWtSJJdVyFA4ILUxVEXgpFu2Rx+VYjLqYH1SW+fWY+Zcgyo5wsk4RQX74ximRdThOoDNCbdipRI7ZXG2AY96aY7/KNyWU/WHndnZ8F2G+nErbyWD42hWNeJ/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdtWuQAi; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2d8e590e2so211027eaf.3
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 23:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737703253; x=1738308053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1o1K/JB2XR1f5n0h8797pNwCCNLrErJQ179f5P2ssZ0=;
        b=ZdtWuQAiZCzy6a6m6j8Lj+7Jq5umG3qO9klBBS5qwmZhvC/McSeTQ0HGcmHpOeIUa7
         m/ebaR+Tm4gAdOWGBWDBNA94/1abuhYw1cMc1AdEPJwkCZo/Ezhb26CzkTB2ptSQyUYk
         uoGzb8i4osrwaFVIQt/h/ZaeWG+HipdpkOm4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737703253; x=1738308053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o1K/JB2XR1f5n0h8797pNwCCNLrErJQ179f5P2ssZ0=;
        b=No1ssgEQFW4SjnMemrU+D/e8DxIgoYXGtabvT0U/Iku6GJnyqcj1aHJc6GqEvRQv+z
         K3AmZLnZ3Mu5TwbWH288PEk2iIu0vI0MyIyfr/dtXumkZFbgbNb8NqFtKdJ6yEAspFzV
         d9EcqsaHLalcS9ISRouj9wGGqVZVMF4bUi1XBMji93lhJcQNwzKJukstkClIqeJJfzaZ
         Hdlh98Tu0ofhoqBxhw2047RftDl1w0abVTj2WGsgFfbr2rBFQlJk6W9kLzzC7FBM3Hp6
         xWE4x4752yVyz5HSrL6vmC1TxrC2bVWjKtGO96nrRBrlcwE0CCx6ovxlcmuRKuJYVI8J
         dsyg==
X-Gm-Message-State: AOJu0Yxy4/tfpqQdIQG9glCOpgq3qxqwZPS04XCjps59gbFoAUY8Hlvl
	ozMCgA4lN3xaQz/ygLZA6vp7/uT2V3KNtzaNkUo3QWJIqbGBKyG8bsiKa+77w//dkBMav6BZMu+
	qk/Ft/xrUArRsTqKo7scMGjCZlnDSUIaxcPUIXZ+FsUlmBhfWhUGd+Ns+6hxXvCmrNTkWTCk9cu
	M917H+mBpJ80QUv21tVlsYlfGwKXFQWHjl7DAhItU5b6ucSRsVBlEIKdYu0wiMsKg=
X-Gm-Gg: ASbGncudcdsXEz3ZGYjWQW/EgZnszMYdic7axyjkpo0lOxLLUSiXAPw3dg0iAcAtlsU
	G+UUvwQ++cStchvve4+m6Xmcvvx8GbuyqiO4GkgqmExjFs5AzYc2WD9UOxjG4IjGlu5z0D4Hs8Z
	zt4dxEh5qB0/uGCbqNLv/HR2n7zBgETy/RnK+WOyEduBKFQ3HyXqogG1eWEIMjn3Btk0W9oHc/4
	CzepwRHfdoEuTFKIuP1wgN9ztli7riczrU2V9ZwtNxCPnOG6N5eEYzks2rURxqr8WPmyztwSgpQ
	WCOFAXgs67irBk5B9BOdOoUyPD5ygoWkHKT4ATzHjKUGD9NO
X-Google-Smtp-Source: AGHT+IHZldH01kYElNZnAI13F6z/szWcYyFhNGzqChJnu6ui+DTeuDlFA51IAVpPEsPU+wsGO26fsA==
X-Received: by 2002:a05:6871:339c:b0:29e:51ca:68ae with SMTP id 586e51a60fabf-2b1c0616e24mr5207177fac.0.1737703252872;
        Thu, 23 Jan 2025 23:20:52 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0fad54sm432960fac.3.2025.01.23.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 23:20:51 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 07:20:47 +0000
Message-Id: <20250124072047.5320-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]

syzbot reported rfcomm_sock_setsockopt_old() is copying data without
checking user input length.

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Keerthana: No changes from v1
            link to v1:
            https://lore.kernel.org/stable/2025012010-manager-dreamlike-b5c1@gregkh/]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index ae6f80730561..56360da0827c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -657,7 +657,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -692,7 +692,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -714,11 +713,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -734,10 +731,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-- 
2.39.4


