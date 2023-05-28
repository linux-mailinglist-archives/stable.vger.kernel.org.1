Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E29713E70
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjE1Tfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjE1Tfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98DFE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B180C61DFE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B5C433A0;
        Sun, 28 May 2023 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302529;
        bh=mM1rmZKpoy7KhA05mdac9DMTf1arAJfst4VxifA90cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibllr5HJ+RTZ2ULI3IHL1xxqzezx3Q3BrRb4RL6ZbqMOIh1a0yLLkLZWPKMfITgrn
         8tBkKioLVWZeX/F+qwxOdVv8gsMohc9LsGf9LIt7d8mXgGVl0ZDhUYiBTJdAfyT0FE
         wa+lVd/evtYt2De4jZJJ8KXKbRVEM73sjY447cjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        stable@kernel.org
Subject: [PATCH 6.1 038/119] gpio: mockup: Fix mode of debugfs files
Date:   Sun, 28 May 2023 20:10:38 +0100
Message-Id: <20230528190836.645928781@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -368,7 +368,7 @@ static void gpio_mockup_debugfs_setup(st
 		priv->offset = i;
 		priv->desc = gpiochip_get_desc(gc, i);
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
 }


