Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF07A3814
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbjIQTbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjIQTaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:30:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE0D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:30:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8E0C433C7;
        Sun, 17 Sep 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979034;
        bh=OmCzPD8G0YRfrP9FbpnnbjskfGCts7Z3KiUTlbPi20A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipbvGrfeAx6ccSR19FeqLqAI+zePyAGBYzDE2GcvZ4g0ryPkTOgRDGyS5ecrA5cu4
         goacY1NxPie/uFzNGmMWTcuuNk/UJ6FVZ/dhu4IRI/+vWW5bMX7XEYsKHNFCWb5uTg
         UksMjTc1JuQI7yQEqKBffX8+dhbEz3uA87xKUe74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corey Minyard <minyard@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 170/406] ipmi:ssif: Fix a memory leak when scanning for an adapter
Date:   Sun, 17 Sep 2023 21:10:24 +0200
Message-ID: <20230917191105.673823134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <minyard@acm.org>

[ Upstream commit b8d72e32e1453d37ee5c8a219f24e7eeadc471ef ]

The adapter scan ssif_info_find() sets info->adapter_name if the adapter
info came from SMBIOS, as it's not set in that case.  However, this
function can be called more than once, and it will leak the adapter name
if it had already been set.  So check for NULL before setting it.

Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 87aa12ab8c66f..30f757249c5c0 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1414,7 +1414,7 @@ static struct ssif_addr_info *ssif_info_find(unsigned short addr,
 restart:
 	list_for_each_entry(info, &ssif_infos, link) {
 		if (info->binfo.addr == addr) {
-			if (info->addr_src == SI_SMBIOS)
+			if (info->addr_src == SI_SMBIOS && !info->adapter_name)
 				info->adapter_name = kstrdup(adapter_name,
 							     GFP_KERNEL);
 
-- 
2.40.1



