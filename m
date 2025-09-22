Return-Path: <stable+bounces-181352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3748B93128
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6263A31CD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7687C2F28F9;
	Mon, 22 Sep 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZL4WZA/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249B2517AC;
	Mon, 22 Sep 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570327; cv=none; b=ETz34Hmr86q8Ed5xasjGYEfZ8HGepkMzZ23Wu3lhX5l+fadtHVkLdUua7LDsIQIwa8iSde+4PMTnGrcP6A5yBM1pTWxkWeTV1zZsIYGeRvFPBcwYJDcqocw1VLJT+LxWnqCT2bho1LsobVSkidycpxyHXKHFQTm8d2ZKPz/tMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570327; c=relaxed/simple;
	bh=wZ793RLk0g3en9na4lEz6iDtQoHFo0IhKHSH0QnkIuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIeeKw7TsnELNFO9yv8RaW5yzfkjHrtKSAOP9sXNCXN3a0apkF97gjsSZkGfZOouuHyGNuC6hd9qIqokpeoixkV4o5KQyeIfuEsGVU/H0hB97VnjLzwwR9ItwT9sGy3ic8Dvo8FZV91/A+U+QqmZFXQbj7K5BaswKCINIlfmrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZL4WZA/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01A1C4CEF0;
	Mon, 22 Sep 2025 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570327;
	bh=wZ793RLk0g3en9na4lEz6iDtQoHFo0IhKHSH0QnkIuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZL4WZA/oSz/00hVRkhDxt0zDfFNZPJepiUfU4O4cm0LuckwvGkDd50WdaYM38Y+bW
	 r2w0KN4HcQUw+MR+RaNJGiTMEChIep5TEbdAogdpayJXPfOtGwnNw6VTi921p1oST1
	 r+P4w1wSAcTtyrGSHmAiPhz17EJzdvl3e01/dYLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20L=C3=A9cuyer?= <jerome.4a4c@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.16 097/149] drm/amd: Only restore cached manual clock settings in restore if OD enabled
Date: Mon, 22 Sep 2025 21:29:57 +0200
Message-ID: <20250922192415.331193907@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit f9b80514a7227c589291792cb6743b0ddf41c2bc upstream.

If OD is not enabled then restoring cached clock settings doesn't make
sense and actually leads to errors in resume.

Check if enabled before restoring settings.

Fixes: 4e9526924d09 ("drm/amd: Restore cached manual clock settings during resume")
Reported-by: Jérôme Lécuyer <jerome.4a4c@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/0ffe2692-7bfa-4821-856e-dd0f18e2c32b@amd.com/T/#me6db8ddb192626360c462b7570ed7eba0c6c9733
Suggested-by: Jérôme Lécuyer <jerome.4a4c@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1a4dd33cc6e1baaa81efdbe68227a19f51c50f20)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2185,7 +2185,7 @@ static int smu_resume(struct amdgpu_ip_b
 			return ret;
 	}
 
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
 		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
 		if (ret)
 			return ret;



