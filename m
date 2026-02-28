Return-Path: <stable+bounces-220870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HlXCsZKo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:06:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675BA1C7E6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A677332135D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8141EE1D;
	Sat, 28 Feb 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm0gcvDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F041EE14;
	Sat, 28 Feb 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300755; cv=none; b=Dj1xjmnTfX5QxV9gqnSoWC/2D/3ABbj8HdLfi5S6KTu8nttXubu6HsNdXUjVFwU1mRNfjdc8B2r8dTGWgU4pTt2AAJBokNWRkrw4usJJ4ep+5yDym53w7pWrFfttgxrMqK3+GrEx3/QlU+m4ihjMO6Y45xFX6BDPTZdkP1iERUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300755; c=relaxed/simple;
	bh=0fLR1J4FMSOIvTYpF/twl2H6aYPkBt+W2GMacOSwAUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5Wz0VSCLxv0s/ZZJWly3AF3CztZhNpqS9KBzeexeG7PXMvKijOYPu31bOuCi7D3gdtPBixfIPtBGOR9g5Of97epzO7gJz/7fS8RUBP+AMFzbah6Lu+a08R/NcGJH3sVTjzPSuN4TefJf82eqPREeAHpV4B6EdYOwgd7gl71WQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm0gcvDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3135AC19425;
	Sat, 28 Feb 2026 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300755;
	bh=0fLR1J4FMSOIvTYpF/twl2H6aYPkBt+W2GMacOSwAUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bm0gcvDXiAi9LoOTpa02kg7cHiOf/aTdvqci+A19hHaa79+M/RWQQWOWiDFNZjYUT
	 mnTSMJSByrYahZoLal6nIy6ZM23WHm5YonUf6ipkeblZmjObRwmqVsF60V3UNAv6WZ
	 1bVnbupSiiSbAT8OSS9R4RbRDjejcFAjVw9HaYZscfqM1YvhRDh3VmxpZJiNNQDX+L
	 JRcLdsCMd/EJgRSzIqwC+fPhFu6BXmVf9bNUw50mL1B9D4qeHtSPMpKg9RvCtdQ+zi
	 LgGbs5oG+k1sPk3mmGAYeNXyqwKgjzJQO1Q1q3KAP1IX8VPyTks5NQpwKB63bMxEi5
	 m/mbLP2aV5ykw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Li <sunpeng.li@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 791/844] drm/amd/display: Increase DCN35 SR enter/exit latency
Date: Sat, 28 Feb 2026 12:31:44 -0500
Message-ID: <20260228173244.1509663-792-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220870-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 675BA1C7E6A
X-Rspamd-Action: no action

From: Leo Li <sunpeng.li@amd.com>

[ Upstream commit 318917e1d8ecc89f820f4fabf79935f4fed718cd ]

[Why & How]

On Framework laptops with DDR5 modules, underflow can be observed.
It's unclear why it only occurs on specific desktop contents. However,
increasing enter/exit latencies by 3us seems to resolve it.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4463
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 16 ++++++++--------
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index dfd0c9505af09..0a21910c87e10 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -768,32 +768,32 @@ static struct wm_table ddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 817a370e80a77..8a177d5ae213e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -164,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 		},
 	},
 	.num_states = 5,
-	.sr_exit_time_us = 28.0,
-	.sr_enter_plus_exit_time_us = 30.0,
+	.sr_exit_time_us = 31.0,
+	.sr_enter_plus_exit_time_us = 33.0,
 	.sr_exit_z8_time_us = 250.0,
 	.sr_enter_plus_exit_z8_time_us = 350.0,
 	.fclk_change_latency_us = 24.0,
-- 
2.51.0


