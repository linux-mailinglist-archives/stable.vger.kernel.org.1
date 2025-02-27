Return-Path: <stable+bounces-119832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2AA47C2A
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385473A16A9
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675D22B8D6;
	Thu, 27 Feb 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug0Unz01"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEA22AE7F;
	Thu, 27 Feb 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655610; cv=none; b=FXmuTHQ8Og5Klfz/Ei/CKcxvQZ8MTgZwiTrvo0BNNTot7ZsG2+Aiqc0PFooQjRvdqLumNY56at2mQHzwgos6z7PEl2FOLlrM9ZOmv1JIBLIvBB4U1H+M6x7m6nW2c5LEfthDDXdLfF/NicG3s8dpDxQ+T9SRNFrgOBRogdE6jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655610; c=relaxed/simple;
	bh=9f1LYLjtUld/AXdeeP1yoNxjoDC7B7LiPpoVoZbktfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg5iMvTLPAcfCnHHLWbt5UUuiTY33uWr9O+hoZ52dSpAvUNx0cyaaZje05K+9PhQpyH4HH7zUt8aIGiamYp6YJSniycSeUTLWXKA/dnIwIKVxTn4RsfgOd0YaZn3pkiraaH0LLUgv1EvY3a6oCTOY3b0lmaV6nfr8QTtbqLjsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug0Unz01; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f504f087eso550890f8f.1;
        Thu, 27 Feb 2025 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655607; x=1741260407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgzSOC+sOCHJ8teJeXSltABfhwmnvmqFPoVaHnhTSP0=;
        b=Ug0Unz01bFqp15ZsWtVRc6ZyMw6G9jd/Aj5Iaw1mKMXsICjPiCaDsXpRMVHxvZvGP5
         2KgKbwItBORlKt68X8b0z1t2P2O1v+AhctcsQ2FgpJWUt2s2w6hV2Mef2VuMDcnFPN4O
         xe82oOExw1pn30104GwjtAbRW6SihBQrHmwFIaym2Nj6CyeAwOIiZS1FvDVpqOdEmTSd
         2X52H53AnWD8oT0l0WIq5kWZvrsb3JRYuzdskpIX84gF9tbaF+03F3d3PsaAj01gosJm
         BrpPj4U/5R9LYuq9n6N7osDF2AT4CP47gCKDcEcCSoqjNT0T9fVWIxopFratHJl2PhWj
         jt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655607; x=1741260407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgzSOC+sOCHJ8teJeXSltABfhwmnvmqFPoVaHnhTSP0=;
        b=FQZJDfdabQRf48PNtSAx98SX0gjQI23fSgZVEKcboP9a/R2GQL1OjGQXuNFTX1N/LO
         coRrBYsYLOkPFYw5bgVb0LSAy3GJUolrNJmNAwN5CF2TVo3FjguhPlskjycNplLJTAvP
         Gd5is/eV2DJpAgWi8YbSBXUwSr7tgL+W9zPwoMNkH3v1O3OicbDAYmgzK8/tt3wh8Nms
         Q8ttMANCF9fM3VhtvQvZrGnFd0zFG2/DA6yRAJCKvZ7EHAVjl1Q0x+HsnGD/giPCSt1+
         I/HY21vZTDZgkWUm0CzsmV1va8NqYI3Lkk5eg/iMsIkTRMX1cTtt3AOeNGSVBrUfSXpf
         +LOg==
X-Forwarded-Encrypted: i=1; AJvYcCUmUgXUIvO5RjGlQCkqF+PZgLHvRE+qfLtvvLH1VIJQk8u1f84H9ndb+rJS44FVk3RNKXKzqZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDX9wFSFg5Akp4XrWkpVrfA4CjFzDT1CHuZS2CNHJhCNW6tzd
	pyg0ZXa906j+YmWKtve2T0mkkjHcJgrLsX5tRjQBkvpeg76zj48s
X-Gm-Gg: ASbGncu6ZsdQV3CbUcyBQjQSG5oQ812xZuUbeKFwT7xHvEb7kESp/B7Y1Anh0uS31sZ
	y7Rmgx9WBJ6Gg77vyFl1aqjo2umyoNplUd7SFIaMzUx6XxPX+BEH0YWCwjQReiRbm3cG/7r4FVq
	BLYQ5kNLL9owWmMsH0e8Bbeb5at/Rgzez75+KVsMQMqr+nGTbve8S134r1yKe274L2iu2FQEbgq
	Orcx1hi95sT9RqkcqroDn1iv3iqvO5+UlWxjkagG5yzovuEqj5wkwncaFqhSDQu+8Jb9dbXHUGt
	PiD2utKyIWcIqmd/gmkSi3NqWklT1v+yuII2KT4nyA5V7u8BudShY69XU+5tM2NfZDQT5A3Zdxr
	0Ug5Hk+Yg27z2lfDv8T4=
X-Google-Smtp-Source: AGHT+IHiRtWpGwxsC8E9LOk1wb2YniA1kHMY2QcXCFLAYxAbgmaT3LsvcBxBcYFDO0pnhH3J/e17iw==
X-Received: by 2002:a5d:6d86:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-390d4f42f64mr6393841f8f.25.1740655607025;
        Thu, 27 Feb 2025 03:26:47 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm1757685f8f.50.2025.02.27.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:26:46 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next 3/3] net: usb: cdc_mbim: fix Telit Cinterion FE990A name
Date: Thu, 27 Feb 2025 12:24:41 +0100
Message-ID: <20250227112441.3653819-4-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
References: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FE990 is FE990A so use it in order to avoid
confusion with FE990B.

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/cdc_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 88921c13b629..dbf01210b0e7 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -665,7 +665,7 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
 	},
 
-	/* Telit FE990 */
+	/* Telit FE990A */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x1081, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
 	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
 	},
-- 
2.48.1


