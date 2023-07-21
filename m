Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA775D44C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGUTTo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGUTTj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B2273F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEBD61D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90418C433C9;
        Fri, 21 Jul 2023 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967175;
        bh=O05TXVz/qaAcc9mYw41t3d6J5r+H7xk0MN9KLJfmuR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mc492mlVRcxUv/aMux0zaMszIRq9X/nlAP6z5nRYYR5Q8aCMJt7KJVbh3qr5lqHpb
         VR8Fw4A28zZCamc+Xjkc2wr77xiVLnqadiZLs6bU+DLkgRvLEGBZi2PHkq/KPgRq5O
         4SfwIsIpg7+BXr8299H61LTDuDCQrEqHIg0h3KmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Kuehling <Felix.Kuehling@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 070/223] drm/amdgpu/sdma4: set align mask to 255
Date:   Fri, 21 Jul 2023 18:05:23 +0200
Message-ID: <20230721160523.850115903@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit e5df16d9428f5c6d2d0b1eff244d6c330ba9ef3a upstream.

The wptr needs to be incremented at at least 64 dword intervals,
use 256 to align with windows.  This should fix potential hangs
with unaligned updates.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e5df16d9428f5c6d2d0b1eff244d6c330ba9ef3a)
The path `drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c` doesn't exist in
6.1.y, only modify the file that does exist.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2330,7 +2330,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_f
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
@@ -2400,7 +2400,7 @@ static const struct amdgpu_ring_funcs sd
 
 static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,


