Return-Path: <stable+bounces-140361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895C0AAA7E7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D02016A108
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4221342C34;
	Mon,  5 May 2025 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT0oeLLy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F099342C2C;
	Mon,  5 May 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484696; cv=none; b=tEapjutjGxQEgU/IQCOAmiwomU+N1j/kxOuzrpea4jFmR2aHblpYxqNQrVQ8kWwmgVB/vmKZAgtzWg0kwpur9ePj+PdVxNrXZuBd2L13NuIhBKL7FQ1Mi4HMYPmYaHmYmp7jIy1FYvmu0pr8GwMNgKlrnvTKYhLNwZC6oozfoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484696; c=relaxed/simple;
	bh=LfceeoSy3Yuos/oSFvaad0WRsAM7wu6oaK05l1ynG70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+LaKQvQUD+rOeepg1SMnNH9U3CxQV7va3/vEKz4EFf7I+E94Bl09F2/oHYKhTAPeCixvbhvFS89v6Vfp+qDYaCB80Okq1+Vi4MJZClmDxMESUnMRw2nsdwkzNkMIiv3Zg543/6U5jKmLWfEbbPHtcHJNktLorh04UC7wiadG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT0oeLLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E18BC4CEE4;
	Mon,  5 May 2025 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484695;
	bh=LfceeoSy3Yuos/oSFvaad0WRsAM7wu6oaK05l1ynG70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT0oeLLyqo2WaVIStnbS3wx9yy2auyrEqVW7MFqfFD5nnnQNtdrApswr9mX8Uu1Xl
	 l0viuwQKoF0niAghgvGPduzPz9RXh/KMGjuXgX3S5c2NihHeji1ycJOilpyXrhmlR6
	 r/mOccG0/vz4OvS6YolCETQ2b01BGnI5qbli7hqj7MVwGfqyz6HuE2g+kvkwSa+Ial
	 8gQefYSNGmtBt1GsXkOlzmS+RMelSfd5jz7pNBOlRQK2rSRjmckiXBPWPtxWpxhXp/
	 rrllZGdjpfhepp3DUVEIdHqABSqcukBwnMhGzujkt5ZVpdueFkg+BGPdgFxkB1viwK
	 STGtWCo88ArNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 612/642] drm/xe: Always setup GT MMIO adjustment data
Date: Mon,  5 May 2025 18:13:48 -0400
Message-Id: <20250505221419.2672473-612-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit bbd8429264baf8bc3c40cefda048560ae0eb7890 ]

While we believed that xe_gt_mmio_init() will be called just once
per GT, this might not be a case due to some tweaks that need to
performed by the VF driver during early probe.  To avoid leaving
any stale data in case of the re-run, reset the GT MMIO adjustment
data for the non-media GT case.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241114175955.2299-2-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 94eed1315b0f1..a749de08982b8 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -650,6 +650,9 @@ void xe_gt_mmio_init(struct xe_gt *gt)
 	if (gt->info.type == XE_GT_TYPE_MEDIA) {
 		gt->mmio.adj_offset = MEDIA_GT_GSI_OFFSET;
 		gt->mmio.adj_limit = MEDIA_GT_GSI_LENGTH;
+	} else {
+		gt->mmio.adj_offset = 0;
+		gt->mmio.adj_limit = 0;
 	}
 
 	if (IS_SRIOV_VF(gt_to_xe(gt)))
-- 
2.39.5


