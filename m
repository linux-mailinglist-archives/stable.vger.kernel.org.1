Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624479B3B4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbjIKVLc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjIKPBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9972125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F256FC433C8;
        Mon, 11 Sep 2023 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444487;
        bh=uFsgvhJkcIYIYQNXv240upZOuxgxfTOJgBrjPu/A+bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoN9sUTn+d6McsFjRojfrxCe2uDAHhK73pvX6b5eO8LQFJN88i4yWyIQgmdLaas4t
         jmMPqnFMfutsjzGMk2buSgokNtCetxX1CHwcMfOJmNJANhQCBE3RU3MoUMcNy3pf8l
         OOWywDNaZ6zZQM4OZFDtV8WvFbHpzBYlvekCbPqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 010/600] phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code
Date:   Mon, 11 Sep 2023 15:40:43 +0200
Message-ID: <20230911134633.921993234@linuxfoundation.org>
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

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit 8932089b566c24ea19b57e37704c492678de1420 ]

The return value from qcom_snps_hsphy_suspend/resume is not used. Make
sure qcom_snps_hsphy_runtime_suspend/resume return this value as well.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
Link: https://lore.kernel.org/r/20230629144542.14906-4-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 6170f8fd118e2..d0319bee01c0f 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -214,8 +214,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_suspend(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_suspend(hsphy);
-	return 0;
+	return qcom_snps_hsphy_suspend(hsphy);
 }
 
 static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
@@ -225,8 +224,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_resume(hsphy);
-	return 0;
+	return qcom_snps_hsphy_resume(hsphy);
 }
 
 static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
-- 
2.40.1



