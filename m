Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB386FA534
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjEHKHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjEHKG7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199E91986
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F50962349
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B68C433EF;
        Mon,  8 May 2023 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540417;
        bh=nLdePqh2bTqCnlpaPt1P2wcp/nv/2C4fsrBJyidy/Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfigRGNvQP9yZrlWGOLubJupkzytnt9iWSHKoorEpWtZzSBzOvZ1t20Su4Rk8FFBq
         30oZdRnEEs9QvhCF/HpafBZwl+yNGhPfCcCB1/kOdQDL9bxJw0QkSTC1kYuW6fLQem
         F2erwaWFkbbLf99RkIdLtTYn1LxQ3cZOs1KxiShQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Rix <trix@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 357/611] wifi: iwlwifi: fw: move memset before early return
Date:   Mon,  8 May 2023 11:43:19 +0200
Message-Id: <20230508094434.004232988@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index bde6f0764a538..027360e63b926 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1388,13 +1388,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
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



