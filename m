Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA979AED7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjIKVOn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbjIKN5c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152BCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0DC433C7;
        Mon, 11 Sep 2023 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440647;
        bh=rNy+Pite8bb3hRMkLlH4K1oWTfaGm5oNM/37R0qeLpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T97cVLTuzDaNJg0O2qQq743Ne2zsdgMk7NEKvUrgvEytA82GOObdcujtaATwq1yXr
         YW0yev37l9WUt+mveY79zOmfxH3vYOb5Scc4TFVdrxmgRa7NtW8uGEdt0uT2baDyN6
         7ZC7NMwCy5P/KfWG5XHQF1Jly87fjTCDDhdIXljI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 108/739] power: supply: qcom_pmi8998_charger: fix uninitialized variable
Date:   Mon, 11 Sep 2023 15:38:27 +0200
Message-ID: <20230911134654.115614313@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Liao <liaoyu15@huawei.com>

[ Upstream commit 13a0d1088c8fea1565e30a169188b59bdd77759e ]

smatch warnings:
  drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.

usb_online is used uninitialized whenever smb2_get_prop_usb_online()
returns a negative value.

Thus, fix the issue by initializing usb_online to 0.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202307280638.556PrzIS-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org
Link: https://lore.kernel.org/r/20230802023130.2516232-1-liaoyu15@huawei.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index d16c5ee172496..cac89d233c388 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -556,7 +556,8 @@ static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
 static void smb2_status_change_work(struct work_struct *work)
 {
 	unsigned int charger_type, current_ua;
-	int usb_online, count, rc;
+	int usb_online = 0;
+	int count, rc;
 	struct smb2_chip *chip;
 
 	chip = container_of(work, struct smb2_chip, status_change_work.work);
-- 
2.40.1



