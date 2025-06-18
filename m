Return-Path: <stable+bounces-154639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C3ADE4A5
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 09:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148443A7871
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B927E1AC;
	Wed, 18 Jun 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTAl8TCO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6085186294
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232220; cv=none; b=CDiRS/dulZjt7IVj0VoUiNxSGkOVwCxRvPQMsuex9+/x/BHznyhdH/ZjntiXsrfs1XHJEcMmgl/9fZKNOSt2sbCv/XuT6UF0eQ+QOzm/YV3szL5JcBUPt+iouAmzsi7xIWqhL5KqxEMqIawVZ0lnhzLiR2vItA6biBEFYE5SyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232220; c=relaxed/simple;
	bh=WkRs/TboFDX8xfzfGINehv8lcvkeaBoDHGvUNBlrxXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfF8KU2wUe89K38e9kXP+TDuS3iJmBr3Fogxtms1guAeZPomso+oSb44PSHj32+p4fwgGgKKFd2ZK1pcCbiGKB7vA7X0onS7Ixul6iXo+1iu+x+FLwZPOMLWqrJFRzGyF72Wa4FJFJvzqVsgfA4YBw2mgBHy7lwvRGV6CfJAWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTAl8TCO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45306976410so1973325e9.3
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750232217; x=1750837017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZXBxt0cc6L0naAoZJZAGNT6TJUcn+mtDHZVLEqs+No=;
        b=LTAl8TCOxh1uOwiGrB8LrimzoI0hpWdZKIcoOk/sdaTPZ0m/KK4oTpy9EpyCWySKaO
         rVguNPBlRlEtticcaia4kU44Szw1+PNwbceUGu41zmDdX92XKLgqneouNgIZuk/9W4zw
         NTMM57h7Sxi7GLnoAhaEKEzoFykIglwEYCWzxDa/z6R6PuoDHd2WUOLW2i0WZEPwI9cY
         wst0pI0mBX52ouJd0klX+SEJbZQ7WouC+oq4sp1HKqP+VBmKNkyQgDhIxT9NxiGTsAeA
         bUVoxDpNRUSALO5U0AWUUIJ+oYFwjhsUsUY2pJoZJja+sW1b52vCUvEEUl6vXT9ue0xe
         IkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750232217; x=1750837017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZXBxt0cc6L0naAoZJZAGNT6TJUcn+mtDHZVLEqs+No=;
        b=muB13z+6s2xXN278Tjq1+SG90fMGW4kJ4X7Yxoi2FMp8LbnXI6G4EeSOpUmvBI7TF1
         VXmenIzuPFDFUVDfl8kIrPLzQ34mSyktt5epGkDSAdXDEBbd270jKNJ9JvlM1pBjXNJP
         o8AaXyblwcniGd4UcOOYhdiSJiLUs51NtYfLBga73xvx2v4RnU7SA9/ZID0i0PH3eqmU
         zolDBlNMj9PjbEybd1RqIp0BzYuLFsO16RF1TR+Ltlk6VXNK0YVhsFnhwKF3IzroJ5C8
         eMzV6Z05tzdEAXn4rVyZMaCmPguBUC5d94AiNW3eyqJKgcymjgH+MBU6BjkP4AOqhIao
         z2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWUXEBocpCc4xltsbxrf7QpF/Zby+sR9fShewAGoAtNlNml12Kjk5KGtv0kRrZyH8eXHNrpoGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpbtAu7amqDyRxlyAaI90b/tdiU2/g/Y1o7tG7LM0PxpSgHXj
	3EaZvjUlUdZihfyLgyD6uXOyh2xSuupurlrl+EqhgO+N9kYJyTVDdE6nx+i87vclwVY=
X-Gm-Gg: ASbGncvwarW12MGoOTk3ukg5yKKdVgCHZosALutth+S3C9Pe/zNT7BnAbGfPnPdhkOs
	cV0bKkIpYDajKX4HBVgK8XqtDAVPsL+RMbaxypCv8pMlfvHL75NgjB7Ary/Bowv2D2hiNC8d9xx
	H2aw+SSt0Btvedd62iPP/X6UhBJC2NayC5cCWFxnUSNdK9G8DsdVY5HSJCfnIy7i38nkhYTWtZ8
	fqPZXQNZkP6RSNJGx69CfmGfMCCeYEVbKu1EGcecqXr3g3zAN8bgOC5tskqNhnteL68+gbOjdND
	xKn7l60WmmlzYN7qWALotU/X15V6iTs7OCT3ZzQXhmGZzyRhqoeMlKBgPF0yHRm1x95iV/sbapn
	6owT7OIR+
