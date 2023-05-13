Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF87014A3
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjEMGet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEMGes (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2B92D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A76760A4C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB88C433EF;
        Sat, 13 May 2023 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683959687;
        bh=ekREUBu/gKc4BnNXCR33QWhHsGUD6XxvW1yx47xRamA=;
        h=Subject:To:Cc:From:Date:From;
        b=1OriDCo+R1X0QOy8xKJFY4rLJz0CdInOBaeowcxlKnmwIFH5SSHTHUeY+4T0Vw/Yo
         Dm/lE2mpvSvXiljg16NFVvEUNM1zNq2q3TV8cuQm1myY8cnKaiXUjTJbaLOzqYGMfi
         6aQvAJXOdSKFM/2iCNKiwn+t0dyZsTu8ESUX3bX0=
Subject: FAILED: patch "[PATCH] platform/x86/intel-uncore-freq: Return error on write" failed to apply to 5.10-stable tree
To:     srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, rui.zhang@intel.com,
        wendy.wang@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:34:29 +0900
Message-ID: <2023051328-colonist-quicken-0287@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 75e406b540c3eca67625d97bbefd4e3787eafbfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051328-colonist-quicken-0287@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

75e406b540c3 ("platform/x86/intel-uncore-freq: Return error on write frequency")
dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and enumeration part")
414eef27283a ("platform/x86/intel/uncore-freq: Display uncore current frequency")
ae7b2ce57851 ("platform/x86/intel/uncore-freq: Use sysfs API to create attributes")
ce2645c458b5 ("platform/x86/intel/uncore-freq: Move to uncore-frequency folder")
6dc69d3d0d18 ("Merge tag 'driver-core-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75e406b540c3eca67625d97bbefd4e3787eafbfe Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 18 Apr 2023 08:32:30 -0700
Subject: [PATCH] platform/x86/intel-uncore-freq: Return error on write
 frequency
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently when the uncore_write() returns error, it is silently
ignored. Return error to user space when uncore_write() fails.

Fixes: 49a474c7ba51 ("platform/x86: Add support for Uncore frequency control")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230418153230.679094-1-srinivas.pandruvada@linux.intel.com
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 1a300e14f350..064f186ae81b 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 				      int min_max)
 {
 	unsigned int input;
+	int ret;
 
 	if (kstrtouint(buf, 10, &input))
 		return -EINVAL;
 
 	mutex_lock(&uncore_lock);
-	uncore_write(data, input, min_max);
+	ret = uncore_write(data, input, min_max);
 	mutex_unlock(&uncore_lock);
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 

