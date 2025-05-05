Return-Path: <stable+bounces-139805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08225AA9FEE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6559F176358
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9D28BAAD;
	Mon,  5 May 2025 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT0S7xuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74D28BA87;
	Mon,  5 May 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483371; cv=none; b=aFTtSQIb6V2binggLeDw8bum5h9jNqOZSJhuRFAUV/wGY0lInbumC4OK21dWVf1dQJA/iiyKCGww19YtGCZretdtvWCVgO/4a+a7wu2ozE+VXHl93CSfH858z+WtSUjyz19+3+R+r3C7ar6pIJ9cWDjdG8WikpLjNiOQpQZUxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483371; c=relaxed/simple;
	bh=o5+vsX92BO+BavWxRTA1ZN0bO51OBzdGdi3JS3VG194=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6EOT75c91GJndYpR2qNr8FXl47erlQxqR7JQqUXzKcaoii5gVKZuRahvBd/wBpgrum6YyNkkCa6XCu0VjIzuOKcPYM9/1QvglvBZjcJB7s7AC5R8mkJJErM1NrSVX6fEVLNAint7MMdDTjzAGV2SkNpZWZ6wecY+QELl3G2WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT0S7xuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD2BC4CEE4;
	Mon,  5 May 2025 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483370;
	bh=o5+vsX92BO+BavWxRTA1ZN0bO51OBzdGdi3JS3VG194=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OT0S7xuFYXT3rdd+bNsKyvfNFWh8FOJuy3GzkyNr2fP99gbryeb8WNLhaW7T1dAPF
	 sRYzMrRfAscJiG3uP7NlIngRY8vES5EtWJCvEFQC2UMYBGZ//wHlSxfzeXWid1ntTd
	 KWNrbZZyYViSBqWoGdbYjUjrUDtj45NQIWB7IbCcae3eX3FvVDIYuVB9itNMuahlZe
	 NOkVXSAt17FynVLHq4L9nxwyZGmUlgRosR76KjTXwjBHqlp9yxhUjs2ND1D/mYNTHN
	 8vC6y53dqghUTUxaGbOQ0m4qaFkui6u4KGbfNSmARmyPTRCAeSPYfy3YlS50aZUzrT
	 zCC2vGB9pg63w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Flora Cui <flora.cui@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	yifan1.zhang@amd.com,
	tim.huang@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	pratap.nirujogi@amd.com,
	victorchengchi.lu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 058/642] drm/amdgpu/discovery: check ip_discovery fw file available
Date: Mon,  5 May 2025 18:04:34 -0400
Message-Id: <20250505221419.2672473-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Flora Cui <flora.cui@amd.com>

[ Upstream commit 017fbb6690c2245b1b4ef39b66c79d2990fe63dd ]

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 949d74eff2946..6a6dc15273dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -113,8 +113,7 @@
 #include "amdgpu_isp.h"
 #endif
 
-#define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
-MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
+MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
 
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
@@ -297,21 +296,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, uint8_t *binary)
+static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
+							uint8_t *binary,
+							const char *fw_name)
 {
 	const struct firmware *fw;
-	const char *fw_name;
 	int r;
 
-	switch (amdgpu_discovery) {
-	case 2:
-		fw_name = FIRMWARE_IP_DISCOVERY;
-		break;
-	default:
-		dev_warn(adev->dev, "amdgpu_discovery is not set properly\n");
-		return -EINVAL;
-	}
-
 	r = request_firmware(&fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "can't load firmware \"%s\"\n",
@@ -404,10 +395,19 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 	return 0;
 }
 
+static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
+{
+	if (amdgpu_discovery == 2)
+		return "amdgpu/ip_discovery.bin";
+
+	return NULL;
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
+	const char *fw_name;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -419,9 +419,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	/* Read from file if it is the preferred option */
-	if (amdgpu_discovery == 2) {
+	fw_name = amdgpu_discovery_get_fw_name(adev);
+	if (fw_name != NULL) {
 		dev_info(adev->dev, "use ip discovery information from file");
-		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
+		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
 
 		if (r) {
 			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
-- 
2.39.5


