Return-Path: <stable+bounces-253387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBTyL+Q/Dmqr9AUAu9opvQ
	(envelope-from <stable+bounces-253387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:12:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45159C9B2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5001D3298503
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0693374E5C;
	Wed, 20 May 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbRJq6Ub"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45C373C0B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311446; cv=none; b=ThqqAm5Ml4na0DtGzYzkhn/8oUMfFHhRG748RWqBJUPHYd3n3uQUrFKGG4wQ2TPTjE804wPbNOxFem2Oj7Ty0cxxCnlgg6MuAZTwg/MIn+sOXpPhP1G/f59DHoWpx5DzjCPTQ1MFXwceUHQBBfFwUBvRbtv4GcfKWUS87XY9HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311446; c=relaxed/simple;
	bh=/l5Hz7B18s0kl3LDUf+t+bfm1uhDyT2nQqW1/5b5dTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haYs9HgiPH2DF3fJr1R9CzyZKJehpFeKvjUIPDyleQe6Y3x/zKIRnc7HGhz0f3BUWuHJOlxAMPLIqCGV9GowgMkykg2jyt8u/otWdaBqen/I7LoGJm/nPhRVdiRbeSLpaW6so66A8vMz+hc434rE6BHrrO0+gVxvT9yQwbSwiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbRJq6Ub; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso5909659e87.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779311443; x=1779916243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAtJcwtjJiTvxYWs0ErGBLQ+DZ4No32jwQQsrxq1u0Q=;
        b=mbRJq6Ubolcq3MYcK4j3THvS9ah7h2wadr+/r+aXn2l617Wf5sg3JBb+hT3Mo4qMUc
         KT6ZOk6ySRiA9E2Xm8ZbwdHoDctQrwK7zKFnavQW+ZyVX8DpSbFRSQOsYe+P45nC2upD
         V7cd1JZLeRl8BJbgQHpFfpHDYWd2DzM7EhNCl30Tq+WkmT+5e1p0ABaC5xX9+kocC5BD
         lqpiZ5bAl/ZNv54WzRSsNZ/q44Vk314JhIEwuvklE/efJG6PfqcFiuAgcF/mP4ZzK/ID
         EQtzPvzk6iwE8mU94L1hr0g6R91x3i0Dz+5UeSpMda4waG6ddw8qATdYQ2LpgUKR+S/3
         8p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311443; x=1779916243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vAtJcwtjJiTvxYWs0ErGBLQ+DZ4No32jwQQsrxq1u0Q=;
        b=IgOcPl88MfHr0Onb4HLkfwfBIFrj6Gume/+CJEqh5H0Ob5VXJyU31jDXDjoTJAcKky
         +t9f5H8GAylRtStpypzzHgCzGNNHivfluft9occRFSB34dbUCDnQQ4cujkNwaVe8jFLu
         ecztL9Lg8eRLRXHj79d1WquZ9pscImtqFr9nwsyTwVoONHxWlMpBbe1Gup4OL7JtcxNY
         3jZtVngq3N50e9saksfstQa1AMu+pOfbzI149+A91JXZBAYyKITDrclthUd1Hh5DAapg
         /obwrDiJ6NgjOr4ACg/quQAS2wXo0Lv+FuJYjGNvA4PMzxrnCor5x+oC+ZhbGSJCeHLc
         RCAw==
X-Gm-Message-State: AOJu0Yz99bkKcvCWx+AgD0NliLjjExAC7FHwi0IVG/6kDiqKhp/I2Rj5
	7TOLCWy/F3+64/WonJbO3iWAHXYlslnKVAIW5BDvxgOwjQn22MyE9zJUrO5P5wyJukxe6u8v
X-Gm-Gg: Acq92OFaFsoNKY98ene9q26ljhSJwKjLlcUDl5GHVwb/7Ivkf7+JhLBd5O6zD4TUBiK
	kApznYMpWHxt6fbvkdNpMEaAzx+TN/BialkRiOchJdBXJjuNwLVmNNcLxGA9SXCWi+M4V1XOwnk
	T3ZCylFyRWB0rpzHBcqnnqkxPoES/H15zpIMSBnHHlFUG9YjsrEvUqQw9aK6DczNyr41SANq10p
	qOcM3sTIbPmnSmsqa0MgnzS9KnXXFg5+rw90AWGYDe/eiDy6sh5X2uMcHfjjjOKs/dvYpJoBjwL
	EXpztFyZKxD9V4aHMFFO/KXdEiO6XEeB8GJ15p+yZolfWytnX87Deby2YXTU62FqbiLrEVMoALx
	oX2No4GPVP1Pz3wmtBsLY16m6596p7amIZLPhiz8/jeHQYLpfhnd6j3oNuHGuKEfYjkXeHnCfvz
	BQ1i1tpPzotmyoFkFS0VOXaHulXqZlQ61s
X-Received: by 2002:a05:6512:692:b0:5a8:a558:63b3 with SMTP id 2adb3069b0e04-5aa2ba9af60mr46016e87.30.1779311443064;
        Wed, 20 May 2026 14:10:43 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec4csm31656491fa.4.2026.05.20.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:10:42 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	James Lin <pinglei.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED
Date: Thu, 21 May 2026 02:10:37 +0500
Message-ID: <20260520211037.144082-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052010-runt-livestock-c5e3@gregkh>
References: <2026052010-runt-livestock-c5e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253387-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amd.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 1B45159C9B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Why]
dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
DC_FP_START()/DC_FP_END(). In x86 non-RT, DC_FP_START takes fpregs_lock(),
which disables local softirqs.

The DML1 path through dcn32_enable_phantom_plane() calls kvzalloc() to
allocate ~335 KiB for dc_plane_state. This triggers the vmalloc path,
which calls BUG_ON(in_interrupt()) because it's invoked within the
FPU-enabled (softirq disabled) region, leading to a kernel crash.

[How]
Wrap the dc_state_create_phantom_plane() call with the
DC_RUN_WITH_PREEMPTION_ENABLED() macro to allow preemption during
this memory allocation.

Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4470
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 885ccbef7b94a8b38f69c4211c679021aa27ad11)
Cc: stable@vger.kernel.org
(cherry picked from commit 183182235f6d53bac62c6c39014738a54a68dfa6)
---
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 8f054d9b5d57..e65577298685 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -91,9 +91,14 @@
 #include "dml/dcn32/dcn32_fpu.h"
 
 #include "dc_state_priv.h"
+#include "dc_fpu.h"
 
 #include "dml2/dml2_wrapper.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif
+
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
@@ -1650,7 +1655,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
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


