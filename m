Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFE7ECC0A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjKOT0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjKOT0V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8028D79
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455C4C433CA;
        Wed, 15 Nov 2023 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076377;
        bh=E+Z1iKroRfvOc0k1vB8igsBZzq6X9UNV0TlKDMOEb68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjJKCp/KTuPQCBReXDipurCwgRFr/DXzIMiuKoka1/8AGdZRjgL7nxbkXWudmP5co
         hVcTFQhrcS3neLNJzqiU2bDKeWxQwzRWtMOCGPgmYjM7Ym9c7kJNLDInmfrvfbq3kh
         oPR2Wncv7mj7APvQS789+cvOmtSs7MhrmDTLcOfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 229/550] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3 dGPU
Date:   Wed, 15 Nov 2023 14:13:33 -0500
Message-ID: <20231115191616.605830641@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit bcfb9cee61207b80f37663ffa08c135657a27ad5 ]

On GFX v9.4.3 dGPU, applications have random timeout failure when XNACK
on, dmesg log has "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
because dGPU mode has 272 cam entries. After increasing IH soft ring
to 512 entries, no more IH soft ring overflow message and application
passed.

Fixes: bf80d34b6c58 ("drm/amdgpu: Increase soft IH ring size")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 6c6184f0dbc17..508f02eb0cf8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -28,7 +28,7 @@
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
 #define IH_RING_SIZE	(256 * 1024)
-#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
+#define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
 
 struct amdgpu_device;
 struct amdgpu_iv_entry;
-- 
2.42.0



