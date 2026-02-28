Return-Path: <stable+bounces-220503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH34HAw5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58BB1C6525
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B1DF320765C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5653C97D8;
	Sat, 28 Feb 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9q99RXb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD73C97CC;
	Sat, 28 Feb 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300387; cv=none; b=BBSuJoC/AUZqfBNoGxyZTDTxvxhIC3HCofPuSmt7akwZ/uW6WgFrEhW4JnDN08j9SwRcdeZWtKZS/NODL6x46UYBittb8jQZgYAg2Y4umgLsqmtzKsHZIf1ovwbLji/0hW3CTcC4B/HLIBDL1DNFfQR6TkePzWkhJBf3YWc0WM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300387; c=relaxed/simple;
	bh=BTDRynjVjWjEDGWUKmJuV6dDV3tt2Q+2Vr7hjJwaa1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCtGQq7Yr0t6kMuxDbzlnAUX28u3WfE2MdbyYLtOUawM1Swg2fKHPg6VcWa72mUFj0m5GHLO9aeFVWndRVaqYCOJSSpB+dxuemmwk2jmVos1YvuguFKdXUio3SbAo7ab4XChP946dvOy+s33WjILtoamRzSwJ1nqjFLGycdT03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9q99RXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC98DC2BCB0;
	Sat, 28 Feb 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300387;
	bh=BTDRynjVjWjEDGWUKmJuV6dDV3tt2Q+2Vr7hjJwaa1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9q99RXbYmEumK6CQfapBxsWsR9cl3NsPrh3rNV6MZTIe/aTWKOfOjgmRedTtd/cf
	 RKTYTKvjdcvWBWTqD0gsha3TXorhtVGj64spMqLdkt8tcy9plU82WJkgeBfarTiUTJ
	 N88SkR3WQacvOkPPUPmh/Cx7nq727zHgdz9g0zgEqfO5x4AixON0814mrctNLeXv95
	 wMw4nt2g546mmgrtjjJxH2xhM+GKfg4+n7H/w70wUC0uXjIc1/ejV/tX5xmy3uXwvb
	 UCsE5sBVJ9+5EdzbLwn80+6U5KpBo7OqJn4Z3HtWkh1JLcOugakGIFMZRR3fkqu8Df
	 YATwhoUOQSo4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 424/844] drm/amd/display: Fix system resume lag issue
Date: Sat, 28 Feb 2026 12:25:37 -0500
Message-ID: <20260228173244.1509663-425-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B58BB1C6525
X-Rspamd-Action: no action

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 64c94cd9be2e188ed07efeafa6a109bce638c967 ]

[Why]
System will try to apply idle power optimizations setting during
system resume. But system power state is still in D3 state, and
it will cause the idle power optimizations command not actually
to be sent to DMUB and cause some platforms to go into IPS.

[How]
Set power state to D0 first before calling the
dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 150cc3fc7b2a9..b6eee94861477 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3468,7 +3468,17 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
+		if (!amdgpu_in_reset(adev))
+			mutex_lock(&dm->dc_lock);
+
+		/* Need to set POWER_STATE_D0 first or it will not execute
+		 * idle_power_optimizations command to DMUB.
+		 */
+		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
+
+		if (!amdgpu_in_reset(adev))
+			mutex_unlock(&dm->dc_lock);
 	}
 
 	if (amdgpu_in_reset(adev)) {
-- 
2.51.0


