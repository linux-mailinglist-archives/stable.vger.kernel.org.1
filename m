Return-Path: <stable+bounces-174454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C37B36373
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547938E024B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7930AAC2;
	Tue, 26 Aug 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gz4ilG4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033BAD4B;
	Tue, 26 Aug 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214435; cv=none; b=Cg2KgnAzgvOa+G7b1XtWOZ5NEWt4T/+wazCzJdx3JGmEnh2+G5XHYocT46P5MFnHC0/pAkxOcol/ZZWESSs17eExMZa4S8xwEggOH0MCp1oofZwtuHUAU2eXbmyWJ24ja9jSQ6FWcZ6PX5KNaI/PsKPrgG0TPBpPRzLgzzhMJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214435; c=relaxed/simple;
	bh=0OCofD8v/PPyweDzoiDEQnXgDrVfI45gfnO4t+kxsaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFEHAp4cOiRJS3YJ+1h8TDUjq9IckZGhGWgEmgH2duAFBV9EQeWPM9gefnW/GbImazEj00K2r+rVF4lQSZ/X38HaNzBU1jFOtX2nuhV5oO2/p2cBYlCRpJOCBCYFezN7PqsxLyyo05qNbhH/TvN4mKVKJ5lIWJ/BBH9tB1jRqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gz4ilG4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5301C4CEF1;
	Tue, 26 Aug 2025 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214435;
	bh=0OCofD8v/PPyweDzoiDEQnXgDrVfI45gfnO4t+kxsaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gz4ilG4c7FUNULYUnjYB4ys44k3x3Jgn89v8z19njbBfSoIVa/6qLUFiqgeRMFlUV
	 Jpz4FC/h1DYQLGtX6HyvIVwhVEQ7qHBwgd9T2GAtBp6a7ZLOv9TQzCaeQNNHAoGwUg
	 YTwFmu2iNwfpplmHWgiq9eqzKgnkEe+9wumXSKGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Antonino Maniscalco <antomani103@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/482] drm/msm: use trylock for debugfs
Date: Tue, 26 Aug 2025 13:06:29 +0200
Message-ID: <20250826110934.177968838@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 0a1ff88ec5b60b41ba830c5bf08b6cd8f45ab411 ]

This resolves a potential deadlock vs msm_gem_vm_close().  Otherwise for
_NO_SHARE buffers msm_gem_describe() could be trying to acquire the
shared vm resv, while already holding priv->obj_lock.  But _vm_close()
might drop the last reference to a GEM obj while already holding the vm
resv, and msm_gem_free_object() needs to grab priv->obj_lock, a locking
inversion.

OTOH this is only for debugfs and it isn't critical if we undercount by
skipping a locked obj.  So just use trylock() and move along if we can't
get the lock.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Antonino Maniscalco <antomani103@gmail.com>
Reviewed-by: Antonino Maniscalco <antomani103@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/661525/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 3 ++-
 drivers/gpu/drm/msm/msm_gem.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..7116c2aac4cb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -874,7 +874,8 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 	uint64_t off = drm_vma_node_start(&obj->vma_node);
 	const char *madv;
 
-	msm_gem_lock(obj);
+	if (!msm_gem_trylock(obj))
+		return;
 
 	stats->all.count++;
 	stats->all.size += obj->size;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c4844cf3a585..4c8e0a022c24 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -185,6 +185,12 @@ msm_gem_lock(struct drm_gem_object *obj)
 	dma_resv_lock(obj->resv, NULL);
 }
 
+static inline bool __must_check
+msm_gem_trylock(struct drm_gem_object *obj)
+{
+	return dma_resv_trylock(obj->resv);
+}
+
 static inline int
 msm_gem_lock_interruptible(struct drm_gem_object *obj)
 {
-- 
2.39.5




