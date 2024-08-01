Return-Path: <stable+bounces-64998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB3943D66
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0C3B25D8D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEBE14264C;
	Thu,  1 Aug 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glsG0Jz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2381C5E68;
	Thu,  1 Aug 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471890; cv=none; b=mfEaed/r6f0uqes1imYjnsgd32x2vmQegQYr0stMEJQJ+O66HgJovoFxN6ATwvVvBuIPyYQQd2zDXp0RSy5P/wBd4/DA2gVP0T//12AGYKB2UdT6zu9IHwZlg4ZyQV5qqhSC/itgE3MIN/NFoRd+g8OZIEozZuNRURqdx+LA3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471890; c=relaxed/simple;
	bh=sJhZN1nywhtMs+jOxZKuOfxvk//enzoo4plEAcHIS+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHBMYfyBQZYkL8SM6TgBIZEwCy2lzqbZhNfUh4WqZQ6AxlWWCcWAM1BdqMfS3fgN4d6fl0Tj/crWUUjhFT7sylt12LVLu4cq0Hhlv+P59kQg2oU4g9ne4OJwohxDuhT3yuT6AXSkqmXvQF/YTowr873W56yEkPy1Qr3STFOPiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glsG0Jz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D82C116B1;
	Thu,  1 Aug 2024 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471889;
	bh=sJhZN1nywhtMs+jOxZKuOfxvk//enzoo4plEAcHIS+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glsG0Jz21y825DW9hznmL3OzLEiRlEySeUt9G9eHPobAWpNr61Zk9+uaG3eVHZQ1v
	 ueyNDWbz4dkWXl5tVJv7n1jDexd4rd1KpohXcj9XB98zs80KV1dKvjMFtL3M+KnPC+
	 WDNllW8b8lXNtAdzM7QSOpi3lMhVntSNxE9j8Cfp7t86yeME5noQV+oGAx47x3SC4p
	 Ir7malp2pKAyvHN8IpYfJUWOwDN86kmGta8fAo/fOPLJtpXRS84bHsgOldaL9G7xYf
	 +/9xDPHEW9CieAYBVXKQI6g+j6qB51avH8YP+33TssAiBK04K8+vEjRzpRfCJQ1p3T
	 VfgIl8VbhzOsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	mwen@igalia.com,
	joshua@froggi.es,
	mario.limonciello@amd.com,
	Roman.Li@amd.com,
	Bhawanpreet.Lakha@amd.com,
	rdunlap@infradead.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 52/83] drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Wed, 31 Jul 2024 20:18:07 -0400
Message-ID: <20240801002107.3934037-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit ad28d7c3d989fc5689581664653879d664da76f0 ]

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9e4cc5eeda767..88606b805330d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -49,7 +49,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-- 
2.43.0


