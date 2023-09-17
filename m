Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7227A398D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjIQTu6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjIQTun (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344FE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1356DC433C8;
        Sun, 17 Sep 2023 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980235;
        bh=lNz8UXBmQwyRzBmIogOTD9NOv0ozDdU2tK/udVornes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8W5DYZzBpaokvv2XezXLD081vAv5mv7EBcLWknv1ARWYlOGAKs5M0+H1g1jGyAl1
         v2X8K+42DsUJw9gJ/eJxqbkV55PfqQbe3OrBFCagNchUNfNO+BQ58NwqmcN5foq5uM
         DN/eqFLPZdwDOdM5rNNErAmohRRvU1mih0rvl9ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 096/285] i3c: master: svc: Describe member saved_regs
Date:   Sun, 17 Sep 2023 21:11:36 +0200
Message-ID: <20230917191055.016182665@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 5496eac6ad7428fa06811a8c34b3a15beb93b86d ]

The 'saved_regs' member of the 'svc_i3c_master'	structure is not
described in the kernel doc, which produces the following warning:

    Function parameter or member 'saved_regs' not described in 'svc_i3c_master'

Add the missing line in the kernel documentation of the parent
structure.

Fixes: 1c5ee2a77b1b ("i3c: master: svc: fix i3c suspend/resume issue")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308171435.0xQ82lvu-lkp@intel.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20230817101853.16805-1-miquel.raynal@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2fefbe55c1675..6c43992c8cf6b 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -156,6 +156,7 @@ struct svc_i3c_regs_save {
  * @base: I3C master controller
  * @dev: Corresponding device
  * @regs: Memory mapping
+ * @saved_regs: Volatile values for PM operations
  * @free_slots: Bit array of available slots
  * @addrs: Array containing the dynamic addresses of each attached device
  * @descs: Array of descriptors, one per attached device
-- 
2.40.1



