Return-Path: <stable+bounces-81551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B825A994415
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA048B29737
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0921714B6;
	Tue,  8 Oct 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uooSmclj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152116DEB4
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379174; cv=none; b=FZE1wqSKdpfqHvahuF5orWjWL6/WwdMCiVeoQRxS2cVatZeoe+034WX/lMLv42bBzPzrGJhmP6QzAkHymDtqY157fjYd6RFZl8LGicvWFhKpFrE+jFj44Xn/HA0yzjgaPH3kJiOrSw92RYGW893sQGz5VH5G6TUSI8xyH4UlB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379174; c=relaxed/simple;
	bh=OKaAdAW6iGH4O3Cv3Y7CT6ssr5aW2o179qRTqslArkU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ltk60/KB7PeLcCGmC/RX1OqE6JppOj9G4bfxthbMY/OAP/WrpNLEqOkOOp9/t6rVft2aJyaoWOfAMMuZRg/NPFd+dcKHX52PKBNlEVtNS7MawBfDj1FUzOGnTIxBVtYdcgUSd7trFcjGI9kc0GKT7bjDbGldEVnq4pxh5IVLizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uooSmclj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA921C4CEC7;
	Tue,  8 Oct 2024 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379174;
	bh=OKaAdAW6iGH4O3Cv3Y7CT6ssr5aW2o179qRTqslArkU=;
	h=Subject:To:Cc:From:Date:From;
	b=uooSmcljQ6seyM7sxREfsTS0gDWxpC2IqCjj7KDX6MKANfCOu4dhs80vSK9mfyzfY
	 E/WAemzW63r7RSlzZoafDTJvMC/0ewInIg7rIEOUCrmuk5CGe6+XIw//7hXNcUPzvP
	 Q+6ZhF4m8tqUBGHSypPLSJ2vvN0y9VGHzmbk+fZw=
Subject: FAILED: patch "[PATCH] drm/i915/bios: fix printk format width" failed to apply to 6.6-stable tree
To: jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,vandita.kulkarni@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:19:17 +0200
Message-ID: <2024100816-deserving-sneeze-b1ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0289507609dcb7690e45e79fbcc3680d9298ec77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100816-deserving-sneeze-b1ce@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0289507609dc ("drm/i915/bios: fix printk format width")
9aec6f76a28c ("drm/i915/bios: convert to struct intel_display")
769b081c18b9 ("drm/i915/opregion: convert to struct intel_display")
b7f317e62968 ("drm/i915/opregion: unify intel_encoder/intel_connector naming")
f7303ab29d08 ("drm/i915/acpi: convert to struct intel_display")
4c288f56030f ("drm/i915/bios: remove stale and useless comments")
6f4e43a2f771 ("drm/xe: Fix opregion leak")
bc3ca4d94369 ("drm/i915: Make I2C terminology more inclusive")
fd5a9b950ea8 ("drm/i915/fbc: Convert to intel_display, mostly")
bc34d310b578 ("drm/i915/fbc: Extract intel_fbc_has_fences()")
d754ed2821fd ("Merge drm/drm-next into drm-intel-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0289507609dcb7690e45e79fbcc3680d9298ec77 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 5 Sep 2024 14:25:19 +0300
Subject: [PATCH] drm/i915/bios: fix printk format width

s/0x04%x/0x%04x/ to use 0 prefixed width 4 instead of printing 04
verbatim.

Fixes: 51f5748179d4 ("drm/i915/bios: create fake child devices on missing VBT")
Cc: stable@vger.kernel.org # v5.13+
Reviewed-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240905112519.4186408-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 54df34c5a2439b481f066476e67bfa21a0a640e5)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index d49435af62c7..bed485374ab0 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -2948,7 +2948,7 @@ init_vbt_missing_defaults(struct intel_display *display)
 		list_add_tail(&devdata->node, &display->vbt.display_devices);
 
 		drm_dbg_kms(display->drm,
-			    "Generating default VBT child device with type 0x04%x on port %c\n",
+			    "Generating default VBT child device with type 0x%04x on port %c\n",
 			    child->device_type, port_name(port));
 	}
 


