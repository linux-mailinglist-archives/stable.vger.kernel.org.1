Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E667B8912
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbjJDSWa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjJDSWa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:22:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA516A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD1FC433C7;
        Wed,  4 Oct 2023 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443746;
        bh=aB7LZUq+yhgWGntnzpjcbjN+8valPLTAnuzj7iNDKyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brnujv5l9RG0bcZyHdSyZVyzR69Fk7a1GqKO4TDZ8g0Ivnn9usfeY/qjkG9m6RFZm
         XjMcoz5G8eDQ8EQ8OC+tvCnnShRPt8oHYqH/iJG8z7Smv+6jH/tAWIPixTZ2BMSRRw
         IjEXnBtWV+fkcn5pYAxVw9zwRXNV6kHUBNlGNMQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, YuBiao Wang <YuBiao.Wang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 255/259] drm/amdkfd: Use gpu_offset for user queues wptr
Date:   Wed,  4 Oct 2023 19:57:08 +0200
Message-ID: <20231004175229.123448205@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YuBiao Wang <YuBiao.Wang@amd.com>

commit cc39f9ccb82426e576734b493e1777ea01b144a8 upstream.

Directly use tbo's start address will miss the domain start offset. Need
to use gpu_offset instead.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -201,7 +201,7 @@ static int add_queue_mes(struct device_q
 
 	if (q->wptr_bo) {
 		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
-		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
+		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
 	}
 
 	queue_input.is_kfd_process = 1;


