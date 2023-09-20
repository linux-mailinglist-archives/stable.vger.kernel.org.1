Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26C7A810C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjITMmR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjITMmQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:42:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E183
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:42:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5544C433C8;
        Wed, 20 Sep 2023 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213730;
        bh=vOA7ub+z3c2wn9GEL08SGu5s8FsY4D6YpHdIS25jPOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJfy/NpRK0VqYak1ZtTP71HkAZ6Y4GEsmoOGl98gnoL7Kb/o1FZyIgSuyzv4jyols
         EU/LscOUt28FZV0+nB46ypCXNm/BsS28Ts92uQC8lZQ5CVt89YvQdBcupkmaOLpAEo
         eWfyDxGFbIawvB5PmI0d6ujkyVva9FrgiOfIYvZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 344/367] media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning
Date:   Wed, 20 Sep 2023 13:32:01 +0200
Message-ID: <20230920112907.409020458@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 9d7531be3085a8f013cf173ccc4e72e3cf493538 ]

Initialise timing struct in cio2_hw_init() to zero in order to avoid a
compiler warning. The warning was a false positive.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 3457f0f545c48..9c0d117e093b1 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -359,7 +359,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
-- 
2.40.1



