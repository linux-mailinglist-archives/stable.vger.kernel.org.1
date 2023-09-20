Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAD7A80C7
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjITMke (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjITMkG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:40:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3F83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:40:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BA4C433C8;
        Wed, 20 Sep 2023 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213600;
        bh=xOm7mf+ggYMotpc7mK8FYpxKg21kXLxXxLYpk1l1WV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zmax86NVKJuVxAUUxdaACgEOPSwfMIxIaAYEuYm6NckLX0tqemcQNG+mTkpLm1vcL
         fZ3iT9Dg1v4C80BIi3SE5AEXH6Vh+F9jrNkWnRK1lqsH7QlfipMMZFWncNa1TGI6N6
         RD2dkjbbqBQzV67uurn4TGhYwp0JbR6+iE95PaYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Zaborska <olga.zaborska@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 270/367] igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
Date:   Wed, 20 Sep 2023 13:30:47 +0200
Message-ID: <20230920112905.553430008@linuxfoundation.org>
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

From: Olga Zaborska <olga.zaborska@intel.com>

[ Upstream commit 5aa48279712e1f134aac908acde4df798955a955 ]

Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
value between 64 and 80. All igc devices can use as low as 64 descriptors.
This change will unify igc with other drivers.
Based on commit 7b1be1987c1e ("e1000e: lower ring minimum size to 64")

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Signed-off-by: Olga Zaborska <olga.zaborska@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index aec998c82b694..a46eca3ffbcc5 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -78,11 +78,11 @@ extern char igc_driver_version[];
 /* TX/RX descriptor defines */
 #define IGC_DEFAULT_TXD		256
 #define IGC_DEFAULT_TX_WORK	128
-#define IGC_MIN_TXD		80
+#define IGC_MIN_TXD		64
 #define IGC_MAX_TXD		4096
 
 #define IGC_DEFAULT_RXD		256
-#define IGC_MIN_RXD		80
+#define IGC_MIN_RXD		64
 #define IGC_MAX_RXD		4096
 
 /* Transmit and receive queues */
-- 
2.40.1



