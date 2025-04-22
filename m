Return-Path: <stable+bounces-135026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C931A95E14
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7732F177A8C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B141F4CBB;
	Tue, 22 Apr 2025 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYgAZSMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFE2F872
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303093; cv=none; b=mqQ5DIjCenWfeNOy0RL7rNX4Z0UmaETBDFY1sKujthvUuS+ztJWPMTc2f3bgWU7eBl3hWiQqppvS12YUfovryGBLwNxCbGFtyqN/XEBCRp8zrgE7iFu57inFFO4yhYqPKHPOsA1mmrrnxogG+5W0TJEaboh68BTWomwozLMoQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303093; c=relaxed/simple;
	bh=8H574IlJpGiwhtH3Jzj87ic7YzaEWyS/muEHSUI5Y1o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KNXnLNXrVI+e0onjhwZcKQfVw5maBC/bX7j9woaw2sxjoGlvV1l4G3V6Zpju32mMc5LINWCc/z/UrcsRcdjwApPjNYY3Fnbdbe4G+WTEuxXi4moizcT9UY9OcYRfd6FoimUiCa9Mvj7POvU55pMDHltk2Wme4Ba4ntGRzZUX6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYgAZSMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11843C4CEE9;
	Tue, 22 Apr 2025 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303092;
	bh=8H574IlJpGiwhtH3Jzj87ic7YzaEWyS/muEHSUI5Y1o=;
	h=Subject:To:Cc:From:Date:From;
	b=IYgAZSMBwZp/YBwKZVN8GC06t8XAI5wIYx8IC503WN3Y6hWxV1rwvJ6TfzS8kH9Du
	 L0MpCni1igNM8ZGjCWM9m/o1GzAwTVhVx0aYKbkB63qoKvX4s55PG2yH0PQEKQE+mJ
	 643UuElT9SCp90BO/DIgXfdzsdAwEaAIG8NqA0JE=
Subject: FAILED: patch "[PATCH] drm/xe: Invalidate L3 read-only cachelines for geometry" failed to apply to 6.14-stable tree
To: kenneth@whitecape.org,lucas.demarchi@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:24:47 +0200
Message-ID: <2025042247-mounting-playlist-f479@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x e775278cd75f24a2758c28558c4e41b36c935740
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042247-mounting-playlist-f479@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e775278cd75f24a2758c28558c4e41b36c935740 Mon Sep 17 00:00:00 2001
From: Kenneth Graunke <kenneth@whitecape.org>
Date: Sun, 30 Mar 2025 12:59:23 -0400
Subject: [PATCH] drm/xe: Invalidate L3 read-only cachelines for geometry
 streams too

Historically, the Vertex Fetcher unit has not been an L3 client.  That
meant that, when a buffer containing vertex data was written to, it was
necessary to issue a PIPE_CONTROL::VF Cache Invalidate to invalidate any
VF L2 cachelines associated with that buffer, so the new value would be
properly read from memory.

Since Tigerlake and later, VERTEX_BUFFER_STATE and 3DSTATE_INDEX_BUFFER
have included an "L3 Bypass Enable" bit which userspace drivers can set
to request that the vertex fetcher unit snoop L3.  However, unlike most
true L3 clients, the "VF Cache Invalidate" bit continues to only
invalidate the VF L2 cache - and not any associated L3 lines.

To handle that, PIPE_CONTROL has a new "L3 Read Only Cache Invalidation
Bit", which according to the docs, "controls the invalidation of the
Geometry streams cached in L3 cache at the top of the pipe."  In other
words, the vertex and index buffer data that gets cached in L3 when
"L3 Bypass Disable" is set.

Mesa always sets L3 Bypass Disable so that the VF unit snoops L3, and
whenever it issues a VF Cache Invalidate, it also issues a L3 Read Only
Cache Invalidate so that both L2 and L3 vertex data is invalidated.

xe is issuing VF cache invalidates too (which handles cases like CPU
writes to a buffer between GPU batches).  Because userspace may enable
L3 snooping, it needs to issue an L3 Read Only Cache Invalidate as well.

Fixes significant flickering in Firefox on Meteorlake, which was writing
to vertex buffers via the CPU between batches; the missing L3 Read Only
invalidates were causing the vertex fetcher to read stale data from L3.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4460
Fixes: 6ef3bb60557d ("drm/xe: enable lite restore")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://lore.kernel.org/r/20250330165923.56410-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 61672806b579dd5a150a042ec9383be2bbc2ae7e)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
index a255946b6f77..8cfcd3360896 100644
--- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
@@ -41,6 +41,7 @@
 
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
 
+#define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)	/* gen12 */
 #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
 
 #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 917fc16de866..a7582b097ae6 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -137,7 +137,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, u32 bit_group_1, u32 offset,
 static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 				int i)
 {
-	u32 flags = PIPE_CONTROL_CS_STALL |
+	u32 flags0 = 0;
+	u32 flags1 = PIPE_CONTROL_CS_STALL |
 		PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
 		PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
 		PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
@@ -148,11 +149,15 @@ static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 		PIPE_CONTROL_STORE_DATA_INDEX;
 
 	if (invalidate_tlb)
-		flags |= PIPE_CONTROL_TLB_INVALIDATE;
+		flags1 |= PIPE_CONTROL_TLB_INVALIDATE;
 
-	flags &= ~mask_flags;
+	flags1 &= ~mask_flags;
 
-	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
+	if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
+		flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
+
+	return emit_pipe_control(dw, i, flags0, flags1,
+				 LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
 }
 
 static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,


