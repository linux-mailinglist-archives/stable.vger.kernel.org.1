Return-Path: <stable+bounces-243908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLKSHNf/+Gko4AIAu9opvQ
	(envelope-from <stable+bounces-243908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:21:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F24C37F3
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638FA305789A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81EA3126C4;
	Mon,  4 May 2026 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/yq6Obb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45D30C629
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925954; cv=none; b=N818ghZklDNsFsyDchA8K5QpshTKHWn7AwL6KH9JT7JXm5rF4kQGQM8Fl0VggDti60OO86qrUryVNT+H0nQn0OFOde1OiwXlD+WkZBl+OQBTxj6x4Pym5TLNNRHGLuCzFl+58ihHgYbda6oYcSNbhZhKCNm5I9c2K4dmokA6fOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925954; c=relaxed/simple;
	bh=EF/AXOZq24b4Tnt1bvQhOXUwu01Y3py1+Jyfb67o9BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXovH4RXpbpXwXiQ+4fCMEU+/UWWGkmjWSmBLsP7VcFIA+Z9zQc0BD8SxQSNR9AIaRpUBe8O6QlETjtih7Qlm5p8QS0zIor1AN2DC/ME2UftE47VqSrmblcRLy9T7SUV3kAYSYLJbcXT8q67ckmJuwKgnTXeybdyZntsT7oXdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/yq6Obb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a860667fabso3351634e87.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777925951; x=1778530751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tOD8/6djJ4pMyTuanqYIEyAgeWg4xBI8A3+BKBgiYE=;
        b=k/yq6ObbBgnyW4N5VMtPd9CvOEyfEyw/Zoq7pXMthK3WWIMT4PYIxhObc5mAafbJON
         m0GqgMo8i6YUwFu1tupbGV/6H+dikEc9OfLLSXqbTCmGsHsTGc0R4mqpjWXk7yNxnQ4B
         xVcK8PeDkQA2cFpsNS+jpx0B4Wd9oKUQO+WxBDp7K9/lwLuBRNSyVEA+mwzhxR8t7P4J
         f4UHPaPxfnukYvnB5adk61f3LA8RthEZEz8G4JwPiLbOzHDixH21Za7nDP+vyb6x04zb
         YyNh8p5gk311qeKX0Kw+IHmd2s3bFOU0lHG9mpUK+4zs2F0GGHDkkpAmHUQzxaGRJ87x
         3HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925951; x=1778530751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tOD8/6djJ4pMyTuanqYIEyAgeWg4xBI8A3+BKBgiYE=;
        b=SiXygTYwr/QZdQWitFTsyWwMPjkzkzPx3msMjU191AbMnPOPM1AuhxZR0iotJnZu6p
         AZ8xtwiAsc9hkufFyY5XKbz5SyeREagDl5L1pVe7Q3KXbCdqsZhhn2OFkUC1uzsJWs7a
         poLMN3CebsWsUCWIwkkTPXlgzNpG/ZjOi83j+E2Se2KTPO0tD6B4wg9uq5c/jjYi/yOt
         n2SFc/R6aHWpFkpDw5MGvQf4ibKXbh22nIZnKpEKNbBnUyec+aaHAz7oRsN5EniQiDyO
         boC65kwrqmkuUkQznBkPDAg6YvoAg+jv6XXdyCD+ePHWEbcjiARTQ5OKkS5WwZAQf+eY
         3g2A==
X-Forwarded-Encrypted: i=1; AFNElJ9tLojTmyD+RqYatbmTZgUQRtz91IsBO9Axh7YQmGz7oWsLkpndUtMF/2CesDksZdETylyYbs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbjBjDVYeT3wrI2bRaOv3DXdBPKAN5iZTLEP7RHtCu73Wsf8e
	2TTZgLhbVzBjE+WE0wUiXgSFVdIL75hIAbD2tSGLifl/5UNEeDDVFdNn
X-Gm-Gg: AeBDietOQ+jqvcLt9CBeUfBgOVhxBFlkcsVJf+lIMnnXVeQpvfDYNlMRHdruGHCBF2k
	kdztIaJPzilHqqIQKJcQ0hnO7TKKmiUuR/ZptAYqZxWcsxTHsWQmi6n15d9zX45WzczaCHlcxN2
	8CeiPMGQuuX0bOGLmpRxGe4WiLE90vi7qzLWVyUBD32DpXD4epzLk7tYEH2BmuyBEzVlo7cI167
	6oERWtethTMw4Y1s1aUASW1GuhJ8F2N32W4teJI8RM14/K7uwFqOgMa/ihaBAyBZVz8r8izmM2d
	jbbeWLsA6cEYDP+Wi23gA/o6DNzWtL9C+C9sTnQ/L32kmgSwxyXkVP5jRpKFk7KEK+VhBjEV67t
	APBKlYLqGfaqZChVuPKZwKG39ti7YuSoZksTHQqAeiHetlDe9n4LOOAZu7gfki78N+ExYNd3ahz
	qsiYh9OXC4yGUeSBm8LdkV6j2iyYxG1PIaoal42zaP8x/8
X-Received: by 2002:a05:6512:3f02:b0:5a4:175d:21a with SMTP id 2adb3069b0e04-5a862ec2566mr3851306e87.2.1777925950756;
        Mon, 04 May 2026 13:19:10 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c230c68sm3245638e87.19.2026.05.04.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:19:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: siqueira@igalia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ardb@kernel.org,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	Roman.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED
Date: Tue,  5 May 2026 01:19:05 +0500
Message-ID: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D94F24C37F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-243908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,gmail.com,ffwll.ch,kernel.org,amd.com,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
DC_FP_START()/DC_FP_END(). On x86 non-RT, DC_FP_START expands into
kernel_fpu_begin() which takes fpregs_lock(), i.e. local_bh_disable().
Allocations done inside this region must therefore not sleep.

The legacy DML1 path through dcn32_full_validate_bw_helper() ->
dcn32_add_phantom_pipes() -> dcn32_enable_phantom_plane() unconditionally
calls dc_state_create_phantom_plane() -> dc_create_plane_state(), which
performs kvzalloc(sizeof(struct dc_plane_state)). On a recent kernel
sizeof(struct dc_plane_state) is 343736 bytes (335 KiB), well above the
PAGE_ALLOC_COSTLY_ORDER threshold, so __kvmalloc_node() takes the vmalloc
path. __get_vm_area_node() then trips its BUG_ON(in_interrupt()) because
SOFTIRQ_DISABLE_OFFSET is set in preempt_count:

  kernel BUG at mm/vmalloc.c:3206!
  RIP: __get_vm_area_node+0x257/0x2d0
  Workqueue: events_unbound commit_work
  Call Trace:
   __vmalloc_node_range_noprof+0x22b/0x570
   __kvmalloc_node_noprof+0x3d0/0xb40
   dc_create_plane_state+0x35/0x290 [amdgpu]
   dc_state_create_phantom_plane+0x1a/0x120 [amdgpu]
   dcn32_enable_phantom_plane+0x101/0x780 [amdgpu]
   dcn32_add_phantom_pipes+0x47/0x460 [amdgpu]
   dcn32_full_validate_bw_helper.constprop.0+0xa46/0x1d70 [amdgpu]
   dcn32_internal_validate_bw+0x49c/0x1600 [amdgpu]
   dml1_validate+0x20f/0x800 [amdgpu]
   dcn32_validate_bandwidth+0x317/0x540 [amdgpu]
   dc_validate_with_context+0xd34/0x1d30 [amdgpu]
   dc_commit_streams+0x7ca/0x1810 [amdgpu]
   amdgpu_dm_commit_streams+0xfd4/0x1e60 [amdgpu]
   amdgpu_dm_atomic_commit_tail+0x29e/0x3520 [amdgpu]
   commit_tail+0x204/0x4b0
   process_one_work+0x8fd/0x16a0

Per-CPU __preempt_count on the crashing CPU at panic time was 0x202:
SOFTIRQ_DISABLE_OFFSET (0x200) from fpregs_lock() plus two preempt holds
from dc_fpu_begin() and kernel_fpu_begin().

The DML2 paths already wrap their large vzalloc()s in
DC_RUN_WITH_PREEMPTION_ENABLED() to handle this case (see
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c:26 and
drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c:24). Apply the same
guard to the DML1 phantom-plane allocation in dcn32_enable_phantom_plane().

This is a separate class of issue from "drm/amd/display: Fix unsafe uses
of kernel mode FPU" by Ard Biesheuvel, which addressed callers entering
DC FP compilation units without DC_FP_START. The bug fixed here is the
inverse: a sleeping allocator invoked from within an active DC_FP_START
region.

Reproducer (RX 7900 XTX, single 4K HDMI display, DCN 3.2): launch any
workload that produces rapid atomic modeset commits. The most reliable
trigger observed is launching Rise of the Tomb Raider via Proton and
repeatedly pressing the Super key during the level loading screen;
crash occurs within ~4 minutes uptime. Random crashes are also observed
during routine fullscreen toggles (image viewers, chat applications).

Hardware verified clean: memtest86+ 4 passes, stressapptest -W -m 32
4 hours, both pass with 0 errors. KASAN active, no reports under load.

Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 82f81b586986..3751f7a94a05 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -92,9 +92,14 @@
 #include "dml/dcn32/dcn32_fpu.h"
 
 #include "dc_state_priv.h"
+#include "dc_fpu.h"
 
 #include "dml2_0/dml2_wrapper.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif
+
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
@@ -1684,7 +1689,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_state == curr_pipe->plane_state)
 			phantom_plane = prev_phantom_plane;
 		else
-			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
+			DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =
+				dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state));
 
 		if (!phantom_plane)
 			continue;
-- 
2.54.0


