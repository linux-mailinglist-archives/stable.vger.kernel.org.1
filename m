Return-Path: <stable+bounces-158912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D967FAED8A4
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B141898E51
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461F423BD02;
	Mon, 30 Jun 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJ7GcC4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738721420F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275526; cv=none; b=MgLBByM45SrlLZrNhFdfnJKTMIUOWu4aHcjm8mFKDHYy9apDfPxobpVQaWy1EHGHPaUiaRl+n6gWG95cG+oh2DTAwImQD1yF80Cnv/KbsO015Hp67mGGL6Aj0SzeagWeuuXDnKlQ0fmrwlArMB2Zgh3oU8SgOiJYbRmPRd09fWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275526; c=relaxed/simple;
	bh=aCTnSJsHSaJ8JQK1MN96CjTn2VRILHTQAOhnk983zeg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V80wau6PZ+E0PDRycXQKEtOqYY/jWkgF/J2YcqIRVZsvjAOiOD4i5G8wgAVL5NsYcLBfaHKfaB7/4E/FF8RbWX+HlbWurMQE3q4UCXblmtxTixKBH9Y0DHgkGouXkYtxCUhgTaVx9oWZ/DX3HXmhAr4tAINuZms/X0YJEH5DZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJ7GcC4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E034C4CEE3;
	Mon, 30 Jun 2025 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275525;
	bh=aCTnSJsHSaJ8JQK1MN96CjTn2VRILHTQAOhnk983zeg=;
	h=Subject:To:Cc:From:Date:From;
	b=xJ7GcC4nHYxPG8akfA6g7HVhAp3bomlbtZFYeo3h9w4cY3i6OWJUI8db/1G3Lh6Xz
	 GtSBl0tyrtLWWf4j4LD0kfaz3XlTooGqZBJ2q0mmPOBSBERl1aZtbBQ9iZ1RgTwAOx
	 7rqkgv0IxScqOxY1IHZH8DIkYIJCaNY1Ilqy2loc=
Subject: FAILED: patch "[PATCH] drm/cirrus-qemu: Fix pitch programming" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,ajax@redhat.com,kraxel@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:25:22 +0200
Message-ID: <2025063022-scrap-uncured-d6c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4bfb389a0136a13f0802eeb5e97a0e76d88f77ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063022-scrap-uncured-d6c9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4bfb389a0136a13f0802eeb5e97a0e76d88f77ae Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 28 Mar 2025 10:17:05 +0100
Subject: [PATCH] drm/cirrus-qemu: Fix pitch programming

Do not set CR1B[6] when programming the pitch. The bit effects VGA
text mode and is not interpreted by qemu. [1] It has no affect on
the scanline pitch.

The scanline bit that is set into CR1B[6] belongs into CR13[7], which
the driver sets up correctly.

This bug goes back to the driver's initial commit.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Link: https://gitlab.com/qemu-project/qemu/-/blob/stable-9.2/hw/display/cirrus_vga.c?ref_type=heads#L1112 # 1
Fixes: f9aa76a85248 ("drm/kms: driver for virtual cirrus under qemu")
Cc: Adam Jackson <ajax@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v3.5+
Link: https://lore.kernel.org/r/20250328091821.195061-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 52ec1e4ea9e5..a00d3b7ded6c 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -318,7 +318,6 @@ static void cirrus_pitch_set(struct cirrus_device *cirrus, unsigned int pitch)
 	/* Enable extended blanking and pitch bits, and enable full memory */
 	cr1b = 0x22;
 	cr1b |= (pitch >> 7) & 0x10;
-	cr1b |= (pitch >> 6) & 0x40;
 	wreg_crt(cirrus, 0x1b, cr1b);
 
 	cirrus_set_start_address(cirrus, 0);


