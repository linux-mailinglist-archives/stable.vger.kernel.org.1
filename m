Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF77A3AC7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjIQUIi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjIQUIb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7EA97
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B364DC433C8;
        Sun, 17 Sep 2023 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981306;
        bh=nii4d2Qyti2rJKnjjwLT2B3iHLJJ9QOerW4lv+EgU2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJ7qIC9mwpUqvqMSgs+RZmro64ZW+b8fLSih8WWiIq2qQsBeuWZ1gooTNXMye9AIj
         f1RgDW+YGjg99Fo7FJX5SxNGTG5loIH4EMQwJrrpVBcfl+PqZzBk/psGt8C3UadlCp
         2YhLji9b8OWTVq+VVh2o1OK2fniZJHWcOjdo0jvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corinna Vinschen <vinschen@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/219] igb: disable virtualization features on 82580
Date:   Sun, 17 Sep 2023 21:13:49 +0200
Message-ID: <20230917191044.681750523@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index d0ead18ec0266..45ce4ed16146e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3877,8 +3877,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
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



