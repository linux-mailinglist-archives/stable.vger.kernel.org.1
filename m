Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F51726BA0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjFGU0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjFGU0j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9932136
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F1D6447A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3723BC4339B;
        Wed,  7 Jun 2023 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169582;
        bh=dEZzXGxb0gguHQvSlEdpoI8CXGzm9w4TCGUUf8xYmA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vy9+6vJLsMaWnyiafIx/5YK1XZK8IR7ugEVpO+uMxCN9kGg53dc+i/7wB5FeJdW0r
         RIlPPe/zwwUTFvJ7DZX8FZGAzEpNeWHhSv13D844eHmTVrmmMp01KmioVfW+sE9LRd
         zRtkT26gZ+HCdA5FYlQCla6HKsJRsYrUULD2bh9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yifan Zhang <yifan1.zhang@amd.com>,
        Lang Yu <lang.yu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 106/286] drm/amdgpu: set gfx9 onwards APU atomics support to be true
Date:   Wed,  7 Jun 2023 22:13:25 +0200
Message-ID: <20230607200926.549374799@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit af7828fbceed4f9e503034111066a0adef3db383 ]

APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather
it is internal path w/ native atomic support. Set have_atomics_support
to true.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 412cb3f1f8826..31413a604d0ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3737,6 +3737,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
 			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
+	 * internal path natively support atomics, set have_atomics_support to true.
+	 */
+	else if ((adev->flags & AMD_IS_APU) &&
+		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
+		adev->have_atomics_support = true;
 	else
 		adev->have_atomics_support =
 			!pci_enable_atomic_ops_to_root(adev->pdev,
-- 
2.39.2



