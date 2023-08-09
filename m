Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A88775740
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHIKoB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjHIKn5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CA1BF2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5AC3630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDB1C433C9;
        Wed,  9 Aug 2023 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577836;
        bh=70iMD/RLSO8mNOULLpYpKy79TorPQ1CjsuicQaxDrOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mELL/agGXba8pAoK8boL99x2+vWf6EJVTiRyuJaQvm6z3N3AK6DVTJ5V0X+0ZWMta
         JoAraZtkjKAFytoibxxGXAkgBnGpoPAQMfBHgGqW2gDtlOJspfVpVKxT7W07hdEYnd
         cvcD4FTztN8HpXpnqkIS8aHkfd/uTlD0xQUDNFoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 012/165] firmware: smccc: Fix use of uninitialised results structure
Date:   Wed,  9 Aug 2023 12:39:03 +0200
Message-ID: <20230809103643.168074363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Punit Agrawal <punit.agrawal@bytedance.com>

[ Upstream commit d05799d7b4a39fa71c65aa277128ac7c843ffcdc ]

Commit 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum
T241-FABRIC-4") moved the initialisation of the SoC version to
arm_smccc_version_init() but forgot to update the results structure
and it's usage.

Fix the use of the uninitialised results structure and update the
error strings.

Fixes: 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4")
Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Vikram Sethi <vsethi@nvidia.com>
Cc: Shanker Donthineni <sdonthineni@nvidia.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230717171702.424253-1-punit.agrawal@bytedance.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/smccc/soc_id.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 890eb454599a3..1990263fbba0e 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -34,7 +34,6 @@ static struct soc_device_attribute *soc_dev_attr;
 
 static int __init smccc_soc_init(void)
 {
-	struct arm_smccc_res res;
 	int soc_id_rev, soc_id_version;
 	static char soc_id_str[20], soc_id_rev_str[12];
 	static char soc_id_jep106_id_str[12];
@@ -49,13 +48,13 @@ static int __init smccc_soc_init(void)
 	}
 
 	if (soc_id_version < 0) {
-		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
+		pr_err("Invalid SoC Version: %x\n", soc_id_version);
 		return -EINVAL;
 	}
 
 	soc_id_rev = arm_smccc_get_soc_id_revision();
 	if (soc_id_rev < 0) {
-		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
+		pr_err("Invalid SoC Revision: %x\n", soc_id_rev);
 		return -EINVAL;
 	}
 
-- 
2.40.1



