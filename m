Return-Path: <stable+bounces-220911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAz0OL5bo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:18:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193451C8EB2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C142B36B211B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB242B3B4;
	Sat, 28 Feb 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM3C10cq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A742B3AB;
	Sat, 28 Feb 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300800; cv=none; b=MV3UlKJxwYT1wRIElFtUkcCtkzpX/dKehzQG7weODcvUDtdSBsY8F28Evul6S/XMPo9nW6FKp/KYvJIfwz5m/mYeOIAOBIxBf2F4QtuXxmowE2aub+Kq0TFhlNtB8Xn5COST7PhSOCQyGx1q3bz0flTW2Oqd/vXZ8Eo7GaECgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300800; c=relaxed/simple;
	bh=DywTTD/mFYVFeVIeDP4xYU2oPCzjCoYlZdqd8b1uyZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL5tuLs7sdwze54tQfao+uK3tsBIHnsiH/TX3Amk00cbfd7J7JnjOqrwNzEdQKRDjuPilftLc5GsEd7q6GJCoYZzaAoXkv7Bvk+sAJmM4DyPxpakzxLmHbs2EY+16ix9LH3L7GiuJoQl30gKE+5mWXaJgNBJtxeWz/cMIe5MAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM3C10cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D1C19425;
	Sat, 28 Feb 2026 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300799;
	bh=DywTTD/mFYVFeVIeDP4xYU2oPCzjCoYlZdqd8b1uyZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM3C10cqmKdX9+JYbTvhijUTob2SEJeC0N1PTbhqUbNWG2TpwWZEgEAw7Av22TzqW
	 Uih/uAaG0QkCwi65f/a7biDHIyl64ECf4ocBle2lbWy89njy6JaQumHpoqIOUiZERj
	 fyUn7dgzPLGevfUem/h+r7FHrjkBPWz9t8a8j3XN5OjxCnMpStHVzkjfpnwIK1FmZH
	 WXz0t/GINkfkz9PrCCYdRbg0iBqW9DyUDWu2V0ssJXuT7LkTkNohloDm7eacyuZjC6
	 neif6Bebz0vN38geyWyd5dcOAVStULy21Z06P/e1BLk8xRCOL+QE6u3nuTXZOKwUC2
	 H2uWlLrz8MNQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 832/844] drm/amd/display: Correct logic check error for fastboot
Date: Sat, 28 Feb 2026 12:32:25 -0500
Message-ID: <20260228173244.1509663-833-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220911-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 193451C8EB2
X-Rspamd-Action: no action

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3d2673a22759a..8b8410ef3e47a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1941,8 +1941,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.51.0


