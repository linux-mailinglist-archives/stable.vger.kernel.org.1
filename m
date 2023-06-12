Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE972C136
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjFLK5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbjFLK5R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3F3C23
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DA66242A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C111C433D2;
        Mon, 12 Jun 2023 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566692;
        bh=h7wDYnHETVKvVKihkDO65vT57WRsgkdC7ZhWEeKrWFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEoq6aE9P9lhrttRUSiiY2GFMjy4hK8/v7j0vNUnNg61dME56/d6FD1h7+JngGl8G
         EVIr5MtaClN+mWcriRfEHnS/Ddu5nuEfujHiozcdhUuA/xICLOKag5iXFkcnmiJ1lS
         oT95GzZ/Vh0IDyz/arUU/x2lx2GY9SbiluEbUjDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/132] gpio: sim: fix memory corruption when adding named lines and unnamed hogs
Date:   Mon, 12 Jun 2023 12:27:30 +0200
Message-ID: <20230612101715.567539889@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Kent Gibson <warthog618@gmail.com>

[ Upstream commit 95ae9979bfe3174c2ee8d64409c44532f2881907 ]

When constructing the sim, gpio-sim constructs an array of named lines,
sized based on the largest offset of any named line, and then initializes
that array with the names of all lines, including unnamed hogs with higher
offsets.  In doing so it writes NULLs beyond the extent of the array.

Add a check that only named lines are used to initialize the array.

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Signed-off-by: Kent Gibson<warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-sim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index cff68f31a09fd..803676e307d73 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -717,8 +717,10 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 	if (!line_names)
 		return ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(line, &bank->line_list, siblings)
-		line_names[line->offset] = line->name;
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->name && (line->offset <= max_offset))
+			line_names[line->offset] = line->name;
+	}
 
 	return line_names;
 }
-- 
2.39.2



