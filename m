Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB787755218
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGPUDv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGPUDp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE169199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCE460EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9972DC433C8;
        Sun, 16 Jul 2023 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537824;
        bh=w9ZrXVXLw8crksylnxgxcMpZFn4W6SGOH+0JK/QSfGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcZ95+GE/Vot9TUVaD6CvtqDS8Scod8hHZtJU5kZmIHMrmBJ8o6bpgXWo7e9w1I+3
         fVKOSbg6mSNRteUU88fM8IvEcEQWox8I4zuNgskan+MWBQqF/H8uWLJpQFFUqiHiBu
         KhNEaZKVb3pJkNoy2LvYJzvcpE5KcAYtMOrw1F0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 233/800] Input: tests - modular KUnit tests should not depend on KUNIT=y
Date:   Sun, 16 Jul 2023 21:41:26 +0200
Message-ID: <20230716194954.500581489@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e0f41f836f5e861bdcaf4719f160b62dbb8e9485 ]

While KUnit tests that cannot be built as a loadable module must depend
on "KUNIT=y", this is not true for modular tests, where it adds an
unnecessary limitation.

Fix this by relaxing the dependency to "KUNIT".

Fixes: fdefcbdd6f361841 ("Input: Add KUnit tests for some of the input core helper functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 735f90b74ee5a..3bdbd34314b34 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -168,7 +168,7 @@ config INPUT_EVBUG
 
 config INPUT_KUNIT_TEST
 	tristate "KUnit tests for Input" if !KUNIT_ALL_TESTS
-	depends on INPUT && KUNIT=y
+	depends on INPUT && KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  Say Y here if you want to build the KUnit tests for the input
-- 
2.39.2



