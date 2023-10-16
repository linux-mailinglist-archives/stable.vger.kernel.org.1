Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718607CAC95
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjJPO41 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjJPO40 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:56:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D88E8
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3EC433C7;
        Mon, 16 Oct 2023 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468185;
        bh=8pDQA6Z7QmUFH6ZYqyPPzxeP3wiJRl3uhP6QdKqVInA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lk7bn28JWJKAbN0lkofVsg4ysGo+cwM9HqGafNQEPDj6OMSd4dBvrfaua743Vxptr
         XFAHLGgq+PoNjmZuIiiUfXV2GJlSUaD702qlNtTwHzxwcsfscz2MqbLY2PfdiJ9bky
         6p2eXq7L02t4DSYoVcUMMLu7519VzTu0SA2dbTa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Binderman <dcb314@hotmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.5 142/191] thunderbolt: Correct TMU mode initialization from hardware
Date:   Mon, 16 Oct 2023 10:42:07 +0200
Message-ID: <20231016084018.699562068@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit e19f714ea63f861d95d3d92d45d5fd5ca2e05c8c upstream.

David reported that cppcheck found following possible copy & paste
error from tmu_mode_init():

  tmu.c:385:50: style: Expression is always false because 'else if' condition matches previous condition at line 383. [multiCondition]

And indeed this is a bug. Fix it to use correct index
(TB_SWITCH_TMU_MODE_HIFI_UNI).

Reported-by: David Binderman <dcb314@hotmail.com>
Fixes: d49b4f043d63 ("thunderbolt: Add support for enhanced uni-directional TMU mode")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 747f88703d5c..11f2aec2a5d3 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -382,7 +382,7 @@ static int tmu_mode_init(struct tb_switch *sw)
 		} else if (ucap && tb_port_tmu_is_unidirectional(up)) {
 			if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
 				sw->tmu.mode = TB_SWITCH_TMU_MODE_LOWRES;
-			else if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
+			else if (tmu_rates[TB_SWITCH_TMU_MODE_HIFI_UNI] == rate)
 				sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_UNI;
 		} else if (rate) {
 			sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_BI;
-- 
2.42.0



