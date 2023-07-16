Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53D75538F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGPUUW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGPUUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A0C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C43F60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89320C433C8;
        Sun, 16 Jul 2023 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538819;
        bh=LdX+6C3Khum77eOyiuj49RS0uXEHIXsSFiAOhcaG6vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdhzJYCZTfKr/s0rgF7jQFdAtjSheR7qF9cpM95zT1Guxs5bJj/mHeB/eYWxHriAf
         vhreZY5EQfxAxanVx3Dz2nCiTAPhbwJoCzDLTftrfucnGqqzxF43JzRDhCShUPIRTl
         x5ZyV6kmFpEDpcxw56hYAlhtO6a6BMmgSIXVDmz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 587/800] soundwire: debugfs: fix unbalanced pm_runtime_put()
Date:   Sun, 16 Jul 2023 21:47:20 +0200
Message-ID: <20230716195002.733961503@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 217f5e0de397fafc94d25a8f7baf71920bea4a04 ]

If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
execution and finally called pm_runtime_put_autosuspend().  Since
pm_runtime_resume_and_get() drops the usage counter on every error, this
lead to double decrement of that counter.

Fixes: b275bf45ba1d ("soundwire: debugfs: Switch to sdw_read_no_pm")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230517163750.997629-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index dea782e0edc4b..c3a1a359ee5c3 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -56,8 +56,9 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		kfree(buf);
 		return ret;
 	}
-- 
2.39.2



