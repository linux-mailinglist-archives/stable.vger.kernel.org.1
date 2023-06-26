Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538B073E7C4
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFZSTE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjFZSTA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F9810C1
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC7160F1D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F68C433C0;
        Mon, 26 Jun 2023 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803515;
        bh=tYyfMgHnGAZxaUDYFsbmAarf858ivoPyM2VJuOtueCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+bV+H97bgpfuUSegxcsnbGTSWxeqRTeCUeili520q9FTJu85LiheMPmzPltOdFRT
         cA/JcYy2XPHj+DUbCqq396Nc8OGIFxHPH0TaUa03WtgzccZ8TcMC6yFfO3thFk042Q
         D5E0Kj8lH0DjCcdRicSjwc7BfFcUnKSYSAXytmr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 087/199] wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0
Date:   Mon, 26 Jun 2023 20:09:53 +0200
Message-ID: <20230626180809.412141939@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

commit 4e9f0ec38852c18faa9689322e758575af33e5d4 upstream.

Add support for AX1690i and AX1690s devices with
PCIE id 0x7AF0.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20230619150233.461290-2-johannes@sipsolutions.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -547,6 +547,8 @@ static const struct iwl_dev_info iwl_dev
 	IWL_DEV_INFO(0x54F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7A70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),


