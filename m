Return-Path: <stable+bounces-253390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLrDHxNCDmrV9QUAu9opvQ
	(envelope-from <stable+bounces-253390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:21:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D686B59CB08
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A674335FE47
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED96381B0C;
	Wed, 20 May 2026 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH1lSmws"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53223815F8
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312497; cv=none; b=Xv+09/IqBWomI4cxJUXfWYwlrHgNNRzp5G+B/aR3fKVpGzw/58FAOw5XWFsU05Qr1VduajeQEMGQxbpcI3hNC9zPEBwqc5Tw/VC5rdKeFETfFhi8J1MjX6YO2MLxAzP/yeVMR0+OmPVJwEdxxAdOyjmh0RnQsn3FwAb+WNUg+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312497; c=relaxed/simple;
	bh=Sobx/4JHq9f+/J2ZkmkIClpHocoB76fdf7aEK6VQeTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucHSejJU3tLusNF1AelHaHjogBCHX7XdGhhqCuMKeFVeJe7Z8EjBOSPhPo5K6TyXcUchZkG3YPnYXcScZiNoekoZrJBtpVPYCP2xZw+vGQ6S/LQiwcooypQWAli6lIvss74Z9Deftb+g2/pxb5CzHdOmau+TS6dMnU/jToB1DIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH1lSmws; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8704dc3a8so5646216e87.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779312492; x=1779917292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMpy6hHf5Kl/QcBykkTOuBOvcixXUlu8eUvMQgkuamI=;
        b=UH1lSmws5DCNP6d7zzUA/i65vUq6PhhNRaRFd5CXvl3gI3gT7X53KVj4BDgEZMfXOY
         6fVjOYHQXfcypzYFvKUmOy8+AbmChWOtUqNctCRLf+cVSkV5h3FofzM8SZcJq9Z8XqyV
         qk/uKkY3sYd9tRdL0uZiWZbYuctXxX+bHMVZn7YdmQ8iZRlrw0MNOIpQ6nKhbsiQ7V18
         eeIAsWPf2IpF1ArR5m4SalcRAbFws7pbVUgRozeSwxEvONklBCb+GtLfvbJQEM75RKx2
         BB9GXKOJ8vcu7xd4MKqmIGbm/69/Ko0k4PICAYaC2SWOsE55f4G622526i/RG9bRpUuH
         pGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312492; x=1779917292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMpy6hHf5Kl/QcBykkTOuBOvcixXUlu8eUvMQgkuamI=;
        b=hzL/3r1R2XfaxX/IB83TvJXS00fBCx3wwH29uUUWkwNUeQP0TtgN/kO9eoIDGOzKEX
         olUxV02FzydD8zRzcGR7VYGywhtqFmjsPJbmmuNKAXLbWKNkcEvhTzHzhY6CWfkDwSxd
         hwBxGgBgHdvVQI0z6BcJd4B254IAgLMYqUU1pXJpWqfWr+xZ9PnroNLIToqkzgtG5NDg
         huzIPztIIjtnQcY3eqVVZFpUcyOgFZbtBidMUoLGIHcj2TpH61ZQfXOjj3wb6hkBFo13
         bKhtk2iASGw4nB2u+1f9xWmC5e6mPeeBF8br2PT29z5Mmpmab1wOq83eNwpTSC6i7rUi
         EVVw==
X-Gm-Message-State: AOJu0YwE2ol2VDCUrUADGL6rjJXgDXmJu0SYaB6/KlmvK6zX0Ol3lEbN
	bzrLJzvs5Bypnc2o2WvoUCsTk3szGO+mxtSIGh5+8HvOzKe+YS9TkVdqLtvJMrz4xeI9zQ4R
X-Gm-Gg: Acq92OF3ZCUkeHP/m0GnJCSYYy7uv3W/Pdp+YLqdqcmOdw+dUvoQTY3rvOLnbRPX5Jn
	JMmIOQnZLP4pGf3g62a4DeWHY/yohYdgJmuOvkPuvC+aBpKqTgmY4+Tz/ZC095oWa1zpDQ7ePVh
	9LMkodWmaHMoqypLEiTHw3OfOIYK1dNFwQeCI5Pa5Vpu/a5JzHK2YPFUoFfzKbN9Iamx2wBTVYi
	vpkHbefEbuf5Cx17siY21fcRiigF9KsOLXsOZM6TnQ6NW0BGeYn/YLQKz6AzX4pBici+MhE9fyc
	XHSegtnakC7m2+MthB80vyYdg05FJg4KYfDo4GuOEauQITOFMStyMcvQognSfvvCNgQfPc6So2J
	2ApdeLqbanUZ9A/ZbX9o6Od69MFB/NY3WB+IhX5fYNidaRYU7YM07W/IUn+Q8pjyAf/F0lb+JeJ
	BzdyyUDVCo0/L3C7sUjWIHFp66KEVuqf/T+l+sQmKqIUs=
X-Received: by 2002:a05:6512:1350:b0:5a8:fb56:e322 with SMTP id 2adb3069b0e04-5aa2ba8f236mr36977e87.36.1779312492234;
        Wed, 20 May 2026 14:28:12 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5705sm5201402e87.58.2026.05.20.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:28:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	James Lin <pinglei.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12.y] drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED
Date: Thu, 21 May 2026 02:27:25 +0500
Message-ID: <20260520212725.182308-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052010-washbowl-cube-3ce9@gregkh>
References: <2026052010-washbowl-cube-3ce9@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253390-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amd.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,gitlab.freedesktop.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D686B59CB08
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
index ccfdca7c83f6..1fa4d32ce0be 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -90,9 +90,14 @@
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
@@ -1649,7 +1654,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
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


