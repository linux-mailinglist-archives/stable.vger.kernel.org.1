Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C870C9A5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjEVTu2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjEVTt6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3595
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D4E262AE7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC7C433EF;
        Mon, 22 May 2023 19:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784995;
        bh=VT4YC7zRdb39ixdVuXW2p4bVbm8q6NglsHoVXOgRoTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7q3q9HxYhPE8d9Gl4v13RcF5gNiJxuM6bw7rZ5OLXpEsoCG+k+UgmHeCnT1jRxNZ
         c3hGAwjL7hXZnq9juMp++efCfOAM2hWgkGmWQngcOBpHAhZijx426CUocHfp3txxM7
         wyqf8L5+MEWDkPNqbrKuZX9PUYw+6kHSv0rpw1Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 273/364] wifi: iwlwifi: fix OEMs name in the ppag approved list
Date:   Mon, 22 May 2023 20:09:38 +0100
Message-Id: <20230522190419.540459238@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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



