Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B07ECC57
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjKOT3q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjKOT3p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:29:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3BA1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:29:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B97C433CA;
        Wed, 15 Nov 2023 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076581;
        bh=vZqNOe8gOplY7Xd9E5LYGMIm5oXzfrv44JR9xCctvDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrXmFsLHqKPH8ytJYtYNeSvAo0+odKOJgr78IIzcmK93KjHpwI+84m2BFypES7bke
         cRnnE9OwsSWF0k9cF7NzV7y/FrgziwD2f3STH9Jv6l0hcWw+XuyC14ONen+Uu3kPNf
         WTpuPH3CSTvbvu+iFCdMj3PwatsSwBTVRc6D43Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 319/550] crypto: qat - fix unregistration of compression algorithms
Date:   Wed, 15 Nov 2023 14:15:03 -0500
Message-ID: <20231115191622.881328405@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 11af152f784d9eca54e193140891ac52de36e9a9 ]

The function adf_dev_init(), through the subsystem qat_compression,
populates the list of list of compression instances
accel_dev->compression_list. If the list of instances is not empty,
the function adf_dev_start() will then call qat_compression_registers()
register the compression algorithms into the crypto framework.

If any of the functions in adf_dev_start() fail, the caller of such
function, in the error path calls adf_dev_down() which in turn call
adf_dev_stop() and adf_dev_shutdown(), see for example the function
state_store in adf_sriov.c.
However, if the registration of compression algorithms is not done,
adf_dev_stop() will try to unregister the algorithms regardless.
This might cause the counter active_devs in qat_compression.c to get
to a negative value.

Add a new state, ADF_STATUS_COMPRESSION_ALGS_REGISTERED, which tracks
if the compression algorithms are registered into the crypto framework.
Then use this to unregister the algorithms if such flag is set. This
ensures that the compression algorithms are only unregistered if
previously registered.

Fixes: 1198ae56c9a5 ("crypto: qat - expose deflate through acomp api for QAT GEN2")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h | 1 +
 drivers/crypto/intel/qat/qat_common/adf_init.c       | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 7d3d67285ff8a..0af8606eac5b2 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -26,6 +26,7 @@
 #define ADF_STATUS_PF_RUNNING 7
 #define ADF_STATUS_IRQ_ALLOCATED 8
 #define ADF_STATUS_CRYPTO_ALGS_REGISTERED 9
+#define ADF_STATUS_COMP_ALGS_REGISTERED 10
 
 enum adf_dev_reset_mode {
 	ADF_DEV_RESET_ASYNC = 0,
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index e4b823d21c505..67bdbee584991 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -218,6 +218,7 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 		clear_bit(ADF_STATUS_STARTED, &accel_dev->status);
 		return -EFAULT;
 	}
+	set_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status);
 
 	adf_dbgfs_add(accel_dev);
 
@@ -257,8 +258,10 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 	}
 	clear_bit(ADF_STATUS_CRYPTO_ALGS_REGISTERED, &accel_dev->status);
 
-	if (!list_empty(&accel_dev->compression_list))
+	if (!list_empty(&accel_dev->compression_list) &&
+	    test_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status))
 		qat_comp_algs_unregister();
+	clear_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status);
 
 	list_for_each(list_itr, &service_table) {
 		service = list_entry(list_itr, struct service_hndl, list);
-- 
2.42.0



