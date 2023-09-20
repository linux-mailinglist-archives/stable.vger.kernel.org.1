Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FA7A7C4A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjITMAJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjITL7v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:59:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8EB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B00AC433C7;
        Wed, 20 Sep 2023 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211184;
        bh=bIcbV5nz8naQsFgfXMvPb2I8luJyhmVTAjStu3BuN0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFla+xWX0eHN/Frawll9PsnHFWRynXOAMQr8+meNW3sZYVxYaOpAGgcozQDcIOwt7
         7z/AAtJRAN09fvJArIZCSidNGfy+9FG5gikxnrYhKS4Co1pkGqXO7Brni5yUJwCmnZ
         Mt/oAgjrPR6FzF4UUWW1gP80SJW5HNBL9HwSPDgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A1udio=20Sampaio?= <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.1 114/139] nvme: avoid bogus CRTO values
Date:   Wed, 20 Sep 2023 13:30:48 +0200
Message-ID: <20230920112839.812803999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Keith Busch <kbusch@kernel.org>

commit 6cc834ba62998c65c42d0c63499bdd35067151ec upstream.

Some devices are reporting controller ready mode support, but return 0
for CRTO. These devices require a much higher time to ready than that,
so they are failing to initialize after the driver starter preferring
that value over CAP.TO.

The spec requires that CAP.TO match the appropritate CRTO value, or be
set to 0xff if CRTO is larger than that. This means that CAP.TO can be
used to validate if CRTO is reliable, and provides an appropriate
fallback for setting the timeout value if not. Use whichever is larger.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217863
Reported-by: Cláudio Sampaio <patola@gmail.com>
Reported-by: Felix Yan <felixonmars@archlinux.org>
Tested-by: Felix Yan <felixonmars@archlinux.org>
Based-on-a-patch-by: Felix Yan <felixonmars@archlinux.org>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |   54 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 19 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2368,25 +2368,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *c
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |= NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2400,6 +2383,39 @@ int nvme_enable_ctrl(struct nvme_ctrl *c
 	if (ret)
 		return ret;
 
+	/* CAP value may change after initial CC write */
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto, ready_timeout;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			ready_timeout = NVME_CRTO_CRIMT(crto);
+		else
+			ready_timeout = NVME_CRTO_CRWMT(crto);
+
+		if (ready_timeout < timeout)
+			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
+				      crto, ctrl->cap);
+		else
+			timeout = ready_timeout;
+	}
+
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)


