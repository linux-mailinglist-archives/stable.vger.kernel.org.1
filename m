Return-Path: <stable+bounces-110356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F545A1AFEE
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2FF188F810
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 05:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBCC1DB12E;
	Fri, 24 Jan 2025 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BFXBAUzT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA41D88D0
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696807; cv=none; b=IrQZoDP4x84FvXY0ZEnF9iXrQWTA5AwcBm7CfeowLU8Z+dQ3v63WH232yiJ2r46SBFP+wSUO9PL91ew09saP6ggLpRn9XyPK6gVbqTiu+kqY5pvT+jZhvEBevR64vdcsK2YIRtT1qaU+A2xcQNvskE1oZPM3K1sIuQLQGV6TV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696807; c=relaxed/simple;
	bh=wSIW9SJc6NZV6MAAaotVBRNDtbW5HnbEWkJPdDpU52k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkRfj7FXeVqTeCEE0lK27G3aEPoK/WoOIIBh/yH6zVxAzDSyyihUXD10jSIqhDcWkdQlnBXXSbYtg9d+/lw5gqfUTqud+aoT2nqJrD2ZPguWxRXSxKG+KOXHcmKc9ugwkctOqTXQ3GH38bsAPmQDKGgdwwxmG8fjh+23W6K/Mbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BFXBAUzT; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e2ddb6fc1so220513a34.3
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 21:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696804; x=1738301604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKI6M3Ga2oIUgZFOTflqzcS/S7V7PY/8wm6k/uUZ8oI=;
        b=BFXBAUzTx2f3k1K6SNB9JtJ1a4FZmUU3werNUcgFiXhCJp00tdkMbRaYe0/ALZfbc9
         x1FrEpFLgQM3FVJP0pEQH2fSEU4IbI9somC8w3PSFRUOpiZ39Swy3mZPVKfCdeYM3LcL
         KyHKe0wT2OIiwOlW2PkmzGHiCiFpFgMWNvyDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696804; x=1738301604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKI6M3Ga2oIUgZFOTflqzcS/S7V7PY/8wm6k/uUZ8oI=;
        b=ciCbp5D07BjcgAYm40nG0zYrsboxIceZFHSHLvpihUjGoPoiXT7ojPqX6Wd3rKHNIu
         ehy9jOkT6ubNdW16sFnNB7joz1mB1tX5sacVjB4/RliU7oOi+26WeEqiJrqGRwclgh7g
         BWUVuMYaZRpqhgH+uUPOwuQ/mEY7/jE3PRP1iOTzbfIl4o8fWvk1urrFwsb+f53fAaPj
         LyRov8q4yKynb9ul2MHc7eYBpgZ2S2HfKup55YNYEffmG81rfbU9KE53pyQm8TFBF6IK
         yfeO1VA4hTcszuu56vsYBlFYcAJ3iQ/SELQ77X01mMz2rHUbjuDNGe4ru7/36frZKFpD
         NH/Q==
X-Gm-Message-State: AOJu0YwdTjZG4OUaJ6XObry94hZFhTNwJlb6B2yE3ZHMi7ClYa8Zv1sj
	85387HHslzLKVa0aNjVPIyNanXwa3Qevzo5S5hsXXcQkKJkNj6CYcc30sKQZZ2zmEKvEJgRFmiu
	BOKP1K1txBfG9Y6gwaJHYoQQcih9T9Ou22Moer+ai4ss5nuuuqrp4FI/etgWXv0hwlIjsCia3+y
	V467Rg6l0U1ufGK6NSGxAuht6tCQBv5ufRmpbGl30M0FSGH7cbMo+6JAFCGdJqryU=
X-Gm-Gg: ASbGncshpS8XyBYo7oGxAm5RnY9KHDc60MS1nJU0zuVP0tubDBOVWAB6fhNeuZ/PKH2
	mT3wLsI1EEmmRAcf2QYJoekKEAJrvbwwHdeMBsPHIFKcp/BloXzDnE3/Gm/f4HGeXQfMKpLJrKZ
	0yT/AMbBSVtJNpWL+d4rI9fdDCzPYU1NTi0/YTB2qmvCh00iAo3JKZ/QuS2M4W8lR+G8iDac9ma
	DZQmV6ciHiOfpzE4h5lvTrMIhnjnPt0l7b9Xqs8l1EPbgUpt2J5yXsmCPCk6fFuyS+bsrDL0IE3
	9d9IlKao61Q0kw9wEANGTT+nFY3srQSoTFiZ9aIcpc6VUOBQPjc09xUloe4=
X-Google-Smtp-Source: AGHT+IHhOD/kMjWyZMdu2nA2GSmKabRzevDKzcDq4NyCBezacU4HqyWOL9aAedfSaePPiXOJQvlzVg==
X-Received: by 2002:a05:6808:1896:b0:3eb:45de:8ab5 with SMTP id 5614622812f47-3f19fd4c5ddmr7038027b6e.4.1737696804592;
        Thu, 23 Jan 2025 21:33:24 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:23 -0800 (PST)
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
Subject: [PATCH v2 v5.15.y 2/2] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 05:33:06 +0000
Message-Id: <20250124053306.5028-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
References: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
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
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2c95bb58f901..47e2fd38b2e3 100644
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


