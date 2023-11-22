Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869727F3CB6
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 05:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjKVEUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 23:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbjKVEUQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 23:20:16 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E3FA4
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 20:20:13 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so2979b3a.1
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 20:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700626812; x=1701231612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7IHJ7mn9YvsgqVWldOpZAr8WwrhVwxq4WUjZXneBFw=;
        b=G+3c9XUPiX6L5U8gzCyCEDVHp/DtYVr9QgYvYWHhax0N5LUnqUzpWNw1uoKskEmcrT
         QBIzl5e5sOXsk6CDj7KNuUkNRTxKzFraPNGmzs15UKfIlPajGmQy/kANOh14y1Ze/ZjW
         E8Pa2OgqT8hQLEVk05NiiAlczvSnyXwqTIyjCwygNJKL2jruP0NWhtYaH6QtbNevwSiD
         YqUpAlR4tnSuHVRhcUifpsEvj7sftNElpXW/neF1oSpckuFfz8ejLp8CNYuc99RxYWd9
         VY6A6SfzKP6YHYqlJJ5lUy1Gmph82dzAA5Fvud9xS8zmDIJUrDYcSSZL8AGqr+7v/vL/
         Rj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700626812; x=1701231612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7IHJ7mn9YvsgqVWldOpZAr8WwrhVwxq4WUjZXneBFw=;
        b=peYv7a40xnCRfYLrPmoYls3J68L95w0sAdboxochD4GieNK0c2aiNrmIvFLcioINRO
         +IcWWu8cHNHEJYtu0RmRQlFPPTVTRM0Ww0sqvhVVIC99dTHRZOqo9J9Ig2fSguxcv6Pa
         T6BdlU2sdsZyWOPJcupuvQtvYPlbnV2wF7xNLuYYjnpd9sOP/a8UI74f7IEI7ec6KB+F
         vK3u70Ow+Bb1b6vzB2om8jLAMWaelUbP3EjGp0vUlJthb/0l8FWa82/fhFRtZOgjhipO
         9Cd1wfo6YSDlbHTs+AEX5vf6+NyrMnisjzusPCfc2quyqmrQz3Jf/ei9XOJ7P8IuZXOL
         VTMQ==
X-Gm-Message-State: AOJu0YzF7y5tnBvZtpJlsZ20Iux0Jy/3trRXX6vZzYw4MzbieBrFVOga
        aFped6P0XevAM7aSz5YP4yGXTfTR4HomgQ==
X-Google-Smtp-Source: AGHT+IGM6yZWp7icTasvtDwKbWTYIrvBcbLkdiwNQ2Pz65D64C7rE9XA6EkoVLhcULF64rkyGFQdXA==
X-Received: by 2002:a05:6a00:3a28:b0:6c3:415a:5c05 with SMTP id fj40-20020a056a003a2800b006c3415a5c05mr1854983pfb.14.1700626811615;
        Tue, 21 Nov 2023 20:20:11 -0800 (PST)
Received: from google.com ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cb98a269f1sm4544375pfl.125.2023.11.21.20.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 20:20:11 -0800 (PST)
From:   Maxwell Nguyen <hphyperxdev@gmail.com>
To:     stable@vger.kernel.org
Cc:     maxwell.nguyen@hp.com, Maxwell Nguyen <hphyperxdev@gmail.com>
Subject: [PATCH] Input: xpad - Add HyperX Clutch Gladiate Support for v4.19 to v5.15
Date:   Tue, 21 Nov 2023 20:12:47 -0800
Message-Id: <20231122041246.8801-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Add HyperX controller support to xpad_device and xpad_table 

Add to LTS versions 4.19, 5.4, 5.10, 5.15.

commit e28a0974d749e5105d77233c0a84d35c37da047e upstream

Separate patch to account for added functions in later LTS version that are not present.
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d4b9db487b16..d773728e9840 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -126,6 +126,7 @@ static const struct xpad_device {
 	u8 xtype;
 } xpad_device[] = {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -414,6 +415,7 @@ static const signed short xpad_abs_triggers[] = {
 static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
-- 
2.39.3

