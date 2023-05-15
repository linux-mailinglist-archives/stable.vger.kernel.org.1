Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3E7039A3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbjEORoc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbjEORoM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A441795A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CDC62E49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568EEC433D2;
        Mon, 15 May 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172509;
        bh=rMz+8QLtZEdcH+H2l6Hxp52PEn2mjsIRSrVT5TEW1yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvLJ1mqpSkAX3IEXwcUZ0kJ50EQERJQR3UEoCVk0gA9ipNNEzeDEn3nXcs8QslSw+
         pFHTALgQclJctJi5Bgu7d1+PF5ko5oY7/9N8rRHydPM2llVnUkz7cOC3p8dMlhV24K
         c6X/XPVD+Ld/Laq1I1/YUSJQmGQ+B6/psgy2w1dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Rix <trix@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 177/381] wifi: iwlwifi: fw: move memset before early return
Date:   Mon, 15 May 2023 18:27:08 +0200
Message-Id: <20230515161744.814454751@linuxfoundation.org>
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

From: Tom Rix <trix@redhat.com>

[ Upstream commit 8ce437dd5b2e4adef13aa4ecce07392f9966b1ab ]

Clang static analysis reports this representative issue
dbg.c:1455:6: warning: Branch condition evaluates to
a garbage value
  if (!rxf_data.size)
       ^~~~~~~~~~~~~~

This check depends on iwl_ini_get_rxf_data() to clear
rxf_data but the function can return early without
doing the clear.  So move the memset before the early
return.

Fixes: cc9b6012d34b ("iwlwifi: yoyo: use hweight_long instead of bit manipulating")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.872a7175f1ff.I33802a77a91998276992b088fbe25f61c87c33ac@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 419eaa5cf0b50..79d08e5d9a81c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1372,13 +1372,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	if (!data)
 		return;
 
+	memset(data, 0, sizeof(*data));
+
 	/* make sure only one bit is set in only one fid */
 	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
 		      "fid1=%x, fid2=%x\n", fid1, fid2))
 		return;
 
-	memset(data, 0, sizeof(*data));
-
 	if (fid1) {
 		fifo_idx = ffs(fid1) - 1;
 		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
-- 
2.39.2



