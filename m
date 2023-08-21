Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018A783249
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjHUUJw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHUUJw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66AE3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA3D864A92
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB897C433C7;
        Mon, 21 Aug 2023 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648590;
        bh=pa8zqNOayUUgClxrfdDgI/YsDAfI/cghQc5RS+neu+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P73DhPYZTM4dVU8DKRmqgJksJyigTYurOKyMf7XGhj+cTy3tRm78FlhakPwzSPn3f
         MDyY3hBb0bcjQTACUnCJ6u7qzoJfalYXdSWFgZY360U3ONXzPR2VPnATN3K26j7Ux6
         0upnKcrdzhjFSN9JIhEhjdGUlGXEDQfP/xwrbgmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 230/234] drm/amdgpu: keep irq count in amdgpu_irq_disable_all
Date:   Mon, 21 Aug 2023 21:43:13 +0200
Message-ID: <20230821194139.086342377@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

commit 8ffd6f0442674f32c048ec8dffdbc5ec67829beb upstream.

This can clean up all irq warnings because of unbalanced
amdgpu_irq_get/put when unplugging/unbinding device, and leave
irq count decrease in each ip fini function.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -124,7 +124,6 @@ void amdgpu_irq_disable_all(struct amdgp
 				continue;
 
 			for (k = 0; k < src->num_types; ++k) {
-				atomic_set(&src->enabled_types[k], 0);
 				r = src->funcs->set(adev, src, k,
 						    AMDGPU_IRQ_STATE_DISABLE);
 				if (r)


