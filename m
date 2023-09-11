Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE479C03D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjIKUzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbjIKO3u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2BF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9BCC433C7;
        Mon, 11 Sep 2023 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442585;
        bh=3FVwIupRbcXvjAn7iKXQS+EQqUMcJ40Ti/0aZ1bfS40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsIkQpzggSCrEhG78WmLfgwugJaB6rhP6LAMfT42CCeQeCtt0qZqmL2cgaEAcvWVs
         CTjZlLVkEMWBlBVj3tpc73OSMOfPh4z2xE8cO3TO0p26qrKoc+rTSSvb57+tT/Bz2I
         gb2hUapyGRec7DBWpynWCELGZd+2/XPx59rrueF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 059/737] platform/x86/amd/pmf: Fix unsigned comparison with less than zero
Date:   Mon, 11 Sep 2023 15:38:38 +0200
Message-ID: <20230911134652.143796475@linuxfoundation.org>
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

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 785c00993dc4c4bb2f7b0f3a3f29c03a6f7aab2e ]

The return value from the call to amd_pmf_get_pprof_modes() is int.
However, the return value is being assigned to an unsigned char
variable 'mode', so making 'mode' an int.

silence the warning:
./drivers/platform/x86/amd/pmf/sps.c:183:5-9: WARNING: Unsigned expression compared with zero: mode < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5995
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230727014315.51375-1-yang.lee@linux.alibaba.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/sps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index fd448844de206..b2cf62937227c 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -121,7 +121,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 {
-	u8 mode, flag = 0;
+	u8 flag = 0;
+	int mode;
 	int src;
 
 	mode = amd_pmf_get_pprof_modes(dev);
-- 
2.40.1



