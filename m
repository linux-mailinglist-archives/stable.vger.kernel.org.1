Return-Path: <stable+bounces-58304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A792B652
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E71283B0E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C336157E61;
	Tue,  9 Jul 2024 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6tTVx7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81815747F;
	Tue,  9 Jul 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523534; cv=none; b=J1qnqSW2n6LNEZnSdzKiEBoUEa/gLZNuYPhN5ch41QbLZilKnbW7hdeA+2xnU2uhRXwplMG2CeIFHIwBzB0y1WPpSFi4RcmqsVKvtR42tRRDJ4eO34mGaaktdH5TMGapJlb7PQdLEkRWHncBeScSj4y/QKNzJPqyMzuar7ZN2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523534; c=relaxed/simple;
	bh=KzO0tahxYmQAsVsoCcLnJyAUJ+kSkyXvRR1IV4fhE7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjttM7kIXZKAN7eHd6051qg95l31uXAQZUMK/K/9yR2nu1Miq3gyYcE7Iyx05tMoJcRZAzvLiL42b+9CBziVeiMmUFbRuq4716hKNYTF8JuvX8MCFFOh+MPKmiMxCMNPNOXsG3/vnzf/zgXJl9snJx9mefqT09zRnFWZULTVTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6tTVx7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44258C3277B;
	Tue,  9 Jul 2024 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523534;
	bh=KzO0tahxYmQAsVsoCcLnJyAUJ+kSkyXvRR1IV4fhE7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6tTVx7mPC9Qne0wlpkrdwpPYAGOW+cAiHW3dnmeO1d25fMwDUTWjCFqvbMZjJBfk
	 LVZsLsg/DrQ0vNO8EpduDAPhbQxn8TfH6MfQEbXQiJc/snyzbG2rsJpDQ+hRKDiSjj
	 XQGARuMX9A2IA03WwcWAmXniA2rfKRAYLLes9OUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/139] drm/amdgpu: fix the warning about the expression (int)size - len
Date: Tue,  9 Jul 2024 13:08:45 +0200
Message-ID: <20240709110659.137515039@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit ea686fef5489ef7a2450a9fdbcc732b837fb46a8 ]

Converting size from size_t to int may overflow.
v2: keep reverse xmas tree order (Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 418ff7cd662da..1c2c9ff9d39df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2052,12 +2052,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
 	uint32_t *new = NULL, *tmp = NULL;
-	int ret, i = 0, len = 0;
+	unsigned int len = 0;
+	int ret, i = 0;
 
 	do {
 		memset(reg_offset, 0, 11);
 		if (copy_from_user(reg_offset, buf + len,
-					min(10, ((int)size-len)))) {
+					min(10, (size-len)))) {
 			ret = -EFAULT;
 			goto error_free;
 		}
-- 
2.43.0




