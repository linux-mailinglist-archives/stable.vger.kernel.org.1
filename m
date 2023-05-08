Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436816FA821
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjEHKhs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjEHKhd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3424AB8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B5C627EA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F835C433EF;
        Mon,  8 May 2023 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542251;
        bh=yc1Hp8cYyXdd5SoDRitAXNyMurPSPbbua4dV9aOc2IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RspNA15FxoYfK9lpNdMP53DPKCBqP4m2PNTlneuo89jYOpUbD3QLtpdF8ud5f7cUs
         GLiBdBtMKFvWwJj4dxjGU4xWL63ue0cGmsqy6/OvwrVylZ8OtwWI1vtQ9TMad3zEdS
         v2d1HlQXiouz1mud2iy6EVPQBsYMdGdUcW+NIXfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 348/663] wifi: iwlwifi: fix duplicate entry in iwl_dev_info_table
Date:   Mon,  8 May 2023 11:42:54 +0200
Message-Id: <20230508094439.437006405@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit fc3c2f0ed86b65dff4b6844c59c597b977cae533 ]

There're two identical entries for ax1650 device in
iwl_dev_info_table. Remove one of the duplicate entries.

Fixes: 953e66a7238b ("iwlwifi: add new ax1650 killer device")
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230410140721.897683-2-gregory.greenman@intel.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a60322..a0bf19b18635c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -565,7 +565,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, iwl_ax201_killer_1650i_name),
 	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, iwl_ax201_killer_1650s_name),
 	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
-- 
2.39.2



