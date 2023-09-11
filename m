Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363E279B8CE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjIKUvC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbjIKOiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356EF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146CAC433C7;
        Mon, 11 Sep 2023 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443088;
        bh=6FBLafqsfBQFNwUV7SWwIuq0pFhraBCdibzexDasiTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHpuhFfo5890aO5zzPi+vynOTp/FewJ5Q3tShJcn0L0m/0PLgCp5TKRqWG2pxCZW+
         rBCwZDl4hJyQQPNUWaD4hcGNTcl6P2uv7fik84bXZROJml3Gu2ia0a610U7L9USOZd
         jnsCsl0fG8Cn+mAMA6Jl2aW0PBAVbgpXFrUzEAXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 254/737] hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()
Date:   Mon, 11 Sep 2023 15:41:53 +0200
Message-ID: <20230911134657.687375754@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d103337e38e7e64c3d915029e947b1cb0b512737 ]

The supported channels for this driver are {0..3}. Fix the incorrect
channel in tmp51x_is_visible().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/ea0eccc0-a29f-41e4-9049-a1a13f8b16f1@roeck-us.net/
Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230824204456.401580-2-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 0693eaee054ff..a8167a48f824c 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -434,7 +434,7 @@ static umode_t tmp51x_is_visible(const void *_data,
 
 	switch (type) {
 	case hwmon_temp:
-		if (data->id == tmp512 && channel == 4)
+		if (data->id == tmp512 && channel == 3)
 			return 0;
 		switch (attr) {
 		case hwmon_temp_input:
-- 
2.40.1



