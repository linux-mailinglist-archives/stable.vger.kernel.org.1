Return-Path: <stable+bounces-208415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A77D225D7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 05:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9513E302921D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658F19CC28;
	Thu, 15 Jan 2026 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fcl9z4SI"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BBE555;
	Thu, 15 Jan 2026 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450917; cv=none; b=FTp6vWX81X6yoPEIP9Mw5D7H9smTdvYD2BAGSlrBNZA8ZwEwYfLP3cmKiavwXon0+mtx5BOKpoGMLtFZ3X8kFl3Fmjg2cS6tK4mPajrZx9Tdku70NfVLtWYDwrRa9Ceb1ZVY0DxYcctRubNOrDr5wcmmxojhxHhkzsd0miGfdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450917; c=relaxed/simple;
	bh=976gSRyCKaODIP02eo6OMC27csqr721T9bqwWYZao4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ey7Q4PnOpvowTE0kcjQaN6oMSxGRr2pvyu7mMo4I+w4AXYHVuu3+V+b+rYfP/6PsKvOhoOILtwWcuJgO8DahOrH+Y1qCGTaVfQJQR/6+xNwUt4CSPA01G4aAoq0yxrk9KC7Yc/IEgNlj3rFEn6AmuOInKf3CKH/WwD8nNKsXWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fcl9z4SI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0x
	N5qkpBt16NXoa/mY6LU4Sk6kdGvDC2qt19ietR/PE=; b=fcl9z4SIFys1nhlbnF
	R4rkcAte0gF8buU9jaGzMEUdr4NAwttk1ZYsfT8GXxr6B3rWc2ST5hl5R4Nj5SDX
	9QVM7X7oUnLaN0KMM09oVwHZhc/oazcSGyQqmIiBZnFJzHhR+gsn45T62q794Le2
	qdYq3QOzyWDf3NWSi87EKWscQ=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX_gnKamhpwpQWGA--.42068S2;
	Thu, 15 Jan 2026 12:19:23 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.1] drm/amd/display: Check dce_hwseq before dereferencing it
Date: Thu, 15 Jan 2026 12:19:19 +0800
Message-Id: <20260115041919.825845-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_gnKamhpwpQWGA--.42068S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Gr4UGFyUJry5Xw1kKrg_yoW8CFWUpr
	n3Gw1rWws7A3WUZa4DJ3W8uFW5uaykJF43GFZFy3Z5u3sIyFW8X39Yyan7GryxuF1DZ3Wa
	qFsxGFWxtF1YkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimLvdUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+gtB2mloastrngAA3-

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
and the commit a8728dbb4ba2 ("drm/amd/display: Refactor edp power
control") and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 508f5fe26848..c542d2ab9160 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1233,7 +1233,8 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		hws->funcs.edp_backlight_control(link, false);
+		if (hws)
+			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
-- 
2.34.1


