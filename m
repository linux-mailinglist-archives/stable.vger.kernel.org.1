Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40F7ED0AC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjKOT47 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbjKOT4s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E791B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C19CC433CA;
        Wed, 15 Nov 2023 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078203;
        bh=6/Ncy7rQLI88tm1V5K5OmsAPZVpmN6WvZ2L+TX2RshM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/obbxj3ft2E+6/Z5Z5GZ25r/+eB2QAANSrTTc+5iSzg6c5i76wY8pFQAkgeHeS/E
         NS1YKR+6/yKBge0PVVfvwYp/4dguHugshNluEw6h6WpNaSEsq4yWeEIYuB1xNd8r1A
         FFrlfD8e0xc9y6Xck8L5i75lxpkbe/2p1NsHgZ6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/379] firmware: arm_ffa: Allow the FF-A drivers to use 32bit mode of messaging
Date:   Wed, 15 Nov 2023 14:24:11 -0500
Message-ID: <20231115192655.525784767@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 2d698e8b4fd22374dac0a2d5150ab24d57a222ab ]

An FF-A ABI could support both the SMC32 and SMC64 conventions.
A callee that runs in the AArch64 execution state and implements such
an ABI must implement both SMC32 and SMC64 conventions of the ABI.

So the FF-A drivers will need the option to choose the mode irrespective
of FF-A version and the partition execution mode flag in the partition
information.

Let us remove the check on the FF-A version for allowing the selection
of 32bit mode of messaging. The driver will continue to set the 32-bit
mode if the partition execution mode flag specified that the partition
supports only 32-bit execution.

Fixes: 106b11b1ccd5 ("firmware: arm_ffa: Set up 32bit execution mode flag using partiion property")
Link: https://lore.kernel.org/r/20231005142823.278121-1-sudeep.holla@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 21481fc05800f..e9f86b7573012 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -668,17 +668,9 @@ static int ffa_partition_info_get(const char *uuid_str,
 	return 0;
 }
 
-static void _ffa_mode_32bit_set(struct ffa_device *dev)
-{
-	dev->mode_32bit = true;
-}
-
 static void ffa_mode_32bit_set(struct ffa_device *dev)
 {
-	if (drv_info->version > FFA_VERSION_1_0)
-		return;
-
-	_ffa_mode_32bit_set(dev);
+	dev->mode_32bit = true;
 }
 
 static int ffa_sync_send_receive(struct ffa_device *dev,
@@ -787,7 +779,7 @@ static void ffa_setup_partitions(void)
 
 		if (drv_info->version > FFA_VERSION_1_0 &&
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
-			_ffa_mode_32bit_set(ffa_dev);
+			ffa_mode_32bit_set(ffa_dev);
 	}
 	kfree(pbuf);
 }
-- 
2.42.0



