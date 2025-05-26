Return-Path: <stable+bounces-146388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5AAC43D6
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E5C1884C8A
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF91F6667;
	Mon, 26 May 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8k3OiDN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F919E971;
	Mon, 26 May 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284588; cv=none; b=IVkhtid/gar+Bo77QVFStabla/hYnnX+38j9v1Eov9vZDAtFvdS7E6O6kAvekvQLoBrvd652CejLcZWpo8pBRh99pNP2K+RGP5/qC3MPSHFNHdnpQWvTYtxoX/KdpLvXtOy0dsaiIe5B+xPJHBmkfj0q2sg9vxDp6svy/EKEb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284588; c=relaxed/simple;
	bh=q10F3cETSwxHPo+W25Xi3CXG0HKkYq2iJA0XWQp5co4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8cDh2na+/Lh684e3K5BMKngDxzzZk5wPeVMLZ9OTA/yjZGIS8ICcrNnSwfx5kiREjUFvGk+OpegYTVl7voXptmJoLN4tK71zYy8AQdB3YrJj2D7u5yzFOXpwRvigqMHcPfSrCb5auIoPXW/htlnEnkhJZS26iu5dG8VIwfFYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8k3OiDN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acae7e7587dso322553366b.2;
        Mon, 26 May 2025 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748284585; x=1748889385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9muOFUpKTfactT/mG7l0xE7US6PC03AM4GydaczuLhQ=;
        b=F8k3OiDNoA7CCzf9MvOqOuh9ewaEIjvTjyWR5oVk1ZX/n8zeN4OxDYxFj7YF0w7Vaz
         yaRnHTvEksEdNsfzWj7wtmo0V5xz+yT8FWcWzMNl31hFFtprNQoMc6CKNBaML8qDYU1X
         l2gwBLtXaQhLPd3CzkUC7tlS2Rb6ivb/eiFD+lUSEJ4zjRfRpXMuc0Cz5nyU1yCpMhSD
         HxTvPmIBErdSlMeU2NsR/lPC0LAeASdf6NGVYYyYWuJ66uPQmqNTg1TTzGKx/scQosFP
         x2paDBhDK+STtj58Zr5N/wH6a2eC9BJWMwFxk+4FqetzooBlJQtMI6qW/n0cq5U2P5Pr
         4/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284585; x=1748889385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9muOFUpKTfactT/mG7l0xE7US6PC03AM4GydaczuLhQ=;
        b=HlSJCJXrCKFbHWqhfyEym+pXud3kJ7/MuVt6YC2ifjjfAGz0wnsZQ8UEA4caJdnPnN
         sTssmc6D4ZXhyJEEq+Bah33hyDQHI4JuuX3M2tyQe7rh2d8+/4UyNeIH66Bh+gRaInun
         V18ff6z8w+bTdR8tAbEV/77KIS/Dx5xPkKB53em2yytT5ZEvihbmDvJR37u5DLCbNrvc
         8L3tfzSE7Qqa8tRYRBOLp5dz+FkuHVLVv3gT8soI8RnLdA7QUrBYjKHctDnaX00I6Or6
         f8guwujwMVXfbH0bV7QUZPWigTXbHdgJirDtItY/Q8yCRbCrhA34s/m/FbXMTVUNTIJT
         A82Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPFoavBWeS3FgyU5EisGWOq79SW8uW+Up1QEBnUHgWZOE/gG53oBKSh1GfDL6FBg9geE/AC4Gfmv4m4sI=@vger.kernel.org, AJvYcCVKfBZkousOxdv41PwOBn4aAR8/s0/BUJdcUSU+8GCyavEnset0oipncTGTm+4NlYNIhny2Qgez@vger.kernel.org, AJvYcCVzdtJYC+Td0qyIvY7SFzXi1WGpQHoBQDpjhAKIIxGE3ZY4rjuXFflqBrShwyp1ZXPMxnF3Jwq6@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBVY2pUdPJ7Li7fwk9KQr2aHmXOSVEFviGpT7H0gsLwQQmyMx
	70EZiKH13B8Z3h4vrBcbkroSTjnwFPrrNsDkkc4OO/HSep+CIkiINEAj
X-Gm-Gg: ASbGncvcEXJAxlSpuzYWDL0p5zbe9P3ktwBTkCmA7bgee2bzzH78MCAIiXoQgQWqTkM
	RctzjXdg04hbq56mouy5fNHlj1n9kYS0n40KpGx8WPoIA2jJoaqNbLgsQROYk239NZsfMMWZmGM
	fCdqS8vjyQ2jpdyuCRAWnJdqnrMJVxa4L/vpLKG79toDhVXvqTkAJ58Vg0TKf1hqvyKe9mSzqjZ
	6lpX85cTopUl9TPSPgTHs/qlkLoJlocs0SGe1p7LRCa4M/3iAyogQ3IgrcQ2O1ju4U7RvqeZ/+V
	B8SXz1zxUsDBiCm8GgcR4+lKFctk9ZvpvqLmzx9JOeI6I53yBtOB
X-Google-Smtp-Source: AGHT+IEOKVdrt+VcdboFlylKhffAnkFRPdnnoYVuUBHMRj1bIdOtygbWy7OQqXFYlZN0q4NyUQf+Mw==
X-Received: by 2002:a17:907:7e93:b0:ad5:520a:8e02 with SMTP id a640c23a62f3a-ad85b1de69bmr818638466b.39.1748284585097;
        Mon, 26 May 2025 11:36:25 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:8814:6671:65ae:f9dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad889738174sm25419066b.140.2025.05.26.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 11:36:24 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: ch9200: fix uninitialised access during mii_nway_restart
Date: Mon, 26 May 2025 19:36:07 +0100
Message-Id: <20250526183607.66527-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mii_nway_restart() the code attempts to call
mii->mdio_read which is ch9200_mdio_read(). ch9200_mdio_read()
utilises a local buffer called "buff", which is initialised
with control_read(). However "buff" is conditionally
initialised inside control_read():

        if (err == size) {
                memcpy(data, buf, size);
        }

If the condition of "err == size" is not met, then
"buff" remains uninitialised. Once this happens the
uninitialised "buff" is accessed and returned during
ch9200_mdio_read():

        return (buff[0] | buff[1] << 8);

The problem stems from the fact that ch9200_mdio_read()
ignores the return value of control_read(), leading to
uinit-access of "buff".

To fix this we should check the return value of
control_read() and return early on error.

Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index f69d9b902da0..a206ffa76f1b 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	unsigned char buff[2];
+	int ret;
 
 	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
 		   __func__, phy_id, loc);
@@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (phy_id != 0)
 		return -ENODEV;
 
-	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
-		     CONTROL_TIMEOUT_MS);
+	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
+			   CONTROL_TIMEOUT_MS);
+	if (ret < 0)
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }
-- 
2.39.5


