Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834937BDF8D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377074AbjJINbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJINbJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073099C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBC5C433C8;
        Mon,  9 Oct 2023 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858267;
        bh=PztRB6Qt8CfrbkN0UB+i6selUxTbrTbCERQ1LyclbnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsFjnJF6Ms/lTZihW3ogZfcLwso2htUiYrK0alvh3BGHZpzErU/K3k1VqfQk6nsmV
         O274k9rqLNYz3EHGm0I85MIrfQEznG8wghHQYU0vaouJLmsFA/62rK1lJxDUjTwpap
         vnvDmh1ZoQpoMKHVL7TFKZz4dD/d2sco/3F/m7a8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Stefan Assmann <sassmann@kpanic.de>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/131] i40e: always propagate error value in i40e_set_vsi_promisc()
Date:   Mon,  9 Oct 2023 15:01:48 +0200
Message-ID: <20231009130118.381089637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Assmann <sassmann@kpanic.de>

[ Upstream commit b6f23d3817b965bcd6d72aab1f438ff6d16a0691 ]

The for loop in i40e_set_vsi_promisc() reports errors via dev_err() but
does not propagate the error up the call chain. Instead it continues the
loop and potentially overwrites the reported error value.
This results in the error being recorded in the log buffer, but the
caller might never know anything went the wrong way.

To avoid this situation i40e_set_vsi_promisc() needs to temporarily store
the error after reporting it. This is still not optimal as multiple
different errors may occur, so store the first error and hope that's
the main issue.

Fixes: 37d318d7805f (i40e: Remove scheduling while atomic possibility)
Reported-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 291ee55b125f8..30abaf939a76f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1198,9 +1198,9 @@ static i40e_status
 i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 		     bool unicast_enable, s16 *vl, int num_vlans)
 {
+	i40e_status aq_ret, aq_tmp = 0;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status aq_ret;
 	int i;
 
 	/* No VLAN to set promisc on, set on VSI */
@@ -1249,6 +1249,9 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 				vf->vf_id,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
+
+			if (!aq_tmp)
+				aq_tmp = aq_ret;
 		}
 
 		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, seid,
@@ -1262,8 +1265,15 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 				vf->vf_id,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
+
+			if (!aq_tmp)
+				aq_tmp = aq_ret;
 		}
 	}
+
+	if (aq_tmp)
+		aq_ret = aq_tmp;
+
 	return aq_ret;
 }
 
-- 
2.40.1



