Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB278ACB3
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjH1KmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjH1Klk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF878C5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F47640B8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85598C433C7;
        Mon, 28 Aug 2023 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219295;
        bh=H38HM8y5xef1TZVguQPsCQZ7qWoWO9WdazVfi5UsB58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiuCOtdQU3UzkmUt+cYmlWxMcZmjaZv9JWHRVk8MOETpUa/B7hX7FyDCa413zXFmT
         cIr5FgwdA0xsNmN7m0cwvHsZfSOkZ7wAY4P04SdKiJEGdkQjv3yLQe2t4wKFvQZdpw
         /hMrOwy605v/wMuLpfXyTmUKP54vHZgmTHmtbKUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.4 144/158] drm/display/dp: Fix the DP DSC Receiver cap size
Date:   Mon, 28 Aug 2023 12:14:01 +0200
Message-ID: <20230828101202.453079752@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

commit 5ad1ab30ac0809d2963ddcf39ac34317a24a2f17 upstream.

DP DSC Receiver Capabilities are exposed via DPCD 60h-6Fh.
Fix the DSC RECEIVER CAP SIZE accordingly.

Fixes: ffddc4363c28 ("drm/dp: Add DP DSC DPCD receiver capability size define and missing SHIFT")
Cc: Anusha Srivatsa <anusha.srivatsa@intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: <stable@vger.kernel.org> # v5.0+

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230818044436.177806-1-ankit.k.nautiyal@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/drm/drm_dp_helper.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1052,7 +1052,7 @@ u8 drm_dp_get_adjust_request_pre_emphasi
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
 #define DP_RECEIVER_CAP_SIZE		0xf
-#define DP_DSC_RECEIVER_CAP_SIZE        0xf
+#define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 through 0x6F */
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
 #define EDP_DISPLAY_CTL_CAP_SIZE	3
 


