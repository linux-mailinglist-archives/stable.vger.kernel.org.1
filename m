Return-Path: <stable+bounces-95219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B359D744A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F32B286059
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637723DD15;
	Sun, 24 Nov 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLgpbS9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527A23DD12;
	Sun, 24 Nov 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456380; cv=none; b=DEXmcbXaNAgKy4wyIifFqF0t14IJVX/Dv9gWL+/ZMglkcOkb6gPeuYFiuGWt26wIVXRgq3mXtmqxyQIxeYhVbjdb9VE32iS9pcsv/NpqQ66/SoXrkCSsrEbNFLNZQ7vT4ufZ7hMiPSXa8aw/06LUYxKAkVj9sLUq+laJwK0LWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456380; c=relaxed/simple;
	bh=VrMC/qm3yF6vGuNO7pBmx5unBh37CgIKAFGLyrw8szc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2sKsNLJRS3Iv4QsEZxt9iPWihazvFChfvFXocJrxlkskiWWomXpnh6nuGHi6MxEkcZAFjGTZ3ZHSYXI3qNP0N9Ummtk4+IzMuObbI4gR3Rrxu+v3SBraNPES7Y38odFoLMx+rrj0giFw6CjA8AYdhNtyHpIqNN/MaiSkjSVzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLgpbS9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9951C4CECC;
	Sun, 24 Nov 2024 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456380;
	bh=VrMC/qm3yF6vGuNO7pBmx5unBh37CgIKAFGLyrw8szc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLgpbS9njvzaDO8vz84wrmi5rAmdF8WaLZ7idBEI5TwdWvqzILeAfq4P3ReK3/D2V
	 KAwxX3u1SeAaSjT+tE/bdGN/Wj9xZCGBJPaEobMXHAZFmMA3Dcwo8f8JcQeXyOGpQw
	 1dNsEx6opaHzkb9zJLuXiYPXJrquDgQi+SP8hwibr0qTsZxEGUFQb2QWO9blDvcLuc
	 NYNB4qL33mF9RNKu8woDXsdsH5wallmoqr7w5ru9cK+FX5AtBcVvZRQJWn0l69qVTw
	 h6zam+zwgGK2H52d4bDo9CcZEMhJF4tfJ9Ky1v98ikjLa+UqdC/lKi3Epou/RHKv0Y
	 Y30JnMAUFajyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	Jun.Ma2@amd.com,
	antonio@mandelbit.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 20/36] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Sun, 24 Nov 2024 08:51:34 -0500
Message-ID: <20241124135219.3349183-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 32e7ee293ff476c67b51be006e986021967bc525 ]

Need to dereference the atcs acpi buffer after
the method is executed, otherwise it will result in
a memory leak.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 592ca0cfe61d0..0adc992e4630a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -761,6 +761,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0


