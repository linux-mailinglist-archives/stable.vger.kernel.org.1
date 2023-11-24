Return-Path: <stable+bounces-1864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB2B7F81B9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B0DB2206B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40462E858;
	Fri, 24 Nov 2023 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yaku/S5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE22FC21;
	Fri, 24 Nov 2023 19:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E907AC433C8;
	Fri, 24 Nov 2023 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852461;
	bh=G5SbTkLj7Oj/YfQ/5Ubo3tE36Kzc+4nNUcDii/XDQU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yaku/S5q0IxX1GiTmY0yW+k3d0HgoKhWI4w/HSfsK0wjLwZ3014vZ9lPezrQqx9Lk
	 OsYnOZpgpPqI2riwTrncm7v2uEkxVS2iMW8aiiZ/rq0BjRIfTHYaVPlECKrECnPdQI
	 g2yR2pt5fdXsKtAG0xJwn4hVqbTbo1s1/glF2UIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 366/372] drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer()
Date: Fri, 24 Nov 2023 17:52:33 +0000
Message-ID: <20231124172022.473187700@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit b71f4ade1b8900d30c661d6c27f87c35214c398c upstream.

When ddc_service_construct() is called, it explicitly checks both the
link type and whether there is something on the link which will
dictate whether the pin is marked as hw_supported.

If the pin isn't set or the link is not set (such as from
unloading/reloading amdgpu in an IGT test) then fail the
amdgpu_dm_i2c_xfer() call.

Cc: stable@vger.kernel.org
Fixes: 22676bc500c2 ("drm/amd/display: Fix dmub soft hang for PSR 1")
Link: https://github.com/fwupd/fwupd/issues/6327
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7219,6 +7219,9 @@ static int amdgpu_dm_i2c_xfer(struct i2c
 	int i;
 	int result = -EIO;
 
+	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+		return result;
+
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
 
 	if (!cmd.payloads)



