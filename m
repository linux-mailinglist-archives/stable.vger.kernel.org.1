Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202079B39F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjIKVhT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbjIKOTj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:19:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467AAC433C7;
        Mon, 11 Sep 2023 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441974;
        bh=+d/jcUWk6XWoDM1IVeTYd05MWBzcbMGfJi72ZMYlBxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxiPKYaATzMbN4yT+tYEmctlEiHHPa9X9QLgeSMbBKxI8u5EELj5tnVVdHxW9XqlB
         OJnsTDCxpg1Shc29tqcx2xAVJ/hK0zHebDDSKkhjY2XFhsITlRSLuK6BeNBOW1IEmz
         VIpF8P67uoyiYHI5DY4l9Aohxy60i/mGT3YscxGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 601/739] leds: aw200xx: Fix error code in probe()
Date:   Mon, 11 Sep 2023 15:46:40 +0200
Message-ID: <20230911134707.887482336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit ad5152b85e8bc7dacb1e6e237553fbe779c938e0 ]

The "ret" variable is zero/success here.  Don't return that, return
-EINVAL instead.

Fixes: 36a87f371b7a ("leds: Add AW20xx driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/4d791b69-01c7-4532-818c-63712d3f63e1@moroto.mountain
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 96979b8e09b7d..7b996bc01c469 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -368,7 +368,7 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 
 	if (!chip->display_rows ||
 	    chip->display_rows > chip->cdef->display_size_rows_max) {
-		return dev_err_probe(dev, ret,
+		return dev_err_probe(dev, -EINVAL,
 				     "Invalid leds display size %u\n",
 				     chip->display_rows);
 	}
-- 
2.40.1



