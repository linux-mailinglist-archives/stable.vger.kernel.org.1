Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056B79BD70
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjIKUvI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbjIKOeg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:34:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1539E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A1DC433C7;
        Mon, 11 Sep 2023 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442871;
        bh=LQzq85J6k7U7JDduhFkEQHb3A+46YwmCyC5m60Tis5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vex2SjTIkO9sIbrBq9TcFaYBFy5NpFasBGr4STFtR7B3CfNuOelHa8KYIjnX+X0P6
         DaH1R7AoD2FsnrJr3nOp/YcFDJ+QhVO9rhxbIyl+86c1j0CUhlHQ1mMRTOkNeR8RnR
         TKJFW2fob4WoTk6Rv9560d3RqYB735s/MQLk5Nu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 150/737] crypto: qat - change value of default idle filter
Date:   Mon, 11 Sep 2023 15:40:09 +0200
Message-ID: <20230911134654.676639303@linuxfoundation.org>
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
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
index f8f8a9ee29e5b..db4326933d1c0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
@@ -35,7 +35,7 @@
 #define ADF_GEN4_PM_MSG_PENDING			BIT(0)
 #define ADF_GEN4_PM_MSG_PAYLOAD_BIT_MASK	GENMASK(28, 1)
 
-#define ADF_GEN4_PM_DEFAULT_IDLE_FILTER		(0x0)
+#define ADF_GEN4_PM_DEFAULT_IDLE_FILTER		(0x6)
 #define ADF_GEN4_PM_MAX_IDLE_FILTER		(0x7)
 
 int adf_gen4_enable_pm(struct adf_accel_dev *accel_dev);
-- 
2.40.1



