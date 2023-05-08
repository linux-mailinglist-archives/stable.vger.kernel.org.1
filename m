Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4C6FAD54
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjEHLdu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjEHLdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F53DC9C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7698C630F7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B2C433EF;
        Mon,  8 May 2023 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545546;
        bh=xXX3wUfe6TuADozToJe046gYH4fKOIApw7c6x4csoJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yT+XCAYQibgZBxUNi3gqIcE4RRCkRDxPWwy/hJwmjLtNaokSSqOIRsMbSg4QqqRXv
         pywpYyXoTYx6fTsAuEyQgDvV3Z0gxABFv/17AnhsVKetqYjXsd2ytr78+T00OIwQOw
         oeAjPMdw5y4tiNCyGOFL+YXA3UR7bRGKATl60Cqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 076/371] drm/vgem: add missing mutex_destroy
Date:   Mon,  8 May 2023 11:44:37 +0200
Message-Id: <20230508094815.130251895@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 7c18189b14b33c1fbf76480b1bd217877c086e67 ]

vgem_fence_open() instantiates a mutex for a particular fence
instance, but never destroys it by calling mutex_destroy() in
vgem_fence_close().

So, add the missing mutex_destroy() to guarantee proper resource
destruction.

Fixes: 407779848445 ("drm/vgem: Attach sw fences to exported vGEM dma-buf (ioctl)")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20230202125517.427976-1-mcanal@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vgem/vgem_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index bd6f75285fd95..43fc56d0c4a06 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -248,4 +248,5 @@ void vgem_fence_close(struct vgem_file *vfile)
 {
 	idr_for_each(&vfile->fence_idr, __vgem_fence_idr_fini, vfile);
 	idr_destroy(&vfile->fence_idr);
+	mutex_destroy(&vfile->fence_mutex);
 }
-- 
2.39.2



