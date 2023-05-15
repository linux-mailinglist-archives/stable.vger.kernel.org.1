Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966EE703515
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbjEOQzg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbjEOQzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5725BBA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C74F629C0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3031EC433EF;
        Mon, 15 May 2023 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169710;
        bh=IbIuFBY39dut/B58uONInkPlM9KkZKRci1tFVb1Rc3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdzncpN+YKM7VhyaPb81wtV8JVkHHZCkM1HYLpNMrMFdhQFLwRw38LM7viK0AHEPT
         ufS0v77ngvYQJXtkRSAdT8EZUvmIezj9twt1c9RNDVBvnc99IUd8kHerEF62HBEsbF
         1ZhFkOse3IB8inIyQQ5Chc+Tpb+0vUILaJ+7ZC/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fae <faenkhauser@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.3 145/246] platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct
Date:   Mon, 15 May 2023 18:25:57 +0200
Message-Id: <20230515161726.909695307@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

commit decab2825c3ef9b154c6f76bce40872ffb41c36f upstream.

Fixes micmute key of HP Envy X360 ey0xxx.

Signed-off-by: Fae <faenkhauser@gmail.com>
Link: https://lore.kernel.org/r/20230425063644.11828-1-faenkhauser@gmail.com
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp/hp-wmi.c |    1 +
 1 file changed, 1 insertion(+)

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


