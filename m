Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6767DD507
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376344AbjJaRqi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbjJaRqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522BFDF
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907B6C433C7;
        Tue, 31 Oct 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774394;
        bh=DVuqq+buzHwqnlArojlZStkL5De6GFcA07KQ9sCGExA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcCTmurp06sp5ACSB2aKkAai30YGWViIXBGDRWGLyBLC2Zfb9FKIgGPoKO2EYW+hN
         4dp85l7P6hIB6W/yYRbPOVd4gNbTvHrnWVbZNuwzMQsbWkyqYWPivNYiV8PBND1sYg
         XMutmymEjRfGjeEE3EUDQcNEOe+7D2XbQ7kk3KXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Shawn.Shao" <shawn.shao@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.5 032/112] vdpa_sim_blk: Fix the potential leak of mgmt_dev
Date:   Tue, 31 Oct 2023 18:00:33 +0100
Message-ID: <20231031165902.339672220@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn.Shao <shawn.shao@jaguarmicro.com>

commit d121df789b159e9a8ee770666f210975a81e8111 upstream.

If the shared_buffer allocation fails, need to unregister mgmt_dev first.

Cc: stable@vger.kernel.org
Fixes: abebb16254b36 ("vdpa_sim_blk: support shared backend")
Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230821060333.1155-1-shawn.shao@jaguarmicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 00d7d72713be..b3a3cb165795 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -499,12 +499,13 @@ static int __init vdpasim_blk_init(void)
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-			goto parent_err;
+			goto mgmt_dev_err;
 		}
 	}
 
 	return 0;
-
+mgmt_dev_err:
+	vdpa_mgmtdev_unregister(&mgmt_dev);
 parent_err:
 	device_unregister(&vdpasim_blk_mgmtdev);
 	return ret;
-- 
2.42.0



