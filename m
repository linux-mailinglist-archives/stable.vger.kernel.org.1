Return-Path: <stable+bounces-136039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D44A991AA
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791771692CF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E529617E;
	Wed, 23 Apr 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZ/4XXJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798728D858;
	Wed, 23 Apr 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421495; cv=none; b=B3MagmYLbaNMR6RxYVgnl77o2rTFbm6o0TbLdgNSvzrNiYT5nB6qh8mcjsvhWLFaFrNN5krSRgk8cz8j+UER7XTheVOJFjk8lD1BxPwCUErZi45+OsK9UAFbl49p4zWKWrVjECWfP1bnzeWJtf9NoZrkrzP478USLMyhYoGUziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421495; c=relaxed/simple;
	bh=2wp1+RuCb3jAvwXvckrNpyvgRwaPN3JytLX7Shlw28U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZpGw6ZqdzMRJVxUMcWIzdd3ZEcaxvxxhgbmcqC0rZQ54FkSCESRsDXKRmebxFqE/+h3t8mNkvHM7LYTAqUe9gHEwiOGndvSwIfOsQBSfiRGSHEI7HvyHqCi12WVthYQMBMZFqP+aNl7OcF5p+G42SxguRR0y12iX5K28yxnqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZ/4XXJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788A7C4CEE3;
	Wed, 23 Apr 2025 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421494;
	bh=2wp1+RuCb3jAvwXvckrNpyvgRwaPN3JytLX7Shlw28U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZ/4XXJBPV2WmPMWrAO1oRfkx557r7Zvufi13F66YgF2B7R+oK4D70rp74ORNRwxX
	 J8U8Kxu5q1eSeBT/FXMkL6M9h3gptObUcPDAJM0nKGnDlQPu8NbcM/NiQiTzCtMwq/
	 I0CSCDY/e69jVYHq4vWZ/1NRaQznqPsG/f3Okzc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.14 195/241] drm/amdgpu/mes11: optimize MES pipe FW version fetching
Date: Wed, 23 Apr 2025 16:44:19 +0200
Message-ID: <20250423142628.477881123@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit b71a2bb0ce07f40f92f59ed7f283068e41b10075 upstream.

Don't fetch it again if we already have it.  It seems the
registers don't reliably have the value at resume in some
cases.

Fixes: 028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4083
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -899,6 +899,10 @@ static void mes_v11_0_get_fw_version(str
 {
 	int pipe;
 
+	/* return early if we have already fetched these */
+	if (adev->mes.sched_version && adev->mes.kiq_version)
+		return;
+
 	/* get MES scheduler/KIQ versions */
 	mutex_lock(&adev->srbm_mutex);
 



