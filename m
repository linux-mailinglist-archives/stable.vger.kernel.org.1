Return-Path: <stable+bounces-220504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A+PK6k5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF81C65E4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D38A730EAA19
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444D43C9FA9;
	Sat, 28 Feb 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5m8R+WN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067883C9FA2;
	Sat, 28 Feb 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300389; cv=none; b=vDeefqqvQCQVeFqAsaTuJNX7FOi8vHTMa8mvoevpuyxLS7rPQnBeMca6KW77YxbdyJYv7yjuRoh2QWaXWVbNfim6l5zuvLyEsO/l7DoMmgDGhdBf/D4pkEuZNCCFJBCUY7aH4+IjrNb7Ri8/dur0KjpyIzYs6G+H8LeYOa+Enpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300389; c=relaxed/simple;
	bh=ywHQZgXUE2dXca+/1j2x1D1sumAvGLhLXQ8vjh723WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUI2wZt4bdEvOeV/QxckKF60TFJYkeWmNbUSpPzmXlr41t8xqwdGCmPTjiAH/8e4jn6Too38hbMd423nYt56K6FflmjUACM485GDcPq5hsyeWxgSMcp4b+7WOLS1Cgrpwj3h12qBPet2cl7CGSIA8au15Acv4cGayrAG+CLETug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5m8R+WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AB0C19423;
	Sat, 28 Feb 2026 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300388;
	bh=ywHQZgXUE2dXca+/1j2x1D1sumAvGLhLXQ8vjh723WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5m8R+WNYjg+aucrhvYBRcEqe11X8Zke9Qz4c9QcVg734z2icfsaUVpucyEhxAxAT
	 c5Z1g+9N4BCTCG4J1iCc94IRy3kwSCu8AnQDii+DOvDfbFMu/1c0zyBczrMyHn49Vy
	 fUhglpTFixGTDKIBCi2DswmkO5IrInWZBUKF+XHDBSkd8ETTzbnZeTw0EUzWiH+mTb
	 Rx9e1n8rhjv6y5yJ1Z7LC/akwJU0zwJtmHwy0akPC5Vpm4k8tPp7/sAUImPwREMRm8
	 RqbqpVVe0ZLWaFagQK6rCDEaKHVQs3m4nWfd/7KlhhZJ+c/h3Cs0THIwIHneU/ciCV
	 99sHil4YuXcRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 425/844] drm/amd/display: Avoid updating surface with the same surface under MPO
Date: Sat, 28 Feb 2026 12:25:38 -0500
Message-ID: <20260228173244.1509663-426-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220504-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 64DF81C65E4
X-Rspamd-Action: no action

From: Wayne Lin <Wayne.Lin@amd.com>

[ Upstream commit 1a38ded4bc8ac09fd029ec656b1e2c98cc0d238c ]

[Why & How]
Although it's dummy updates of surface update for committing stream
updates, we should not have dummy_updates[j].surface all indicating
to the same surface under multiple surfaces case. Otherwise,
copy_surface_update_to_plane() in update_planes_and_stream_state()
will update to the same surface only.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6eee94861477..e84ec4365ca6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10961,7 +10961,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 		for (j = 0; j < status->plane_count; j++)
-			dummy_updates[j].surface = status->plane_states[0];
+			dummy_updates[j].surface = status->plane_states[j];
 
 		sort(dummy_updates, status->plane_count,
 		     sizeof(*dummy_updates), dm_plane_layer_index_cmp, NULL);
-- 
2.51.0


