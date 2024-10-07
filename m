Return-Path: <stable+bounces-81210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6E992359
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 06:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707F61C210DC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 04:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF50200DE;
	Mon,  7 Oct 2024 04:03:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF73C2F
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273837; cv=none; b=KMKZ1gDtNiZDsQo2tW+GNVt4gHghm8Nff2RQCgXx9CNfm5jJwqDINwAztQ9koeQbgxbPQ8UoGww3UMCbnpQH0SJdSlK891krqcYyQ2XJbPxX43LqL2mU44J/htDAuHM7MbwZdS5WeKAMi9gjEHCETcAPk6UNdYAwr0HB/8xVmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273837; c=relaxed/simple;
	bh=/RnLXw3vk89MesAIpn1ayPePsXKh/ExoSpLraqcdsQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ss+Bl53lN/5Ih7g/4e6hrNqX+9S5CowoPN8K9ooGiiEObo3nc/XJHcTe1XZ1ZO3wkC+s0A/CILazig64LJ3JVuXRNLjVSAL0UpqgM7ahb937eyz4osQWFkTCujdey7N4c9XrBr7zRwzSIXUvXIvgFtvPAWgSbGZHIulyvEw1ZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.44])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id fcca008b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 14:57:12 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id bf0c7d92;
	Mon, 7 Oct 2024 14:57:12 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"
Date: Mon,  7 Oct 2024 14:57:11 +1100
Message-ID: <20241007035711.46624-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a53841b074cc196c3caaa37e1f15d6bc90943b97.

duplicated a change made in 6.6.46
718d83f66fb07b2cab89a1fc984613a00e3db18f

Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7fb11445a28f..d390e3d62e56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1266,9 +1266,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
-- 
2.46.1


