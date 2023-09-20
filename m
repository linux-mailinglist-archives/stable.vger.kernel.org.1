Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE77A7E7C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjITMSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjITMSK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9292
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:18:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E2DC433CA;
        Wed, 20 Sep 2023 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212285;
        bh=gklEJnEJ3AQ4N3Sbdf+pyFYLHq6Ntbqs5Ja8ITp5EIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaJwjLwxFdjzTboG0scnHPrJ6AZ4UCbYebd9K5oHJIADRC3jnY60C2JKU0gryaKCA
         1yqHvY7KrNcwUE3PcRxLPL32GW52sXz/oojCFYPXqq2IOcV/x3p0UFbmkPR3ltOwK5
         d2kcc1ql8DrNqec45lCbjFuqtj06O5SJavJy9SLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olga Zaborska <olga.zaborska@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 220/273] igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
Date:   Wed, 20 Sep 2023 13:31:00 +0200
Message-ID: <20230920112853.225571652@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Zaborska <olga.zaborska@intel.com>

[ Upstream commit 8360717524a24a421c36ef8eb512406dbd42160a ]

Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
value between 64 and 80. All igbvf devices can use as low as 64 descriptors.
This change will unify igbvf with other drivers.
Based on commit 7b1be1987c1e ("e1000e: lower ring minimum size to 64")

Fixes: d4e0fe01a38a ("igbvf: add new driver to support 82576 virtual functions")
Signed-off-by: Olga Zaborska <olga.zaborska@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index eee26a3be90ba..52545cb25d058 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -39,11 +39,11 @@ enum latency_range {
 /* Tx/Rx descriptor defines */
 #define IGBVF_DEFAULT_TXD	256
 #define IGBVF_MAX_TXD		4096
-#define IGBVF_MIN_TXD		80
+#define IGBVF_MIN_TXD		64
 
 #define IGBVF_DEFAULT_RXD	256
 #define IGBVF_MAX_RXD		4096
-#define IGBVF_MIN_RXD		80
+#define IGBVF_MIN_RXD		64
 
 #define IGBVF_MIN_ITR_USECS	10 /* 100000 irq/sec */
 #define IGBVF_MAX_ITR_USECS	10000 /* 100    irq/sec */
-- 
2.40.1



