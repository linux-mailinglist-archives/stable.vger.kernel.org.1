Return-Path: <stable+bounces-152599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C8AD8143
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 04:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A8A3A017C
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10D24169A;
	Fri, 13 Jun 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhv9mNah"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802118A6AD
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783138; cv=none; b=RUjGzEcUYd1iKMTLQ6JUqa0rW1zh4JpaeGNZ0ikPnTw9vRsmwWg6tgXqcitpKHoRzDkwLZLNOlgFIeMR5ZaQaTMjPu0NGxfhfK6ZZvgrNKvwqK/+tBUo4mg62xd8LIKIRiFkD79ZV17IJpOZSQJpIyVbzPWVihS2QvaW5KF0bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783138; c=relaxed/simple;
	bh=nYk6HdzFLt64/RM5C0y/3p3H4xCf/634Nv1ZOcfo690=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlWMVMJuXKAsLf2GfBjpMatnjeXnaMByji/YUv3m64hvmznz3BrXXKIAIk3gYNqPiP3PS0VOP7LzyJj1jWOcBsQl6IIaswWJ2UoS91a8Id7uWywMaJ7zMEb1PrfLUYpwV976Nh91tw6rZ2SmpTLWOk3wmrfTLT7qRCaHUnmi5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhv9mNah; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23649faf69fso16651105ad.0
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 19:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749783136; x=1750387936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1QAQYjhRY6VZzSDU0ZFwRsyHmXvKEp5ZfhKVHci6qU=;
        b=Xhv9mNah9mL014GO1YZ8V3DE9Un5eJTdXTTtLToq6F6vUNmnA+I6t0yrGIp54UNweY
         FL5anLdYwz2jaxjUYuvBER58M9RTPfc4ZG5SIwpoQpTwDIzrkcjQ+BqM1hUSrDCT2mom
         VNvMnuXoO7HjnrT3ubLRcykEQ2ivxH3GLZPVJHW7dVYpTwkS+aD8XJUe9It7f/+UqAy2
         lJj5rXmPR03GPvm0VU6CwvewoaHmcyuRF7wbmsJvyVxZmkJ9ZTSsnIKp1zjzfhLIl/1H
         XmOuHoLPhfFkspjniEoZVNYxf9hqbulrWcY8MSeh9zdxR5uu98OsAF235mCPnUuNIecs
         Q8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749783136; x=1750387936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1QAQYjhRY6VZzSDU0ZFwRsyHmXvKEp5ZfhKVHci6qU=;
        b=XTYWh86bGx0kXP2nVfGFkcEOhEOuVF47EHjS40ib/VoMEcClH8yXkerZZfcLCORAin
         H/hUO7LhswfMY4vdsSfOHHuxgAbeOJWSip9f2YYxj2MiHVWQuEPxPJ3ygzltezZ+K7Ua
         TxwfmsS6qCZQJ723xHKSWy6tyyQirdXauq6jPJ0WVa88jLCXGw3cskZq0hi9A8YL62QL
         fkAskKVCTeTr+vBajRdUDHiOdwwC9VB1F4HiO/FXC4WK2jFloiu/lbeIzOjrR1MpzcHu
         X41IoPMOT+0V3eJwEeDsgVA2rr1m5wcJnjlVHfjAjxjlW2BPHtywgCV9JZuTKkfWKzXx
         d/Sw==
X-Gm-Message-State: AOJu0YxbermgHWdew+002tYDhFftip4x2z73wcqwKsVY1k+mF7TsFhxY
	0+PEkh4dSS78dZ8QuRU1uFfa92CJllhnNZCRJedGeslAryLinEOEbQhpZOMSbUL0
