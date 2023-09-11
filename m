Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36D79AD7A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378888AbjIKWhu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbjIKObe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:31:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ABEF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:31:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA74BC433C8;
        Mon, 11 Sep 2023 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442690;
        bh=yUQicCfDfnEWFoThZwdncEdYqqm3pXLv3oDheTvw24c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=it6AXG+IT/DgZY4XY1vggcVpDWpx+YnqGtIhRDfhtHi3jDOM2l2Hx+5NtWMS0zBra
         DfzL86hunAkctHv29Hy5nYkpPJmrpjShG7u8iv99vQKKkiwLXWvC38ZaLRPRkkHSbu
         rc7AZqzfGnkmAx2hSBRE8ySCugKwpwfFcyRmPUFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 113/737] OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
Date:   Mon, 11 Sep 2023 15:39:32 +0200
Message-ID: <20230911134653.661673512@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit d920920f85a82c1c806a4143871a0e8f534732f2 ]

If dev_pm_domain_attach_by_name() returns NULL, then 0 will be passed to
PTR_ERR() as reported by the smatch warning below:

drivers/opp/core.c:2456 _opp_attach_genpd() warn: passing zero to 'PTR_ERR'

Fix it by checking for the non-NULL virt_dev pointer before passing it to
PTR_ERR. Otherwise return -ENODEV.

Fixes: 4ea9496cbc95 ("opp: Fix error check in dev_pm_opp_attach_genpd()")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b5973fefdfd83..75b43c6c7031c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2382,7 +2382,7 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = PTR_ERR(virt_dev) ? : -ENODEV;
+			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
-- 
2.40.1



