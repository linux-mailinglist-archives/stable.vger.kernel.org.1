Return-Path: <stable+bounces-137061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F408AAA0BA4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDE4845A8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D02C17AB;
	Tue, 29 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcst.ru header.i=@mcst.ru header.b="p5ZA9exv"
X-Original-To: stable@vger.kernel.org
Received: from tretyak2q.mcst.ru (tretyak2q.mcst.ru [213.247.143.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692752BEC5D
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.247.143.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929730; cv=none; b=L5hnRo2kWRbG6ZGaGoRf1r7zphlz3kJuxXpr2crGNLcCeTxhhKaCZK3KeUZhSaZbR98+W/U8qOcc3VhZZ1jcrfATwKgE/lJDRLM2VAnWOY7cPIlmgQNCaaePDBSdvkOb3QkY8qgcNeai2kEmjlgcVirxmHZtm9wZcyLem3RKy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929730; c=relaxed/simple;
	bh=ZGOwHJN9T6Ufq78cJaZMUAQsKWhGnJeXHj2oH8VgLH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZb43xQz1E1qHB3dv3p5p3ZOfV7uT75pydWqxErOtJfP/ZVCG2TdLQwowrr4nANqYdaNEXZzhZOiJZL9scuFkbrWpSkibWixvPhbuYKKpRcJDhNtvj48cn55FKQf0FIsxul6ruijpogKjrG6o19ucJsqmTSlMfeu8fOp1iuy0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; dkim=pass (2048-bit key) header.d=mcst.ru header.i=@mcst.ru header.b=p5ZA9exv; arc=none smtp.client-ip=213.247.143.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2q.mcst.ru (localhost.localdomain [127.0.0.1])
	by tretyak2q.mcst.ru (Proxmox) with ESMTP id 0ED22100C09
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 15:28:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcst.ru; h=cc:cc
	:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=dkim; bh=ywxBNZm
	/e8MuqcQvNAqzfZyw9hVYSTV4wTfXNoxerqU=; b=p5ZA9exveVnEd/AVFHrAPky
	wTA+tUq7WuVaCUDajMDcHNYVm9djyGMWplG4gnw/v5+vqO0AuWDvEcZ5EqdCg57F
	5zDxMcDrv+XFlqtK6UVIdgS6V94imODgkH/xIglmjfXrfJJsaHqvg7/yUOdrKfdc
	xwzN/Jfcmbqdky7blaWTENpCTDYn6pYk4tP79g+sB5liglyo55mtofn5FDCdepyE
	570I9x8b/FiyV8QqPnXO9i1v0cSGuLL2Ewi+cTEAnjqMHt0VO1/myRYvepPIgclt
	r2cfWLxQMz9KMBSPeXwFy6al93GFIDFdU+4PmyKLDX5E0zE7EvbaUXT6r3/rHUQ=
	=
X-Virus-Scanned: Debian amavis at mcst.ru
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [lvc-project] [PATCH 5.10/5.15] drm/amd/pm: vega10_hwmgr: fix potential off-by-one overflow in 'performance_levels'
Date: Tue, 29 Apr 2025 15:20:15 +0300
Message-Id: <20250429122015.1503994-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

commit 2cc4a5914ce952d6fc83b0f8089a23095ad4f677 upstream.

Since 'hardwareActivityPerformanceLevels' is set to the size of the
'performance_levels' array in vega10_hwmgr_backend_init(), using the
'<=' assertion to check for the next index value is incorrect.
Replace it with '<'.

Detected using the static analysis tool - Svace.
Fixes: f83a9991648b ("drm/amd/powerplay: add Vega10 powerplay support (v5)")
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Igor: In order to adapt this patch to branch 5.10/5.15 the variable name
'vega10_ps' has been changed to 'vega10_power_state' as it is used 
in branch 5.10/5.15.] 
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 79a41180adf1..30eab5002077 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3171,7 +3171,7 @@ static int vega10_get_pp_table_entry_callback_func(struct pp_hwmgr *hwmgr,
 			return -1);
 
 	PP_ASSERT_WITH_CODE(
-			(vega10_power_state->performance_level_count <=
+			(vega10_power_state->performance_level_count <
 					hwmgr->platform_descriptor.
 					hardwareActivityPerformanceLevels),
 			"Performance levels exceeds Driver limit!",
-- 
2.39.2



