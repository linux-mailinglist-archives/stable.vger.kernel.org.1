Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9177ECF03
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjKOTpr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjKOTpp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291DB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A96C433C8;
        Wed, 15 Nov 2023 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077541;
        bh=5usueZtFGQzVvtTkanJY+fkeJjzt87NPQg3jJ6JYlNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+XmNMOmr/DYlWID+9UgVbjIzsDE69Z4hcq4vP/wbcuIbJOrGXvffv8bHYMzXP5D3
         yuycrfpArvW1Akf0Ke77LmRQVM+2cI6bmolP5wmWkXbHMXHIfjSoyNp5gpWg28rkFx
         ONX6ayWHu87E1oQmr0Q55d60IukLDI4K9ZRMFrn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 348/603] crypto: qat - ignore subsequent state up commands
Date:   Wed, 15 Nov 2023 14:14:53 -0500
Message-ID: <20231115191637.611127924@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 9c20cb8b1847dedddec3d5163079290542bf00bf ]

If the device is already in the up state, a subsequent write of `up` to
the sysfs attribute /sys/bus/pci/devices/<BDF>/qat/state brings the
device down.
Fix this behaviour by ignoring subsequent `up` commands if the device is
already in the up state.

Fixes: 1bdc85550a2b ("crypto: qat - fix concurrency issue when device state changes")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
index a8f33558d7cb8..8880af1aa1b5b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
@@ -68,7 +68,9 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 		dev_info(dev, "Starting device qat_dev%d\n", accel_id);
 
 		ret = adf_dev_up(accel_dev, true);
-		if (ret < 0) {
+		if (ret == -EALREADY) {
+			break;
+		} else if (ret) {
 			dev_err(dev, "Failed to start device qat_dev%d\n",
 				accel_id);
 			adf_dev_down(accel_dev, true);
-- 
2.42.0



