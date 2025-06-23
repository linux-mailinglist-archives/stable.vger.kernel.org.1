Return-Path: <stable+bounces-157783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E7AE5599
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEED1BC5881
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B1226D04;
	Mon, 23 Jun 2025 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwOiVc2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E228CB5;
	Mon, 23 Jun 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716711; cv=none; b=pcrHFM0tvT+H3X+qK5NnGjWL+czUFGiQBfmZlz6283/lBm073oxuNTwLiNq07sltoPtTvn7fjSD9NNn4HwQBIs9qqztdUfQ+FrgM0hYHOhLDXWAx3JSO6iCYyLBrlvOTpuAEsC4l247+33moPlm2QsUgC1bzzFOg6C494JkhN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716711; c=relaxed/simple;
	bh=ltL6AN9XZC2RfwcCmt0zh0sPqWzk5G0QWQ0IasuIeLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biqL+nYiyPx+O9Wz5HzrMJbyWxyGKdIuFgoASgoqqcluNYCIy6Oc1J35/kCfj1JUTfomG0qYIYdzThTZPdLHK9NKRhGfGxjet6WBmIQTHYZdlnCOv0hyl+Se/rtGxqGcguU8yTV8QlTBL2qvKbkQgLo/zImFmf1VsnDnHMRQWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwOiVc2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74815C4CEF1;
	Mon, 23 Jun 2025 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716710;
	bh=ltL6AN9XZC2RfwcCmt0zh0sPqWzk5G0QWQ0IasuIeLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwOiVc2x5AlBw6azP0wIMLkvCjbGlm12dQtJCZuQ5ilg1Lfs2Ss5rtQFtASeyoXrD
	 MXarwWheBuT7igNlwrdu+qYrsWN6PFxzrEsr5+455o9Dx2r7YBz613rFDO76uJA/s+
	 h2PrB3ZRYMFhtAADfYBZ2FB338E4MBH923e+bJYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 549/592] drm/xe/bmg: Update Wa_16023588340
Date: Mon, 23 Jun 2025 15:08:27 +0200
Message-ID: <20250623130713.502230217@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 16c1241b08751a67cd7a0221ea9f82b0b02806f4 ]

This allows for additional L2 caching modes.

Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
Cc: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://lore.kernel.org/r/20250612-wa-14022085890-v4-2-94ba5dcc1e30@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 6ab42fa03d4c88a0ddf5e56e62794853b198e7bf)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 66198cf2662c5..4bad8894fa12c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -116,7 +116,7 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 		xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 	}
 
-	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0x3);
+	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0xF);
 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
-- 
2.39.5




