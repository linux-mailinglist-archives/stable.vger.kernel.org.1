Return-Path: <stable+bounces-191696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66770C1EB9D
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22CA1890E09
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80B3358D5;
	Thu, 30 Oct 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeIBdFMO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C572F0C66
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808934; cv=none; b=JgEdWXk2rXcmYq3bpYdfwuniYecXHAaoiqpitC0Y83Cd2wSDsAo2L+3rk6e8p+ct4VUziwG4BbvQVg+gfi7d+3RETdrJKY1MXr8tUttAoUX/V38Dx348d3UWTG9M2WoeM1Lw730z6f0VOcGS1ZqU5Mljlhr3F6evd9jVMy4o5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808934; c=relaxed/simple;
	bh=BK9QyNasA/qNf+VmxCdQRMf4FU+qlzDQIVRA+LFxeLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCN3Jm8N8Oo2sQgdtkjamUCmx5Vmbfxvf8JWL664QxEgU4FIXsgEJyC7M8/GImHVicaK5BqFxR7BRimpFa290m5LUAKBRT7qt79Am8Le5rvg8eWgAM7eZXxbE8e5ObFDhfeCrdNYPTgBqrqOXeX/3lZPHydrZ4Se2mUgzMGw4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeIBdFMO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67684e2904so448453a12.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761808932; x=1762413732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=VeIBdFMOyNnzytW6z7wmEMpo4U4u9D3bbb02YciQYyYJBuMx8RZ0Xhedz1pVJEKtx5
         S+1t+qYNEwqQDDU1c65q7nZO1LAXELE8Qwl1eC5AYHqGy2C0qed4+T4FI+bIFxe7N/6X
         1mNGM/dMf5GWt108wPWBf9R+oXxpCDhK24/LPT3YEBeR/88Zc59pK0cjbaLpa1yIEqit
         q7OqYvv6fQbf+7a3RHVEA7OazvTxP4sPUnOSfAWP+BpzhN1xXJR3Rd7HpyQEU62XzYrt
         qlSR36qicwNVp84yhm4sLbGlJrreqNy+TGz8r5eXBWWX6byMXPfJv5/PgFfGbe5riOkf
         JPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808932; x=1762413732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=pspFLXOpmVKH1TZ3cw37uQHiveVdkHmU7OlCybPJS4ojKR+S+NeDpwP7XOAu7yRuHe
         1Fk5X5llYx6j2sKPidCD0w+z4M9XM+wFfvpzKSNTXHg5upNkXACge9xNX3r+KeNMiqwt
         arRNxmbT0uNEces1cU5YCtEnvVuUoLWkcjWhoBIOxZnYsThqWD8QRkSilbQnL36Mv0Cn
         2Bpu/DeaFaKrvrMlZycfu525Pp9NX6XEr+FgNYS1khuDDtICrXSVoYeSJUc+GHbKBkq2
         OeKx1ADpB0BPJgemwGE68GeAI2u05Yfagkl93AZxVpB1skBuwIo7UtDazLjwjXJF3Svc
         51Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Eb1+Gf10j/30KA2pVqvBYbxN/H9qXGYYeF9HneD407SbQROlhgp3s/X+EH4bHCy7EOA7kds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl8mxXBFtb+tHJZ9RJwtm6XWbXGfOZLS+5ByUiEb8L4eLD2JJ
	tAl34UPVNZF5ouwnZjM7CaULmVSIApkqIsl7lQe4t/N7YMGBitEDzr+Y
X-Gm-Gg: ASbGncsB8CwJNcd8cmmB16x2N6NmrnVu/Y/RPgqhIv+Dmeca/NtKF9pCwH6/rlA6oTS
	wLfuxrSPttvtrQ7mG2LBD/pqrWdAdYDrIcmoMP7fCfj/1UxBtWYZ37lBJidbhNuEkzdU9/GlSR7
	ThXQ5k6N+ydHBipvZN1ZODYeur6EqhiX9LQ9CfW1jrNoHKbLvGdYUNL3u1l6szJksL9RJmmayql
	HIFBRPRDbVPkIPNVoNdxz+wmRF9Y5ozV+RAnWjqJ47ycB7rWZvHiHEkhsoUALXvp541u/bUIw22
	YCaRqulAaTrcZxcd3DVYxHZKkJo/r0CWLK0sjxhUpNq2NXQfEVaHOCHd4FKbR6doGDCS6KxN6LJ
	OiTK2p513oSIUIwYSVg/sz3BvOWFmv90/isOtFSCsC5dVIzqfy58H8+7Bsn4UU46OfXqRO4SQYm
	tQXWpE+kZvhmYSEUvXaIg2eg==
X-Google-Smtp-Source: AGHT+IEJzjadnlIxV5ulJGWrPrx9myLqREBJf1yyP0HpGFqWQhdbyL5hCkrJAnTltkMImoRPFo5a0Q==
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d79 with SMTP id d9443c01a7336-294dedf4305mr67171885ad.5.1761808931687;
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d23218sm173814695ad.51.2025.10.30.00.22.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Kotthoff <metalhead@metalhead.ws>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] sparc/led: prevent buffer underflow on zero-length write
Date: Thu, 30 Oct 2025 15:21:53 +0800
Message-Id: <20251030072156.30656-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds access in led_proc_write() when count is 0.
Accessing buf[count - 1] with count=0 reads/writes buf[-1].

Check for count==0 and return -EINVAL early to fix this.

Found via static analysis and code review.

Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb..aa0ca0d8d0e2 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 {
 	char *buf = NULL;
 
+	if (count == 0)
+		return -EINVAL;
+
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-- 
2.39.5 (Apple Git-154)


