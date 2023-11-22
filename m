Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A667F53CB
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 23:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKVW7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 17:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKVW7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 17:59:17 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CFAA4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 14:59:14 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1cf669b711fso2051115ad.2
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693953; x=1701298753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiooVFepU1Jwhl7kPKHVdWNhk4fReDa/81ZY8czXB6Q=;
        b=nBBiOZMTjqFar8raNPZFqJ+MbCpP3zx/0DWIyDzDprxy5loGQwQ4oOSN1+6isT2mFJ
         gRgT0TALJfE9/FGlabbwFS+6s24WGyF4rtZFMMFPzlNIIkhB4oA5dIUHoxIxcSmH5fq9
         eC2AeJbev9EGPj+Acz+cVlVcuEuKPznAJqNYRM4t1IQJld3ojIdBH6EGuZkqAWH+HnAo
         yuNPrkDGhEYU806zYO5r9eB5sRsmdZlYrmQJ7fb+T2dJIMPCLTJs+Rsug5dmAgeYfGyF
         fgFPjhUlbgDqphIXwcDeQwo2EnSQVTFoG89RFhUhml7w+Esag91jbRen311dqfTm1V6x
         vzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693953; x=1701298753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiooVFepU1Jwhl7kPKHVdWNhk4fReDa/81ZY8czXB6Q=;
        b=c9VFuPD4HK+P/O02GGzkK66JzEqWaZ5DTYcKT22KwK5uPQ1HzzPwLGbfY/MiwEI5sP
         n/rXOpbtJKNg5tmhjK1R7QKMAo4wuC2KMGD5yU0tvB8fxcNWLiXhQwKu2NavzMFgJ5De
         df3u98mvUGSqCoar4gcsa6rUErXBkpATaSiq1piVcSUdlPEp1FfbwpkgDUelVbbXJYL7
         CKwgkBUwO4pqhU5MFLlb/W3FrEQTtpI+m7w38zun8s10ZiEtewHfySK6l/UkWoZka4V5
         zyABQUnEaA3oNLc0+s6Bpn98j/tx+jMRUhGJg5fnaUeyVdTNTAXvhOfRO0u66LQYAGmg
         0BVw==
X-Gm-Message-State: AOJu0YzI21Ksw7A8b2fTVvcOIrzJCz4ylDBGaag8hcIHgEvfJDq89NLB
        ASR/fMnMSrQPnFXzB5QB4W3lB7tk5mUIyw==
X-Google-Smtp-Source: AGHT+IFHoX/YjW7p2y3A78CemIlZYLYri3qpcTS/GRFCYb6MLbOXwXd2EYwVBL+FVpBDEaWua2C2Mg==
X-Received: by 2002:a17:902:ee95:b0:1cf:6d67:c3aa with SMTP id a21-20020a170902ee9500b001cf6d67c3aamr4041380pld.40.1700693953280;
        Wed, 22 Nov 2023 14:59:13 -0800 (PST)
Received: from google.com ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001c9cc44eb60sm201966plx.201.2023.11.22.14.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:59:12 -0800 (PST)
From:   Maxwell Nguyen <hphyperxdev@gmail.com>
To:     stable@vger.kernel.org
Cc:     Maxwell Nguyen <hphyperxdev@gmail.com>,
        Chris Toledanes <chris.toledanes@hp.com>,
        Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH 1/2] Input: xpad - Add HyperX Clutch Gladiate Support for v4.19 to v5.15
Date:   Wed, 22 Nov 2023 14:55:29 -0800
Message-Id: <20231122225528.13383-1-hphyperxdev@gmail.com>
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

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
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

