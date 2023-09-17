Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F67A3CA9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbjIQUdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbjIQUdf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:33:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F97101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:33:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7133C433C9;
        Sun, 17 Sep 2023 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982810;
        bh=ywKYbJgICIrX+LOId+wci4bTzKj2k78XzpQOtegAPxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=py9dFMeD3VjYKuhk6rq8xrC33Vgo/6qCFASMWquMX/H0FW+X/g+b0Nzv0sLC9kaUN
         CYR6bdbtqiwrjvoatfE7K+94AWKCohtFPcYNGk/lK5A0z50q2yJRO0ry4D+dYtCBaV
         hNj7SZTAG11yjnJd06t9iyiYp7OfW2u3eF+jM9eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.15 359/511] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Date:   Sun, 17 Sep 2023 21:13:06 +0200
Message-ID: <20230917191122.467110610@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit e520d0b6be950ce3738cf4b9bd3b392be818f1dc upstream.

Allocate extra space for terminating element at:

drivers/cpufreq/brcmstb-avs-cpufreq.c:
449         table[i].frequency = CPUFREQ_TABLE_END;

and add code comment to make this clear.

This fixes the following -Warray-bounds warning seen after building
ARM with multi_v7_defconfig (GCC 13):
In function 'brcm_avs_get_freq_table',
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
  449 |         table[i].frequency = CPUFREQ_TABLE_END;
In file included from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from include/linux/cpufreq.h:12,
                 from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
In function 'devm_kmalloc_array',
    inlined from 'devm_kcalloc' at include/linux/device.h:328:9,
    inlined from 'brcm_avs_get_freq_table' at drivers/cpufreq/brcmstb-avs-cpufreq.c:437:10,
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
include/linux/device.h:323:16: note: at offset 60 into object of size 60 allocated by 'devm_kmalloc'
  323 |         return devm_kmalloc(dev, bytes, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -Warray-bounds.

Link: https://github.com/KSPP/linux/issues/324
Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -434,7 +434,11 @@ brcm_avs_get_freq_table(struct device *d
 	if (ret)
 		return ERR_PTR(ret);
 
-	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
+	/*
+	 * We allocate space for the 5 different P-STATES AVS,
+	 * plus extra space for a terminating element.
+	 */
+	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1 + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);


