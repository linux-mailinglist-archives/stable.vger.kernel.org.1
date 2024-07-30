Return-Path: <stable+bounces-64626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69205941EB4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277CC28414D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7184187FEC;
	Tue, 30 Jul 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HaHMdzK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D01A76A5;
	Tue, 30 Jul 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360735; cv=none; b=gLaZdZIcxMhP6vqpsl3D9Kr9sb8kwghm8dlwCXC9bf5ZDSxZAMw8PsirMGVRo+E0/MmzxGwJAbAddpfT10NZqnx0FEXoAqFxqIX6LWBdK33/R1hK9Tg2nRa2jAIV1oqpajBac7cgYUrGPFw0OJR5h3tv1/kAGUQ/Pe0C+D/jHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360735; c=relaxed/simple;
	bh=C9hc6DYZQpka2eaXtb3ux6U7VMDwgDaQ0C6B00kkVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW46ZEyOQsBMlN3mZfHk/KspeXXAq97aLdgDxE7/nAYaiHL2VMM73UHR5Nx/DlGVnSR7UEo2XCtXyise/813xHLAGwhLfNV7CIEKLW7dKISNwyxe+ql0gzeP5l9oKLUANJWrlGsOX5XS/GviGJA7FXODHWmRukjKz1Qnc965zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HaHMdzK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E7C32782;
	Tue, 30 Jul 2024 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360735;
	bh=C9hc6DYZQpka2eaXtb3ux6U7VMDwgDaQ0C6B00kkVQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaHMdzK8w9D8aajquJ+p0/eBANYpN2FoHctcgwdNOAOb1tRhYzTjd3A8z8rKLfTgw
	 g37++VDTlE1+hDuy9+thgcLESRF+ejR/YYZZVwHoeRaD9+br0zyQkbQcZmOvieUa3d
	 CCNyvgeRfNmBKw/SKLIFWiMTe4CU0caq7aWgjUgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 790/809] drm/xe/pf: Limit fair VF LMEM provisioning
Date: Tue, 30 Jul 2024 17:51:06 +0200
Message-ID: <20240730151756.170693734@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit bf07ca963d4fd11c88a9d4b058f2bd62e8d46a98 ]

Due to the current design of the BO and VRAM manager, any object
with XE_BO_FLAG_PINNED flag, which the PF driver uses during VF
LMEM provisionining, is created with the TTM_PL_FLAG_CONTIGUOUS
flag, which may cause VRAM fragmentation that prevents subsequent
allocations of larger objects, like fair VF LMEM provisioning.

To avoid such failures, round down fair VF LMEM provisioning size
to next power of two size, to compensate what xe_ttm_vram_mgr is
doing to achieve contiguous allocations.

Fixes: ac6598aed1b3 ("drm/xe/pf: Add support to configure SR-IOV VFs")
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240711192320.1198-2-michal.wajdeczko@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 4c3fe5eae46b92e2fd961b19f7779608352e5368)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index 6c2cfc54442ce..4f40fe24c649c 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -1527,6 +1527,7 @@ static u64 pf_estimate_fair_lmem(struct xe_gt *gt, unsigned int num_vfs)
 	u64 fair;
 
 	fair = div_u64(available, num_vfs);
+	fair = rounddown_pow_of_two(fair);	/* XXX: ttm_vram_mgr & drm_buddy limitation */
 	fair = ALIGN_DOWN(fair, alignment);
 #ifdef MAX_FAIR_LMEM
 	fair = min_t(u64, MAX_FAIR_LMEM, fair);
-- 
2.43.0




