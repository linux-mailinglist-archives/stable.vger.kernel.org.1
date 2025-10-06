Return-Path: <stable+bounces-183429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F75BBDE85
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB75A1895CEF
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815926A0AD;
	Mon,  6 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRADCv4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE162A1BB
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751138; cv=none; b=rFYfWIygCnCuP9vjymi/psznroN8GElnm8JEiwVQ9ZIbrmZnbcgLRr1H9ykyFcy+F9yl2xmU3s9JpZESAS3LMPIn7uPgkZL6+LFti0At5AKaSODQ8D6UOTjfCEufod+vjWqp2aCYkVfZ8ULCI7MeH2wJ6cS2Oek/UW5MetWUEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751138; c=relaxed/simple;
	bh=BNMTecTK7ht2nSD6ZXYzFBe3xWgFyVgzfWdD51vF2ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiJzK7kVfyaA5+uELf1+0Fb0sWpkDjrskU5x4j1sd3+TU5gHUH9sTGNWSqymP5jJMcfdE7Rafzz6Ybyhj/rqCK4Q3VrSptNGcyK3iwINC9hG3WZvjujiL31XgiIOKFUbok49Dwq3s3QrczOe5mL7zVGouhfVg+4aUEn15gEHHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRADCv4A; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3851458a12.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759751136; x=1760355936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=BRADCv4AmoGrSNykcmZfCU/NW5/7yNOzfyyXh+TlUefpAiPXbXvjsvL6+Mkywkeaux
         d7RkUdN4FTXhku8uwu8Ynn3ZtHiv6N1kgGjwsZ+etbRxQcY0kvKsZQr0VDnKy0AwVrIS
         B3ei/oTRLl5WFIXu/soM4vbP+Yuie2aQ60yUFwnBCJVbdKQ9iEQkZrSJjaKx9D1sFIS9
         U45p5CwcA1iCaoLLBd3lMQKQMC0WomvwA2PpWgYcCD8QZv+oQEn6pdqBTe6nj8HBV7dK
         Bl+Ap2jftmSXuvc9TvE58gljXCXfJx5jMWUKp1EnAzIPw//8FzM2Zf2OkkJkkUQEHKgV
         gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751136; x=1760355936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=W4hS1YcXhynLPO9DENHWH0rWcg600bOZVVt/AsG5JACox7hEn6NmuSMq8ZYNUJf4GQ
         yYVKmcphBWUf1KmnVjKWOsVtqJPkw0cxxCswpGlpM2DY/TXKLri6evdVPnT1X7v/07ZV
         1kef+pv61cCEcCeeAJswAQolV9TQB/sRCUb2rJe8Gr7UpZd009PAyuntQxmuTPbYKiYV
         +RLiP91k41abkfwl82QrudGz186ogMwTcyVRBz1tEySrJU7GHDAAD/oYjCh5AcD4NUn/
         ecbslazgbrAB9dFGHLpYtk4ci2qMdQitNGDDET4Z+9aaH/c2zqknRB3DovDspNkdUABM
         oqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPmOQzhOR7+Qnz1H6/PlZM/expoBsDIchQPKbMYfVlO8aTGCbR0D9FHkLkaBhoURcn6GJp/RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJ8UbppeG+66ybww5QHlYSmP453fQQPrWO4CurASajaJm2nSX
	75qJXZ2nZvWmY4J4SDXAKGmf+6pSUjmS/Uzxg5GTgUxcZ488Piyh8mK7
X-Gm-Gg: ASbGncuWToAK1vAzysCuAnCJp7+QQKM748e/MqhrBsQG2SM5y9H2hi43+Aok1BjI4+a
	cr3QGRnt7krfxBEs/GlzX9Wh8Cz01hOUTGdAYRUC86X5lpV+YkSA0tfEU1gYS0J/lYJtHvoGb0j
	W/7kKcVATW/mktEAAaZjfZtnmKWb3b3WogqWUkx6XAcAt8bqPU2hYSZCjW1cZY3lMLxIIos0Rk6
	0cPERh9TSg/Jv7qZA72FLwoBD+z+tEgsC9Jrc0VaZPKhTSrWvveSgbHA/lrZA4YgwsnOF3xVCI7
	LfUkV1j/iLs7Xo56q8qSNYOJOcSOkp/KUHOPaD1munOnQzGhkr9nYd+FPDJmpAhM4o/csW9yR/e
	2rwn+c9vJjpTg5laN0d7J7zmQOE6RzdBbBqJp0IjsFB3czQyX9ywEFCo2FTSbyj5h50egZD2uJp
	vphYU84xDP
X-Google-Smtp-Source: AGHT+IFxvKU50K5L0Q+Tb+yTYS0SE7q47+l6oijumnjKnEw2OY+E5WVkaAED+m1lCr0N1DGoF+vVUQ==
X-Received: by 2002:a17:902:db10:b0:264:8a8d:92dd with SMTP id d9443c01a7336-28e9a58b55emr157083105ad.20.1759751136030;
        Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b845bsm130568745ad.79.2025.10.06.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:45:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: viro@zeniv.linux.org.uk,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon,  6 Oct 2025 20:45:07 +0900
Message-Id: <20251006114507.371788-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the loop that converts characters to ucs2 ends, the variable i 
may be greater than or equal to len. However, when checking whether the
last byte of p_cstring is NULL, the variable i is used as is, resulting
in an out-of-bounds read if i >= len.

Therefore, to prevent this, we need to modify the function to check
whether i is less than len, and if i is greater than or equal to len,
to check p_cstring[len - 1] byte.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..a52f3494eb20 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (p_cstring[min(i, len - 1)] != '\0')
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

