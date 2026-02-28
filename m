Return-Path: <stable+bounces-220238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFoTKL0vo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A991C5828
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D46933270687
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDC371469;
	Sat, 28 Feb 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6PTN/Gy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4EC371461;
	Sat, 28 Feb 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300142; cv=none; b=CL49fKV337AHl2s/dfuxF6mgBRTNILJoa9dGdN1zFkafR6OF46v0y0LPxljgAWjsk6Hqe9IAuDjbMna+k6e1PSIlalYxTLG4A8vPgqvvAZfmsv6qLrao1Ahk2CmytxyAUs2XlPbt+U8S5K6fGjdno+QX021Mv7TA9jkcmIMZYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300142; c=relaxed/simple;
	bh=btPV7Y2TMivWIgaVJU2GSYHzCWhw0jG0pCY16L+3Ha0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmUjyb5ctLghpGIdbwuj3cIpXzxEcdAb24Vn/Sm6vpEs+cGGh9yDKHVyzCLZxJSHmbS5EsXnA5s72u0x92lOIudLnz6rU4LjO1U3G/de/+dSetveKlivRLy0xw2yy7Vc4RljdfL83epkwFzyucx6G52J9LNbapYtdD5g3Iwmr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6PTN/Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76246C19425;
	Sat, 28 Feb 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300142;
	bh=btPV7Y2TMivWIgaVJU2GSYHzCWhw0jG0pCY16L+3Ha0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6PTN/GyxI9joeJK5kILaqfV+rYTvpomh5VlbitHvY9/Olaf7MOoCZRk/eVpz3Ykb
	 jdCHpvJIGhcv5lm5WlmyoAj6183RIJ0KaZH/5meOAYSjHO5TzV6jSbUCW+5gTgPuaj
	 BPuNo3/m8r47Y9ItSAe5fQxksjdr3dENwzJ54j/Dq7XUsN/V2pRxEKiQrqz5b8qZsJ
	 Zws5D5rhudXDpn70aQAOKSZ97OY9y3iPwFCMp9ernV0z5b/OGVCxQucKzy85gTkSmR
	 HSQyeFldeffvdBK3bkEVDz/x0ha5ITu8SVw/xHzqeClXvH7BebigI5E2PudCuhHw4b
	 bEW/uGOIc8Kxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Swapnil Patel <swapnil.patel@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 160/844] drm/amd/display: Fix mismatched unlock for DMUB HW lock in HWSS fast path
Date: Sat, 28 Feb 2026 12:21:13 -0500
Message-ID: <20260228173244.1509663-161-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220238-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 68A991C5828
X-Rspamd-Action: no action

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit af3303970da5ce5bfe6dffdd07f38f42aad603e0 ]

[Why]
The evaluation for whether we need to use the DMUB HW lock isn't the
same as whether we need to unlock which results in a hang when the
fast path is used for ASIC without FAMS support.

[How]
Store a flag that indicates whether we should use the lock and use
that same flag to specify whether unlocking is needed.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e2763b60482a0..052d573408c3e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -741,6 +741,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	struct dce_hwseq *hws = dc->hwseq;
 	struct pipe_ctx *current_pipe = NULL;
 	struct pipe_ctx *current_mpc_pipe = NULL;
+	bool is_dmub_lock_required = false;
 	unsigned int i = 0;
 
 	*num_steps = 0; // Initialize to 0
@@ -763,11 +764,12 @@ void hwss_build_fast_sequence(struct dc *dc,
 		(*num_steps)++;
 	}
 	if (dc->hwss.dmub_hw_control_lock_fast) {
+		is_dmub_lock_required = dc_state_is_fams2_in_use(dc, context) ||
+					dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
+
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = true;
-		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required =
-			dc_state_is_fams2_in_use(dc, context) ||
-			dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
@@ -906,7 +908,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	if (dc->hwss.dmub_hw_control_lock_fast) {
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = false;
-		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
-- 
2.51.0


