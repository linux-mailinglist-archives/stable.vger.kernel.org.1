Return-Path: <stable+bounces-3687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C618019A3
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 02:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371E3280C35
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8517C0;
	Sat,  2 Dec 2023 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m076SBOp"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5D10EF
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 17:45:42 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-35d53f61754so3936985ab.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 17:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701481541; x=1702086341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFoJxCf6whhpmJUGlYDfcPfMwMbqeYht8Z2DaE/hxuI=;
        b=m076SBOp4BZ65wEungjMaHNjm5pcmDvhtHTk5fgfLuen6E5JyX4N2PlIzKKMi3izYw
         doeNsn1hP2V+QRqmNl0W8yuQjjWTCKYe3OhJrfx8TGsdj0Ed3g0VGDoUKj+SN7Q5RF9i
         OZTnCJYlV7y+RI6maQjNUCD5P6iHbnkYYET3hfNaudp0vChmSHAcZzBH+EmF7XxEJ1DO
         +RhxMdpH57B5dLHs1csQimNcRzqm2jfUvl3f/xeqOmyZCJKuAd0ml7w0W2bSxEtGRLJq
         KZ7gBACgipbW1RsshOmCayHxLakq8YDz1epcg+vf3GrtW3AHaIDnrf9/goZBOS4K3eEW
         0WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701481541; x=1702086341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFoJxCf6whhpmJUGlYDfcPfMwMbqeYht8Z2DaE/hxuI=;
        b=MLiWWPyKTdrUaBGipu6yWGe7mN74j4+f89Sb+BRUCvaQEyq0EJ6jlUur3e8ISAujnk
         qOq4zux1j9BcdadiBsNlg3bqj2fW99rmSnb3JcooVJqeAb47jSjOmzlBlEgS7SOCRGGm
         PqBpSA6VicQ+H25gcm+i0XB1xR7Vk8xe2eqQyPRFZACbUc757Lbh4KYjunTf0HZfktVt
         sA+LP/qVtk8vlagShuPUvmcZ7ZN7s8Z+mislx0EQ2zUOF7hd6bk8NSFNK6bZ3fWh98J7
         EFkAUl1HiPQAtEN1NSMSJ2ytiQYMhqz4jzv6LuDbd96ln7avwRENHRN2HzhjlrBYNuZg
         CA9Q==
X-Gm-Message-State: AOJu0YyIXvgGus7mHxzTjOE/ZKcK04L8Y4xdH7BSiKWBGMmzCq+oVMT6
	DGBFP3qvX+QgEyj/dHP6Gpk2vOPYf2P9Bg==
X-Google-Smtp-Source: AGHT+IF3sUvwObXkcll0KNe6MvxUEb5KP4tDHsKorCzRqaGll3tspi6+15hEzyPJyivbIzi089/O0w==
X-Received: by 2002:a92:db0f:0:b0:35d:59a2:331f with SMTP id b15-20020a92db0f000000b0035d59a2331fmr460515iln.35.1701481540927;
        Fri, 01 Dec 2023 17:45:40 -0800 (PST)
Received: from google.com ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001d05433d402sm2056384pll.148.2023.12.01.17.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 17:45:40 -0800 (PST)
From: Maxwell Nguyen <hphyperxdev@gmail.com>
To: stable@vger.kernel.org
Cc: Maxwell Nguyen <hphyperxdev@gmail.com>,
	Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>,
	Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH V2 2/2] Add HyperX Clutch Gladiate support for v6.1
Date: Fri,  1 Dec 2023 17:44:25 -0800
Message-Id: <20231202014424.64330-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add HyperX controller support to xpad_device and xpad_table

Add to LTS versions 6.1

commit e28a0974d749e5105d77233c0a84d35c37da047e upstream
Separate patch to account for added functions in later LTS version that are not present.

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2959d80f7fdb..5f2ff6999df4 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -136,6 +136,7 @@ static const struct xpad_device {
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -459,6 +460,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
-- 
2.39.3


