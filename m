Return-Path: <stable+bounces-158844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31395AECC9F
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F483A7C3E
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857B21323C;
	Sun, 29 Jun 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ml23W4Zk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19CEEA9
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201148; cv=none; b=RZ+Yl2WhRU1duv3UMCvhLBV1ips5VEYcch9kodbBPLwtdNn8iEzoh1Ei+nlEZcITAaJCWXGIeY+B2sp2axnOJnEJS8yP4u0yi+oOIco5yLdTOaiFD+lPMbmbmCfV/fnBRwgPagyb/mUNp1jv3Th7xsQrzvKtqL3UiPQrzdwf2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201148; c=relaxed/simple;
	bh=sz5emBhIRGcP7olD97v6ex+l6TMc+TyBpjUWw/qecJI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cgOXPeuEeFCxmMK+/1llHp6VbLpCBQRSwk3sAxG1acfdlmxlQvoeJaKFQgT4b9q5G2iq2LNB3jZN8TMYHK32Y5ebfbKlMOsIpgri5RqCWmubJ5VsVgiBP3H4VGgUnEily561yp/hqljPLtswpXP5CZlQX0z7HGGCVWuHrVljqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ml23W4Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0494C4CEEB;
	Sun, 29 Jun 2025 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201148;
	bh=sz5emBhIRGcP7olD97v6ex+l6TMc+TyBpjUWw/qecJI=;
	h=Subject:To:Cc:From:Date:From;
	b=Ml23W4Zk9eh9IDpj6TtuKD8BG8w/YaaPGV3XRsYZO61v9dCadZwbIXk/ypF+iDAJf
	 +9umcNpbv7XdTxw1sgUjKlEYeESjprGRWv/HgAU22BjUcw69PZnWwB5N2fwSC/QnIB
	 WIyAdDMACeJixyR9ECgERuqwuJfQxxhzT7w0XnPk=
Subject: FAILED: patch "[PATCH] drm/xe: Move DSB l2 flush to a more sensible place" failed to apply to 6.12-stable tree
To: maarten.lankhorst@linux.intel.com,lucas.demarchi@intel.com,matthew.auld@intel.com,thomas.hellstrom@linux.intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:44:22 +0200
Message-ID: <2025062922-dictate-payphone-2af2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a4b1b51ae132ac199412028a2df7b6c267888190
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062922-dictate-payphone-2af2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4b1b51ae132ac199412028a2df7b6c267888190 Mon Sep 17 00:00:00 2001
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date: Fri, 6 Jun 2025 11:45:47 +0100
Subject: [PATCH] drm/xe: Move DSB l2 flush to a more sensible place
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Flushing l2 is only needed after all data has been written.

Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://lore.kernel.org/r/20250606104546.1996818-3-matthew.auld@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 0dd2dd0182bc444a62652e89d08c7f0e4fde15ba)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
index f95375451e2f..9f941fc2e36b 100644
--- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
+++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
@@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
-	xe_device_l2_flush(xe);
 }
 
 u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
@@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
 
 void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
 
 	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
-	xe_device_l2_flush(xe);
 }
 
 bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
@@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
 {
+	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
+
 	/*
 	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
 	 * both for weak ordering archs and discrete cards.
 	 */
-	xe_device_wmb(dsb_buf->vma->bo->tile->xe);
+	xe_device_wmb(xe);
+	xe_device_l2_flush(xe);
 }


