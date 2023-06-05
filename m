Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED5B723074
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjFETxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjFETxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 15:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEACD9
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 12:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9011460F5A
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 19:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7434C433EF;
        Mon,  5 Jun 2023 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685994735;
        bh=jpDl9bKbdX5FB/pbb3we1SqSdJGh1AALeW3UPcZJhaw=;
        h=Subject:To:Cc:From:Date:From;
        b=cgMLWYHEUC/KMvQlj34Bh5ZkQyM56UV9C0e4rz7T1XQC7hpbogDAeiDLDtlfqIs4l
         lQ/sYBPmTFX1w9uKG3FLsDyMs8PTifLQonByfAQiXNG3PcbTjLxdAFb8mWeiMHF4Yv
         M9LxgaGDVTRrG32WzLRxy49k64Ectv5ReD5Q09Dk=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-combo: fix init-count imbalance" failed to apply to 5.10-stable tree
To:     johan+linaro@kernel.org, dmitry.baryshkov@linaro.org,
        vkoul@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 21:52:10 +0200
Message-ID: <2023060510-gains-hungry-0aed@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9bf03a0cbd80a256bc1e1c4bcc80bc2b06b8b2b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060510-gains-hungry-0aed@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9bf03a0cbd80 ("phy: qcom-qmp-combo: fix init-count imbalance")
94a407cc17a4 ("phy: qcom-qmp: create copies of QMP PHY driver")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bf03a0cbd80a256bc1e1c4bcc80bc2b06b8b2b9 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 2 May 2023 12:38:09 +0200
Subject: [PATCH] phy: qcom-qmp-combo: fix init-count imbalance

The init counter is not decremented on initialisation errors, which
prevents retrying initialisation and can lead to the runtime suspend
callback attempting to disable resources that have never been enabled.

Add the missing decrement on initialisation errors so that the counter
reflects the state of the device.

Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
Cc: stable@vger.kernel.org	# 4.12
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230502103810.12061-2-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 6850e04c329b..87b17e5877ab 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2472,7 +2472,7 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
-		goto err_unlock;
+		goto err_decrement_count;
 	}
 
 	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
@@ -2522,7 +2522,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
-err_unlock:
+err_decrement_count:
+	qmp->init_count--;
 	mutex_unlock(&qmp->phy_mutex);
 
 	return ret;

