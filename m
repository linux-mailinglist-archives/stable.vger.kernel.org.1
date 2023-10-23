Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A947D3347
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjJWL2j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJWL2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3A92
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB395C433C7;
        Mon, 23 Oct 2023 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060517;
        bh=/1UcCXj8K7h1f3th3hXxiHAKHUL+HCwS6fzptRoBW4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07svVojuIwpwefZkeRRK4lPObFuh7E7/1ebGShGobvD3DqYIt8vlYdoxhv6V5TOqx
         dCIfJo+jCG2Z/eSdgvRJ7Q+GACfZCaSc/hiE6fT/nzKwEfQT9c+bIYu1LcYPEzmGHK
         b4pGuFnRi46EF2IsjsaSnlYavnPcc9mpsLjz20pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 172/196] platform/surface: platform_profile: Propagate error if profile registration fails
Date:   Mon, 23 Oct 2023 12:57:17 +0200
Message-ID: <20231023104833.281888128@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

commit fe0e04cf66a12ffe6d1b43725ddaabd5599d024f upstream.

If platform_profile_register() fails, the driver does not propagate
the error, but instead probes successfully. This means when the driver
unbinds, the a warning might be issued by platform_profile_remove().

Fix this by propagating the error back to the caller of
surface_platform_profile_probe().

Compile-tested only.

Fixes: b78b4982d763 ("platform/surface: Add platform profile driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Link: https://lore.kernel.org/r/20231014235449.288702-1-W_Armin@gmx.de
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/surface/surface_platform_profile.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -159,8 +159,7 @@ static int surface_platform_profile_prob
 	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
 
-	platform_profile_register(&tpd->handler);
-	return 0;
+	return platform_profile_register(&tpd->handler);
 }
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)


