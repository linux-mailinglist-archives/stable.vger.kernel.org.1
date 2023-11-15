Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA047ECD85
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjKOThA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKOTg7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85041B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CA8C4339A;
        Wed, 15 Nov 2023 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077016;
        bh=X7NAyUK1qyBYY04wcpCYzznOoMZsYJWfHo1BNYeVHL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNTZrCxVo9uYQpK4DOwf9ngXzBgwoC8j7XD/XODOxeESg0nr3K3Vj2gqcP+bESjqe
         WTw8yJ0VFPcHH+YwQO9OeTMkb39hkZluFhReIQ9zHU1UMhWaBe+7CJp2U+ixINZAtd
         7BUOCdCfC19aT0z4zj13hfZ6HuCvvbqLmkp+Dl5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alexey.klimov@linaro.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 493/550] drm/amdgpu: dont put MQDs in VRAM on ARM | ARM64
Date:   Wed, 15 Nov 2023 14:17:57 -0500
Message-ID: <20231115191635.059338091@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit ba0fb4b48c19a2d2380fc16ca4af236a0871d279 ]

Issues were reported with commit 1cfb4d612127
("drm/amdgpu: put MQDs in VRAM") on an ADLINK Ampere
Altra Developer Platform (AVA developer platform).

Various ARM systems seem to have problems related
to PCIe and MMIO access.  In this case, I'm not sure
if this is specific to the ADLINK platform or ARM
in general.  Seems to be some coherency issue with
VRAM.  For now, just don't put MQDs in VRAM on ARM.

Link: https://lists.freedesktop.org/archives/amd-gfx/2023-October/100453.html
Fixes: 1cfb4d612127 ("drm/amdgpu: put MQDs in VRAM")
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: alexey.klimov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fd81b04559d49..477bfc813c81b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -383,9 +383,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = &kiq->ring;
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
 
+#if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
 	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
 		domain |= AMDGPU_GEM_DOMAIN_VRAM;
+#endif
 
 	/* create MQD for KIQ */
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
-- 
2.42.0



