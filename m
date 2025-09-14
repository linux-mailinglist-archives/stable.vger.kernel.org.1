Return-Path: <stable+bounces-179569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF2DB5689F
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D941637D5
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7731DED5B;
	Sun, 14 Sep 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcNAtOI2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B810E55A
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853272; cv=none; b=fl7YVOFUDVslLevjGxSCJbkxz0URCmSnBjXBAK9S4IYFuAyEXI+ppDAa8zL/d1OX8iTLoGe0RJ0hoy7ZfvJbB2JPwNEBNa3DIyF39wBQdORwt7oSLUr9tyVw39bbLGKSSwUd025Nfs04bwcaokzeWa1s6JjZeCAD4Oy8iWmUneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853272; c=relaxed/simple;
	bh=bmS6QrZZo1BytHN9KWBmuiFQEaci9tLyOhgOFfuJQ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbtidP44rZqnubJTwzUx6/SVWmFQBA5ZocZNCV2TZT/IS8A/BAWzv05WQQsRZGB9owUGKqsHfzzvayNWMh1uBCMsXN7kE8m6rGpMqmz+4+VL9HcV+U9VnJt4Fdeano1869rEHObq29byYXW7gNJH7zWh+FOpUstK+kNti5TcGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcNAtOI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B770C4CEF0;
	Sun, 14 Sep 2025 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757853271;
	bh=bmS6QrZZo1BytHN9KWBmuiFQEaci9tLyOhgOFfuJQ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcNAtOI2+vhqvjA6+xQMm4kQ5u24EBRrnxg2jHcxjo2dKVPLSXE8VDJExe5+yOsNX
	 V9iWzn+Ra6Nf5K+h2avXR5/ZZ7JIi+jubgyk0u9rOm7lgkI8WjpDVErpm+RvLJmUrd
	 AGcatBUYyNma0mNr1ecXVi3ccG7iGfoTvVZHil7FP1BgYTaLsh7HAjnlqt5JFk3jJr
	 gespHD+YL/I5wbSLae9/z4y2yRKmiDdYaO+iMgf4biw8ePninnRgJAwAEHHv7m/DuU
	 czASSa9k5uUlnhf3K8e72xG16DOKsKlvZU2+IQ0BszozV1Q0iDfLTSM4JB8tREc9s6
	 f8XH3EauVdG3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>,
	Alexey Zagorodnikov <xglooom@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y] drm/amd/amdgpu: Declare isp firmware binary file
Date: Sun, 14 Sep 2025 08:34:29 -0400
Message-ID: <20250914123429.37713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091303-unstaffed-specimen-7319@gregkh>
References: <2025091303-unstaffed-specimen-7319@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratap Nirujogi <pratap.nirujogi@amd.com>

[ Upstream commit 857ccfc19f9be1269716f3d681650c1bd149a656 ]

Declare isp firmware file isp_4_1_1.bin required by isp4.1.1 device.

Suggested-by: Alexey Zagorodnikov <xglooom@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d97b74a833eba1f4f69f67198fd98ef036c0e5f9)
Cc: stable@vger.kernel.org
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 574880d670099..2ab6fa4fcf20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -29,6 +29,8 @@
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
+MODULE_FIRMWARE("amdgpu/isp_4_1_1.bin");
+
 static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
-- 
2.51.0


