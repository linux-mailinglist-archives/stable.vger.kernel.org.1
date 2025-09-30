Return-Path: <stable+bounces-182370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45BABAD896
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DF3A2C6C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC930594A;
	Tue, 30 Sep 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZYsuOly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF77302CD6;
	Tue, 30 Sep 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244723; cv=none; b=g2goDVZdRKPLGwYbDzIlWvsxiNimxRO39gpT4DPRqyZEn40LfnmEKSfCBQ2e1+K6Pq7O3K3dtZ+QM/e68QWShoZm3Y5jizn6cLsq6gacr31f7vbkTODHrlPexuNvv62EQnvIWHMQlB9bkz0djv/DrGYQ5gwEVGVKOHOuOvvis1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244723; c=relaxed/simple;
	bh=n60Lm04VrlyKZJ/H1tUp3HELDznPzcUsJ6uNslM9Zvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODcC68in2KXTuIaxVCeyUgxsXgl2bpm7wPGrwDIkX++ZmZTJOn/pSlwM9C0mb2c1hDgoqCX9TRm//SXqHWVjzsQpiHeqJOF4UQX4hjKJ2sfHH/+S9n5Di4ZC3WZzIb1xxEYtS3VK0yDfQyJZOb5iv0t7gHdGQSZy9S5jnhiiImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZYsuOly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4236C4CEF0;
	Tue, 30 Sep 2025 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244723;
	bh=n60Lm04VrlyKZJ/H1tUp3HELDznPzcUsJ6uNslM9Zvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZYsuOlyZlmUtcqgwE+8s1mk+MPpm2oE32hIwFzYKQ/4dyBFfRuUK7zJi36uJfkC7
	 MC98atdiDyHAin3ln2TFrf6vBdoHym9oIdpWuIs1f533z9xnEe0pNkeEH5aF3QWst1
	 j7mLNxLWG+891Tu9ueO1I0Fejq0t3tKyId+kdOPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 052/143] drm/amdkfd: fix p2p links bug in topology
Date: Tue, 30 Sep 2025 16:46:16 +0200
Message-ID: <20250930143833.307679125@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Huang <jinhuieric.huang@amd.com>

[ Upstream commit ce42a3b581a9db10765eb835840b04dbe7972135 ]

When creating p2p links, KFD needs to check XGMI link
with two conditions, hive_id and is_sharing_enabled,
but it is missing to check is_sharing_enabled, so add
it to fix the error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 36cc7d13178d901982da7a122c883861d98da624)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4ec73f33535eb..720b20e842ba4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1587,7 +1587,8 @@ static int kfd_dev_create_p2p_links(void)
 			break;
 		if (!dev->gpu || !dev->gpu->adev ||
 		    (dev->gpu->kfd->hive_id &&
-		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id))
+		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id &&
+		     amdgpu_xgmi_get_is_sharing_enabled(dev->gpu->adev, new_dev->gpu->adev)))
 			goto next;
 
 		/* check if node(s) is/are peer accessible in one direction or bi-direction */
-- 
2.51.0




