Return-Path: <stable+bounces-132326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA1A86EEC
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BA08C042D
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90492230999;
	Sat, 12 Apr 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvhsn3BK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E422AE59;
	Sat, 12 Apr 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483136; cv=none; b=juUCChTKX8Kb5wmv0z41zJOd32e5RRzKR19Iskp4V1Z8vnF16YAvVH87Tc6Az80VaUDwaYx0D+sMzeRL+bppBKqdQ8mH0p8ffyuTmlBYUDXa8u4cNn9Au2Xwdjs28c0WLVn8LrtBjB64JE2pm1uJ0O/PoapTvKFLido4K0WVXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483136; c=relaxed/simple;
	bh=p33eXj35w3OqPN5REOigU1xwZ+LWQdjRStna6ySff7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZESyQM5RiamfVgj4CTFsY5F41PWJTOAMsosd3j+hz9g/YkeWce4dzw/10S7pTao7UN3gbJw0m/paNru6ryv1plWRiJNlFCL8yCE7L7DK+G+pXdxJEV7k11Ia81+Dav/FWNOVJPiXytAZ7WUNPJF6hdwJHCUOTQW5oPZFqRI8Yss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvhsn3BK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso23005635e9.2;
        Sat, 12 Apr 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483133; x=1745087933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuavb+wGeDAlFow8byd6Kbt5rrT1hwsnu7KsTIYCUj8=;
        b=Jvhsn3BKcNnGg86cf3EiVHlwantllw53Ee8q9Pqb+bdx3kSmevr5p3xWBnpYJcsLaT
         9/qF+0pfarwQfVY2VoJma6n+iO+roRNw6dRvpomlR7fql9D3+CRcQJpIYJVtRmCpDZ1w
         9jAy6Pix9NvdQROcTDKFQo9rPZjwVG4a0vxadbxMUDwDNm87XXMD5CeodZjRPEJbhxMQ
         zx/75BePmBVJnc1DxjdISdeaAMM0unPAuwQWC6AENOx2lagaEEYg53eEUli7wdZzNecr
         sredGs/oDY8gf0mXgfOktfKywhjnTyBoh6dU1G6auKCI7FhZEhCgNfj3s1H6gkPMlY5D
         raVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483133; x=1745087933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wuavb+wGeDAlFow8byd6Kbt5rrT1hwsnu7KsTIYCUj8=;
        b=S+CEggTZlpBcKhJ9UootcGE3O8FxG2Vz6khZCVST0Hy7kN5ElW1uxNHULoBqYNUpqw
         OYclIlWHIN+aTqb2ZAtKERx+pgqrFRVpbm5dVSTdBG9TGgyRXtkgBglYqbuINvZ1t5Gc
         3kIxWBBiipVCJSkh9NRxv3tRX5B6OGVvrVe2tiVQakbc6tks+fZiBh2bdvqsxV8+EEDW
         6B9W0T4KzQ7/Y3T7XrUn9LUZhNTI4nnvo1DWirYQ0xhbOCi+gke0qVEWddozXb8ajpYS
         eggk8XnVvJmRyKznJ2sXzv3cnxC4t/Nl0KOFmkgcpRULM0nDowPJCMBum+eykNPiYcVG
         uYfA==
X-Forwarded-Encrypted: i=1; AJvYcCVkS0PjY5dX6djq9U0G8c6Phc5ylkDy0ns0qjktz6TSrTyB7DQiW0dcxaABKBKMsEghnZ66YI4p@vger.kernel.org, AJvYcCWuFJ0zs+P9RZ0YXgEnm6yW1WT6LrYV+eT/tMJ2wzatRuj/J4+achV9KRIScprVn0wx6sgZAUTQ@vger.kernel.org, AJvYcCX1SlvQiq5DV1HH3WKMEQzqUd0oN0e5rhOVs/WUUT5StygHKOkDFdAM167kZOH+rwisbfgqBUBj8S7i@vger.kernel.org, AJvYcCXV48bfnCEk6CDJol/XwJvAoXQZtVV4ZrpE3oF6C6upn+wlDNm0hj49z5hD25JmryToIBhS0h09qDThUtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vapzgcIeRnDc/+WlvjRbbhR+8SGAKBlw0Szben4Tfa2wb5pu
	x8X0Nyn9/6LrWLvlu/EayDNO9pV2azZMIq8cw11B8I9dyKAikG+h
X-Gm-Gg: ASbGncvwIY1SiCXWOfwCu27RQ4Ht/BRaYyqF5gig8HJNPWsDPsw6anyegtLHQvUeRA9
	0jfDr1w0Tj2lL5EjpCYlgd2GAUvLE5MxB0D6UarZJRLpIZcQ6MwRyRIFc97M0/35ZacBN51IuS/
	pzZ2HATYk4IA71Jdh4+ZJ16C0xbh0fS1w5vaHPsbkX3lLpLMsNvB6cBo+PyKqmsHXwBXkwzVN7c
	PrKennGJM/vvmYsHYx2Ub7ieEzBhph5qjIXU9uL8vbX6V+7ilzlA1I2cCi31JbWPPpYuP8yA+nf
	XMFW1d/HZGH5Ao3gjWtIQ3B0AC3YrmbcDiQbfO/tpU47l2AWnIdBDssr25JYzEmoOA==
X-Google-Smtp-Source: AGHT+IHyKoiHQ3xiUNTu3aWxUuAKb6FNb2OtIDwxap3KWvdKSy23MCSs0vOxYXNK6dEdmWtotysHww==
X-Received: by 2002:a05:6000:1883:b0:391:2eb9:bdc5 with SMTP id ffacd0b85a97d-39ea521772emr5505267f8f.23.1744483132825;
        Sat, 12 Apr 2025 11:38:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:52 -0700 (PDT)
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
Subject: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on non-zero PHY ID
Date: Sat, 12 Apr 2025 19:38:29 +0100
Message-Id: <20250412183829.41342-6-qasdev00@gmail.com>
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

During ch9200_mdio_read if the phy_id is not 0 -ENODEV is returned.

In certain cases such as in mii_nway_restart returning a negative such
as -ENODEV triggers the "bmcr & BMCR_ANENABLE" check, we should avoid 
this on error and just end the function.

To address this just return 0.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com> 
---
 drivers/net/usb/ch9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 187bbfc991f5..281800bb2ff2 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 		   __func__, phy_id, loc);
 
 	if (phy_id != 0)
-		return -ENODEV;
+		return 0;
 
 	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
 			   CONTROL_TIMEOUT_MS);
-- 
2.39.5


