Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F670C786
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjEVTad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjEVTac (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2839E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0630628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF453C433EF;
        Mon, 22 May 2023 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783831;
        bh=DarLmDaLHiY3F9oUP+4q0bsz4PjaJXtkzGAZLTHb3Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJObkVkEHR4BDqYSsdcgIZwiO20VrBVXENtvGpagvVA/JB2c+/X0Sg4oAIRdBtUVi
         TZ6ATfXHkocAAAhdLMEOX16FW5ewh24JXFmhrGcQssA815lVPZlgB/4PA4iCXiTEwD
         9hZlYZZSayZsXCvIAbPybR+pg3sY8+tvjtdNkyJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fae <faenkhauser@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/292] platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct
Date:   Mon, 22 May 2023 20:08:26 +0100
Message-Id: <20230522190409.688009077@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Fae <faenkhauser@gmail.com>

[ Upstream commit decab2825c3ef9b154c6f76bce40872ffb41c36f ]

Fixes micmute key of HP Envy X360 ey0xxx.

Signed-off-by: Fae <faenkhauser@gmail.com>
Link: https://lore.kernel.org/r/20230425063644.11828-1-faenkhauser@gmail.com
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 4a3851332ef2c..94af7d398a1bf 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -211,6 +211,7 @@ struct bios_rfkill2_state {
 static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
 	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
 	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
 	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
-- 
2.39.2