X-Gm-Gg: ASbGncvvSoPs+/zdbpyk3SmUA4r+/zsDOboGBgy1MqmDiMbc6H6T3NZj5D+1avx66Y4
	UqGYhkwaDAfyqIZo4QHNsURPXWziS5pPohH+/WBZYPloTChwzjmbaEkX62yc95u0hz7whH9y019
	JCZeqdOO7p5LpiOOccp8RI0lp6wr5nct0NAetgknr0DK2Yh1K7JVsfHoPRzjA3UnSNUnxo/zRJe
	H2dC3ndmriQLjdJb2YvjPQ1SrgHlmdUlNzgWblS/uAgM8oxejvqCvUtrYhJZ66Ew4bkUN5pdEFp
	aPh9N7CHZUDrLDoMnxj6z7FLTkNt9CH4O+B3DHgs7rcHVYH8dMae7u5VHpK160YuHCCrVgxJO7b
	ELsuZqyhjy+DlZhGyJD/FTPUOa5r0EC8E1BXT
X-Google-Smtp-Source: AGHT+IGKtQqENBxU4ySDUzDv4MsvEqfPugvo9xaZfw2KKsaEAsui13EbCQiKCb5UnHnqXZRB8CQKcA==
X-Received: by 2002:a17:903:1cf:b0:234:b41e:37a4 with SMTP id d9443c01a7336-2365d888103mr16242975ad.6.1749783135549;
        Thu, 12 Jun 2025 19:52:15 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365de782d3sm4411295ad.115.2025.06.12.19.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:52:15 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH 6.12.y] wifi: rtw89: phy: add dummy C2H event handler for report of TAS power
Date: Fri, 13 Jun 2025 10:52:12 +0800
Message-ID: <20250613025212.6303-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 09489812013f9ff3850c3af9900c88012b8c1e5d ]

The newer firmware, like RTL8852C version 0.27.111.0, will notify driver
report of TAS (Time Averaged SAR) power by new C2H events. This is to
assist in higher accurate calculation of TAS.

For now, driver doesn't use the report yet, so add a dummy handler to
avoid it throws info like:
   rtw89_8852ce 0000:03:00.0: c2h class 9 func 6 not support

Also add "MAC" and "PHY" to the message to disambiguate the source of
C2H event.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241209042127.21424-1-pkshih@realtek.com
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Currently the rtw89 driver in kernel 6.12.y could spam the system log with
the messages below if the distro provides a newer firmware, backport this
patch to 6.12.y to fix it.

[   13.207637] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   17.115171] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   19.117996] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   21.122162] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   23.123588] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   25.127008] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   31.246591] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   34.665080] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   41.064308] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   43.067127] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   45.069878] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   47.072845] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   49.265599] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   51.268512] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   53.271490] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support
[   55.274271] rtw89_8852ce 0000:02:00.0: c2h class 9 func 6 not support

---
 drivers/net/wireless/realtek/rtw89/mac.c |  4 ++--
 drivers/net/wireless/realtek/rtw89/phy.c | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9b09d4b7d..2188bca89 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5513,11 +5513,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5c31639b4..355c3f58a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3062,10 +3062,16 @@ rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u3
 		    (int)(len - sizeof(report->hdr)), &report->state);
 }
 
+static void
+rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_report_handler[])(struct rtw89_dev *rtwdev,
 						  struct sk_buff *c2h, u32 len) = {
 	[RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE] = rtw89_phy_c2h_rfk_report_state,
+	[RTW89_PHY_C2H_RFK_LOG_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
 };
 
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
@@ -3119,11 +3125,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			return;
 		fallthrough;
 	default:
-		rtw89_info(rtwdev, "c2h class %d not support\n", class);
+		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "c2h class %d func %d not support\n", class,
+		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
 			   func);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9bb9c9c8e..961a4bacb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -151,6 +151,7 @@ enum rtw89_phy_c2h_rfk_log_func {
 
 enum rtw89_phy_c2h_rfk_report_func {
 	RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE = 0,
+	RTW89_PHY_C2H_RFK_LOG_TAS_PWR = 6,
 };
 
 enum rtw89_phy_c2h_dm_func {
-- 
2.49.0


