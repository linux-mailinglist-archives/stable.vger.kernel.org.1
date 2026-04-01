Return-Path: <stable+bounces-232628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFJIIsNqzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7566373453
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7F830F3217
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808C1F3B8A;
	Wed,  1 Apr 2026 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqM8xUEt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AF1E98E3
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003989; cv=none; b=jxQV0ubxYP6d6BMJBK44vULZaKzCmaayuL9T3+PxYIhnkOpLtKOTW+Cg9r49mD39vSoS6FQZtbF+6FwIGMeDgqLw4sVLH3ZBUGA0zU0+UYuFm6gpMBhdNfeJu0dw34ILNPYK0gE8Jlsg80QG/Hp/DfptCVmri/zkyvgAB3tmM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003989; c=relaxed/simple;
	bh=Vacv1AYbBGRqKrpf6lgBpGx5USD27JyF6UBd15D8dNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV5Md14qK5kaTXjpyKuPL9zC6/tHyUM6Ymt68vNQdwevdTIhlOFxM0mlcaL8Sqe8ZinS4b3dgbcy8KWZiXF/Aos5hGJmxFacX+KsoBO1ri6xKW2N3MxSoAiLWO1hzZTtE38lKq/et17z+yx20htAZpW7kvK7GLtZbg4hTfogj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqM8xUEt; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c160cb021cso6504541eec.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003986; x=1775608786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
        b=dqM8xUEt4Ip4ApbjDVII5Fba6ivfGmD6rgbbfKw5d9UMbl8eqGw2HR99jlUL/7Q4AA
         s+VwtijREjTdVTNmFREDMCvFh+iQ6zVwmCSyyFEO3V/hyq6JCY3ypiixN2EXLDtyzqd9
         ci2TMxaesgidbcFH238S2YQrx2VyMhUWGek/kBJ7tYP0xdXxlytPcjCuZqwZlIr5mKmC
         h6EKGR5JVoaSkPGVLO1cfj+P40Cz0mwy0Nq7Posjw1Jm9I1lpQ7/YodRprtArchNZahj
         vVHV7d0tLKKI70rDUBO9eEws6v8oNf0suYY+Z8NRNdFWtZoKKMIyMrbRMULkA0ruBIZg
         HX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003986; x=1775608786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
        b=Ziz1sbt7GMic/wxOyKSbjXu0ImU5G67isUyArfrsmUSyIl4WexP/U8OVP9TPV6ri6B
         ZK6NZ03w4Rx0wBHDnZmldKE7tG6xQ4BzSmzTx7yZZih2noUg4++fxkW45YCIbUny7lJw
         2BdsYpDhcjrWigdWWh1bQnLyMl6KS1q3+UxJlQvq1q3TltWIUJ41PlXTFFPPRX4g6Bku
         nKD6O9s4pqDzJ03Hfz37P9tv6gt0TX5bM/SoB4ujvXzC1Z3jKKshqWuFZUaITG8CN05i
         wz4ybqFazQbe75fxBuVOI2n0vhMiczUyg7hTz1238b/H/U7QM0M3TLCpMOSJ5llWUneW
         97Cw==
X-Gm-Message-State: AOJu0Yy4nh3FGIkY7WetIGCk2G5peYWWbl9xZ8Rc1IfeoF5nqDFFC3/r
	DmbpsNqst0Jl0wPAc5ksgwfDTzhsK2hf2xQbOtoJgmCzzYsV77ivfaIblUSMnyqZ
X-Gm-Gg: ATEYQzwkGfZBxtrOsjjXr/25P2grO387fL51PTHGWvdQyjv4vRK4gAnChRP4fFOQSDm
	8f2aZUsYogZ1dxiuTY4SG5ukOo3MaU0V4tJDvIhlCJxmdFgGZUh7YDIA+abBKjxCpsisnD3O4nO
	3KGrzY/S7rkm7lQrLY0TIVVcxtPNRo8FcPftcTlifBpGYfmQ9uhu8hSHQxdVOpOFD4zq7TD/+jC
	dTd2C8cNMnvhhWS5wKyv23b989eF7zpcRPCONGKl0tYq1FOxPDch6XZHXwRt7VyRGEU7BNpjNDF
	CNwROhxIo7oeMOB8SMuvkC9BsM8ZoxmcI7RfnDFT58JJL5ZS6J3YF+PZuV/QGcgYUzRSXoyrTdz
	qr777ZR6MRAhI7EroUyGgmxiO+PyAy3wLw7+V3vKuJKwwd+4byKbs9ioRjuXcuKJnunLBbxc9l2
	jCi+23n2eRkbVWGUYviovrgK41ltDgfHaHLfRJMv/A/tngQ5ckSyUyE1kQbrkQxRgyZw==
X-Received: by 2002:a05:7300:2391:b0:2c1:27c:75cd with SMTP id 5a478bee46e88-2c9311779d8mr930291eec.13.1775003986357;
        Tue, 31 Mar 2026 17:39:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 10/10] drm/amd/display: Correct logic check error for fastboot
Date: Tue, 31 Mar 2026 17:39:08 -0700
Message-ID: <20260401003908.3438-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232628-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7566373453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit b6a65009e7ce3f0cc72da18f186adb60717b51a0 ]

[Why]
Fix fastboot broken in driver.
This is caused by an open source backport change 7495962c.

from the comment, the intended check is to disable fastboot
for pre-DCN10. but the logic check is reversed, and causes
fastboot to be disabled on all DCN10 and after.

fastboot is for driver trying to pick up bios used hw setting
and bypass reprogramming the hw if dc_validate_boot_timing()
condition meets.

Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7dc99c85b8ea..551638d9ff61 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,8 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0


