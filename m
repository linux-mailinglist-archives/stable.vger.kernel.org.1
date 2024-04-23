Return-Path: <stable+bounces-40688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101788AE782
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429F11C235E1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D354135A5C;
	Tue, 23 Apr 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0t6X6X6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAD135A49
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877726; cv=none; b=dtUziml/Q+aAeE1N+UimLoBbRFN40ATPxUkaTFkTKqNezaSJnMA8RAYxmmzOoqPjkAeJxkMS9zqLYSo00QcurDdtP5T2NjLcPX6VvoKLO0DyOI8rEYr0owoTyF+3Fj1N1Z99Ogxi9yGa0f/RycKKuoOxRxVBetsa2Z9eymcGZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877726; c=relaxed/simple;
	bh=/jLbHYeyZz3yjVYqSs9hJzsb2CsSlPOm3Pfnl4saIXY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e423sB47tzfZMkrkjBejdS5rt8F2rpn8mg0WUOGwaMA1vZ38Xv9kZjCi4gSAO48o3JQ63wcxHcM/sZ/RDkW7KbHkKjE76l9m3C/j11JU6oChSa1hsXiELxqZTb//cj+rcuwAWfEWRvEC1gA7Fiw/lQCyipdhJ71gqA4466msWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0t6X6X6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2862C3277B;
	Tue, 23 Apr 2024 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877726;
	bh=/jLbHYeyZz3yjVYqSs9hJzsb2CsSlPOm3Pfnl4saIXY=;
	h=Subject:To:Cc:From:Date:From;
	b=0t6X6X6TZ+tar/d9qRFIcSAixsAf0Py0dzPgN+PHbKta//K6WA8X+LL/tK6LjlaSp
	 d5/KEwRvWG4KSMaxMZGZzv/KmmIAwuYQ2h7GiOcoQOYy4TAeRFipNxIkDzvC1BDr1y
	 TNQK0pEQQJ7owb76hK/EuEWH5okRR9BXVPYYK/Ak=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Sort primary plane formats by order of preference" failed to apply to 5.4-stable tree
To: zack.rusin@broadcom.com,bcm-kernel-feedback-list@broadcom.com,pekka.paalanen@collabora.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:08:36 -0700
Message-ID: <2024042336-upscale-specks-c8aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d4c972bff3129a9dd4c22a3999fd8eba1a81531a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042336-upscale-specks-c8aa@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d4c972bff312 ("drm/vmwgfx: Sort primary plane formats by order of preference")
8bb75aeb58bd ("drm/vmwgfx: validate the screen formats")
92f1d09ca4ed ("drm: Switch to %p4cc format modifier")
d8713d6684a4 ("drm/vmwgfx/vmwgfx_kms: Mark vmw_{cursor,primary}_plane_formats as __maybe_unused")
5fbd41d3bf12 ("Merge tag 'drm-misc-next-2020-11-27-1' of git://anongit.freedesktop.org/drm/drm-misc into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4c972bff3129a9dd4c22a3999fd8eba1a81531a Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 11 Apr 2024 22:55:11 -0400
Subject: [PATCH] drm/vmwgfx: Sort primary plane formats by order of preference

The table of primary plane formats wasn't sorted at all, leading to
applications picking our least desirable formats by defaults.

Sort the primary plane formats according to our order of preference.

Nice side-effect of this change is that it makes IGT's kms_atomic
plane-invalid-params pass because the test picks the first format
which for vmwgfx was DRM_FORMAT_XRGB1555 and uses fb's with odd sizes
which make Pixman, which IGT depends on assert due to the fact that our
16bpp formats aren't 32 bit aligned like Pixman requires all formats
to be.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 36cc79bc9077 ("drm/vmwgfx: Add universal plane support")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.12+
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240412025511.78553-6-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index a94947b588e8..19a843da87b7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -243,10 +243,10 @@ struct vmw_framebuffer_bo {
 
 
 static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 };
 
 static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {


