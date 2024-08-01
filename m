Return-Path: <stable+bounces-65055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4D943DE4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B0C2830E0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E5B156F2A;
	Thu,  1 Aug 2024 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFwfIXDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372916D302;
	Thu,  1 Aug 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472206; cv=none; b=EZ6BzeJKwnlKQh+keCHEcfSk4xbwHdVcqwpNkyIYNNsXf/ouefLuTlv2rKk4sjd9DGfsgAJsEyA5svPLkIEtIs2HytHkL42cVb2WatwLQUn8sjoFFHI6njmzr1Jw9+vCpNz+Wd+Lm+U5Vch5BdTjIQwfOvg090+nDyee+BFP/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472206; c=relaxed/simple;
	bh=0bI9+w/hFpDnETbZHXp4jVTxP5Q7S2zAMabv/M1qWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DR+z5iLaYzM9OGIkj9dnJC1UYvaJIzOLwmDlvI5zOqzKXnySQePjdLeVLXK0GhnG5U92SRzqv6B0r2g9NfJqlwUQx4sSyqvElZtQJuwGw/SC1MOFRuDsCEopgspUOmgsSbkl4rXXzqn0mx71eorQ8dxBekSgQK2sgkpjb/EAHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFwfIXDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217F9C32786;
	Thu,  1 Aug 2024 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472205;
	bh=0bI9+w/hFpDnETbZHXp4jVTxP5Q7S2zAMabv/M1qWRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFwfIXDXOjOheW5vXFbF87+B85bfFJhGVsM/EXODHMGqW/lCuC9QzFMfQVZ6FwwBF
	 XUqJnAryjaXA/8eNLUeVWoK1E/zOQpIiPRHxR0J3SyC42GoJPn5TakV7kmTTzKG7tI
	 tLFPj9/Kib6QQZsnU9Cs93nQrEPK4Kv7kh2yV/5k4t3Sa/mUAAJxnRpDlSfNuwTHNv
	 crNgrIEZ/25ZYeAgnuMCwqWvRNxk9ItPYsnHfc+bb++sjPlOe8BpvpKfD/4108Mm1F
	 tDs3eVl5fAW6e9abD4Xkhn8+X2yWtJo73ZwrbgAVuSGJS8RyZdoKGc2ISiUDMZbqAW
	 fOuVsWapumX/w==
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
Subject: [PATCH AUTOSEL 6.1 26/61] drm/amdgpu: update type of buf size to u32 for eeprom functions
Date: Wed, 31 Jul 2024 20:25:44 -0400
Message-ID: <20240801002803.3935985-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index d6c4293829aab..3e4912f1f92af 100644
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
@@ -226,7 +226,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes)
+		       u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
@@ -234,7 +234,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 
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


