Return-Path: <stable+bounces-132323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C1A86EDA
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BD519E0F6D
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A2221FCE;
	Sat, 12 Apr 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxXPofZd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA302147F8;
	Sat, 12 Apr 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483130; cv=none; b=XICbJ0y/6NegSG2XPNa/BEORClAYqOwA9JwDdfYP2RJ0QO6psBA4EEOxgd4TBztr3qzN2QWv27fGEMs4Mi/Y5A588rWmc8vUD/11294AVdwefJXRP8wrSwwsxvlyZrKvSpT7EZZeGC6AFfMbxB8e1lGOix2DEN4uJBDbXmmc/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483130; c=relaxed/simple;
	bh=zUgtBxcHNfQHwID95Nlq2oNdFKYo8VFOlfj+ZMKdcwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME2/tiYWeBfncI+Bz3QLmiS3gPwcK1DiKVmhi5Tl2Xoazi2R5Tw1Ocht/tLKWW8uKT70ULqpQG0DwDhJLxcU0qAAMEW8pbbAFGcfF0F2MIZ5nft7hqU/+/P6CzH1ZAfKiuLjCF1bZBMDq0qmhZh1BTtaNNu/eUj9dv+WmCG7cCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxXPofZd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so26850465e9.1;
        Sat, 12 Apr 2025 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483127; x=1745087927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUgYhksfu+Eoy58ll0DmCMo/txL7WUG0gWBs2LYDM8U=;
        b=JxXPofZd1V9Yo7ZiAvQosT2LX2Kc6y26stttUgGmao9uKDZ7zplGYqUikFdyhtAn2S
         MVODZno8cG5nTamclnO4i/QMZZ1n0Ga2lVBXawi6bzAC+WkRRQrCDQw4D50G2WNUKKly
         MhVIgWA+xeO/TqyOxuwRkJhfK6VZzZIwBcL1OrlIB0gxC/VLhQH4qDbZJXReCwjzZVfQ
         4cwCFcYQ2261QcxY+K5a954difngPfiPTBtHiMaCKlx/MUkboKiWJMQ32QEqttZEwWMy
         OsryJZhQfQQPf/NiyU5zfP1wA+StVe9UppLHHJQlTjcAR74SnM8U5BzGbGWurC7YhQki
         G04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483127; x=1745087927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUgYhksfu+Eoy58ll0DmCMo/txL7WUG0gWBs2LYDM8U=;
        b=ITUb6jJrSXGkE1Yu9s+flv/6JtV6aXzxFoTOOVvuuYtYHtRVbmk1rVuedV0LnJlqpx
         LLa74u50yGgjQD5jEg5UFsxROwNiRp5I6Pglv3ywacB7MeXVQg7cfLPkNM83kyuIpRa4
         mH6LbkKDJmiGnEHLNK3CuZhEm59Rz2Z0AAcSj60KTdCUKnlApITKQnmgtHTpDC18iAQo
         vW0pktSWf0mm/8siLH5VB/O9kUk2a5WRjIqZYWeKtg94j+ppEc6R0/mJmCJlb5cQ31ii
         Nj/DwKsKw6Zpacor+84C8xwxGrEx5/Xkscx8+wfu7gVgCFMdetHFf9N4LD6weC40qQUs
         o1bw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0Ja+XV4xlLML+ex9hfyxh1HWLIcDSDSgE7UoBA2bAyYi7w2Jqwq/6w2Btx9lJUAUuBohcFkqxA7X@vger.kernel.org, AJvYcCUdy/GW4pf1GXzDgC9SN7wuO9g0D5TcyKSaxecumpj3dUKBYySJO/jldAvxEzUHHwEOrTW66PrV@vger.kernel.org, AJvYcCUr9Y03ChxnS89fEOJp3tor883eiRJb3ewbGf2Nqhg5qRX8u9nkePplvpgiF7zTZHX7kxd1FukS@vger.kernel.org, AJvYcCX4cExZJ0MdfKwhKrT2oidPhHCvYtNLBqhEuTLCiK/r32rknWtvuXtTeN2O0ue6fTGxMHDiBSgTYe84yuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4r6DYYpKMeD9JH5ufK52ifB4unky2VB8Bu3mSjxNpqh3Ca/y
	hjL9amGy+Sbo/FrDwvoi75FYZMUpOOJItny4aRvcTJaukBYKeYJe
X-Gm-Gg: ASbGncsHERvocPH5e64SlmD+mTPJXarieaufjiqeW50KWdbLodBCw8TCR0uXmM6+JB9
	sJCnA7c7WUuqCuDPsq943Gbi48KrfMVLWrKN3+RzH/CBYlQAwTx6caTF7C2XshCO+tW3s4uAIiI
	8f3aA4xnloh29kueV28RgBKpyDTWLiXGdtBd5q//XMpDxbpxNMiP+4V5xOZ1jQ/FuXfE5qL98gD
	692Cix3ZXbrMQRSqV3dfQCvluW/9tOdym2Y9nghkj3RFLmnweu4r8d+7HoLFkHCgv2KRqBqHHFj
	FuPFLG/0aVYwfkEkIb6Zsd64/rn+xArFAW+oI9G3ZLcztOdtv7i/wp4=
X-Google-Smtp-Source: AGHT+IEuU//N4q6Mgvz6wC6S1hlZkt1w7Omac2lzLX0BCkFbvgKOxgZnRbknb6CWCqXhsC8obs+M6A==
X-Received: by 2002:a05:600c:3c91:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-43f3a9a68a1mr55598015e9.22.1744483126901;
        Sat, 12 Apr 2025 11:38:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:46 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 2/5] net: ch9200: remove extraneous return that prevents error propagation
Date: Sat, 12 Apr 2025 19:38:26 +0100
Message-Id: <20250412183829.41342-3-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250412183829.41342-1-qasdev00@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control_write() function sets err to -EINVAL however there
is an incorrectly placed 'return 0' statement after it which stops
the propogation of the error.

Fix this issue by removing the 'return 0'.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 4f29ecf2240a..61eb6c207eb1 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
 		err = -EINVAL;
 	kfree(buf);
 
-	return 0;
-
 err_out:
 	return err;
 }
-- 
2.39.5


