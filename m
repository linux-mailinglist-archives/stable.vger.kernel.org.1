Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6757ECF07
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjKOTpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjKOTpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4D1B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F95C433C8;
        Wed, 15 Nov 2023 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077548;
        bh=/FqpEpsKxq6NfIbLo65JZvKXkMc6HH4QZi2wS7mR3/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYxebBCGB3/ITQppgdBAVTc//3VjDQHbXIyLlpchLiISrEJhJMIyXoXfKOElPM88G
         VGx7Q7Jd0+q3bEXO1yhxqW69o0cF1QVaTQPPH3yRQ8d1UwLbcuyF73wBGhxiDM6YPB
         0by6MG8NgZ0LSxnYJC4xeKuBMEbI7UWpD82VSkbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 349/603] crypto: qat - fix unregistration of crypto algorithms
Date:   Wed, 15 Nov 2023 14:14:54 -0500
Message-ID: <20231115191637.675535581@linuxfoundation.org>
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

[ Upstream commit 9b2f33a1bfcda90b857431a764c9c8f9a412bbe5 ]

The function adf_dev_init(), through the subsystem qat_crypto, populates
the list of list of crypto instances accel_dev->crypto_list.
If the list of instances is not empty, the function adf_dev_start() will
then call qat_algs_registers() and qat_asym_algs_register() to register
the crypto algorithms into the crypto framework.

If any of the functions in adf_dev_start() fail, the caller of such
function, in the error path calls adf_dev_down() which in turn call
adf_dev_stop() and adf_dev_shutdown(), see for example the function
state_store in adf_sriov.c.
However, if the registration of crypto algorithms is not done,
adf_dev_stop() will try to unregister the algorithms regardless.
This might cause the counter active_devs in qat_algs.c and
qat_asym_algs.c to get to a negative value.

Add a new state, ADF_STATUS_CRYPTO_ALGS_REGISTERED, which tracks if the
crypto algorithms are registered into the crypto framework. Then use
this to unregister the algorithms if such flag is set. This ensures that
the crypto algorithms are only unregistered if previously registered.

Fixes: d8cba25d2c68 ("crypto: qat - Intel(R) QAT driver framework")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h | 1 +
 drivers/crypto/intel/qat/qat_common/adf_init.c       | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 673b5044c62a5..ed640cb37616b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -25,6 +25,7 @@
 #define ADF_STATUS_AE_STARTED 6
 #define ADF_STATUS_PF_RUNNING 7
 #define ADF_STATUS_IRQ_ALLOCATED 8
+#define ADF_STATUS_CRYPTO_ALGS_REGISTERED 9
 
 enum adf_dev_reset_mode {
 	ADF_DEV_RESET_ASYNC = 0,
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index 35aef5e8fc386..ef8623f81fa33 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -231,6 +231,7 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 		clear_bit(ADF_STATUS_STARTED, &accel_dev->status);
 		return -EFAULT;
 	}
+	set_bit(ADF_STATUS_CRYPTO_ALGS_REGISTERED, &accel_dev->status);
 
 	if (!list_empty(&accel_dev->compression_list) && qat_comp_algs_register()) {
 		dev_err(&GET_DEV(accel_dev),
@@ -272,10 +273,12 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 	clear_bit(ADF_STATUS_STARTING, &accel_dev->status);
 	clear_bit(ADF_STATUS_STARTED, &accel_dev->status);
 
-	if (!list_empty(&accel_dev->crypto_list)) {
+	if (!list_empty(&accel_dev->crypto_list) &&
+	    test_bit(ADF_STATUS_CRYPTO_ALGS_REGISTERED, &accel_dev->status)) {
 		qat_algs_unregister();
 		qat_asym_algs_unregister();
 	}
+	clear_bit(ADF_STATUS_CRYPTO_ALGS_REGISTERED, &accel_dev->status);
 
 	if (!list_empty(&accel_dev->compression_list))
 		qat_comp_algs_unregister();
-- 
2.42.0



