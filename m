Return-Path: <stable+bounces-28287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18F87D66E
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 23:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C2B1F23596
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAE46544;
	Fri, 15 Mar 2024 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNjcnp08"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AD4AEF9
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540153; cv=none; b=kwxai/51EptdV/0I4AWeuXu/E5tbUXmwk/GhkIaXvoDW2PCUuhOionvjeTx0G/Il+kUVqy1dwU8Sahr2QHsz/9XZX6YavFp4N2CvBCmwS1YFITPyydjUHqMBb3WK7ktsrkCjx7zOR/YT42k3DjsvqMk1+NdWjVv8rwzJAb98Fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540153; c=relaxed/simple;
	bh=1lTOagpQjIfn9EhcA+MLLAKI8R+RMHPUKKVHFPeQzbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kujms5CPkfJeTeSsw30kTx/eRouWHtI1LhMCFJowZJPKXdKQ7UYWzFnurb/q4mJgowOZeeA04QpjEjUJoKCTTi+SeQ2kOASf7vvaLjkAKKOotBfXnujPEPFgFDUFnsh/9LoMiUPFJ5Ir8jyug36Bo7bpLv4H29clr7qb/CvOdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNjcnp08; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1dc49b00bdbso19678105ad.3
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710540150; x=1711144950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dp7qcZX43C3/mgMfwjWAkYtrVuo6TxhZrtILJmAfG2U=;
        b=hNjcnp089GpHoa0OaUq1fejhqhyyWRbRi/AI3lqSxtYHkYQbzePx+TSKm9VYbNKkf/
         MKuIZgwIrQ8oMQXHPgYo1BHKeg5U+GX2fELSrt7gUlHtEJVJEkLB14E95PBuO3KBiL5J
         Gf06r8tjHWAepztcJhFmaakSoV34ma+3WpP9I4EDkq7zdS944MlQdQp7jY7feyr+ENpJ
         L5w9XhA29q+qtaN7dhkgRuZtsOErOBz3Wrpi5MS8XNAd1muPVtAjCYNPVn1PCDfBbGwo
         7ML5gnZThG6D6W28DwJdWTEDbhz+z4695pO0Zk22CKtQfu5dBRdtOD8q6vee5UU+npIT
         jgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710540150; x=1711144950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp7qcZX43C3/mgMfwjWAkYtrVuo6TxhZrtILJmAfG2U=;
        b=so7rSe7RTukspGDuxH3lXMqC0eYQXdg/sg+Txf+0AmCbXgKIbRktAyVHLPaU4vLy/Z
         4ZTIl2yAjoYdIhn+mowAgXvG+mok2l3UWAJo49h2Q9c9DjINXjHE62xmnx/0HNvDqFFP
         S9rSuyTqio2Tuuu2zmzbO+JaoRzTPaTEmJ6U1J5FjmwtyyYKupmDNhu5kWBLfD7Gn34y
         zM39iw3HoaFM7O9rAOSsEh5MgxoDWeI3KAXaJt235dY+VkQZFuUSuC5pxLDQrI2MpEKE
         gxBeMlXist0lTjScovnrziPxxvefAR8Jv8moTd1P8frPPYrvcKGYyjHx418134XBxilc
         x+/Q==
X-Gm-Message-State: AOJu0Yyt30ZVwMuVe7G6+qNDGR3Z6efymIZNbmKN31ULTrrabvCbavnG
	eg4O3+UhYoCvBkqKUHq1DTLUI5si8l7Uynzym+5l+J5KhW/4AgNELEUAlbHhXHY=
X-Google-Smtp-Source: AGHT+IEx/JXIc1btZx8SRHoJu2VJdhHnYeaQpfcRz1dMLzhTi0kej2AJMZly5NfHqTx6JHNDJNixmw==
X-Received: by 2002:a17:903:181:b0:1dd:afc9:a34f with SMTP id z1-20020a170903018100b001ddafc9a34fmr5122843plg.50.1710540150501;
        Fri, 15 Mar 2024 15:02:30 -0700 (PDT)
Received: from google.com ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b001dd2bacf30asm4405144plk.162.2024.03.15.15.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:02:30 -0700 (PDT)
From: Max Nguyen <hphyperxdev@gmail.com>
To: stable@vger.kernel.org
Cc: Max Nguyen <hphyperxdev@gmail.com>,
	Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>,
	Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH 1/2] Add additional HyperX IDs to xpad.c on LTS v4.19 to v6.1
Date: Fri, 15 Mar 2024 14:59:19 -0700
Message-Id: <20240315215918.38652-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional HyperX Ids to xpad_device and xpad_table

Add to LTS versions 4.19, 5.4, 5.10, 5.15, 6.1

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
---
 drivers/input/joystick/xpad.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index dffdd25b6fc9..842733305fa8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -128,12 +128,17 @@ static const struct xpad_device {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x038D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wired */
+	{ 0x03f0, 0x048D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wireless */
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x07A0, "HyperX Clutch Gladiate RGB", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },		/* v2 */
+	{ 0x03f0, 0x09B4, "HyperX Clutch Tanto", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
-	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -446,8 +451,9 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
+	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
-	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
-- 
2.39.3


