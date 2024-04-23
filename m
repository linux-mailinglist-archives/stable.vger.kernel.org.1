Return-Path: <stable+bounces-40689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F758AE786
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CB2B26141
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569F136652;
	Tue, 23 Apr 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGVMN7ua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505F135A7C
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877728; cv=none; b=gjsXB0buXhzuR1n7g0D4wBOgwW8FbsnixZMh/lwVHZsZyKS3HMKH4/Ud1BbovhV0lywnT5izXqn+yo+fIPmUoLgmL3pOFY4Dm6HtmwhMIXysk5fS1EZQXWUIA6doMf1fU/zFLlYsEdoC7bFCHL8TYwiyKS+m9KWBZz47k/U/hgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877728; c=relaxed/simple;
	bh=aRHzWiAPd9NNNN/xODnrwJKN6g/Eqw0LW26fCknoric=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nm+To1A5CiXgr76GFoMUss+dC1y/Fxaomc4DSpoggJdKoRGL6g2qsb45jlUdNYikHgyOnld3rePmaScVlXnIdqxBHWom+G2HiLt3tvLl+GQaoHIj3RG7W0XDDjFHym6Mf6oNmPUa/4OhqN1dWofGD0PQfDH4Cbi05IO6S6/ZyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGVMN7ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA71FC116B1;
	Tue, 23 Apr 2024 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877727;
	bh=aRHzWiAPd9NNNN/xODnrwJKN6g/Eqw0LW26fCknoric=;
	h=Subject:To:Cc:From:Date:From;
	b=RGVMN7uaH7EQ47sgTmmJ+t2XL6w4EkURPIT79jDowB2CKzrqZIwVJ5472LHQx66wx
	 ComzKbGFDX7GkVoBh81AX4ie4GlbGUQS4874DFZe0wmGAMSNCmnVwkFL4/exGMWbk3
	 gY/kVU5FF26A3eSm5yaAiNC/izvU5Suko/zshsCg=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Sort primary plane formats by order of preference" failed to apply to 4.19-stable tree
To: zack.rusin@broadcom.com,bcm-kernel-feedback-list@broadcom.com,pekka.paalanen@collabora.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:08:37 -0700
Message-ID: <2024042337-sizzle-quadrant-ebd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d4c972bff3129a9dd4c22a3999fd8eba1a81531a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042337-sizzle-quadrant-ebd6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


