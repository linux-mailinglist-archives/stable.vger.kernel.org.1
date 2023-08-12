Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC577A11A
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHLQg4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHLQgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 12:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECBB1702
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3AA61042
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 16:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DDC433C8;
        Sat, 12 Aug 2023 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691858217;
        bh=7iW1frDaCmPzZivOCoT5FYki9o/bXMLG06H6YM/6BNg=;
        h=Subject:To:Cc:From:Date:From;
        b=ZHMgL/ma7C3KqBosvbF7jJkhDsGnX6945mjDP20KLkJMlsUKNHHAPsMobkY81oYXZ
         xr51kPT3DCNQHKNGAIQFY55FQ8H0vBW5+z2c34MPAth5fweu8aim1NgN5Huo+N6QYV
         2wjnDnHOpmGzmMC30mQc0dlS5q/17GUJu4EihlMc=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix Thunderbolt 3 display flickering issue on" failed to apply to 5.15-stable tree
To:     sanju.mehta@amd.com, Sanath.S@amd.com,
        mika.westerberg@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 18:36:50 +0200
Message-ID: <2023081250-headphone-efficient-efb9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 583893a66d731f5da010a3fa38a0460e05f0149b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081250-headphone-efficient-efb9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 583893a66d731f5da010a3fa38a0460e05f0149b Mon Sep 17 00:00:00 2001
From: Sanjay R Mehta <sanju.mehta@amd.com>
Date: Wed, 2 Aug 2023 06:11:49 -0500
Subject: [PATCH] thunderbolt: Fix Thunderbolt 3 display flickering issue on
 2nd hot plug onwards

Previously, on unplug events, the TMU mode was disabled first
followed by the Time Synchronization Handshake, irrespective of
whether the tb_switch_tmu_rate_write() API was successful or not.

However, this caused a problem with Thunderbolt 3 (TBT3)
devices, as the TSPacketInterval bits were always enabled by default,
leading the host router to assume that the device router's TMU was
already enabled and preventing it from initiating the Time
Synchronization Handshake. As a result, TBT3 monitors experienced
display flickering from the second hot plug onwards.

To address this issue, we have modified the code to only disable the
Time Synchronization Handshake during TMU disable if the
tb_switch_tmu_rate_write() function is successful. This ensures that
the TBT3 devices function correctly and eliminates the display
flickering issue.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 1269f417515b..0dfd1e083994 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -579,7 +579,9 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
 		 * uni-directional mode and we don't want to change it's TMU
 		 * mode.
 		 */
-		tb_switch_tmu_rate_write(sw, tmu_rates[TB_SWITCH_TMU_MODE_OFF]);
+		ret = tb_switch_tmu_rate_write(sw, tmu_rates[TB_SWITCH_TMU_MODE_OFF]);
+		if (ret)
+			return ret;
 
 		tb_port_tmu_time_sync_disable(up);
 		ret = tb_port_tmu_time_sync_disable(down);

