Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8699279BB04
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357930AbjIKWG5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbjIKOUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C2DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D5C433C7;
        Mon, 11 Sep 2023 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442028;
        bh=P56UyPXfOzf/tga5WFnLhN1jdcKv3jpDKsuxRYiN59U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6P/FqPIvxNTPx/cJdS6oQrF6VM48H9xs/rgMRW/TVgpGpZiv4F+0H6J4CO428CUS
         nJFPMV+dtq7mbpoH+z6pHqwr8jxH8OjNNl5dxQi8e3CouiF4iAFlgh1zSk78RtVxtO
         cZwvk0HbaplI1R36pUPHZBXrTbIPO+eR/npJDVz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 621/739] dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported
Date:   Mon, 11 Sep 2023 15:47:00 +0200
Message-ID: <20230911134708.444437050@linuxfoundation.org>
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

From: Fenghua Yu <fenghua.yu@intel.com>

[ Upstream commit 62b41b656666d2d35890124df5ef0881fe6d6769 ]

WQ Advanced Translation Service (ATS) can be controlled only when
WQ ATS is supported. The sysfs ATS disable knob should be visible only
when the features is supported.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230712174436.3435088-2-fenghua.yu@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 0056a7f07b0a ("dmaengine: idxd: Allow ATS disable update only for configurable devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 36a30957ac9a3..d16c16445c4f9 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1088,16 +1088,12 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 				    const char *buf, size_t count)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
-	struct idxd_device *idxd = wq->idxd;
 	bool ats_dis;
 	int rc;
 
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	if (!idxd->hw.wq_cap.wq_ats_support)
-		return -EOPNOTSUPP;
-
 	rc = kstrtobool(buf, &ats_dis);
 	if (rc < 0)
 		return rc;
@@ -1316,6 +1312,9 @@ static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 	if (idxd_wq_attr_invisible(prs_disable, wq_prs_support, attr, idxd))
 		return 0;
 
+	if (idxd_wq_attr_invisible(ats_disable, wq_ats_support, attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.40.1



