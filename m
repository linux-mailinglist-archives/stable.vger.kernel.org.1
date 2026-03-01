Return-Path: <stable+bounces-222196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAgWDm2io2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:20:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA21CD750
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0818532A2941
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB72EA481;
	Sun,  1 Mar 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/uL99ou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB12C08AD
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330136; cv=none; b=fnbBBmS7wU9j9/ubaW8KbsmaL//mpEaKJiMPVl3vEMkxkyCIdzZDzMs8O06fRXKqX+aPoyrWoL8z4HAKZORYE/8GzTKnWNZ+aiLsMB5Tflg1G/jtyFgB7Al+7mHzi7ZE+hl2tUkgqlH8Yof2tFh/D17EkGQ4hb7pRzW7CDiMr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330136; c=relaxed/simple;
	bh=musc2uRF0XxxZlUq2OWGOOlzOkQAX09z5nqdbHPwYJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1+QdmLzMPYJWBkoGqJecptiAEsPFfbHdG3FYcNHzjc3vFDX1BwC8DsVbbNoSuqJkLLP4r4jdOaJz2geAeBgwDwlv3BfZgMdB6sAclEyU/LZNCPrndt0G9paQM/9wLNL8hpMeJo/2mMa6f/1869YYsyOqbHJZm7N6CGvi55rC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/uL99ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD025C19421;
	Sun,  1 Mar 2026 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330136;
	bh=musc2uRF0XxxZlUq2OWGOOlzOkQAX09z5nqdbHPwYJs=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/uL99ouGdPGadeRJLV441D4aAalYLk6gd88PviR4OWO1xpSxL4odeFS+kWmnyYvb
	 wolaM9umxCNJEznmaYnFrQACNbFVClz96R9o8r9rRSwtCF8B5RVruWqbA/2o8TKSro
	 XXksJqqWAj3mB+um/lwLrP1tytcMas4Er/kKjFgF/Wm5qAm8E4HVB02r32YE3L0Od6
	 GTb6eRl60HfGtKTna3rfQ0IIMStLYhQV1ncyQROSM/nAZL6p6CzHayqFLVFeRCP/Dh
	 bs+uAY/r8Go63ej3uJWnwJomioLxiWZ0DJexRXei/8nJVnSduDo/M0qN3/7r4MTu4b
	 KSNHlt7iGTJlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sunpeng.li@amd.com
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amd/display: Increase DCN35 SR enter/exit latency" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:34 -0500
Message-ID: <20260301015534.1722831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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
	TAGGED_FROM(0.00)[bounces-222196-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 93CA21CD750
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 318917e1d8ecc89f820f4fabf79935f4fed718cd Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Mon, 3 Nov 2025 11:14:59 -0500
Subject: [PATCH] drm/amd/display: Increase DCN35 SR enter/exit latency

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
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 16 ++++++++--------
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 7abe6811e4dfa..6fc5247526132 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -766,32 +766,32 @@ static struct wm_table ddr5_wm_table = {
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





