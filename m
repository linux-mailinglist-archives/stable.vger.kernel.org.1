Return-Path: <stable+bounces-64874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5D943B5B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052D1C20B1A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A7145B28;
	Thu,  1 Aug 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJCmQ/O4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BB130E40;
	Thu,  1 Aug 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471263; cv=none; b=VxnkbPf+3w0nX6zQLG1TjJuF1B/jOwZDmxe/CogXEceszS5G/rK+gDNx2tMx72PbPeUaF1V/b37EaBuGBm3GwqboRl9mrBVRa6A7Ea1kiNqVE6wb2CAqLDZBSIyEUNTbu844R/kD2isfLFm1szoznB4BntM7+Y1I5cwNi3A5pJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471263; c=relaxed/simple;
	bh=u8f3Fbpg7m+gCX4jvES6p7tPGmIb+3Z6Xt9QGz6loCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQs61fGYVlOx0WNXA/Q9d3XbIOcyUh5pJcmGBgU2x15s/vOhQ6C9eCGRRwxQnXtFYkB84QEbJVgkzNDiDmSyNPVDjHxTx81/oGVFlZCwlW9IQe+oosc11mlHNMuAzJbkkp1V1ny6VaeM2gUaDGficVNkQPlTIupuwoDX6ihiRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJCmQ/O4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A953C116B1;
	Thu,  1 Aug 2024 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471263;
	bh=u8f3Fbpg7m+gCX4jvES6p7tPGmIb+3Z6Xt9QGz6loCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJCmQ/O4McQmKP+K43Gmk6Hc1hb9vtV8L3bRTUHIndmWWUqTVkoqDHJLH8kXjTRqO
	 Fs87OyTuCaqxcJE2nsik9ueHoSJRunhJD1tC3RXpGJNIFHumrurH9Ff0gAk4KC2+WE
	 kEIAVltNhjoaJTUtt8gIzO+N2ruqYWJjB6wlaiknMgEsXu8lcuhnpQchEeLPJkuB9U
	 vNRThSjxGZUk7at3S58SjZc3k3ddjNtbsrRUZzSMWJ9DCeGUFOVjV/iXnXRxqujeyB
	 MMdDIK170YNjxgK3WBiKXCbBldEljwiIGjouXJc01yUQHGATDkx4yforv4yUgAOw6o
	 w51N5hRQWfQqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Zhou <tao.zhou1@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 049/121] drm/amdgpu: update type of buf size to u32 for eeprom functions
Date: Wed, 31 Jul 2024 19:59:47 -0400
Message-ID: <20240801000834.3930818-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit 2aadb520bfacec12527effce3566f8df55e5d08e ]

Avoid overflow issue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index e71768661ca8d..09a34c7258e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
-			      u8 *eeprom_buf, u16 buf_size, bool read)
+			      u8 *eeprom_buf, u32 buf_size, bool read)
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
 	u16 limit;
@@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes)
+		       u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
@@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes)
+			u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f1..8083b8253ef43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes);
+		       u32 bytes);
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes);
+			u32 bytes);
 
 #endif
-- 
2.43.0


