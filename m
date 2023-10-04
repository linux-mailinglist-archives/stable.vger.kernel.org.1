Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30007B8853
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbjJDSO5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbjJDSO4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3EBA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15C2C433C9;
        Wed,  4 Oct 2023 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443292;
        bh=dhOkjKnzwEpO0jWdI+XFieYXaJiJG3XuPw/UwbSDiGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mzs93JZ0RCh/Fn2dpjRJ+Kn8By2zDdb9HpYUPimDyS2UL/QCA6kV80rIJvIuZaTmR
         ricCzEf2/PzxjKo1xmDYzC13ebG0Z/Iq7KMIVhevRxQRRN/NxWn2LtF4Zq4J4wI4TX
         6rRTjv2Glm0h+WKHmj6qwTrxc3xZGnuAuN62n7LY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/259] drm/amdkfd: Flush TLB after unmapping for GFX v9.4.3
Date:   Wed,  4 Oct 2023 19:54:38 +0200
Message-ID: <20231004175222.163478349@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 75dda67c7213c3e0d17244a8c42547c27ee746f8 ]

kfd_flush_tlb_after_unmap should return true for GFX v9.4.3, to do TLB
heavyweight flush after unmapping from GPU to guarantee that the GPU
will not access pages after they have been unmapped. This also helps
improve the mapping to GPU performance.

Without this, KFD accidently flush TLB after mapping to GPU because the
vm update sequence number is increased by previous unmapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: edcfe22985d0 ("drm/amdkfd: Insert missing TLB flush on GFX10 and later")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6d6588b9beed7..f374f112f7b71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1349,9 +1349,9 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-	       dev->adev->sdma.instance[0].fw_version >= 18) ||
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
 
-- 
2.40.1



