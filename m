Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0C70C63F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjEVTQt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjEVTQj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AFE10C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA4A622B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86638C4339C;
        Mon, 22 May 2023 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782993;
        bh=HBAtGPMefx7xKMZ+SBw+YPnjUj/CoM+exI6w9O4NVDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUY24xUWTPcOQKENF4kwvnVxw2TS3CMq4s2YtJZblhoHGqCRzjH0CMU0///Hvcywu
         YHlddqfaARQxFGYqSlCVreDwYg0IKnjMYOHCJo/7L5c2mRArdyekbROYLX04a0HZO2
         tAACuLSzInSf4HKhU+SwMJ1NQP1/JA3UzID+Y9s0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Houldsworth <dhould3@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 104/203] platform/x86: hp-wmi: Support touchpad on/off
Date:   Mon, 22 May 2023 20:08:48 +0100
Message-Id: <20230522190357.861860068@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Houldsworth <dhould3@gmail.com>

[ Upstream commit 401199ffa9b69baf3fd1f9ad082aa65c10910585 ]

Add scancodes reported by the touchpad on/off button. The actual disabling
and enabling is done in hardware, and this just reports that change to
userspace.

Signed-off-by: Daniel Houldsworth <dhould3@gmail.com>
Link: https://lore.kernel.org/r/20220922115459.6511-1-dhould3@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: decab2825c3e ("platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp-wmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 1e390dcee561b..2f06e94ef37f7 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -154,15 +154,17 @@ struct bios_rfkill2_state {
 };
 
 static const struct key_entry hp_wmi_keymap[] = {
-	{ KE_KEY, 0x02,   { KEY_BRIGHTNESSUP } },
-	{ KE_KEY, 0x03,   { KEY_BRIGHTNESSDOWN } },
-	{ KE_KEY, 0x20e6, { KEY_PROG1 } },
-	{ KE_KEY, 0x20e8, { KEY_MEDIA } },
-	{ KE_KEY, 0x2142, { KEY_MEDIA } },
-	{ KE_KEY, 0x213b, { KEY_INFO } },
-	{ KE_KEY, 0x2169, { KEY_ROTATE_DISPLAY } },
-	{ KE_KEY, 0x216a, { KEY_SETUP } },
-	{ KE_KEY, 0x231b, { KEY_HELP } },
+	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
+	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
+	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
+	{ KE_KEY, 0x213b,  { KEY_INFO } },
+	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
+	{ KE_KEY, 0x216a,  { KEY_SETUP } },
+	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
+	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
+	{ KE_KEY, 0x231b,  { KEY_HELP } },
 	{ KE_END, 0 }
 };
 
-- 
2.39.2



