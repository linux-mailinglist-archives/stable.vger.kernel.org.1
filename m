Return-Path: <stable+bounces-111613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4649A22FFA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AB61883293
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E681E8855;
	Thu, 30 Jan 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z2+M30sg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF311E522;
	Thu, 30 Jan 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247247; cv=none; b=B9MmfMIusw4LjJLxqYVrtZ0VTISUb9FNUX80cVNVmRs6TD1z2fhdLq6NFfpJE0ZZDqY9fNLAjvCQe4rBqDwwACi4g4ygTJ+ar2o/qpTW3kHlxanWdHBsmkCrrfQZyiJFxm5l0iBCt19Li9rTST87bLm3ubDKof5NsTznRLJue/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247247; c=relaxed/simple;
	bh=IAHCnFJNaY1xgRlufNJ/vrb13KdYykNow9icbvPoJW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jch4HatrzmG+jRsakFEkOkksAsvN5WGFlPWdhroM0DoxXYxbgYDwqoH3jKMDtE8XP1Q4XvmS/LjktXxVNno+QAvHKKCT+g4z3lpJuiMJBLvdbJjaFhdN3tAXF7KDjNs8P34uc+H7Va83g6KPCFD7F1h6hMQeSpNV+0srD+AOcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z2+M30sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B72C4CED2;
	Thu, 30 Jan 2025 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247247;
	bh=IAHCnFJNaY1xgRlufNJ/vrb13KdYykNow9icbvPoJW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2+M30sgX/XBNYQbHT/2kdLimgCCUf8mAbtQKlEnudauZFWxhPEt2J3jWu39/mdUe
	 up0KZT+HmV/z/9OjhPw22OkM2gpmPK18ZMiZHhg/Nx9QrbFlgw5lNs38OwHfucvAfQ
	 DTuBfd6saBfFVrMoSnIRAKe30TBVWvdBHub7BVog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 103/133] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Thu, 30 Jan 2025 15:01:32 +0100
Message-ID: <20250130140146.687974174@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 upstream.

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -582,7 +582,7 @@ static void radeon_gem_va_update_vm(stru
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, &bo_va->bo->tbo.mem);
 
 error_unlock:



