Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DD7039A2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbjEORo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjEORoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D567683
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C48962E3F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AEAC4339B;
        Mon, 15 May 2023 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172506;
        bh=CmsO0nj1b+TKyZ2VdMkTac/bZKpIrDNLfLpV+k27QA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecBVJWrRBH+qA5c07VNNl+Nemh8+64dJ6Op0vTHs8reLVeu5bo9p8UwNY75qvdu/C
         GeMH5lPKBw+kcJjiyDcmuweaWJnmI2DTPDcY4RSVYS+bw7Lfg7skFrPT2yDSdqDhZo
         XhssMtB93O5A3TnMpBb9TIXfC5J6b/BA7ZlCqPb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 176/381] wifi: iwlwifi: yoyo: Fix possible division by zero
Date:   Mon, 15 May 2023 18:27:07 +0200
Message-Id: <20230515161744.764521709@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit ba30415118eee374a08b39a0460a1d1e52c24a25 ]

Don't allow buffer allocation TLV with zero req_size since it
leads later to division by zero in iwl_dbg_tlv_alloc_fragments().
Also, NPK/SRAM locations are allowed to have zero buffer req_size,
don't discard them.

Fixes: a9248de42464 ("iwlwifi: dbg_ini: add TLV allocation new API support")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.5d6688ed74d8.I5c2f3a882b50698b708d54f4524dc5bdf11e3d32@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3c931b1b2a0bb..fdf2c6ea41d96 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -191,6 +191,12 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 	    alloc_id != IWL_FW_INI_ALLOCATION_ID_INTERNAL)
 		goto err;
 
+	if (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
+	    alloc->req_size == 0) {
+		IWL_ERR(trans, "WRT: Invalid DRAM buffer allocation requested size (0)\n");
+		return -EINVAL;
+	}
+
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
 
 	return 0;
-- 
2.39.2



