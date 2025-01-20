Return-Path: <stable+bounces-109500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28CA166C7
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 07:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6BB3AA21B
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5C18B47C;
	Mon, 20 Jan 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiQw5maz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB17CA17
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355614; cv=none; b=PKCwiRU+4QMMtWoSxgtW3S1MLcxndlkWcJBICUgbZVbCGL7VZIc0VDD5TeSKw21Ue8DrNnSqATvyz19w339fFdUWI6S32Gw3wr7SI4wGuLHc0dtbnMJkV/gQfB3WFu1LARXtq7PxMXvp/ZA8GjJq2XnrgiIbn6ob+nlqNFDO8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355614; c=relaxed/simple;
	bh=5pqQZkMykC3JXMoqaN+ZurnKZHbS+SxjBXDSMJB8Nb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSSMO7LB8oPXSUjKeVxbnUk2WBNakuRnuseRHdiCbjGCwsLgT02GwrVzup1lRIrjtYkztSdik9g7Lp0DImOSiAiiQ2F8iEyURyVqH/FoCyDZ/J04SjXSLPlSHTIii2qnZnmd06L9GXqVEdbgMRUgbxKohzMPJWf3K5S6jAlAEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OiQw5maz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so867814a91.1
        for <stable@vger.kernel.org>; Sun, 19 Jan 2025 22:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737355612; x=1737960412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=OiQw5mazhRNet3UON4tn0A1XIpxYEPnnctU6hbJDOcpPTM5zf8Szjhe7fOIYDzow6v
         C4a8N0OmgiZ92voGrcOycR+kD1SFR8lNFFkDDHMrA9I5MxPjGYhSQ+VKoWjm2It3jZO2
         6tlfSn/omIpUg0RDsiIkWRuUsPXQPGHLDzJag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737355612; x=1737960412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=lEZrwN6rhNlhXGUxLO5g4vLlNktswkUeYyF6T20AQWBv3oarvti3m6itdCEDE6kFRn
         4Wxhwm0xNFWoMViVRY3GCtcN4j5/KoTQ1zKDcFOBRmJLKE8jSeGPGMlX3DkJkYbRA1XK
         4r/eQbNXyjvUAREBWTHJTn7BRzph3qcnZACHr+fWdqlw3aXZjfXQWjTCZTYMTJpvLCGQ
         YH2TemTeHpxValXsN1E1tv/ypiAmqW83GeHQHPzOZZ+Z3fRqlg5ORznUT0f3wUwLLORA
         abXFJ6pP36ohScQrAwEIN9wtLSlhGdxYghZZN4f0NdwQR8dUfOf4eZm2udn/IzFhPcd4
         AtTw==
X-Gm-Message-State: AOJu0YwNjQ3JakzRp2/RoZlqBYsvvJaDXeeQlptIDzACh43vLXsCYtFO
	4D1mlym5ymCBTL3sVBvqMY5Vb2cxqWv41z61V8+WUbkPqcwkJJ+uF1EBFGgJpq1YRY3Epuf8S/w
	6eNK8vr4L2Iv8PvEXI+y944pvukt7g9mD/O7sczwN4BeKQ58lVMOUCpa2Avy52wJq21oHUws60e
	ow17NH0PovUJJ8gFbepsvOuYZzybtk9ek36JaTPYIfio8c+3wIZMT4hcOUOmJs
X-Gm-Gg: ASbGnctvJceHnW74Rf6ioEoa+x5LA4dVMumwzAdIL3Nr/17PGgdg13J81EXYpnNrvc0
	VYweRPPJq/Lq55oZWPUcwoNW4DBR1rmTBhqtQWRX8iogR22ymxwkKVVJ/RJMT+aDCmNPcn/jtPE
	4UWOqF5/FgCTv1wGQzhbWZBrYWJJAeuP8gYi1qloytIzOofyU6isteSqyPyPo7uanb+9v+7TEv5
	SJGCOk2bmFTfryP690mc0UPzuO00ohQ0SfZvwV0UAk3zqYn/AJvz0nPXFghDQ/rU6gGwE3JJ62y
	ezJ1SLOOyyf77DVUUJZZAKmtHZL3llXpugm6BQ==
X-Google-Smtp-Source: AGHT+IEYpgRdLItQd5/Tlw0NlvDB9gMR6mMU3xksiQtwizDh2l57h4EiKgvPCSa+k6iJA3IpTpnLkA==
X-Received: by 2002:a17:90a:f944:b0:2ee:f59a:94d3 with SMTP id 98e67ed59e1d1-2f782afea54mr6765626a91.0.1737355611976;
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c191e2fsm10949617a91.19.2025.01.19.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
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
Subject: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Mon, 20 Jan 2025 06:46:47 +0000
Message-Id: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
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
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 1db441db4..2dcb70f49 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -631,7 +631,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -666,7 +666,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -688,11 +687,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
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
@@ -708,10 +705,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
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


