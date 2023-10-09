Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD77BDF8E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376789AbjJINbN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377076AbjJINbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B329C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95182C433C9;
        Mon,  9 Oct 2023 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858271;
        bh=9SXpDgbjuf1kBx7tGZeOhHDJs7zTnnf4mReOo+bCELI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAlRrguEC9RHaXNH6DAO95kQz72ux9kWyZOneg64GWq/2WViHarvAzdGe/5OiPj7H
         T2XTmIa5kiO2HB++1zvSNxo8N1yx0hdDv6r5aPtktfscEi7Zg5inYVh6y9/7NCQwX5
         cxwwd7g9OtGFbogioGgVhv20W0iX/Iz170Odztd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Assmann <sassmann@kpanic.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/131] i40e: fix return of uninitialized aq_ret in i40e_set_vsi_promisc
Date:   Mon,  9 Oct 2023 15:01:49 +0200
Message-ID: <20231009130118.410314174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

[ Upstream commit e1e1b5356eb48dce4307f5cae10e4d6d5bd3df74 ]

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function ‘i40e_set_vsi_promisc’:
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1176:14: error: ‘aq_ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  i40e_status aq_ret;

In case the code inside the if statement and the for loop does not get
executed aq_ret will be uninitialized when the variable gets returned at
the end of the function.

Avoid this by changing num_vlans from int to u16, so aq_ret always gets
set. Making this change in additional places as num_vlans should never
be negative.

Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 30abaf939a76f..37ce764ed3730 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1125,7 +1125,7 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
 static int __i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
-	int num_vlans = 0, bkt;
+	u16 num_vlans = 0, bkt;
 
 	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
 		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
@@ -1161,8 +1161,8 @@ static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
  *
  * Called to get number of VLANs and VLAN list present in mac_filter_hash.
  **/
-static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, int *num_vlans,
-					   s16 **vlan_list)
+static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, u16 *num_vlans,
+				    s16 **vlan_list)
 {
 	struct i40e_mac_filter *f;
 	int i = 0;
@@ -1196,7 +1196,7 @@ static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, int *num_vlans,
  **/
 static i40e_status
 i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
-		     bool unicast_enable, s16 *vl, int num_vlans)
+		     bool unicast_enable, s16 *vl, u16 num_vlans)
 {
 	i40e_status aq_ret, aq_tmp = 0;
 	struct i40e_pf *pf = vf->pf;
@@ -1295,7 +1295,7 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	i40e_status aq_ret = I40E_SUCCESS;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi;
-	int num_vlans;
+	u16 num_vlans;
 	s16 *vl;
 
 	vsi = i40e_find_vsi_from_id(pf, vsi_id);
-- 
2.40.1



