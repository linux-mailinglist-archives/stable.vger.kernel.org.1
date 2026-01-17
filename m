Return-Path: <stable+bounces-210154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB791D38EEE
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6567B3005310
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C66219A71;
	Sat, 17 Jan 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwMMfcZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7001F2380
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768659012; cv=none; b=JpTd6mj3YeI2nQ7/+SIDRipqN/S/3x6muc9MX3XpDRkAfU3I4SNN4j8cERd9Mym6dzb5/isCePTGloMsink4xJVJ7qomk30Fd84xBSOcdjOJICH9Sq4FTzcAqfcTLgkFR01UvHe9U63ASJkXFXu35maq+2uRaCIBOsUX7afWUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768659012; c=relaxed/simple;
	bh=QAIEr0P+YLPaShZQagznwIHykJGkUBoI8g4SE0BgWRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ys/qarljAVFg722M7e9/UzCmmhwM1EvkT+/TML1WF0qbFWdGmbRG6S+MamFNol85xBSF9SJt6XRdCIewGqy7JwoRPm9Hvu5H8dcgSt6SNPnaKjqEca+77EGzFWFYK86TmVtZzeTRRCY9yKsdadf+0zmyj7N9e5RkkPwpyiASmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwMMfcZZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1170147a12.0
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768659011; x=1769263811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YsjaSB9aIQokwOFTN0Ov8qKUwyht65twzNGrMEevb0=;
        b=ZwMMfcZZNCj5942+F7urbmHUqbJtL3JcjVWOC0s3ndieZ+mwPCjX7MfsVaQgp9aP9O
         xePVkeJV6AlrIgsPj4qqywx9v0p+XBw1Dk3tu/zD6xkuNHmxglNKiTG6MkxyXPqS1IF1
         w5kMyhLP8AdNR78h9rlUfomfn/VpSQGmnUtDhuNSAuXuuYa/78jj+6NtsxdHfsCVJyaH
         UC3fXUrKMduZH3ymloKdLdOZsKmTZiGTfBcPo50CZNrYzWlBicp8aFiKhea1tVE2HRfU
         tn5OSsIEc7GSE7PqLctWNkFxaL2Pcxx8PqrqIVTC/355SszVQoiifFbSB5nAs+txHkqK
         WbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768659011; x=1769263811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YsjaSB9aIQokwOFTN0Ov8qKUwyht65twzNGrMEevb0=;
        b=hS1gdRAvKpVuO5OlA0l/goBntRKjKFhxWznMLo6Q8D6EiRQqOh5MesD7A2eu+zEoVE
         d1IXryY1wJOaD79OUJFsQTm7JoQDh0aTJ86C8IgDvR+IX0rZrA7v7z9wzZFVtuWTiJ8C
         GkVSvG86SS/YqNwNdVUbdHQiy5J/iRZSTztoP7m8bUxus7a6AfaIzLBJpRjg+kBzA+90
         JVJ6fFKmTpnrf4xpge3FdV0Ov7a+/x1d/m76x+ky3ejyurFmof41aFhmeOqljutJsKuN
         SOBoHYtu+I1as+3hoI5gtnLP+0aMSocDbqRVs+Vken5BoNLuauGCFeNXV4By5elVJKvo
         O2gg==
X-Forwarded-Encrypted: i=1; AJvYcCUkWYUF2C5hmsrrv7Vy6NIf0Ip5n+G+DBVih/VSf0PJr49XTW3Tnb9B9CpLOSYSoRdX5IAjbQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52+iP0AKa7ylHE4UoBUBMmPgUxRRtmY6Hd3SWlGGKKhLxE3wv
	RUtvGxQz7u5XuuW4jQno4f/H6ycAntCzvzrbbt49TsSFPAjeWKNtqXe7
X-Gm-Gg: AY/fxX5XMiNhFD+y5Vvs2tVdv43+RNvI+iPE7ZHPDdswhEJbYrfy5K+x1uKjOZncvLS
	BCEgSDz1bD+qCy2mpfsAB5mu9eVVF770mvUEGUCMctRmQtDt4yPJ9YZWjgE7Kdilel/awULx5lh
	DYCVT3zvuF1/pHuHbmUdXgBAZQ41E2aQFd4ixp45AepdBLjHaYpl72w7LWZ7KjGF5VV5XUCH6Js
	+I4i3oVHqRZl6ggAKzzz4I4iiYMEeg3ebRukU7vZjDoO1AFjsIEjsAnaqwBGcAxLZYs2F1t4Tpw
	1TsDlOI3AV3SVBWF9wbUTBZ1ibi/OqUvuFFFM7pqDym+BK8tKI7qzb1RHPDtwVIwhnacbuoVVnq
	b5aGluCg9dqmc3TK5kJDuBsN5cj/G2boxjI6wrM+fyM4pGKQpye/LRiYqB9FNLCGA8VoAdiE+5o
	CP8pAw/Pom7fVqQLuchZ3+7bPkWduD34T+Qg==
X-Received: by 2002:a05:6a21:1506:b0:364:1332:54ca with SMTP id adf61e73a8af0-38dfe7b7580mr5929841637.59.1768659011011;
        Sat, 17 Jan 2026 06:10:11 -0800 (PST)
Received: from localhost.localdomain ([111.202.170.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32dbc1sm4834519a12.21.2026.01.17.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 06:10:10 -0800 (PST)
From: Xingjing Deng <micro6947@gmail.com>
X-Google-Original-From: Xingjing Deng <xjdeng@buaa.edu.cn>
To: srini@kernel.org,
	amahesh@qti.qualcomm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xingjing Deng <xjdeng@buaa.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] misc: fastrpc: possible double-free of cctx->remote_heap
Date: Sat, 17 Jan 2026 22:09:59 +0800
Message-Id: <20260117140959.879035-1-xjdeng@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fastrpc_init_create_static_process() may free cctx->remote_heap on the
err_map path but does not clear the pointer. Later, fastrpc_rpmsg_remove()
frees cctx->remote_heap again if it is non-NULL, which can lead to a
double-free if the INIT_CREATE_STATIC ioctl hits the error path and the rpmsg
device is subsequently removed/unbound.
Clear cctx->remote_heap after freeing it in the error path to prevent the
later cleanup from freeing it again.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>

---

v3:
- Adjust the email format.
- Link to v2: https://lore.kernel.org/linux-arm-msm/2026011650-gravitate-happily-5d0c@gregkh/T/#t

v2:
- Add Fixes: and Cc: stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/linux-arm-msm/2026011227-casualty-rephrase-9381@gregkh/T/#t

 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ee652ef01534..fb3b54e05928 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1370,6 +1370,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	}
 err_map:
 	fastrpc_buf_free(fl->cctx->remote_heap);
+	fl->cctx->remote_heap = NULL;
 err_name:
 	kfree(name);
 err:
-- 
2.25.1


