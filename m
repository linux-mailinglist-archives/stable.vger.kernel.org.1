Return-Path: <stable+bounces-158915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E7AED8A7
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB887AACDD
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75323F27B;
	Mon, 30 Jun 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bh6H2Zzo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB421420F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275541; cv=none; b=gFuPhQC3IxXvwV+IQd2+VtaA4C5+ufkkPjyieP82ERVXjShsvntvMvGJbYq2z9RcSD4WvCrEIGWdYLOVhuNrhDeMBjOa7hej1tFWd2MtjcRqcYcQBVFHh3elEFb8EA42EDJV9mFSb/uK0jdU5axBxP4v0NnlB0v3lmF3WA06r34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275541; c=relaxed/simple;
	bh=+b3EUGhF/kIh6R8y4d5Ui9YFnSVnmojo9UPCK/N/yWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tiTLws03CvSi33u5fF+ciXgghk440HcFkCvVEf4Wu3c7JhTxHuTNYJIO/vOKVXxnmcsJtem1KOjZB4NZKlyTcBCVFcpWEC4t5s49E38hW1zX+ddgddEDu4G5aoU7veKwC6L2oW23USnmfjq96ZAvfptwB9KGA+xtYtonYLnoBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bh6H2Zzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74DCC4CEE3;
	Mon, 30 Jun 2025 09:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275541;
	bh=+b3EUGhF/kIh6R8y4d5Ui9YFnSVnmojo9UPCK/N/yWE=;
	h=Subject:To:Cc:From:Date:From;
	b=bh6H2Zzowk5mSEQe2wjt/wiwMzKTPAy7rBvonVeRS2A/y0WyN0i86qAuz5g41XDkV
	 hUuE7Q+5E+N68qw+Omad4e/05PjaC08x9R0mIiq/inpPEcA43vP9Qqh76IJRhXeMJv
	 T5qwH6ugqhhs1Ne7q2yaOe/dS60m3JbSeeW60SPw=
Subject: FAILED: patch "[PATCH] drm/cirrus-qemu: Fix pitch programming" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,ajax@redhat.com,kraxel@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:25:24 +0200
Message-ID: <2025063024-nibble-exit-e642@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4bfb389a0136a13f0802eeb5e97a0e76d88f77ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063024-nibble-exit-e642@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


