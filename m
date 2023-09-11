Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D820379BCA4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbjIKVGP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbjIKPPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFBFFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:15:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765F6C433C8;
        Mon, 11 Sep 2023 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445310;
        bh=zpA8iSmvRyVRgaUS3y+hWCYnS60m30I2IyMjbb2ZUtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuxzKVpjfGrcUxM+TvERbPpnvyyAa+hc71PU4Gx+ejr1VuG8aY5MlXTxU/G3L78zf
         NRP+Ev41OTGdGs/PrkHiFCFioElhxFLPPThOVKgI2omAo5s2rRpj0Onjmdo059EiUP
         tfS7hxkRuKUbzVDRW3Y2Q+3ygikyEIwNNjYhgyO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 303/600] bus: ti-sysc: Fix build warning for 64-bit build
Date:   Mon, 11 Sep 2023 15:45:36 +0200
Message-ID: <20230911134642.558801406@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit e1e1e9bb9d943ec690670a609a5f660ca10eaf85 ]

Fix "warning: cast from pointer to integer of different size" on 64-bit
builds.

Note that this is a cosmetic fix at this point as the driver is not yet
used for 64-bit systems.

Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 9b7268bae66ab..0c933788d8575 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3125,7 +3125,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 
 	match = soc_device_match(sysc_soc_match);
 	if (match && match->data)
-		sysc_soc->soc = (int)match->data;
+		sysc_soc->soc = (enum sysc_soc)match->data;
 
 	/*
 	 * Check and warn about possible old incomplete dtb. We now want to see
-- 
2.40.1



