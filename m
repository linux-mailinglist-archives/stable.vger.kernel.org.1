Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6370C802
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjEVTfN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjEVTfI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D237E1B1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B68B6293B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E82AC433EF;
        Mon, 22 May 2023 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784021;
        bh=VT4YC7zRdb39ixdVuXW2p4bVbm8q6NglsHoVXOgRoTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F97wmtuKq450aiR075m5s3cACOGfXP9c6tz4L4tcEzJRq0ynkbFqJt6laNb8hSRHO
         D5GEd/tuW9JWDwvL5pIqNe7CnyOaRVgspHuol5YPC3U1WJUdEIhVVhHmMhy0LZkHEl
         De6bBFD3My7WmQo26wFaA0OUSOiTKD59yuXnKeCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 210/292] wifi: iwlwifi: fix OEMs name in the ppag approved list
Date:   Mon, 22 May 2023 20:09:27 +0100
Message-Id: <20230522190411.208073259@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

[ Upstream commit eca7296d9a671e9961834d2ace9cc0ce21fc15b3 ]

Fix a spelling mistake.

Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230514120631.fdd07f36a8bf.I223e5fb16ab5c95d504c3fdaffd0bd70affad1c2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a02e5a67b7066..585e8cd2d332d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -38,7 +38,7 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	},
 	{ .ident = "ASUS",
 	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek COMPUTER INC."),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		},
 	},
 	{}
-- 
2.39.2



