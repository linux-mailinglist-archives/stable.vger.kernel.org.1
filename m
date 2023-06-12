Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5872BFD0
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjFLKrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjFLKqw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D3AC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9055622B1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC1C433EF;
        Mon, 12 Jun 2023 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565891;
        bh=Tbu2ok51QPVVY5W7T+bALWIj77KRewtAb9WN5gCVu5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFovGpxqEqshT6NaxATrMpmhR8YKAlIHtwzZfKcbO3knUsvg9bjoSmuaVdhCPwRnc
         AklZadPWWjCgESxLbcfKItXgyVXvEKdAIZZSlegnhRyDjtTHVPmp3qKzTyg84oQZ6u
         YbdKAxTmpq8ibVnfsVaXIYGh2sSA2F9nVWkGGO8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 31/45] pinctrl: meson-axg: add missing GPIOA_18 gpio group
Date:   Mon, 12 Jun 2023 12:26:25 +0200
Message-ID: <20230612101655.913256087@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
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

From: Martin Hundebøll <martin@geanix.com>

commit 5b10ff013e8a57f8845615ac2cc37edf7f6eef05 upstream.

Without this, the gpio cannot be explicitly mux'ed to its gpio function.

Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hundebøll <martin@geanix.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Link: https://lore.kernel.org/r/20230512064925.133516-1-martin@geanix.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 


