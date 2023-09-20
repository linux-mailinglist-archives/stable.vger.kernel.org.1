Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D687A80A1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjITMic (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjITMib (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:38:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7FB6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:38:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E031C433C8;
        Wed, 20 Sep 2023 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213504;
        bh=9JTiAXyJi503yV2kfi2QCIXdSn7kFPdtmYpfVTU85VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXpOYPyqhmRAhTSRXj0iCxNFPOV+RjmBWIpbSzsqJmrIDCzCnyNPxwjmHijmwb6GY
         yXmHnJ+qQE22VyNHVqsK5zcSFt+qVP+awxPlyBU/gtCYV2xfOTDtSW7P2x7BXSbxuC
         GKEW/8NJO29eq/FEHY00vonGabKqKJ2IPl2GKxAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corinna Vinschen <vinschen@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 261/367] igb: disable virtualization features on 82580
Date:   Wed, 20 Sep 2023 13:30:38 +0200
Message-ID: <20230920112905.319062947@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corinna Vinschen <vinschen@redhat.com>

[ Upstream commit fa09bc40b21a33937872c4c4cf0f266ec9fa4869 ]

Disable virtualization features on 82580 just as on i210/i211.
This avoids that virt functions are acidentally called on 82850.

Fixes: 55cac248caa4 ("igb: Add full support for 82580 devices")
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b8113235f281f..6638d314c811c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3710,8 +3710,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	struct pci_dev *pdev = adapter->pdev;
 	struct e1000_hw *hw = &adapter->hw;
 
-	/* Virtualization features not supported on i210 family. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
+	/* Virtualization features not supported on i210 and 82580 family. */
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
+	    (hw->mac.type == e1000_82580))
 		return;
 
 	/* Of the below we really only want the effect of getting
-- 
2.40.1



