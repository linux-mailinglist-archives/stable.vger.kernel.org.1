Return-Path: <stable+bounces-127485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35890A79C83
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 09:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C888716F2E3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986E23F296;
	Thu,  3 Apr 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkmQLBxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC923F273;
	Thu,  3 Apr 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663830; cv=none; b=GKQ5DJdr0SVkZSry3bzzJ2YtBKrzo1y8IZdbCgoBN6HtIJBxMKbklbUj+NAtbGJ0PsT0LzP79tbsnXDMJI0sVx3C5kw2i4lUzWq/9BJEGJK5LXr951QXozTMFKBcAFPcBSVEzK58IzgiWlseAuh4fRBmqNagVHHFAOfsq8QV2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663830; c=relaxed/simple;
	bh=VqD21zug0bzNRIfh64ajCU8czSXSOItLcFIN3MXSFaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUqzAzlLbTM3dg7KfRRRFRSAPxq9sFA8QBh4WSq4E/f0jzcjpBxM1JCPq2VEEfjNMmPBvnn/x+2VDKHcipyJGhKFCdxcvupzTHFZf6xTSnGkE2KmaHTqQSlIRqCXTOZyuKVyQFZZyytrYKlJZTz9Mp+yilnAUsShH3hoczhJQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkmQLBxD; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-736b98acaadso519751b3a.1;
        Thu, 03 Apr 2025 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743663828; x=1744268628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igrrWjIKA7a8qvg8aOTq0yFxsHm/NBQIR20zcRQX2tE=;
        b=JkmQLBxDBcpms768ZjrH2SRCZFkl+6IUN9LpQHDKQxpaaX8xSv0MIsK88sBEbeCF8a
         F7siQ/1qPsNucZUlU9qBAYuX+2b8Fz8ZvpPrLOG98A0D2UkUCaq3oILe3t5rtSuu0F6Q
         5Hq+Sdf6I1VlIXkZpO0dCgNHyEkR8CPLbHzZ9SPBTpsYsED8JN70wr+pQFJvAcmx2p4f
         2+MLgQFGgaTN8rECI81fcMRX2zoebvKTFl4ndu38CwKic0Lr6VcPCHwcYRCRZuiBxP58
         LM1V03G9ywS4X0zbC54WRGaTtlSugqGBuazCOGRlDT92cnc13adqpJ9N+RMPNwlays1r
         n2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743663828; x=1744268628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igrrWjIKA7a8qvg8aOTq0yFxsHm/NBQIR20zcRQX2tE=;
        b=IzHkMTjmN8UXYipNizl/gXudrghRTsL3zx1fTX/yQGrmHsUEhCBq7LMTul2em3MoWT
         VEzGxxrPzXaK00J8XABqV2lQi5U3bibZwEo6q1Ls9vDSqpDjGrrH24IJ7choY6XhYUL1
         LmUkvuJDr6JQnCVaiGwBhdd8pBwhW566JxpxYhsGBdyrfxIXPWFM3kSMkkYAZ+HZZ55e
         F//BejGQgfkq+pN0GEwiz5HH4GGldCiaLXqL778ScQwdn5gQBr6eNWSgclJ1z8RZOqlq
         gSVCKcdB5rOYsVRR+k6cxEUpTKPXfEQswUQKNwptcBAsQZMEhEK53Dj1csIxA7/o9gTK
         5A6w==
X-Forwarded-Encrypted: i=1; AJvYcCW7wJahkgcAsjockA+/4f2HZrHgwV4RC0fQXpyTdW68KNVAycIczsegBXk/CcVseC8UUu0acMk5@vger.kernel.org, AJvYcCWKhkojVc/ueg7/o0Uo+WFeEcNQACI38zeYvhDzIE7hA69OqhBOV6HWlQKlzqmRGwqa4YDqZ8JLxE4XAfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG2HHsuZOMOPlpDRXbTDl1pTHKZQf+eUawc0xBp4h/PzfRcJ1
	XzPAHwViGBziMN93yNT5vGBSsBqrHsoDVsVlf2/iANvVCIqvBWEu
X-Gm-Gg: ASbGncsHnygAerBoPQ1+pO+heD1ynYJ70Ps2Ug1SjAunCRMffzm0XmbB0BHJdsZr49h
	IfiDLL932PU9E5H5IMjmmKQ/uxiImpn4TY/v09omtGUjeqPo4i2KU7hAr6Rn8KJjbNewZbKJFty
	+XOoWtV9q+sO+tSVjnqm4HsOr1dW3ivzKYgy63ALeY8S9VbGe/9QeWb2rMgvY+qXBdFVRrhDpQ6
	btscZGBOmnIlg9TyenxXbCOrjTjze+oq99QmOz7EQN3ToF9ZIMS/4TxXfH9aJa8ZGpLri2yDRU7
	/g9rZWWOJezw0mS8IDPhlRtJyXmW7Yc9+EDsPiaMIOvXVQGDNmYFX+7Ay2XKs3sXk/QKvmw=
X-Google-Smtp-Source: AGHT+IGvBTDG64dD1aEu97XOwefwRvLxgmE2MZM8c2Q0z/ib3acvry/82BosJjBqsHs0ikDVPGaxLw==
X-Received: by 2002:a05:6a00:130e:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-739c7843529mr6441217b3a.5.1743663828066;
        Thu, 03 Apr 2025 00:03:48 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b3009sm717700b3a.123.2025.04.03.00.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 00:03:47 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	sugaya.taichi@socionext.com,
	orito.takao@socionext.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: Fix null-ptr-deref in mlb_usio_probe()
Date: Thu,  3 Apr 2025 15:03:39 +0800
Message-Id: <20250403070339.64990-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025040301-unmanned-lapdog-5446@gregkh>
References: <2025040301-unmanned-lapdog-5446@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, mlb_usio_probe() does
not check for this case, which results in a NULL pointer dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Cc: stable@vger.kernel.org
Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add cc: stable line.

 drivers/tty/serial/milbeaut_usio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 059bea18dbab..4e47dca2c4ed 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -523,7 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	}
 	port->membase = devm_ioremap(&pdev->dev, res->start,
 				resource_size(res));
-
+	if (!port->membase) {
+		ret = -ENOMEM;
+		goto failed;
+	}
 	ret = platform_get_irq_byname(pdev, "rx");
 	mlb_usio_irq[index][RX] = ret;
 
-- 
2.34.1


