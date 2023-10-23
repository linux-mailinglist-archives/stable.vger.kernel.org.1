Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101197D30E8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJWLDf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJWLDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5AD7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1DEC433C8;
        Mon, 23 Oct 2023 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059011;
        bh=H4PDnlbZSm4jpJu6ntrjkIVrSAdTCuOfTe1VnxhykGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyaBp4guoa9oEq8ZIsTcF+6pPZz4vbMP0ShxhDOU7WaaaSzho+a/crDwtzPvWsxLW
         5hggQUggwkCrZl34vcSxMm5Bt8dS0VRvqvHZxunf9R8N8m8z8DOqRiQbTq0rHhw677
         gEGxEPr+FSEMgWXLtnjeTAsyQmjKtQv9TtPRNtUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
        Jan Sokolowski <jan.sokolowski@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.5 009/241] ice: Fix safe mode when DDP is missing
Date:   Mon, 23 Oct 2023 12:53:15 +0200
Message-ID: <20231023104834.086189524@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

commit 42066c4d5d344cdf8564556cdbe0aa36854fefa4 upstream.

One thing is broken in the safe mode, that is
ice_deinit_features() is being executed even
that ice_init_features() was not causing stack
trace during pci_unregister_driver().

Add check on the top of the function.

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Link: https://lore.kernel.org/r/20231011233334.336092-4-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4632,6 +4632,9 @@ static void ice_init_features(struct ice
 
 static void ice_deinit_features(struct ice_pf *pf)
 {
+	if (ice_is_safe_mode(pf))
+		return;
+
 	ice_deinit_lag(pf);
 	if (test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags))
 		ice_cfg_lldp_mib_change(&pf->hw, false);


