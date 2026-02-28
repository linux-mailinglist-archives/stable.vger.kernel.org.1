Return-Path: <stable+bounces-220520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF4gMbk6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADE1C676A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE71D311297F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD73CD1A2;
	Sat, 28 Feb 2026 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0cQjw+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144F3CD198;
	Sat, 28 Feb 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300404; cv=none; b=Xd8Ceur94MpEfaustC7zZ2hEfxaOjNzf7AlRc0pfA/JrsV8dWkJK1clrz756gUV1e50/quJ3DUKAfErt/i1W4ZS4cXt4nQ5MF8D4ldmkq+n/jMX0LXnftU9RoNsZnBwJfIL7n3wparACiQL8xO35F2XGu2qnWqYR4FFThzJC4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300404; c=relaxed/simple;
	bh=JhcK1gvo4yTmYegjrZ9t6Zk3+B0vjGYbIhz1HG6nqHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6ZVBvV1EzFzdNK/LgyDR8YyFX+QUHWQe29t/Qx2iIf9QqrkIL7C/21pkjnQbF0mLonMk5jF6sEZralBb9tfjlJXOcK+hlU8om/5LnHSzKzcJTkDYphakRxTIyz5rRNVNJ9m47g3RbLU90WoRxGgQ2zCXje9v8wK2/J9vA3dyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0cQjw+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A790C2BC9E;
	Sat, 28 Feb 2026 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300403;
	bh=JhcK1gvo4yTmYegjrZ9t6Zk3+B0vjGYbIhz1HG6nqHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0cQjw+M4SGS2M23tZBwIT0EXBVL81jl8q6+FhJrbMjY5wKibDBlAe5oetVc/1DwN
	 Tige9pIaGuAQJ8AeNBN6x9eOzvhY5b+prhGCGa5Yzl6bY8QBnr+I5dt/zu/BSOimrY
	 U++8UsBnSwR7VFkXYvTnVL0fRUUGRGc31BRXwV4k9DC2wJTrCiObGatdA4R1/gCQpQ
	 K2QgBqBvT+4vxgcq3dJMX521aGGnG7TtyctdunGzWK+nanRSfm/vIDCpsuOZOagSNz
	 wxgCrFTS6SqfcK3XK2OQ+yaQLsRbv+XD5clO4Rot7gxZS4q/6m/2Q+6unkVYt+rsez
	 AEpm8Re2DcBCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 441/844] drm/amd/display: Remove conditional for shaper 3DLUT power-on
Date: Sat, 28 Feb 2026 12:25:54 -0500
Message-ID: <20260228173244.1509663-442-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220520-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 61ADE1C676A
X-Rspamd-Action: no action

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1b38a87b8f8020e8ef4563e7752a64182b5a39b9 ]

[Why]
Shaper programming has high chance to fail on first time after
power-on or reboot. This can be verified by running IGT's kms_colorop.

[How]
Always power on the shaper and 3DLUT before programming by
removing the debug flag of low power mode.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 83bbbf34bcac7..badcef027b846 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -724,8 +724,7 @@ bool mpc32_program_shaper(
 		return false;
 	}
 
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
-		mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
+	mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
 
 	current_mode = mpc32_get_shaper_current(mpc, mpcc_id);
 
-- 
2.51.0


