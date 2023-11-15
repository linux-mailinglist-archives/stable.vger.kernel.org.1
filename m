Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96007ED478
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbjKOU6L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjKOU5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D91732
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CE7C4E66F;
        Wed, 15 Nov 2023 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081452;
        bh=JI1r07HKb0TDr8Ow4KZGgSJYr/hEMzubjh8xGMpp1P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEy7p5J3jcPtHUpdRAfx9DPxzWIyQhAgB24KGuagdl0FXLRNpm5pX/2qpko7c1gpl
         g8c+YHAh69DrMzkVnY7JPnY6G8GsfYCNoCuT7EUFvh4M8g0jSCGLafEieWxSuHzBoY
         /aOpvJHqTFUSIlo0F79nOK1qIEUCXENkhBcoA4O4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/244] crypto: qat - increase size of buffers
Date:   Wed, 15 Nov 2023 15:35:28 -0500
Message-ID: <20231115203556.516867920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 4e4e2ed22d505c5bacf65c6a39bfb6d120d24785 ]

Increase the size of the buffers used for composing the names used for
the transport debugfs entries and the vector name to avoid a potential
truncation.

This resolves the following errors when compiling the driver with W=1
and KCFLAGS=-Werror on GCC 12.3.1:

    drivers/crypto/intel/qat/qat_common/adf_transport_debug.c: In function ‘adf_ring_debugfs_add’:
    drivers/crypto/intel/qat/qat_common/adf_transport_debug.c:100:60: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
    drivers/crypto/intel/qat/qat_common/adf_isr.c: In function ‘adf_isr_resource_alloc’:
    drivers/crypto/intel/qat/qat_common/adf_isr.c:197:47: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 5 [-Werror=format-truncation=]

Fixes: a672a9dc872e ("crypto: qat - Intel(R) QAT transport code")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_accel_devices.h   | 2 +-
 drivers/crypto/qat/qat_common/adf_transport_debug.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 580566cfcb04c..3bb67b22edd6e 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -24,7 +24,7 @@
 #define ADF_PCI_MAX_BARS 3
 #define ADF_DEVICE_NAME_LENGTH 32
 #define ADF_ETR_MAX_RINGS_PER_BANK 16
-#define ADF_MAX_MSIX_VECTOR_NAME 16
+#define ADF_MAX_MSIX_VECTOR_NAME 48
 #define ADF_DEVICE_NAME_PREFIX "qat_"
 
 enum adf_accel_capabilities {
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index e69e5907f5950..006867f410bd3 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -90,7 +90,7 @@ DEFINE_SEQ_ATTRIBUTE(adf_ring_debug);
 int adf_ring_debugfs_add(struct adf_etr_ring_data *ring, const char *name)
 {
 	struct adf_etr_ring_debug_entry *ring_debug;
-	char entry_name[8];
+	char entry_name[16];
 
 	ring_debug = kzalloc(sizeof(*ring_debug), GFP_KERNEL);
 	if (!ring_debug)
@@ -192,7 +192,7 @@ int adf_bank_debugfs_add(struct adf_etr_bank_data *bank)
 {
 	struct adf_accel_dev *accel_dev = bank->accel_dev;
 	struct dentry *parent = accel_dev->transport->debug;
-	char name[8];
+	char name[16];
 
 	snprintf(name, sizeof(name), "bank_%02d", bank->bank_number);
 	bank->bank_debug_dir = debugfs_create_dir(name, parent);
-- 
2.42.0



