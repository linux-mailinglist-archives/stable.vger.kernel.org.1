Return-Path: <stable+bounces-203158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04ECD3CF5
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A7883007E43
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79625A2BB;
	Sun, 21 Dec 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrDeP1Nh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C624E4A8
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305461; cv=none; b=LSAXewglxsKh2g0FUJVOjPdis5rrlUqwmwPwS5XeizNuv8zMbeEWZMAc8mvnQ01fa3WGH/SMPG6T+029FH/qJXa8rNv3pyiH0xqWLadtCGuGt7KQR/4IgsuaZqjr+Kb5LVAfTkkFA2LIqnSiAXXq5/wbXCSEcE7xVgup9nfnmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305461; c=relaxed/simple;
	bh=aRLaB3KuMxXhmDs9PQpW42dlh/BhCSSc1295RbPjwPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ur16deaQT34tfOPCgH21UUvbrPtb3XvoJiKYSk3iMUMJz4Qhf5sUUyPpS7tq0gkFvFlwmedrpLh8hfNA3c8GJ+L6RLdVdQdwkWkkueOTpCQcxYj+mtwTqVUmIUvIpCf3sZY/bcLOVz8cbVqlvgn5Vr5ucYZLWIokBOW5lp0rpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrDeP1Nh; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f2676bb21so39433385ad.0
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766305459; x=1766910259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppyiSi+wYHHJO04DxY+5AJW+uBJ8Dan1LsY9lw9svb4=;
        b=DrDeP1NhRqJGuaCK06LHNaiHhDPSGTFkOWT/vFMNJuMMRCV+TSN7MvzmF0pnCo1bhF
         JIg9bgTEcQJpHJaK7yb4ise3rZHN9BKmqM2J2wo/uTMO8/lkSkdFaVwHjP5CjDFAGtg6
         k9FJ9mbG1SDJGJv+Ul+8gOGYvoX92oKXOJbh0WXcXMhzoRnvpD542ElUd191RtsgO8dO
         9LfiFrRIIDMO8iEvAorIE+91PAn3xl8uMvVhw/9l/08LEnHFIGiuCivPVgsXDvRJWcXA
         K8iPlJNxANa4oUGk+y/1wJlO5rwJwPO3Y4hhuVAuNIIPYC16038Jdq17C1LK4t8nOyY7
         cERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766305459; x=1766910259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppyiSi+wYHHJO04DxY+5AJW+uBJ8Dan1LsY9lw9svb4=;
        b=ffdcT2RGlbUJLj0oCUFIJ06ul7gCSNFbRGWRsmfVFIZoGNeYYY3sQfJ0JYtGq7nAoD
         ePaY1N2i263Qp8EibHByHovvsq+LEGm0KDPQVOspkuNqN3C47F2G+ksN7BOc1mM27sdZ
         1gnhbPNeRE2cuu8tCQNp3Xph4H5nQGX/2W8treG0ckPMOFAu91u2n0lfm+cLCzuDqhK+
         UAbC3sD74asFv2huq/ow1CaKEQc3Igxb+wf5nN3IJcpmb3XKslUa72lIDXEP0i9ZEwQn
         2ZIlXtCB3B1HuMxoxa9+KA1198uraAW5zVrBCRav0OgcZI2Z5yAtGDxx0AfThqYBPE9s
         +wdw==
X-Gm-Message-State: AOJu0YzM/U2dl7SxebT6MebTT7cOjS51wLhZ7dMbjAnYfHdNJn5LNeFY
	Q6K70oQzDqK61ZlkNL0FlZe5gCFFbUpekvDua3J5J7OBMs7/r7Nqbg+f
X-Gm-Gg: AY/fxX7gpDXElNiTrMXB3ryc+trTPutjfpGmf6nqqSa8MssXBO0g9O11dYT3KbYgBVU
	gjDldh9iGEm/qtJchkGikaFhm69nIRBh2TXmjeIEHZNAKgsqlUwgSiPBfmOAKjE89stuc6n9una
	TZiDQzPC5KebVbzRcQAHnYESpR/UO9pMul8gMpJIDaqN2f+4m0n7tDMMbg42JvAMoN2Tz9bRWmw
	VuQ8mfEjXSX1QN1Sz6fUqBicFzva1+mPWuGVpf5VilKbJ2KsmNjFP9P5RFEA00GZCsHEgnT3Bxc
	S5WEpf9PizAdgFTzvXVTA9a2kGsjO5JbD8oRcQuydHFiUzlrRLw+Wt2afkSt4wIvOcD8EmdjXNl
	CdaKnOvZZoo63Pw619Vz02yAZMQMtxKx9WgTcQFiFx2pOyYD32Uokzz15MfuPkt91spKBl2JyU2
	YkueyVJzTbS4bTiWQjeuY1RMalAZEsBr8kfFvfh1nvT2zqn0g+7EF657UB+KvnjIW6S8i3CFxuB
	VaUrBQtdTahXOvp4DcCdaIqVE6s+Xy7WWKbwFzVvbIVXIVEC/UQY/0zpg62QQvEb4Xzhs7kA+mY
	Gx4C
X-Google-Smtp-Source: AGHT+IHz+nWY6N4A0JUS4wDUAGuKAHpm5umfcPtGIoz1kTOK7eloiKKpcEvU9y28U6EykqpFQ37inA==
X-Received: by 2002:a05:7022:7e8e:b0:11a:c387:1357 with SMTP id a92af1059eb24-121722ac203mr7819522c88.16.1766305459236;
        Sun, 21 Dec 2025 00:24:19 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm30368015c88.14.2025.12.21.00.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:24:18 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2] net: usb: sr9700: fix incorrect command used to write single register
Date: Sun, 21 Dec 2025 00:24:00 -0800
Message-ID: <20251221082400.50688-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the device failing to initialize with "error reading MAC
address" for me, probably because the incorrect write of NCR_RST to
SR_NCR is not actually resetting the device.

Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 091bc2aca7e8..5d97e95a17b0 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8 *value)
 
 static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
 {
-	return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
 				value, reg, NULL, 0);
 }
 
@@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
 
 static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
 {
-	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
 			       value, reg, NULL, 0);
 }
 
-- 
2.43.0


