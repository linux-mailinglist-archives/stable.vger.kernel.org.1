Return-Path: <stable+bounces-158914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F7AED8A6
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5E4189941D
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA753242928;
	Mon, 30 Jun 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ucIhz9dL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5121420F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275540; cv=none; b=Yko2aeslFj0mp1y2TInQuAbJwE6XCMlE8fj2DcU8n2Bd/k+wOYQ5eLPgb7aMIUd/NJl0IxP29ilgJ4Y60KXF0GdnpGE4LKxtN4/Hzf7bEyBZU9kVHSxo4Os28mpJJ0CIRhdHHs1eTqtIKpO47zi7KltfzhkFGJFcHoEKDGSQ+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275540; c=relaxed/simple;
	bh=nj9CeefDLnSX6ivaMSe/5GkHTpaPkCOmx7TEYCicF0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AF+X0WYeI/8swkZkfYWTJTeVtQ6MBEnDCgztFqPJV1ayJUr/9TzdTziwaPO64pmbdigN70I6lbmt+nJH2ZtznOIYIOYfhjHlCJB+5jwD+41DLKggacQ0H7pMsiUZ/ttEIYqCpLNW69PI6e84rRv3EqRKJ6tmgHth5IaI5hfhHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ucIhz9dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713E4C4CEE3;
	Mon, 30 Jun 2025 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275537;
	bh=nj9CeefDLnSX6ivaMSe/5GkHTpaPkCOmx7TEYCicF0I=;
	h=Subject:To:Cc:From:Date:From;
	b=ucIhz9dL5Vj/5rwrjwWS4xG2tOvhwNWs5EhFhHae5iOEfBncai6jKQlz98NwYYTQF
	 US36ItRDPuGOxuIU5hB+KmNZhUk6TK1xLlh4TraUpsZbrQXWVmegph5Yz9AHuLGiv2
	 XlIjggPvGUkm2PNSjBwRE+e05NgPO1x1gAlUmayk=
Subject: FAILED: patch "[PATCH] drm/cirrus-qemu: Fix pitch programming" failed to apply to 5.4-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,ajax@redhat.com,kraxel@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:25:24 +0200
Message-ID: <2025063024-sighing-rascal-cce8@gregkh>
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
git cherry-pick -x 4bfb389a0136a13f0802eeb5e97a0e76d88f77ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063024-sighing-rascal-cce8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


