Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03967611D7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjGYK4r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjGYK4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A43A9D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AB761680
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539D3C433C9;
        Tue, 25 Jul 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282426;
        bh=sB+XtJAYpsxpgs8eSEbivLDZHx106L5FQ9mAbaQJbvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCXMiImXK9V72Gew3wK3QlmP561q+NJfJAUlIlCxiXD9QYJUymM76Sj5Ov88lJ497
         +aCxw9GFayq4XchzcTKGOLRrAU9v0bpy2EDxfGqcQJQMn2GA6/NdetQylTey+/QM9h
         pbYMmX6ukfvZxkVHkIpK+Wjygdve6vSTd1MKT4s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 124/227] wifi: iwlwifi: mvm: fix potential array out of bounds access
Date:   Tue, 25 Jul 2023 12:44:51 +0200
Message-ID: <20230725104519.946711193@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit 637452360ecde9ac972d19416e9606529576b302 ]

Account for IWL_SEC_WEP_KEY_OFFSET when needed while verifying
key_len size in iwl_mvm_sec_key_add().

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230613155501.f193b7493a93.I6948ba625b9318924b96a5e22602ac75d2bd0125@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 8853821b37168..1e659bd07392a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -179,9 +179,14 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
 		.u.add.key_flags = cpu_to_le32(key_flags),
 		.u.add.tx_seq = cpu_to_le64(atomic64_read(&keyconf->tx_pn)),
 	};
+	int max_key_len = sizeof(cmd.u.add.key);
 	int ret;
 
-	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
+		max_key_len -= IWL_SEC_WEP_KEY_OFFSET;
+
+	if (WARN_ON(keyconf->keylen > max_key_len))
 		return -EINVAL;
 
 	if (WARN_ON(!sta_mask))
-- 
2.39.2



