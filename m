Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D879B09B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348944AbjIKVbv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbjIKOgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D56F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3DDC433C7;
        Mon, 11 Sep 2023 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443000;
        bh=nLT1A0XyCAeoi7a2btSTJXQ6H6ZiNA3JLPkvnRGWk/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQQzR+DwZGNkR1pgFFQBojHvMmWj6zFIkQeBUhaZURxIBGtFOZ13ykCMOB89VeVtl
         uxDxPp+b2HeFVtWC0kh5bk7oYbQCFR1iXZ+C/f8ko+iznfZwvcHqrFPKcp+onf6zoX
         zTRPgHjuXjl2Gwkq6EzHzkbHgzHuI7E96yaeEW6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Simon Horman <horms@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 223/737] net: lan966x: Fix return value check for vcap_get_rule()
Date:   Mon, 11 Sep 2023 15:41:22 +0200
Message-ID: <20230911134656.813134150@linuxfoundation.org>
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

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit ab104318f63997113b0ce7ac288e51359925ed79 ]

As Simon Horman suggests, update vcap_get_rule() to always
return an ERR_PTR() and update the error detection conditions to
use IS_ERR(), so use IS_ERR() to fix the return value issue.

Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d1246..1da2b1f82ae93 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (vrule) {
+	if (!IS_ERR(vrule)) {
 		u32 value, mask;
 
 		/* Just modify the ingress port mask and exit */
@@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (!vrule)
+	if (IS_ERR(vrule))
 		return -EEXIST;
 
 	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
-- 
2.40.1



