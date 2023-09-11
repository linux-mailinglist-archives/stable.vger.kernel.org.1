Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2322E79B3C7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbjIKVku (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbjIKPHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B00FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D1CC433C9;
        Mon, 11 Sep 2023 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444867;
        bh=ACQcNbWpflEesWC5DgfH1wCQkb69Vixc9UhpEFQZaH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOPLJhD0FrIvAVQrmvkMICqKHwfBCiuRWqbn+vap3kdL5g5+pkLi6hY/5xQB4pb0E
         AyzVMSTSshixPEgIji5bHkf1okrsi4cF40w8ZZlB8+mzmrn1bDPAhYig88wGs5cXBP
         cBhSnHxWax3TSbE0JGpAE4B+3+JXO5/luz/MfNBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 144/600] crypto: qat - change value of default idle filter
Date:   Mon, 11 Sep 2023 15:42:57 +0200
Message-ID: <20230911134637.857663926@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 0f942bdfe9d463be3073301519492f8d53c6b2d5 ]

The power management configuration of 4xxx devices is too aggressive
and in some conditions the device might be prematurely put to a low
power state.
Increase the idle filter value to prevent that.
In future, this will be set by firmware.

Fixes: e5745f34113b ("crypto: qat - enable power management for QAT GEN4")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_gen4_pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/qat/qat_common/adf_gen4_pm.h
index f8f8a9ee29e5b..db4326933d1c0 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_pm.h
+++ b/drivers/crypto/qat/qat_common/adf_gen4_pm.h
@@ -35,7 +35,7 @@
 #define ADF_GEN4_PM_MSG_PENDING			BIT(0)
 #define ADF_GEN4_PM_MSG_PAYLOAD_BIT_MASK	GENMASK(28, 1)
 
-#define ADF_GEN4_PM_DEFAULT_IDLE_FILTER		(0x0)
+#define ADF_GEN4_PM_DEFAULT_IDLE_FILTER		(0x6)
 #define ADF_GEN4_PM_MAX_IDLE_FILTER		(0x7)
 
 int adf_gen4_enable_pm(struct adf_accel_dev *accel_dev);
-- 
2.40.1



