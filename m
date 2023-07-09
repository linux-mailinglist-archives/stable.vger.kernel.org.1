Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC074C28F
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGILWA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGILV7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A649913D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451A260B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C3BC433C7;
        Sun,  9 Jul 2023 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901717;
        bh=AVSPoR5fVw312H/2t4iXkTZ0JOHb/kkKiY5WJk9zUOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8wrMiOX2qa/xEHLmsE5r1PzjMJirSvmjbmMEf8HzTMm2SJQIr4UjH4Jv5CTZEXNC
         fk+WlTPBh5XK+Vd1SxA2lhGi2qVC+7peBfgPJX88pvVTpoTKvFK1IrzjYdmV5EaOcy
         uIv1pWM1knVoIW6t7na0024LJqLdsmSGURrFEO0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 119/431] wifi: mac80211: Fix permissions for valid_links debugfs entry
Date:   Sun,  9 Jul 2023 13:11:07 +0200
Message-ID: <20230709111453.947515274@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 4cacadc0dbd8013e6161aa8843d8e9d8ad435b47 ]

The entry should be a read only one and not a write only one. Fix it.

Fixes: 3d9011029227 ("wifi: mac80211: implement link switching")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230611121219.c75316990411.I1565a7fcba8a37f83efffb0cc6b71c572b896e94@changeid
[remove x16 change since it doesn't work yet]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/debugfs_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 0bac9af3ca966..371add9061f1f 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -691,7 +691,7 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD_MODE(uapsd_queues, 0600);
 	DEBUGFS_ADD_MODE(uapsd_max_sp_len, 0600);
 	DEBUGFS_ADD_MODE(tdls_wider_bw, 0600);
-	DEBUGFS_ADD_MODE(valid_links, 0200);
+	DEBUGFS_ADD_MODE(valid_links, 0400);
 	DEBUGFS_ADD_MODE(active_links, 0600);
 }
 
-- 
2.39.2



