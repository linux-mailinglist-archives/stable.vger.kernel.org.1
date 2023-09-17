Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9717A3996
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjIQTva (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjIQTvO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D539F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A27BC433C8;
        Sun, 17 Sep 2023 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980268;
        bh=tSFp93k9bLyNpKXgm7cTl2c8OZsvhZHq7+N9AvG+dQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4FkpeZTYm13ANwxSITMvK6NKXBX+4hMSq5wrFo1oj11GmYyOWvTAVm58aoG7PGwU
         nWADjlyojAhYE/w2xxFg0Q1eaP7L5KWKj6kY/r25UA8T+Z6VxqelTSO0mSQJ0zXeV5
         J1M8RDRqtwHOXBCCfw774RthhBLu/sbKno33u+MA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Zaborska <olga.zaborska@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.5 143/285] igb: Change IGB_MIN to allow set rx/tx value between 64 and 80
Date:   Sun, 17 Sep 2023 21:12:23 +0200
Message-ID: <20230917191056.628434864@linuxfoundation.org>
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

From: Olga Zaborska <olga.zaborska@intel.com>

[ Upstream commit 6319685bdc8ad5310890add907b7c42f89302886 ]

Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
value between 64 and 80. All igb devices can use as low as 64 descriptors.
This change will unify igb with other drivers.
Based on commit 7b1be1987c1e ("e1000e: lower ring minimum size to 64")

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Olga Zaborska <olga.zaborska@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 015b781441149..a2b759531cb7b 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -34,11 +34,11 @@ struct igb_adapter;
 /* TX/RX descriptor defines */
 #define IGB_DEFAULT_TXD		256
 #define IGB_DEFAULT_TX_WORK	128
-#define IGB_MIN_TXD		80
+#define IGB_MIN_TXD		64
 #define IGB_MAX_TXD		4096
 
 #define IGB_DEFAULT_RXD		256
-#define IGB_MIN_RXD		80
+#define IGB_MIN_RXD		64
 #define IGB_MAX_RXD		4096
 
 #define IGB_DEFAULT_ITR		3 /* dynamic */
-- 
2.40.1



