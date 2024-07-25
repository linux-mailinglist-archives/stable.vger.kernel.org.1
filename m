Return-Path: <stable+bounces-61715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9993C59D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD61F21533
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9219CD0C;
	Thu, 25 Jul 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J9V6ELYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0613C816;
	Thu, 25 Jul 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919210; cv=none; b=LrbAkigaZXiMHJzj71YlrVQvDHgyQIfzm1leuydGY0DiNqCEGNp8iNRI7/mBJDkdYF6bCcSCM78SoKvhLZfOIc600i11IL63vUyhpzaxYJ6kOe+r3E0cyXepYLjmi79FNScA13z/0S+BxMOq1R1AB4HBmuykkIhID7gglDU3jBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919210; c=relaxed/simple;
	bh=FAau1rtoTUoRMuqIE0Q/8K47DxNmISvynfd+rRzQXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8KH1TMZTNx0/YXwFZyG4NBILxyn/sig9ifYWKwDz89yvi4Hh55u3abucHA/S7xxn8bnkv9k3l+gPnqRNq7SIShaQ2CtAifWMyDBCWpctTfbr0d7OpWlUATFuLAJHd3qXS5lf0XLFFcNxhL+zp4SqT28tgM0e/Pfbl1nYAAuLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J9V6ELYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C6FC116B1;
	Thu, 25 Jul 2024 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919210;
	bh=FAau1rtoTUoRMuqIE0Q/8K47DxNmISvynfd+rRzQXXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9V6ELYy8TO0k7fR1nEBJx8EQFpGQI2uDkf1UXlH38w6do4Mp2wQ9st+axPEgpSd9
	 BuH1jAerPqvLCnOH1Yw9ybamabK89Wz5cJTi93f7WX/HZx2mt1jxtlKVRXwVIVaUz0
	 Ig17H83+JqUBrDgyk8a5JUWs1JzpvemRdKcFXIEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 57/87] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Thu, 25 Jul 2024 16:37:30 +0200
Message-ID: <20240725142740.582569911@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 ]

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 57218263ef3b1..277a313432b28 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -653,7 +653,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.43.0




