Return-Path: <stable+bounces-203267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F8CD8368
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1504C300C29F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE551FA272;
	Tue, 23 Dec 2025 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="czBtDdGS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0F137C52
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468913; cv=none; b=kCz/fdjF6tHX9UE2/wT205+/8iyc4I/VG6zvLsdSjxGvRE+CgetO7/O1HgSzPMdaEcHdH6QJg5xueEdJRccl9dB989eHKW+2X+3OSSntTMZIXkKBtwa/yk8gJLu2GwxS2JBukjxe28g/aFfCFe3YNVb/TAJWcemXwCn2l7Kh28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468913; c=relaxed/simple;
	bh=RPpkS1QuyFFtxTsDVMkWej7l2G7Y6oeqyI5L1QR3FHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpX4OYLcJ0h1XTqwsXgIXWZGUEe5tF7CLKhaTMp9GvFdSjp8AsSInC/uZnVhGT46fbjQCPPtLG9Xqw8tLvE+7vTXOBSOxUlVXlVjw6f5hNrvp2sjJimNHfXPL6bEskXTGh/vqHrmuGyI9dSPc4B3zLDKRZxQ3Y7qaE5yc43TYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=czBtDdGS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9387df58cso7486126b3a.3
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 21:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1766468910; x=1767073710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jlHTkGTlLd5I0Fc+k21AUFih0xaPy2p6vqpjRhpFjs=;
        b=czBtDdGS5hnEvNVsOoXU+17XTIRcWVn0ro0tVUqEos0m/F3z2/1497uWgiOURw5nUQ
         mLZABxLHgTtmFO7g6f0MrEvl1scvfcpeWuGQ6yFl4mwXm9asafcSUAYu0fFHuRLo6ZT3
         sea4EGBqRKdoHWRdF5yrz9UlN3L9nuREt/XzjlSCNGZEo7LbNbMPEg/mT9X7ZH3Jrnx/
         yzkfp80HJ9IC9j2gcBgCIHV7GpYxFwPTH8xvzoquAXsasoOjUC8mrP+PnTRZ5KU4K9xc
         QgHUoR55yyXnKlE9wCF2BVUDGXsmBRwUyjDjOSQLIrWozmgO5d+x2ojrjyG5CF+B0Cys
         WRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468910; x=1767073710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jlHTkGTlLd5I0Fc+k21AUFih0xaPy2p6vqpjRhpFjs=;
        b=sc/34hX/wDEPxiW9fXt3Wc+4xm7ORjf9UcNeCQWml5ZCAvWimE1O/NdEYS6XFQLHYh
         pw62U6hwDKBc3nJ2Zh8UQH1Uwwps+qpPYthBTrYTs6B0FxApzVO4HEMBlbF+crswBG6F
         69k2o8LJ0uah2dC92KQqE0xfuPGgMwobfIN/18Pl2fuATerRQqQk/iCzm6uTmysa5kz0
         EuDsE/Fn7RGPEl5FBOC61mS2V4RLaQj6dBMQ82NB1p8xrNJNhbM+DA+qSiXLn/Bh0mEQ
         fLzfa6gy2n3fRQxbgChxe9Z9INGfSFxt8p6C4w7kMlNzGKeyZpKZ117XR/47EfRG4VVw
         DArw==
X-Forwarded-Encrypted: i=1; AJvYcCUfp1uaMplmK1+SCIpdvPHxna+rwKIm5xJHBeoiqBCILPXGFMY5yfB79UBgdKonwLgdfSOhgnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZu1oSYXR3TcfC0aA4d0opxbLwnmcfk8TFJI/ghSzN/IQhCQaU
	1j8hnwwPFt31Zcq2zmsZHeJWA//Oun75VyP8QCW3IcxWPUMgYlBmhS4KSZONvFpQb0U=
X-Gm-Gg: AY/fxX7ETc7MTzO2xuBZSaZEVMpfWoUIyS0qedIpUNWB9TryutO8Y0rOTPj24/Tmi5j
	Jh+2evZJ5DnaCyx2F65tEwF+jfOWpUKr+36OnNpk/ko7Hd1stqHErn89NXe98ZPf6KsR01QOCL9
	L+GduiTZaeErvrDb6r/LrWb2p/nyFlzyuQKBLoopskr2kif4DGWOX8Y5XMqDTJIS7sX1yL+iQyz
	pOZSQtM0tCPMk81rsZt0buhzzntA/3DxHHESZmzCOHDfjIybNeRCk4zHT+jminrA4Ag2AmFLIKy
	god9oqm6o6/Fz9ortCNBlTJiNMyw8NIzLRQNA1Tjx1IC5UqdeyIcTCQ1E00XAu9xx0rM+Pw3Bov
	sOdWUn6un8mPzzTJXXg+CaoPw8x6JyM5jNJpyyavZvsr5dYa+QnMkSvDOyqNfTewBf+bxnc8Npb
	35FEOWIDaiVilRHBRHmXlRhx4m
X-Google-Smtp-Source: AGHT+IEmBnCEvZ4KcsGUP2OBZ3PJxb3lPfUs8yKwN7nmXuTr/Mr71NH3RlybylhUYq9H/FqrLtaMBQ==
X-Received: by 2002:a05:6a00:808c:b0:7e8:450c:61a1 with SMTP id d2e1a72fcca58-7ff66a6d896mr12891880b3a.56.1766468909846;
        Mon, 22 Dec 2025 21:48:29 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm12287026b3a.32.2025.12.22.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 21:48:29 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: mchehab@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c/tw9903: Fix potential memory leak in tw9903_probe()
Date: Tue, 23 Dec 2025 11:18:13 +0530
Message-ID: <20251223054816.68912-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error paths in tw9903_probe(), the memory allocated in
v4l2_ctrl_handler_init() and v4l2_ctrl_new_std() is not freed. Fix that
by calling v4l2_ctrl_handler_free() on the handler in that error path.

Cc: stable@vger.kernel.org
Fixes: 0890ec19c65d ("[media] tw9903: add new tw9903 video decoder")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/media/i2c/tw9903.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/tw9903.c b/drivers/media/i2c/tw9903.c
index b996a05e56f2..c3eafd5d5dc8 100644
--- a/drivers/media/i2c/tw9903.c
+++ b/drivers/media/i2c/tw9903.c
@@ -228,6 +228,7 @@ static int tw9903_probe(struct i2c_client *client)
 
 	if (write_regs(sd, initial_registers) < 0) {
 		v4l2_err(client, "error initializing TW9903\n");
+		v4l2_ctrl_handler_free(hdl);
 		return -EINVAL;
 	}
 
-- 
2.43.0


