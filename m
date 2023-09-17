Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDB7A37F8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbjIQT3g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbjIQT3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720AD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AD8C433C8;
        Sun, 17 Sep 2023 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978954;
        bh=hGycoti6tL6EY2KIsB4VzxY+YVXQk4ELpV/qDk2C2eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cb9FzkXSJUJ255K5GdRuN9Zuzd6lA+ewqrmIa/TgBLny2tPOxVnEJJCulzxcvtOjW
         EU5YO3QvehHJWROEnlitOkXinO0Ejn0QyZvTaUSWmrGj/vjyMVCB9ZPbYLRIcGLF7/
         VVIuKDiDS8TZgeuPPMWJ3+dELfLUemE6wH+AGsAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 164/406] bus: ti-sysc: Fix build warning for 64-bit build
Date:   Sun, 17 Sep 2023 21:10:18 +0200
Message-ID: <20230917191105.511204399@linuxfoundation.org>
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
index fcfe4d16cc149..fa7894cab2152 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3041,7 +3041,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 
 	match = soc_device_match(sysc_soc_match);
 	if (match && match->data)
-		sysc_soc->soc = (int)match->data;
+		sysc_soc->soc = (enum sysc_soc)match->data;
 
 	/* Ignore devices that are not available on HS and EMU SoCs */
 	if (!sysc_soc->general_purpose) {
-- 
2.40.1



