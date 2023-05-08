Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7369C6FA47C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjEHKAA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjEHJ77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E382D414
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0C0622A6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B050DC433D2;
        Mon,  8 May 2023 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539997;
        bh=DU6V6TijueeXw5Bbs7En6EjH8Vcz67aqmz3VEVKcrHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+dhR3FM6U3bdmI6b1lwB5mUw9uNsxuT+4hYpAnTIpNWEj5WfptFVJHvmfWyn+Q2r
         Shof68FjlsVwXxCiN2UyZvtR2Xg3an7wsZUpqIvREpKL2jJOpZGGxnpaDw+0mAM60O
         yMRAr/+aHW2Umt0iCQCqmKAH2BicvG7rV+kP4aic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhaoyang Li <lizhaoyang04@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 204/611] soc: bcm: brcmstb: biuctrl: fix of_iomap leak
Date:   Mon,  8 May 2023 11:40:46 +0200
Message-Id: <20230508094429.007624968@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhaoyang Li <lizhaoyang04@hust.edu.cn>

[ Upstream commit c3fbced9af885a6f217fd95509a613d6590916ce ]

Smatch reports:

drivers/soc/bcm/brcmstb/biuctrl.c:291 setup_hifcpubiuctrl_regs() warn:
'cpubiuctrl_base' from of_iomap() not released on lines: 291.

This is because in setup_hifcpubiuctrl_regs(),
cpubiuctrl_base is not released when handle error, which may cause a leak.
To fix this, iounmap is added when handle error.

Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
Signed-off-by: Zhaoyang Li <lizhaoyang04@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230327115422.1536615-1-lizhaoyang04@hust.edu.cn
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index e1d7b45432485..364ddbe365c24 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -288,6 +288,10 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	if (BRCM_ID(family_id) == 0x7260 && BRCM_REV(family_id) == 0)
 		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
 out:
+	if (ret && cpubiuctrl_base) {
+		iounmap(cpubiuctrl_base);
+		cpubiuctrl_base = NULL;
+	}
 	return ret;
 }
 
-- 
2.39.2



