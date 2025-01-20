Return-Path: <stable+bounces-109508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102CA16C80
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D1163A30
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1721DA5F;
	Mon, 20 Jan 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Av2D9gLK"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6521FC8;
	Mon, 20 Jan 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377118; cv=none; b=uLf0Np/1V+oeqIC4CfdK4X1qTKnSI3eiM+SBuc1XTaOngcOudCaki2AH/ranMt3OKUb8iiKG9PQjf200P4jVMHREbdo5/uNh0xLVBoq0DqFifg8kMWjVimNRyG5KEuCQe6hIjHdRU2qKznU3pyM/v79ElknhnYR9cptMlI6NLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377118; c=relaxed/simple;
	bh=g9/VXHOw8Ibg9+BQ+ablv0wI7AHFvf6VP9Dkz30lxAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCKzaFBcwArv/71s8zHLe2SmZMDCAU9c2szSUGJAtcJ1MfcHxTjtRcs12zM8orEa7zd514NUlyXCwrRoQpz2eg1P0z5Vz8dl+6HsXr4i8iCKmAFTUTGFeeRs3aZitAD6Ks7UcXKVq9jPMP/4O00I/8LZEQDx86QivizsY/iRZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Av2D9gLK; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737377112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4/psA0m1o91XWq5sYUPCRXkQJFrjno5ZMVOnvX30W8=;
	b=Av2D9gLKJ24lX1xYUUICaEbd9qvYO5S3JgPfwHedLQJ9aU4ScS7VfHfipILbjCx543ff2H
	H7IigcTUbAAgYHo+rHf8vW6F1QzkjtiJupux9aH/cxRU7QKlwAklYb1UCYtVtRp+TbWerj
	Kz/RX/6YdfyeTU/ocG+TynV6l53mxHg=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 5.10] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Mon, 20 Jan 2025 15:45:09 +0300
Message-ID: <20250120124512.51418-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 upstream.

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Denis: minor fix to resolve merge conflict.] 
Signed-off-by: Denis Arefev <arefev@swemel.ru> 
---
Backport fix CVE-2024-41060
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-41060
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 75053917d213..51b6f38b5c47 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -582,7 +582,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, &bo_va->bo->tbo.mem);
 
 error_unlock:
-- 
2.43.0


