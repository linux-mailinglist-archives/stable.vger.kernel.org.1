Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8EA76AE4A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHAJhi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjHAJhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028DE1996
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4406614BB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0A8C433C7;
        Tue,  1 Aug 2023 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882533;
        bh=DTZ+jtHu4mkVkPZ+cVIMVh8PNe3TLQQjUkrCTd5wMgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTPp+ottBS2kXdlCQc452Xzz4Eg3XvHRaOdo3ayXtbML1o+iHQtHPcE34KmwzSe1J
         Tkj2geuDvJ6+TZiZRYNQJIyfCypWzDPGgv5Q2jgrYctS8GUkq1HaLjoFsuf+iBbwri
         X3ZSr18xXq9wN4m/LYkpQj53whawI1FhmjoaHLYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/228] drm/msm: Disallow submit with fence id 0
Date:   Tue,  1 Aug 2023 11:19:57 +0200
Message-ID: <20230801091927.874454972@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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
index 5668860f01827..c12a6ac2d3840 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -875,7 +875,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 * after the job is armed
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
-			idr_find(&queue->fence_idr, args->fence)) {
+			(!args->fence || idr_find(&queue->fence_idr, args->fence))) {
 		spin_unlock(&queue->idr_lock);
 		ret = -EINVAL;
 		goto out;
-- 
2.40.1



