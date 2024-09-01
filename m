Return-Path: <stable+bounces-72188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B84967999
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41D51C20C21
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDC185958;
	Sun,  1 Sep 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2J/mUb5U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A20185B58;
	Sun,  1 Sep 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209129; cv=none; b=rYMi/O5tA5EFWy09I9l6D3ERm6nxE0Zd9F1FaaKVZDpgQBASXJdpy1BVIAF15w8bFHSttkhn5Jwz0pDj9uwbVVIfin0bbWKxM9VF0W/3qwdaWCX6At70BGefQfZHX9mVw94VvGnX4MWxCZgs1v8jby6U+g/82eVmKf3pPZZCHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209129; c=relaxed/simple;
	bh=vWtYNI3WpLzV7JjVoNdbkf9uJ7EeFgdVBEALm+eV100=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfppYLc5+bOmQbPutEi87DhUwTwhlbjJTTrkdw4F19fSsWCXQvJ3vwWMAbw6qvLaG0e7ZEIk/al/m47IVRJnctlgiSPCKSNOl1CzgCQPiV5elqHUwXAstvjqeCfoflbhFEh05+MT6oaQPrhKf9htdO2oghebU3/FP3du+xYKvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2J/mUb5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B54C4CEC3;
	Sun,  1 Sep 2024 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209129;
	bh=vWtYNI3WpLzV7JjVoNdbkf9uJ7EeFgdVBEALm+eV100=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2J/mUb5UQAUDLho+/KUWHgrhT5FwXKExuqKi3Hj3TihnSfWW9kphXHlcQ7Y4xNv3+
	 m16/TDC+K8rdK0cRsu7fRVnLS1MtzsVp5EEHueL5mxvg/1ZCDXF8YC/laHjmPa08eQ
	 pne1cUTpRxv8VpIfDMYBz+DaxeSoBKdT2+8sgkKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <jesse.zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH 6.1 01/71] drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc
Date: Sun,  1 Sep 2024 18:17:06 +0200
Message-ID: <20240901160801.939133742@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
References: <20240901160801.879647959@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Zhang <jesse.zhang@amd.com>

commit 88a9a467c548d0b3c7761b4fd54a68e70f9c0944 upstream.

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
V2: To really improve the handling we would actually
   need to have a separate value of 0xffffffff.(Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -743,7 +743,8 @@ int amdgpu_vce_ring_parse_cs(struct amdg
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned idx;
 	int i, r = 0;
 



