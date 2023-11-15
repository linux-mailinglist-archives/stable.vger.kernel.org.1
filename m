Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534117ED37A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjKOUw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjKOUw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CBB0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:52:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED32EC4E778;
        Wed, 15 Nov 2023 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081572;
        bh=rZJSGmXrGi4SHysY7E/D/j6nymm44PG0kOHIhELP2eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/SBlcH2OiSNJBX0hD2EwRoYbbpxrVqG+mv4DXNzFNLIOcew+Bj0lW9mTr7Gnbleg
         8LfiJeQBV8lMDD0m/3L2EOF9s5Su+0psbfdsbJYVT1yeomThk6WH7kw6YhdTVTH3Gx
         zMQGmEZGeqQliIK/Nh96Hp1OefFrPVads1v4hdo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Erik Kurzinger <ekurzinger@nvidia.com>,
        Simon Ser <contact@emersion.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 236/244] drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE
Date:   Wed, 15 Nov 2023 15:37:08 -0500
Message-ID: <20231115203602.496373904@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Kurzinger <ekurzinger@nvidia.com>

[ Upstream commit 101c9f637efa1655f55876644d4439e552267527 ]

If DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT is invoked with the
DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE flag set but no fence has yet been
submitted for the given timeline point the call will fail immediately
with EINVAL. This does not match the intended behavior where the call
should wait until the fence has been submitted (or the timeout expires).

The following small example program illustrates the issue. It should
wait for 5 seconds and then print ETIME, but instead it terminates right
away after printing EINVAL.

  #include <stdio.h>
  #include <fcntl.h>
  #include <time.h>
  #include <errno.h>
  #include <xf86drm.h>
  int main(void)
  {
      int fd = open("/dev/dri/card0", O_RDWR);
      uint32_t syncobj;
      drmSyncobjCreate(fd, 0, &syncobj);
      struct timespec ts;
      clock_gettime(CLOCK_MONOTONIC, &ts);
      uint64_t point = 1;
      if (drmSyncobjTimelineWait(fd, &syncobj, &point, 1,
                                 ts.tv_sec * 1000000000 + ts.tv_nsec + 5000000000, // 5s
                                 DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE, NULL)) {
          printf("drmSyncobjTimelineWait failed %d\n", errno);
      }
  }

Fixes: 01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
Signed-off-by: Erik Kurzinger <ekurzinger@nvidia.com>
Reviewed by: Simon Ser <contact@emersion.fd>
Signed-off-by: Simon Ser <contact@emersion.fr>
Link: https://patchwork.freedesktop.org/patch/msgid/1fac96f1-2f3f-f9f9-4eb0-340f27a8f6c0@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_syncobj.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7e48dcd1bee4d..c26f916996352 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1056,7 +1056,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		fence = drm_syncobj_fence_get(syncobjs[i]);
 		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
 			dma_fence_put(fence);
-			if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 				continue;
 			} else {
 				timeout = -EINVAL;
-- 
2.42.0



