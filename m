Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1C719D79
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFANXe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjFANXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A5138
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E255E61627
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4C4C433EF;
        Thu,  1 Jun 2023 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625803;
        bh=F3awYTmNQuERjbkpEeLb5xpFZNod9Dy7EaDMGqeaw8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyiQLRO6wBt3mrMBLNfDxTIcTSstG1VvBqoDDiFRK2k1MdozjwXt/sm7aZUfKd+Cj
         i4ydjumRdaLtzMBhSJ+eLXfS92INqI+W1UNdZcOEbmj+dZbryS7tHZIbn7y7ZUlWEw
         p2LfqG5UoOcB/WfqDxsWp2c9PYOP/248T/khPb44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 04/22] power: supply: bq27xxx: fix sign of current_now for newer ICs
Date:   Thu,  1 Jun 2023 14:21:02 +0100
Message-Id: <20230601131933.922681198@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
References: <20230601131933.727832920@linuxfoundation.org>
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

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit b67fdcb7099e9c640bad625c4dd6399debb3376a ]

Commit cd060b4d0868 ("power: supply: bq27xxx: fix polarity of current_now")
changed the sign of current_now for all bq27xxx variants, but on BQ28Z610
I'm now seeing negated values *with* that patch.

The GTA04/Openmoko device that was used for testing uses a BQ27000 or
BQ27010 IC, so I assume only the BQ27XXX_O_ZERO code path was incorrect.
Revert the behaviour for newer ICs.

Fixes: cd060b4d0868 "power: supply: bq27xxx: fix polarity of current_now"
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 35092c5819f8 ("power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 79eee63a2041e..d34f1fceadbb4 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1781,7 +1781,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
 	} else {
 		/* Other gauges return signed value */
-		val->intval = -(int)((s16)curr) * 1000;
+		val->intval = (int)((s16)curr) * 1000;
 	}
 
 	return 0;
-- 
2.39.2



