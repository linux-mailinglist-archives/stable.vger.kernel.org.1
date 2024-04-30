Return-Path: <stable+bounces-42727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF548B745A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23281C21E09
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB812D768;
	Tue, 30 Apr 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hTIbWZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344212D214;
	Tue, 30 Apr 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476589; cv=none; b=er44yuVNSIOBkHrRoKQz6VNOPGxuDxDMBEpu2oydJxOBPQeRiwWysJNOL0/hlmE0uVHAvAQ4CU6EApnNoKfLJXEjZLC072+sSQs0FXPmRubh9Bj8wXuENBjOoWnqMUwWGkzDYayZN4CLi82HKoRb6KSNKmIBcmc7x58QGRUp1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476589; c=relaxed/simple;
	bh=AVlkvlIIL7pnVx54QF2m4J0IphXZEUcVZ4rTH8+hdBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBx7QEiwYTg8ZWmA7IZkf+XEP/o9+fY9oQBXSMsPd3fZFRfbIMdQP+K5bGGJgYfnH2MyTmSINCzxRNVbphRGKGdRGMRU1RbNq6Xuxhf7b8xcNmGPB+L7F8Pwo8v8FDiuEHqtUwEQkazBAtR7Ikhxkdjy2tGRecFd2dlNe38Jw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0hTIbWZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA50C4AF18;
	Tue, 30 Apr 2024 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476589;
	bh=AVlkvlIIL7pnVx54QF2m4J0IphXZEUcVZ4rTH8+hdBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0hTIbWZvKFP4TQFJkQjbEHw4lRXI7FTXFqbAyyVf4CzJEiYoRy/EJa3h8GzGTS2Au
	 YWy7rrCFiEPurzGJrnkoAILXcDwmnmZEEz4A53tVQhGCutbNVYyTZQOi544hLNgBT8
	 l08tMx9aE5yb+dIcyW5K14Te/4I4oLDZI6qPk7Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukul Joshi <mukul.joshi@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 079/110] drm/amdgpu: Fix leak when GPU memory allocation fails
Date: Tue, 30 Apr 2024 12:40:48 +0200
Message-ID: <20240430103049.897401253@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mukul Joshi <mukul.joshi@amd.com>

commit 25e9227c6afd200bed6774c866980b8e36d033af upstream.

Free the sync object if the memory allocation fails for any
reason.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1779,6 +1779,7 @@ err_node_allow:
 err_bo_create:
 	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
 err_reserve_limit:
+	amdgpu_sync_free(&(*mem)->sync);
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
 		drm_gem_object_put(gobj);



