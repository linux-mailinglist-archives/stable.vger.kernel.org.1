Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191A57F5431
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 00:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjKVXIT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 18:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjKVXIS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 18:08:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F31BE
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 15:08:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cb55001124so1030471b3a.0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 15:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700694493; x=1701299293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZSSohd/WPwZ3GJcYplBt61TdHf9+hAJUKT3c1Clmmo=;
        b=cMjugwYJCt/nKR1G6T+55779btrF34qHEBVv6pFCXtcXvkFS9ivTdA+vnSh/Sg6fo8
         CmbXM+4fdzB+AI4NRRju1IGSGkey88qZUaRPM5zF2J1r3mPS5WE0egZbCBiGTPpJxyVA
         eSA/Je8n66+7sZhtqxwt1eT1ZQxFQtjZd9vjbXZeJmOFiJpqfn2f1z1ZbFMjLRnxwoTg
         Q03P7KFRtLfi2q4aRAHF6omSoY5ezeMyGsWT3LmRHvWnbnOiqizhOn9mU+sCv6dUFxT6
         KnODBVmcVBYfIA87VCsN1VkRj2FX2rr856qil0Z7SXZuMYW7M0K2CrZJ2CiW7F11UrbU
         2NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694493; x=1701299293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZSSohd/WPwZ3GJcYplBt61TdHf9+hAJUKT3c1Clmmo=;
        b=OWWJWYvXLpE6vZDqJAFVAK+pqoIAH8VULROXbjWaSUj5osD4rmaWWoUXjpt+pouTpK
         mk0vcwv0cH8wKyHqCcUxnRXwa35IBj4Ef3I+GGblmH8bJ4/4GwR6sHx6+X30s0nb5zRJ
         H1WXE+FdS5zH0eiZBJ4aGctxJNrJwk7qShD2csPeq9VVA6QFMGFGyE8XNz5IBnqDwvhd
         xh08k+KGmiiI7WP63u4V/X/iScmicxeNEuyXP0N56VUp2QQ+V6K7VVr8jzI58+nDiQbo
         U3MorQ4JmI86kf9aEP9EItbMBM0lmouZjEdhWKKZ0qqxdRhU+PC69TtdJkZZsyhYqNvY
         /46w==
X-Gm-Message-State: AOJu0YzKLxMG0Y35ufDIViMKv54zQBu4OUdia8t9aG2hxtH0B28op2gs
        DeGA8IcvV2ozEuU6OuyPJuXjgz2r/wTytQ==
X-Google-Smtp-Source: AGHT+IGGyXFrEf2T93z0pQUcGuazngUBRUT0ge0ZbA8GbjDMyK9Ze5I5trR2XrYK1UFEFSwLcinpkQ==
X-Received: by 2002:a05:6a20:ba28:b0:185:d125:ea70 with SMTP id fa40-20020a056a20ba2800b00185d125ea70mr833517pzb.19.1700694492741;
        Wed, 22 Nov 2023 15:08:12 -0800 (PST)
Received: from google.com ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a00114200b0068fece22469sm17332pfm.4.2023.11.22.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:08:12 -0800 (PST)
From:   Maxwell Nguyen <hphyperxdev@gmail.com>
To:     stable@vger.kernel.org
Cc:     Maxwell Nguyen <hphyperxdev@gmail.com>,
        Chris Toledanes <chris.toledanes@hp.com>,
        Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH 2/2] Input: xpad - Add HyperX Clutch Gladiate Support for v6.1
Date:   Wed, 22 Nov 2023 15:04:06 -0800
Message-Id: <20231122230405.13775-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Add HyperX controller support to xpad_device and xpad_table 

Add to LTS version 6.1.

commit e28a0974d749e5105d77233c0a84d35c37da047e upstream
Separate patch to account for added functions in later LTS version that are not present.

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2959d80f7fdb..597a21a7e6bb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -129,6 +129,7 @@ static const struct xpad_device {
 	u8 packet_type;
 } xpad_device[] = {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
@@ -457,6 +458,7 @@ static const signed short xpad_btn_paddles[] = {
 static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
-- 
2.39.3

