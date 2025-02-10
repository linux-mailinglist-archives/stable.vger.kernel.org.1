Return-Path: <stable+bounces-114539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30BA2ED3C
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE033A0740
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD8223313;
	Mon, 10 Feb 2025 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzvkqrIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E9243378
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192937; cv=none; b=DiYRnlfytR/FIBJWegHq9hGLxX0co/DzIvpRqq9c81/Z88K7e9W4tcN25gYj9A3m9mEUuXinHsGt9VKvsSHIHUesFIGhKcMdYxWpBXIcLtDwUkFcSihblB8evghV+jfQuLwdxjrXcgoHx4fLj+LQE1jRU6lwXYN5GyfoTL/7F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192937; c=relaxed/simple;
	bh=Lvk+/eRhTEBZmoJD7IoWajJoVy94epd7USvXDMd4rPQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LUDAFTc1sIHVpaWatGGy8+W1Mg2llKvszHiB79ewRYUbwK4rX+fxK0yN8kbpaCWrnWNOs2fr37BVO5SkxuD2diCkes6GFtNfXSuWKdEgMiMjVbmaCgxGq2ifC2rm4ebpvug9bQzHX31wliZLbHlNFMLqb1Q2boNUyGQWAvbPzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzvkqrIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55173C4CED1;
	Mon, 10 Feb 2025 13:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739192936;
	bh=Lvk+/eRhTEBZmoJD7IoWajJoVy94epd7USvXDMd4rPQ=;
	h=Subject:To:Cc:From:Date:From;
	b=GzvkqrIGZD6JzhJHwpkG/7HO4JCjasGWcSYS2UlTLht44MTM3gzogFnq99egajnHP
	 nbGK/y6vjvf3YpQwwcIi5lJky8z3pjgAGjg1yAlcFVkUKLTZZ0atR4dJOcDFQOA3Lb
	 gvCQV5ZT6gVOnxrDUfuuZP7118VScqvX5yNStM2Y=
Subject: FAILED: patch "[PATCH] drm/i915/guc: Debug print LRC state entries only if the" failed to apply to 5.15-stable tree
To: daniele.ceraolospurio@intel.com,John.C.Harrison@Intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:08:48 +0100
Message-ID: <2025021048-majority-stature-58b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 57965269896313e1629a518d3971ad55f599b792
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021048-majority-stature-58b1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57965269896313e1629a518d3971ad55f599b792 Mon Sep 17 00:00:00 2001
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Date: Tue, 14 Jan 2025 16:13:34 -0800
Subject: [PATCH] drm/i915/guc: Debug print LRC state entries only if the
 context is pinned

After the context is unpinned the backing memory can also be unpinned,
so any accesses via the lrc_reg_state pointer can end up in unmapped
memory. To avoid that, make sure to only access that memory if the
context is pinned when printing its info.

v2: fix newline alignment

Fixes: 28ff6520a34d ("drm/i915/guc: Update GuC debugfs to support new GuC")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v5.15+
Reviewed-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250115001334.3875347-1-daniele.ceraolospurio@intel.com
(cherry picked from commit 5bea40687c5cf2a33bf04e9110eb2e2b80222ef5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index bd4b3d2470e4..cc05bd9e43b4 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -5535,12 +5535,20 @@ static inline void guc_log_context(struct drm_printer *p,
 {
 	drm_printf(p, "GuC lrc descriptor %u:\n", ce->guc_id.id);
 	drm_printf(p, "\tHW Context Desc: 0x%08x\n", ce->lrc.lrca);
-	drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
-		   ce->ring->head,
-		   ce->lrc_reg_state[CTX_RING_HEAD]);
-	drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
-		   ce->ring->tail,
-		   ce->lrc_reg_state[CTX_RING_TAIL]);
+	if (intel_context_pin_if_active(ce)) {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory %u\n",
+			   ce->ring->head,
+			   ce->lrc_reg_state[CTX_RING_HEAD]);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory %u\n",
+			   ce->ring->tail,
+			   ce->lrc_reg_state[CTX_RING_TAIL]);
+		intel_context_unpin(ce);
+	} else {
+		drm_printf(p, "\t\tLRC Head: Internal %u, Memory not pinned\n",
+			   ce->ring->head);
+		drm_printf(p, "\t\tLRC Tail: Internal %u, Memory not pinned\n",
+			   ce->ring->tail);
+	}
 	drm_printf(p, "\t\tContext Pin Count: %u\n",
 		   atomic_read(&ce->pin_count));
 	drm_printf(p, "\t\tGuC ID Ref Count: %u\n",


