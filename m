Return-Path: <stable+bounces-209981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C81D2A3DD
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766DB300FD61
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B5E336EE0;
	Fri, 16 Jan 2026 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sm3Lg0qg"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2221ABB9;
	Fri, 16 Jan 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531236; cv=none; b=t6BjZ658VDpepY+MzZrNhlAiLHHL7AFmF4nXOXDtoLtKWPVEQHg8mLupWIWDN4/MqpC1NV9ivwIdVDXKS+3+iraUpZNZRs3Wucwnr+JI9uDVSmZmkjDj+/l+8ygHiHgS+0v4Ggevyx29fMuauIXYrIQyShWK7M/+uSbkz9Ottyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531236; c=relaxed/simple;
	bh=BMl6wYBEdAu/FmR8lpxBoYYXTmXk6bnUmky0WVbWwDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXrGdAXn9KqOjBhRDoCxKyBQbJ9axQBwoq50L0mF8N2VCiLcNinRbXDoRTIuTSD2t4DQ/a3p+NBy1U7XhdsI+DPj7eiFfyvIX3ct05MrCZv2iQMLLohh8Z80pJvPNN1233kDIzGoST/Td5bxJhzYwLh6+Hc7oJ3pqRg34OdWzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sm3Lg0qg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z6
	lZ+BrBAbLkCyZas3+4InPi/c+HxqLyNXj0gl5XhbA=; b=Sm3Lg0qgqcohu3EDjW
	hkTTZy8F2wkA3Fu7E4mhMk4Lb3TxVtuBzrYgyPC0K3Wl6NHimvnlXPtKJsJo8pgZ
	UYMc/sc08LJDq0V677MAkHROMXhFCP+LUdOl6uE1W6DVASYHlDeAJYYv7p6K8Iza
	DPBf7Y5AS5PnYQdWVUo4lbz8A=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHCBT9pGlpqauOFw--.661S2;
	Fri, 16 Jan 2026 10:39:59 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] drm/amd/display: Check dce_hwseq before dereferencing it
Date: Fri, 16 Jan 2026 10:39:56 +0800
Message-Id: <20260116023956.142238-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHCBT9pGlpqauOFw--.661S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Gr4UGFyUJry5Xw1kKrg_yoW8Ww1kpr
	s3Gr1rJ397Z3WUZa4DJF18ZFWUWaykXF4fGFsrA3Z5ur9IyFW0qr98ArsrGrykuFn8Z3Wa
	qF13GFyxtF1akrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR45dNUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3h8dtmlppP+SZwAA3E

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
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index d389eeb264a7..fb18a2a9378c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1228,7 +1228,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!link->skip_implict_edp_power_control)
+		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
-- 
2.34.1


