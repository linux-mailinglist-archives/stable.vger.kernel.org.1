Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E7D30D1
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjJWLCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJWLCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:02:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6AD7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:02:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D444AC433C9;
        Mon, 23 Oct 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058950;
        bh=sGXDJuRCEbM81m1hbzrLH2zqNa2G/Ek8HeeyDPKfHgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9U61Unp5QoFA+hLr/zLIWC/vOyMgYYUu4oHlwdYztadOywEz5vyqC3Vr9MqfAIvn
         KUtj+sujFGwULKl3hcg7ElwXcVU2jbgOmtBWPm/pb9dYMiPWwO8Oum0mI+FOud1HiP
         kpjA5diUflK/ntZ+aL3Vg8Ml38lIPr6JUKzwpH3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 014/241] regmap: fix NULL deref on lookup
Date:   Mon, 23 Oct 2023 12:53:20 +0200
Message-ID: <20231023104834.256095891@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit c6df843348d6b71ea986266c12831cb60c2cf325 upstream.

Not all regmaps have a name so make sure to check for that to avoid
dereferencing a NULL pointer when dev_get_regmap() is used to lookup a
named regmap.

Fixes: e84861fec32d ("regmap: dev_get_regmap_match(): fix string comparison")
Cc: stable@vger.kernel.org      # 5.8
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231006082104.16707-1-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1572,7 +1572,7 @@ static int dev_get_regmap_match(struct d
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return !strcmp((*r)->name, data);
+		return (*r)->name && !strcmp((*r)->name, data);
 	else
 		return 1;
 }


