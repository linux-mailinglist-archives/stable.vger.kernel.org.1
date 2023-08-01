Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF976AF73
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjHAJrg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjHAJrS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072832706
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C49614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8BBC433C8;
        Tue,  1 Aug 2023 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883149;
        bh=jwfB92qjYPQYhwAGu4V09nVlFbDk+S5HKLIPKs935BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ag/zlnI484Tm6QIQuVNlp+V1U73VI0tDaIzRanPaEmfS8ZaqQql8p1lUGBxUkNXlD
         CGzty9zFViXjvsaz9gFbAf+ByIguO8r6SpbOi1Rh4Fk7h99BAEpUVfAZ6W5NZgqEiB
         7bKy0do7n55d/yuljWfJBmkt//Bs6kt2klTqbsQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 133/239] drm/msm: Disallow submit with fence id 0
Date:   Tue,  1 Aug 2023 11:19:57 +0200
Message-ID: <20230801091930.501352244@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 1b5d0ddcb34a605835051ae2950d5cfed0373dd8 ]

A fence id of zero is expected to be invalid, and is not removed from
the fence_idr table.  If userspace is requesting to specify the fence
id with the FENCE_SN_IN flag, we need to reject a zero fence id value.

Fixes: 17154addc5c1 ("drm/msm: Add MSM_SUBMIT_FENCE_SN_IN")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/549180/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 10cad7b99bac8..1bd78041b4d0d 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -902,7 +902,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 * after the job is armed
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
-			idr_find(&queue->fence_idr, args->fence)) {
+			(!args->fence || idr_find(&queue->fence_idr, args->fence))) {
 		spin_unlock(&queue->idr_lock);
 		idr_preload_end();
 		ret = -EINVAL;
-- 
2.40.1



