Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF81779BDAC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353597AbjIKVrp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbjIKOqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5118106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:46:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC82FC433C7;
        Mon, 11 Sep 2023 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443565;
        bh=NlzhHss2MaxOK/W7nT93vQYRKzMFIoH0CTuwf34nkKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7xCOXKwox/7+mK1acfkF777E6l6EfDlsXBdqQOVjpCaSsxYp8xG6+5wVlfGBWIDP
         /w/j60TC4P3g+j1H/ChiHIubAFLT2MCyITAlV7yKg/Cuz8K2SZJoxck2l0RdZNhdly
         msTmiquyGBSn8A6u8vw8HaF2GoVIjBoyuZs9aJ2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nishanth Menon <nm@ti.com>,
        kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 393/737] bus: ti-sysc: Fix cast to enum warning
Date:   Mon, 11 Sep 2023 15:44:12 +0200
Message-ID: <20230911134701.572473642@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit de44bf2f7683347f75690ef6cf61a1d5ba8f0891 ]

Fix warning for "cast to smaller integer type 'enum sysc_soc' from 'const
void *'".

Cc: Nishanth Menon <nm@ti.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308150723.ziuGCdM3-lkp@intel.com/
Fixes: e1e1e9bb9d94 ("bus: ti-sysc: Fix build warning for 64-bit build")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index dbc37b3b84a8d..c95fa4335fee2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3106,7 +3106,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 
 	match = soc_device_match(sysc_soc_match);
 	if (match && match->data)
-		sysc_soc->soc = (enum sysc_soc)match->data;
+		sysc_soc->soc = (enum sysc_soc)(uintptr_t)match->data;
 
 	/*
 	 * Check and warn about possible old incomplete dtb. We now want to see
-- 
2.40.1



