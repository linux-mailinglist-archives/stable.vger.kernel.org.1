Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04929713E72
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjE1Tfi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjE1Tfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BCFBB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA9B61E06
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36274C4339B;
        Sun, 28 May 2023 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302531;
        bh=dxuvqh8S5yG7Mvr/xZ2n3VfoEwgvoJaH0M7S7QTabWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFbF1gTtySguJ0hTg/BsnnVex/TE5qS/VGgQllMeb9dIzn5kW6XnDUDfYoNeveKcH
         GkAQvkGVDew+2bdrNx+QKAS+cwE8oI+TDp9w+Uc0C7BuZiSXpRzq+vQNlQHUSdVztw
         xPh10XZ2bJ8LEKttU4jhKL2ouTos2YTI3WkBXfas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 012/119] platform/x86: hp-wmi: Fix cast to smaller integer type warning
Date:   Sun, 28 May 2023 20:10:12 +0100
Message-Id: <20230528190835.750155482@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit ce95010ef62d4bf470928969bafc9070ae98cbb1 upstream.

Fix the following compiler warning:

drivers/platform/x86/hp/hp-wmi.c:551:24: warning: cast to smaller integer
   type 'enum hp_wmi_radio' from 'void *' [-Wvoid-pointer-to-enum-cast]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230123132824.660062-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp/hp-wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -552,7 +552,7 @@ static int __init hp_wmi_enable_hotkeys(
 
 static int hp_wmi_set_block(void *data, bool blocked)
 {
-	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
+	enum hp_wmi_radio r = (long)data;
 	int query = BIT(r + 8) | ((!blocked) << r);
 	int ret;
 