X-Google-Smtp-Source: AGHT+IGzdx4bFzKCr1o8dRWdVSdkAmLcmC90spjSihYQwSyc0weZmyPLolTCTmYgiIecY8zC3ErPWA==
X-Received: by 2002:a05:600c:1d0d:b0:43b:ca39:a9b8 with SMTP id 5b1f17b1804b1-4533ca48dffmr58906925e9.2.1750232216922;
        Wed, 18 Jun 2025 00:36:56 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8f2e0sm195792835e9.8.2025.06.18.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:36:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vincent Cuissard <cuissard@marvell.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] NFC: nci: uart: Set tty->disc_data only in success path
Date: Wed, 18 Jun 2025 09:36:50 +0200
Message-ID: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=WkRs/TboFDX8xfzfGINehv8lcvkeaBoDHGvUNBlrxXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoUmyR9Sy/6+NxZF35Vz8mGEq+q31qkerrdCl1S
 kIPLmllOdKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFJskQAKCRDBN2bmhouD
 13omD/4zhyiDc3yVsBfIujWpgDnnQ/l3ePHvdbts5xY9N05fFjRhLNIv9Z/PMQfCL5sWiYJxZZo
 9X1IAcKsu7TItxoN+Kx8Ah6IruEbidB02Nyt/C9TxaWVzETWDWvDCUQzwpM1H1lVNmQPojXIwgU
 wZaoSbr66Qlgyygzsh8npVA48SkBzSucYhEpPfGVP2+5MIMEJthHwGaoUyss0tfJAGD0XA6VMl7
 Ad8vdIwkI0ZCY3kkpnHxYMsWSYFzJAZmRRvrJC4B2+rQHdctXwwfSvjBrlTWMV9r6tt5c3EBk/P
 xnmPGhzHSXp11rasBPlmwmubeC4879dQdbewqlIVj5ymyfSVLqOdvzoXrqBwoXajhxUDS78SN/y
 iEs/8phFmc98F5kLrJ2cB9zI5hoSD/VmM50fHfgjuVpSjF+fQqnRl4D+wuj6rgvmpmL5otgI50O
 eUC1qmE30Almsx/ey2bbBlVsHeSvC41jwzdMK+Y93qjIoZdqaqVc4AztnwPFk3pCw3f/dnpCn8Y
 YYleGNGUgPIcPC5sKa/McvfOHO7VHEHTXkOfuTdqk5d+pqc6XesjhE3YKNTYLyO0rWb70akwz4c
 l9Ey/IYMak4UQ0W6IgEV1JIL/PHA6xqIs2jbjimYqngW79+VBvS77zkrz4B4ZtSNvuzp2a59Ej7 bsaAbyuHHDH8vfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Setting tty->disc_data before opening the NCI device means we need to
clean it up on error paths.  This also opens some short window if device
starts sending data, even before NCIUARTSETDRIVER IOCTL succeeded
(broken hardware?).  Close the window by exposing tty->disc_data only on
the success path, when opening of the NCI device and try_module_get()
succeeds.

The code differs in error path in one aspect: tty->disc_data won't be
ever assigned thus NULL-ified.  This however should not be relevant
difference, because of "tty->disc_data=NULL" in nci_uart_tty_open().

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/nci/uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index ed1508a9e093..aab107727f18 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -119,22 +119,22 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
 
 	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
-	tty->disc_data = nu;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
 	if (ret) {
-		tty->disc_data = NULL;
 		kfree(nu);
+		return ret;
 	} else if (!try_module_get(nu->owner)) {
 		nu->ops.close(nu);
-		tty->disc_data = NULL;
 		kfree(nu);
 		return -ENOENT;
 	}
-	return ret;
+	tty->disc_data = nu;
+
+	return 0;
 }
 
 /* ------ LDISC part ------ */
-- 
2.45.2


