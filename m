Return-Path: <stable+bounces-230552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4On0IsjGxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:52:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCD33D40C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A83530DABB8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B0495E5;
	Thu, 26 Mar 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aan38cOJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6081F03DE
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568877; cv=none; b=E92Z34hxsGWNl+h9/VAAIhsM+ZuIrT+2YxUd9CWiOlW7vLt5fMohV4WJmuUVzryxLVQynJLjx2Bc26G1UzTCcQuLZP8D2Hf6Cs6SSLbPFcs2nl0sCipO3iYAWRCK41Ue/F+qi6LufUR3LVps+6ukwAiUzs6f8ZpcyxOeITZDDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568877; c=relaxed/simple;
	bh=HjDa2ZaVfCGyD0njzM/Hx1F3qeaUeXvsmO8wpznl5Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAhR8cacz0aCrR9SZsf4lzcY+0SqNEA9S3PQVowLbHDkmAHCgq3BpLPsjU1VqnQi946ncA3cuqDAu3Wyjn/BSHVj4MEvIHwd71LuVESDsW8YgfpdMASdFxtRZ5tUwnmfuX+uhh4yreRVboqPPU8vixIT/7tJC3Pit0cKwwyl8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aan38cOJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1228181a12.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568870; x=1775173670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
        b=aan38cOJ4P6Jt48RwEGnMigjeQYWKaP4ukgUJeBVkmXLOoeylu9TKYgsjHcVai1v7f
         vOhMsJaxHpooQVFJLyKr7YcG+OT8U81rZuXtFJ3Gam6fUW1RwQTrc9KxFmKttgol3MjI
         HgJGsq8oJaVkVg9Iex8pyQktfnpdAyPRyh2vGnZ/V3dnlJrZwiAfZ6ferhfRvg83+lP1
         Qu8jCjqJ0wCMXo5pYNJIxyW/MrQPwp6Wtou2kL4v/PrCyemntg5st0W3EfQrcUz60osK
         zOXA81bOqNLOd1YSqkh/bFPkFvOIb7Ic8Yn1tfKmGYGOZrig56BPBzIBjo6jsBdEOcWh
         +sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568870; x=1775173670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
        b=O/39oxLgdD8Kjo4JX2cQa5WnkZnuphinOcBM1BUPQJ4qGuvA6n7Aceo+1JP5nbMvvC
         4XkMjDr9gwnR7H68dnLVN7A9pHjuh+ErtS/tkV5GwKGUm9bMvDYZGb+lgFhH+IaWRfRn
         5/rm83/VcujlAInl7JPswyO0YjdJNafn6fkRbbmdbPHawvZ+rawErI6t1LWqCnsWsYx5
         5wy4yCCFEhVarsiQyNCIiUfkkEZuLEv7+B6URUEw94UCcwNKg2Dd3j1dIKmg2om8hHBR
         /5N9EZ3xDJAWsHnAgWrX65MZdATkvW69ShtD8b6VSbRQLpeRBLw5a8GSHNWbPqbFzO0Y
         YOew==
X-Gm-Message-State: AOJu0YyvGqirPvdGOjr8f0fUt5PGgXJ2Hm+22V7GZc8FCb94wD3DJzp8
	xP73M0reNhwBV0FNheI103ieUdKmsL+0ssv0QqsXvISWvtsOq9zsUSXA6nYHjN30
X-Gm-Gg: ATEYQzx5eBrkc7zKfiLjyru3lkHBzeRm5DXCUr/eEtOKiQiGUrgIyHnuDQ2j592qwtP
	Wp2Js+03YvwPrqsZpKTnXeFvNjeUYcplXy8S8wIfv6tceCDAyrLVlwfuq7auhdMw2kEC+O/7UT+
	sm0ZMr8PCkYaLqPcRus9x0ODTtSu3YdAZWgHJ0GfRAIi9K2AofbPeSd2OwFz6UOvQwt0EAnyCy2
	0mdN2/jh8S/D0sMh4gun8meSeyM38NESvvRDobZOqLYRIA9zbFDD1LE7J/ppwf8cWRT47EJ2hX7
	cm2Eoan+TG2yZP4mJGfSEG4iIb6gu1t8FPmRyG/T6RgtsJ12FOgyrwL61gMypE0trcsnFAPcZzk
	62EQ15XNvpE6DvxP7SMcRiQJyOFiy254Ybj9gCGDl7xi8IG7i9jA8yju1Ck37P+sEM2HFWOBhpp
	qIFxCU4a4nSsB7ItnfCYpDU5jm5r0YhFknxg34v5DM07sBTmLw37tvzvEBsBRvT6sW/g==
X-Received: by 2002:a05:6300:210e:b0:398:919a:ddf5 with SMTP id adf61e73a8af0-39c878d5394mr525263637.24.1774568870090;
        Thu, 26 Mar 2026 16:47:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 7/9] drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
Date: Thu, 26 Mar 2026 16:47:14 -0700
Message-ID: <20260326234716.16723-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230552-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: DDDCD33D40C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 1ae45b5d4f371af8ae51a3827d0ec9fe27eeb867 ]

Adjust the nominal (and performance) clocks for DCE 8-10,
and set them to 625 MHz, which is the value used by the legacy
display code in amdgpu_atombios_get_clock_info.

This was tested with Hawaii, Tonga and Fiji.
These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 8-10 which
are already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also	adds a check to	make sure
not to exceed the maximum DCE 8-10 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 5dbe89d9b72d..6131ede2db7a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
 /* ClocksStateLow */
 { .display_clk_khz = 352000, .pixel_clk_khz = 330000},
 /* ClocksStateNominal */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
 /* ClocksStatePerformance */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
 
 int dentist_get_divider_from_did(int did)
 {
@@ -403,11 +403,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.53.0


