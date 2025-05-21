Return-Path: <stable+bounces-145830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40327ABF42C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8544E7E25
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB826A0F4;
	Wed, 21 May 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaH+pyo1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF4269813;
	Wed, 21 May 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829852; cv=none; b=bnmBgcZxZI9yxb6Me/Eynn+w29VxZnqqs0YgY9ORo5Ao1CQj/ZAfTsvDBXikQYCb5D3X+gk0B7mNQnYXAoWifR9+eLMu4JSfudHsoazC4GMScAZu4ZPE0eHfCfYOqQqPyKGrdboSCvGjtj1NVbC7huAd02mHM2wkTpCw0R6ZrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829852; c=relaxed/simple;
	bh=Fb9BRWO1ogcE647To3q6WgSr60w6091YC7O9FyRF6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY2EhqB6wIt5YHRBHfvTEgwN8oaW0IAsqpQWI/GU/D1+iz0pm1IJexXtsMhufxUyyW2xwhPoarq6NO5gn/OQk+xp+wooYGeZBESkrhbPm2OpK00wkK4pfPzMFgVoHYmx9qHy2tbWQRT5dsOKAPOtOstIwzpjCyr1LzA2rBX1Pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaH+pyo1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ea95f738so56259515e9.3;
        Wed, 21 May 2025 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747829846; x=1748434646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Ov1y6vudYSmo/RcJZAA1bs9J9A2lRPHxSejXpSw2Y=;
        b=LaH+pyo1+VARtOsUGBtnBFs6t5c1dSnwTFrqabq6Bj76Zxm0j2IZm5FBJFwpIiJRtQ
         uPEKxjFiMDnefWr1XO2qZXryzQzH8IaVtDX7lv/fZwlhgnCCj00poT1UWJU05YvRqAJu
         012IH1qtAe92e4xQeVBmssXi+ZsTnjzwdH619KounmpMVVCdneTnIA8Hhaq8w0LXXNJ8
         KvtwlDVjWz41HLunmIFDPg2UAq/AFivEVbZMg4VCq5Qa16nlhWF13K3rnubYInKSR8tM
         57D4R2ic9TXlCynjTxGDK9kMGzYrZPVXap9MX4jL4b+bOM2ObKrEZQc8XocrDJQ0Ue4p
         jbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829846; x=1748434646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94Ov1y6vudYSmo/RcJZAA1bs9J9A2lRPHxSejXpSw2Y=;
        b=Z9L+oq3ch68LDc+mJIhysgg0gfYSYTwGN5gCBJ9q/t9gcXIgzAaHWUY8QXq/foGp2W
         2ZAKWmYMPiuCAcpH6H72gzN02VfqqtcxlOWdTb/yJdHjRhKY2Gr8K0AW/cFem0KGjs8g
         SYVZDF97Pem49CieY8pAyR3DrfNbacBY0ipKvx3WS1lIKXtpfjMcsuAj/qWVuQp0tqzl
         31i9SQoow6pA5yrEiQyC81bGjwUj7W8O9zs1AGnuobzKK6RscYk8L5M8kLDA6cPTLlez
         7SfiKdCT/e60n3FodNDJLcyPeUCvkpktE6DjRbFg9gLhGCquu+Af4/GtHcnW5WIBp+9a
         FDdw==
X-Forwarded-Encrypted: i=1; AJvYcCXPTP9TkmWYDIcqmFnQULt3+7J1PDQSRhEq7rIhtvn8tH4nAAZFk6/P+q2DgItwhyGiIaVCUycc3Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQ7+ics01MRL+PKiak68LRCgj9ImULujqC7ZN1AntxMYdWmo0
	DOhHizrVpAqEsfAd5eRT842yKeVhUXqipbK2sIb7Sc9/n37WxrwlUVK1
X-Gm-Gg: ASbGnctXRrKqBOSwwqn6Obw2IeYoIV1BtXUvQkFhuzekM30/noC3QbTYp3Jjr/snAo2
	2phyLigfveSdBBZ58OCT/nNOsv5kMOsB6r1X7qJecsKiBHWFo2AFsvSQNtwT6ZIaL797/SXnScH
	PKpaatPcnVYvKS7bchEYxZpzGUfRnDfAehP5ehQauOk1AOrdP36dG44bLIJ9veGaxuQZSKczaWg
	YHwWZ+oKQ7s2XSWxK+nrIZod8I4tu3W0G7L3UIagh2cV/B/5Mk+oZSmiK1ImW1K0u9nUCiPOugL
	658KqEk3oERcv/ubqi3JuxkaykKZf7HuEAAykFrId/bDNwDLbQN/YzM7mY47KOGhZs95r8LAB/G
	N3kZB+D/DUmA=
X-Google-Smtp-Source: AGHT+IHAcB1HgpHxoAMZuCpgwFNk499Y7O9muQyJdcKNacIh8Sbex7s/w1tWsc2n+LrN352qy8GdCQ==
X-Received: by 2002:a05:600c:6285:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-442fd63c726mr240296945e9.15.1747829846137;
        Wed, 21 May 2025 05:17:26 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm66327845e9.11.2025.05.21.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:25 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	guido.kiener@rohde-schwarz.com,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/2] usb: usbtmc: Fix timeout value in get_stb
Date: Wed, 21 May 2025 14:16:56 +0200
Message-ID: <20250521121656.18174-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521121656.18174-1-dpenkler@gmail.com>
References: <20250521121656.18174-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout requires a timeout argument
in units of jiffies. It was being called in usbtmc_get_stb
with the usb timeout value which is in units of milliseconds.

Pass the timeout argument converted to jiffies.

Fixes: 048c6d88a021 ("usb: usbtmc: Add ioctls to set/get usb timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/usb/class/usbtmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 08511442a27f..75de29725a45 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -483,6 +483,7 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	u8 tag;
 	int rv;
 	long wait_rv;
+	unsigned long expire;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -512,10 +513,11 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	}
 
 	if (data->iin_ep_present) {
+		expire = msecs_to_jiffies(file_data->timeout);
 		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
-			file_data->timeout);
+			expire);
 		if (wait_rv < 0) {
 			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
 			rv = wait_rv;
-- 
2.49.0


