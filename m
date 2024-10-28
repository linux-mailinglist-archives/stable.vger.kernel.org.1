Return-Path: <stable+bounces-89013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611669B2DB6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182601F21C65
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4B1DF73C;
	Mon, 28 Oct 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0aCgGXD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5301DF72C;
	Mon, 28 Oct 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112728; cv=none; b=CoPbXS2Qx7CmeMeSVa2AWYvc6yPsrEuagG+5Xxg0wc81fh8TqJ21itNMjRjWoOAb5srJl2gdV7YvHa3hPik23TJ434vqwOFi3rOjiVvmPgS+74fcc6UYYeAc0ICykDld/vD021It/FNl7kcuVzqTh1jOsl6PLk3TlmRqrzZzRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112728; c=relaxed/simple;
	bh=AWjY+Jh4gtpC1T5OPEmBU/M+2xT84tsdA88vaJts8HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTr+2Hah5oJfcnk0zQyngKRxm5v6rS4a8Tm6wfZi8AnQRvub/MBmBc7PEIAcFzp3TARk4APp0bkUM+MVB9fprhFy11vLmcjeECog5oGUBfJMSBAm/2Dgbeh9eD4Fr+r1SR1xyAcfDx71ezz5oev2ufeig+AS5pE9xK5i6VP6mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0aCgGXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00300C4CEC3;
	Mon, 28 Oct 2024 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112727;
	bh=AWjY+Jh4gtpC1T5OPEmBU/M+2xT84tsdA88vaJts8HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0aCgGXD4b69btwrFx5cW1WpiCGMiTVRJIsYuf9mLnruQuL8g00YUZXCjyyjxHYMo
	 6RN69aI2hCp17rc8E4InXWj78V7mvi8OYKtSi/AjD1QgVQ5EOBho2egyZ3pap4erjF
	 JYr5ucVExdS92euVSEdClIqJQMDtB5EyanScJpbwK8kzNKS3NCrs6oKWtPOm/YCQaL
	 NSMXfM508xLUOYEf91Lc6iGES8LPU1xBkv81PvfRqA+VNQEL227p7zE9QkIWgLz3ap
	 xKUB/XdFM6kdxLgM1tZgHgthHwtJT+xu/BN/Fv7NHMRXuI/KYKPZaHgPD840hVFspg
	 ZAeTUW4kG2fiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 31/32] drm/xe/ufence: Prefetch ufence addr to catch bogus address
Date: Mon, 28 Oct 2024 06:50:13 -0400
Message-ID: <20241028105050.3559169-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Nirmoy Das <nirmoy.das@intel.com>

[ Upstream commit 9c1813b3253480b30604c680026c7dc721ce86d1 ]

access_ok() only checks for addr overflow so also try to read the addr
to catch invalid addr sent from userspace.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241016082304.66009-2-nirmoy.das@intel.com
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
(cherry picked from commit 9408c4508483ffc60811e910a93d6425b8e63928)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index de80c8b7c8913..9d77f2d4096f5 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -54,8 +54,9 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 {
 	struct xe_user_fence *ufence;
 	u64 __user *ptr = u64_to_user_ptr(addr);
+	u64 __maybe_unused prefetch_val;
 
-	if (!access_ok(ptr, sizeof(*ptr)))
+	if (get_user(prefetch_val, ptr))
 		return ERR_PTR(-EFAULT);
 
 	ufence = kzalloc(sizeof(*ufence), GFP_KERNEL);
-- 
2.43.0


