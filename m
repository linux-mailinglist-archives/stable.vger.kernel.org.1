Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BB72C0FB
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjFLKzz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjFLKz3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B28228
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA182612F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC141C433D2;
        Mon, 12 Jun 2023 10:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566548;
        bh=NmHJv/SBeLeBzYTSHDHLUuGlHowF4P4QraHZbW5vAoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLvysGBhDFfF8oJ0Gb9M9PkzLSJJf2+VBa1BUI/JIKWgLMimfngMdYy/iGK/B/EFN
         40o7HuLD89AC1m/SLw2EjwZkSn3CJHV3zKWrFgwMhKgytkMa8qt/u2YBmpBHEeeCSp
         e/cr5Kd+9o8ESGO6loHuxFco6EEyG2ifGJLa2nJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, YiPeng Chai <YiPeng.Chai@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 074/132] drm/amdgpu: change reserved vram info print
Date:   Mon, 12 Jun 2023 12:26:48 +0200
Message-ID: <20230612101713.642424577@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

commit dac652220ba0e5a2ef2da2a47a60b60aea333fdb upstream.

The link object of mgr->reserved_pages is the blocks
variable in struct amdgpu_vram_reservation, not the
link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -799,7 +799,7 @@ static void amdgpu_vram_mgr_debug(struct
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &mgr->mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, "  vis usage:%llu\n",
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -811,8 +811,9 @@ static void amdgpu_vram_mgr_debug(struct
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, "reserved:\n");
-	list_for_each_entry(block, &mgr->reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
+		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+			rsv->start, rsv->start + rsv->size, rsv->size);
 	mutex_unlock(&mgr->lock);
 }
 


