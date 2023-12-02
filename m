Return-Path: <stable+bounces-3686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA12801999
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 02:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E30E281E29
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1815A6;
	Sat,  2 Dec 2023 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml2QjxRU"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BF116
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 17:42:18 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3b8412723c4so813694b6e.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701481336; x=1702086136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBTvMeskTEpkIFEbp7wSmUUr64n6oXZw6+AiiZsxmgA=;
        b=Ml2QjxRUwEw8RDBt3g/j+XeiHFcfctUlLscSL2prlVurLE7FtULqK53yZxibZIuz5K
         wulRyw/eWp0Xij+rMz1vFXkmZe9J7aq/+dIrx9SDguSpPNq3hDCS3Uy75Dx5f4pWIM/3
         LQxOUSy4npWdUyCCK2aaGQaojViJMtqOVPRYgtMpm2gaXd+4y6mWOtWd00vvQadbUxoo
         lTpyVj2e6qalbzpWPtTQtQKybYpjC4oDbl/1VkP/vvHga8Su0VatL77E+xEky6SDAXaR
         Vmc+SnPCMMk8zNObOxsrH3fRvYrHNz10aA0sMK+IH9eqit+nGWOTNxHewGpsSpaAyZqC
         2IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701481336; x=1702086136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBTvMeskTEpkIFEbp7wSmUUr64n6oXZw6+AiiZsxmgA=;
        b=JF0s8YyIm4d7DCAs/T0EIsh+toMRnn6Udxgb5sVMwV6+AOqM+h6lGu+ZIzMdm2M8p/
         IS1NWCiPSCdfll0Mb8ZlEHAVU+CypiUihzINdQr9t3Tw/oGPZ+5nAQsLo7RiPf62iXMe
         4tKIeD3yqzaZQBZe3dY9Sq+w6jSWlbJc7ZbYssPXCnsy1Gu3Z7L/6zMu2RmKCr5HkYAL
         4r6/750YCT7xm7H2VbHGdauGqdNeyUaj5xp36mvXyg+0AIQlo8SfwiSh83HFyuL3lHQt
         HffXA1z8Ymhbunf4NccrWXKjGrvJK0tRF3XbZqBtFj+yGsjfdbMh3jwbF9396wHnuE8c
         WdtA==
X-Gm-Message-State: AOJu0Yw9M53V8045gGaSZWoC+d4RcIBJmR5vMxPV8Qj4d0xdZ1QTJ+Zu
	wRAXe4YpvtyqMK7z5toq5DE2/I8mFCgbSQ==
X-Google-Smtp-Source: AGHT+IEAqxx3bBImt+/CyyTUvjH8VKrY1xw/FYRgytsnBWiLQXhvcEJvZ1ptLkm3dao/lswG5yLXkQ==
X-Received: by 2002:a05:6808:228a:b0:3b8:b063:8266 with SMTP id bo10-20020a056808228a00b003b8b0638266mr504512oib.104.1701481336266;
        Fri, 01 Dec 2023 17:42:16 -0800 (PST)
Received: from google.com ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id bm10-20020a056a00320a00b006c4d128b71esm3703920pfb.98.2023.12.01.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 17:42:15 -0800 (PST)
From: Maxwell Nguyen <hphyperxdev@gmail.com>
To: stable@vger.kernel.org
Cc: Maxwell Nguyen <hphyperxdev@gmail.com>,
	Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>,
	Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH V2 1/2] Add HyperX Clutch Gladiate support for v4.19 to v5.15
Date: Fri,  1 Dec 2023 17:38:44 -0800
Message-Id: <20231202013843.64125-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add HyperX controller support to xpad_device and xpad_table

Add to LTS versions 4.19, 5.4, 5.10, 5.15

commit e28a0974d749e5105d77233c0a84d35c37da047e upstream
Separate patch to account for added functions in later LTS version that are not present.

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4c914f75a902..0aad4f417f0d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -118,6 +118,7 @@ static const struct xpad_device {
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -420,6 +421,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
-- 
2.39.3


