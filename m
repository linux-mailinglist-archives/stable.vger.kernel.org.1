Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2336735236
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFSKcg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjFSKcd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DC13D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60F0F60B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A082C433C9;
        Mon, 19 Jun 2023 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170738;
        bh=e8KBPGafc4lWioyFKqhihelU5VkPeA2MRjnvL3ZBZZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOQszJUqso5PDVcR+cW90RrvW/JhTXxvRagoQzdKbVRlUbWrOXlLATrBjak/NFn2I
         N+hHO0qSTnRKEYGSwp1ZuX5H9LQ69T1mg7uaiVbJ4QT535SHJSStOPB4s7y2WFKJwM
         5sQLgfFgKT6X1VYPXf2pxLjt09daUqyZFab0yyJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandru Sorodoc <ealex95@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 018/187] platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0
Date:   Mon, 19 Jun 2023 12:27:16 +0200
Message-ID: <20230619102158.501784617@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandru Sorodoc <ealex95@gmail.com>

[ Upstream commit 362c1f2ec82cb65940e1c73e15a395a7a891fc6f ]

On ASUS GU604V the key 0x7B is issued when the charger is connected or
disconnected, and key 0xC0 is issued when an external display is
connected or disconnected.

This commit maps them to KE_IGNORE to slience kernel messages about
unknown keys, such as:

    kernel: asus_wmi: Unknown key code 0x7b

Signed-off-by: Alexandru Sorodoc <ealex95@gmail.com>
Link: https://lore.kernel.org/r/20230512101517.47416-1-ealex95@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index e2c9a68d12df9..fdf7da06af306 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -555,6 +555,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
 	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
@@ -584,6 +585,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
+	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
-- 
2.39.2



