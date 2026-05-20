Return-Path: <stable+bounces-249953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JqUM/7LDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF55904F0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C7531AC17B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987B3A1E89;
	Wed, 20 May 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oXMehtps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0723E8C75
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287841; cv=none; b=sP3gPlDUZ2yOhKGXiCGe+J0FofpnYvag+HtSdlagY1SWU7oLWamvmoXPbiawFdDo/gFqnwaBpvcG7kwcVNhEIhwWzgadoFPJVecVdYh7noevAeMi2Kj/kDgFjaB1SMcH8r7sqhMd6vd9bcbYVWeISOye0HdOZIW6zvDt81qy/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287841; c=relaxed/simple;
	bh=Z30txzjq7FfykbBGrfLbR+7BqTrUE7DqqLEgPxCFEOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CnL2ykH8A8R2BChh/49HfgSN+aZ6U2klU0vUyzimCh1+BxAUT/hKcdIq0QHVmBwLtjnhSZ4S2dhZPxX2HiKPs2Isvx7rGYFnHakfQEFievP71RudNLQaAQsOIvF2zb8HPr5YZKNL5P6rYXz0/Ym5cjhiMuoEwyKaI+IXXflyqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oXMehtps; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E8C1F000E9;
	Wed, 20 May 2026 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779287840;
	bh=nEsR/PmPB/3W3oq4mH67kcr/nXAlBLzMB6/MsdtY//s=;
	h=Subject:To:Cc:From:Date;
	b=oXMehtps8PodquJVpQ0s+ysIlcuYfmoIPQIQwyrfQh6YRpLjynWFYYW56sROtmK3I
	 KFWjEdvxqovJlAivNg1zmhZD9dOYaxwRmrFWtJqooDAhF1pAGfb2LCeZwYovQxKFeE
	 jze1cdsjbio6yCwwpDr9sgPj95YigSLtY0pZlH0E=
Subject: FAILED: patch "[PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in" failed to apply to 6.1-stable tree
To: mikhail.v.gavrilov@gmail.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,pinglei.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:37:11 +0200
Message-ID: <2026052011-reimburse-omnivore-396b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249953-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,gitlab.freedesktop.org:url,amd.com:email]
X-Rspamd-Queue-Id: 29BF55904F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 183182235f6d53bac62c6c39014738a54a68dfa6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052011-reimburse-omnivore-396b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 183182235f6d53bac62c6c39014738a54a68dfa6 Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 5 May 2026 09:05:37 +0800
Subject: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in
 DC_RUN_WITH_PREEMPTION_ENABLED

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


