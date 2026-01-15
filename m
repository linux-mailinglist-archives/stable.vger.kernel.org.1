Return-Path: <stable+bounces-208425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2DD22FE4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 09:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DDCA302AE02
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269432E729;
	Thu, 15 Jan 2026 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HFnvmfhF"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300B32D0DA;
	Thu, 15 Jan 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464079; cv=none; b=f4UHWbFolnzWn9NBovrMoMBiYQ3wUgDtwsswvLpty+HToxU1giqoL2Ow6x16Gvrzz3kuPtC+oYrnOfcitk/R6OgLtHNoPH2EPDsqk3D6pSniFBazLnvOgc2raQz8XyV4s4b9EUZlqJ6Lu7KK96oLbXhfNQM5dno+uK+l44mVi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464079; c=relaxed/simple;
	bh=lXDrfcYT2/L6H0I+Od/Sh574+4eSfA0FLWax4xrReco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQm/UUFWdKaA4JErxQBdxJ816V49qwevxtKDf+znRkQHKUa+n1S8QmqoYkG62DwmeDnkbvvma9/7tkVMSWIQO8Dse0aDWkyRHMp6zD32qu5rKLPqduwBeN289KI9OKFbIatxBppQYNy2egb1oWpBBdKQWa02EOJc4LUpurQW9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HFnvmfhF; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ts
	P3vu7i/YOBVx2BAnqJqecOaEhTmHap+OVDhYqSDR0=; b=HFnvmfhFTGD1DIgKyt
	G/yAHuf3pMOvOvp/lsrIkOdCtYUTv/qHxy0x46hfE7kPzMYt/KUd1QSZzlNgY2ec
	8up1kp14KFGafhb/z7gQ05KXExIcBx8kc1swhdc3UvRehWza3aHUHqp1OHuRZlv2
	PGVH6SNiNcLM1cDKcqjRhvNik=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3wo26nmhp4AC2GQ--.6711S2;
	Thu, 15 Jan 2026 16:00:59 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v5.15] drm/amd/display: Check dce_hwseq before dereferencing it
Date: Thu, 15 Jan 2026 16:00:57 +0800
Message-Id: <20260115080057.339115-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3wo26nmhp4AC2GQ--.6711S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Gr4UGFyUJry5Xw1kKrg_yoW8CFWUpr
	n3Gw1rX397AFy8Za4DJ3W8uFWUWaykJF4fGFZFy3Wru3sIyFW8X39YyanxGryxuF1DZ3Wa
	qFnxGFW7tF1FkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pii0eDUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+RtK42lonrtjxQAA3J

From: Alex Hung <alex.hung@amd.com>

[ Upstream b669507b637eb6b1aaecf347f193efccc65d756e commit ]

[WHAT]

hws was checked for null earlier in dce110_blank_stream, indicating hws
can be null, and should be checked whenever it is used.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 79db43611ff61280b6de58ce1305e0b2ecf675ad)
Cc: stable@vger.kernel.org
[ The context change is due to the commit 8e7b3f5435b3
("drm/amd/display: Add control flag to dc_stream_state to skip eDP BL off/link off")
and the commit a8728dbb4ba2 ("drm/amd/display: Refactor edp power control")
and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 87825818d43e..2da3fd6522bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1208,7 +1208,8 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		hws->funcs.edp_backlight_control(link, false);
+		if (hws)
+			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
-- 
2.34.1


