Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127E278ACFE
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjH1Kos (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjH1Kob (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDCE41
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D986419B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172FCC433C7;
        Mon, 28 Aug 2023 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219440;
        bh=PVw/fHqj3cOYtVN1s2MDn0N8qZdy89BKf4NCy+YLH3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08TNFNjWmKmwMUg1kvpNt3wLjKiPGRynRg5rbKku6TuK0oZGnFG9hXL+fDBOS1Uz9
         r+2wC1KK4souqC5v14QBekTyrixjsd7cAdYvxPFxv9mJP7IvOwLLZMw9bt2m2xH8Fj
         PHnb7jlFXmSp/haZxtQopa8qbK2SST3z6LXvDh9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Neftin <sasha.neftin@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/89] igc: Fix the typo in the PTM Control macro
Date:   Mon, 28 Aug 2023 12:13:37 +0200
Message-ID: <20230828101151.403879819@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sasha Neftin <sasha.neftin@intel.com>

[ Upstream commit de43975721b97283d5f17eea4228faddf08f2681 ]

The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM
requests. The bit resolution of this field is six bits. That bit five was
missing in the mask. This patch comes to correct the typo in the
IGC_PTM_CTRL_SHRT_CYC macro.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://lore.kernel.org/r/20230821171721.2203572-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 60d0ca69ceca9..703b62c5f79b5 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -539,7 +539,7 @@
 #define IGC_PTM_CTRL_START_NOW	BIT(29) /* Start PTM Now */
 #define IGC_PTM_CTRL_EN		BIT(30) /* Enable PTM */
 #define IGC_PTM_CTRL_TRIG	BIT(31) /* PTM Cycle trigger */
-#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
+#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
 #define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
-- 
2.40.1



