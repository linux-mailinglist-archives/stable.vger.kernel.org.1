Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A76703620
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbjEORHB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbjEORGm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F949EF3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C92D62AAD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB6C433D2;
        Mon, 15 May 2023 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170273;
        bh=FbnlYb/vQ90ju0cjmiHeW3y/SIWacZiFnA5aAqR35WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVeaLxon2Wqq7OpJbC+JYBVCeNunI+m1JmStW+E42pQl/ZxayDqW89QI9NM5qn5jt
         e3aio2ulJsfgli8TFqCwqomo2jszbhPZZaYs8L8BgrAxMt3DybSaerVz2oP59Ir13x
         96BAtb0RMFd8Wn7kg6Vs36qXm3UZKeaAlnPRoJ5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 078/239] ionic: catch failure from devlink_alloc
Date:   Mon, 15 May 2023 18:25:41 +0200
Message-Id: <20230515161724.024135758@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 4a54903ff68ddb33b6463c94b4eb37fc584ef760 ]

Add a check for NULL on the alloc return.  If devlink_alloc() fails and
we try to use devlink_priv() on the NULL return, the kernel gets very
unhappy and panics. With this fix, the driver load will still fail,
but at least it won't panic the kernel.

Fixes: df69ba43217d ("ionic: Add basic framework for IONIC Network device driver")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index 4297ed9024c01..2696dac21b096 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -65,6 +65,8 @@ struct ionic *ionic_devlink_alloc(struct device *dev)
 	struct devlink *dl;
 
 	dl = devlink_alloc(&ionic_dl_ops, sizeof(struct ionic), dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
-- 
2.39.2



