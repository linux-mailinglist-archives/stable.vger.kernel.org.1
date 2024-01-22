Return-Path: <stable+bounces-13656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7F837D48
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902751C27C74
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E058AA8;
	Tue, 23 Jan 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/wh1Ul7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBA3A8F4;
	Tue, 23 Jan 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969875; cv=none; b=fT0ByYAEusVxH2xKKlTbOowo34A1mhP3TTkTrNEc8Pz4SlUB+5DY6APUCxRzZwNXJl3jqMD3hR++Spp+ZgmIX3vai9Yi7zz5aoxbYqfixpv7qFSszQsdpltmGTqL4DpsFpBekxJ527mls2gVUNcSznFQ/07n6CMdoLYJnavwBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969875; c=relaxed/simple;
	bh=JC405hPRvvGe7apQCTHI2CmLZox/qbyeqLlqztQ3Xy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+QPUi4+1kZlUBHqvTgjkL/WMoKG80OoqLQvxmhDM5CVkgJmzYkh9J9Su5Qm069mSmFT45KmBeLzFeNvAIofiRRBY6fBdRqeEOUbJJiOQMdEG4/C4fH46Sqc+IVcwD71Vy02Nr+ZWdPLX1xEtOBz6aNHXDVgEJdw1JgkPoJIaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/wh1Ul7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56BC43390;
	Tue, 23 Jan 2024 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969875;
	bh=JC405hPRvvGe7apQCTHI2CmLZox/qbyeqLlqztQ3Xy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/wh1Ul7f7I4LcxFeat+22iFgjRW1HXHYTrEdagRjnXKkL0jkIAWb7xoqzylLJL96
	 j2rdiyUqKxGPNpWoZjaM6LsJStg+wqYTx24X5Yok2Tax4fc/v0Eq/QJOCi/7Sz8P7G
	 vq72Vjk8aCdEl8zC6RPs2Ekm+QUr2ZLELkTv1KU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Swati Sharma <swati2.sharma@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 499/641] drm/i915/dp: Fix the max DSC bpc supported by source
Date: Mon, 22 Jan 2024 15:56:43 -0800
Message-ID: <20240122235833.676783547@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

[ Upstream commit 584ebbefd12296c6bad009c8a0c9e610eb8283c8 ]

Use correct helper for getting max DSC bpc supported by the source.

Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Swati Sharma <swati2.sharma@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231213091632.431557-3-ankit.k.nautiyal@intel.com
(cherry picked from commit cd7b0b2dd3d9fecc6057c07b40e8087db2f9f71a)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 62ce92772367..1710ef24c511 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2025,7 +2025,7 @@ static int intel_dp_dsc_compute_pipe_bpp(struct intel_dp *intel_dp,
 		}
 	}
 
-	dsc_max_bpc = intel_dp_dsc_min_src_input_bpc(i915);
+	dsc_max_bpc = intel_dp_dsc_max_src_input_bpc(i915);
 	if (!dsc_max_bpc)
 		return -EINVAL;
 
-- 
2.43.0




