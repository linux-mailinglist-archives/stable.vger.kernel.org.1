Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643F57E2324
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjKFNJO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjKFNJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:09:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A009BD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:09:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB29C433C7;
        Mon,  6 Nov 2023 13:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276151;
        bh=uYgzN7rnCE5cfvQ3nqE5W7LjkUHQfalbsYUBonJvzU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6DzIONT0aVi21qeyvH/IJlb+BosdpzrtW2BX8Ah5C049WAwk8gdzw9kFQPFz6O8L
         WfqLr9cG85Ho9YPyy4Y4JUZMFotdEEZG5QgRFjYOQF2QqP1QJmhmEjlBi1Ex/Yes4k
         +OdTFk10zur8OlQopiEgo2jppS3mtF+j46PLNLlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aric Cyr <aric.cyr@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 01/30] drm/amd/display: Dont use fsleep for PSR exit waits
Date:   Mon,  6 Nov 2023 14:03:19 +0100
Message-ID: <20231106130257.961606006@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 79df45dc4bfb13d9bd3a75338b9d9dab948be3d6 ]

[Why]
These functions can be called from high IRQ levels and the OS will hang
if it tries to use a usleep_highres or a msleep.

[How]
Replace the fsleep with a udelay.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index b87bfecb7755a..a8e79104b684e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -586,7 +586,8 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 				if (state == PSR_STATE0)
 					break;
 			}
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0f24b6fbd2201..4704c9c85ee6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -216,7 +216,8 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8
 					break;
 			}
 
-			fsleep(500);
+			/* must *not* be fsleep - this can be called from high irq levels */
+			udelay(500);
 		}
 
 		/* assert if max retry hit */
-- 
2.42.0



