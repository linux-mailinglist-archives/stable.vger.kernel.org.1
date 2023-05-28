Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882DC713DB9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjE1T2T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjE1T2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C2A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F8F61CE8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE912C433EF;
        Sun, 28 May 2023 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302097;
        bh=9L5Ir1Wn7U3eOzQ0K8V/W044w0ZJ1OI3WyI6PgNi+LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypIM3a4rrjJIQYY68PedNaTLx4DVTftRVM/xca9TQbvCmKAYFAAz1+npXb/i0faKZ
         DmBb3uh+lgslP+WZh3j4EHzh5UNWaVErVTqbmZxW/1nsOPvfW2IGqaO4HD385Qoa97
         pz8GKIHhX2YqA6/26AGMDA4gU3Ef4x6uj9fUtVHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        stable@kernel.org
Subject: [PATCH 5.4 132/161] gpio: mockup: Fix mode of debugfs files
Date:   Sun, 28 May 2023 20:10:56 +0100
Message-Id: <20230528190841.179954275@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zev Weiss <zev@bewilderbeest.net>

commit 0a1bb16e0fe6650c3841e611de374bfd5578ad70 upstream.

This driver's debugfs files have had a read operation since commit
2a9e27408e12 ("gpio: mockup: rework debugfs interface"), but were
still being created with write-only mode bits.  Update them to
indicate that the files can also be read.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
Cc: stable@kernel.org # v5.1+
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-mockup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -339,7 +339,7 @@ static void gpio_mockup_debugfs_setup(st
 		priv->offset = i;
 		priv->desc = &gc->gpiodev->descs[i];
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
 


