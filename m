Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2475D3C2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGUTOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjGUTOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475E1FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0965761D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4DFC433D9;
        Fri, 21 Jul 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966855;
        bh=i6VymhsLQytxzno3ew3//5OfujOAWmGW9DnLwFtelCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSCxeo4SrMVRVAO6x7Xq6JEUUjfPbHghORq4O8ZA76CCqfdxd5iAPCSS868y6MvLA
         Kso8iCOZLsz/pTQ2GIYVP3p5LlLO6H4gkfYSGbp21j62mwdfO4+iZvYtV+k+S1AAna
         QOlnYggakip0cu2odNtZLnbhYU6eB+/isdAwZMho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, gaba <gaba@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 491/532] drm/amdgpu: avoid restore process run into dead loop.
Date:   Fri, 21 Jul 2023 18:06:35 +0200
Message-ID: <20230721160641.178114871@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: gaba <gaba@amd.com>

commit 8a774fe912ff09e39c2d3a3589c729330113f388 upstream.

In restore process worker, pinned BO cause update PTE fail, then
the function re-schedule the restore_work. This will generate dead loop.

Signed-off-by: gaba <gaba@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2350,6 +2350,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_
 			if (!attachment->is_mapped)
 				continue;
 
+			if (attachment->bo_va->base.bo->tbo.pin_count)
+				continue;
+
 			kfd_mem_dmaunmap_attachment(mem, attachment);
 			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
 			if (ret) {


