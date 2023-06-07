Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57C726CD6
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjFGUg5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjFGUgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7582D6D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9531864581
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DD9C433EF;
        Wed,  7 Jun 2023 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170183;
        bh=6gnuX+36rESmbE76q5z0b3ZbXeU+lnG8X+gszrsdztw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcJxjYtk8+3tbIlAZkfZkvVdTWvhYaAKFOAYQYP8Cta0JgYCSTrIB6EkQKmb2qJER
         l3xEK5WUA+OchcscMBb2fe1dOoilcPFRpJg9LwOcPQpXK3CwPHJ+ErYoI4poP9wZjb
         WcFNqA62hHJnkQceAIx3+ns1Jx5qhAA1nyse2DZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 76/88] wifi: rtlwifi: remove always-true condition pointed out by GCC 12
Date:   Wed,  7 Jun 2023 22:16:33 +0200
Message-ID: <20230607200901.608133037@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit ee3db469dd317e82f57b13aa3bc61be5cb60c2b4 upstream.

The .value is a two-dim array, not a pointer.

struct iqk_matrix_regs {
	bool iqk_done;
        long value[1][IQK_MATRIX_REG_NUM];
};

Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2414,10 +2414,7 @@ void rtl92d_phy_reload_iqk_setting(struc
 			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Just Read IQK Matrix reg for channel:%d....\n",
 				 channel);
-			if ((rtlphy->iqk_matrix[indexforchannel].
-			     value[0] != NULL)
-				/*&&(regea4 != 0) */)
-				_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
+			_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
 					rtlphy->iqk_matrix[
 					indexforchannel].value,	0,
 					(rtlphy->iqk_matrix[


