Return-Path: <stable+bounces-81552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A3994409
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039531F23FF4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75300155747;
	Tue,  8 Oct 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEWV74/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572913C816
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379178; cv=none; b=m4ux7CZAqCkgVCCwxg+aOcyH6EXCnWOim+blJtfWBuBZlj5xREaHnUVU2g99gaqB+TeqhmH26DMcMEjYaMrLk0x1/CDHEjF6otL8slzUdycCkO6z52hut+j4pIOhk2+zFW9MyJpjVKTu7fWg6ZinkKVUOR8nfzdek487C5KJQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379178; c=relaxed/simple;
	bh=yHD8ZlST2ftpmqdrn2BN9hl1mILX3iyd6jZtbE5a1oY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WENpIu7guvV2yFUTaG+eaw31d7nTkZJzFE0/ZI+DsSPngqanOfaiXU5rgirWfF/4P04AxFuTabtTqU7bSDbbi5iqBHIDgFcem+sDLKaTRqJNs9Dy969EhOBnUTlDTxmAIcF0GUJ5l6sKHqa5EJihD0AeR7tMHf3Xsq8svDm0WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEWV74/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53798C4CEC7;
	Tue,  8 Oct 2024 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379177;
	bh=yHD8ZlST2ftpmqdrn2BN9hl1mILX3iyd6jZtbE5a1oY=;
	h=Subject:To:Cc:From:Date:From;
	b=fEWV74/MLMeIvQkHrYUBws1vdZqRCk0qWQwn3ETOnfmonrBddv99rh564qBm2uo6d
	 JoOMgO8DeBHEac5jrIEbQ1FjUfRSWtQ4bk75yL6uq1TdtK0/1oThF2CLAjUBecbBJ6
	 Z4HuPFnLmTrWBKNssPEJkKfFYARd/ihq/9HXpvb4=
Subject: FAILED: patch "[PATCH] drm/i915/bios: fix printk format width" failed to apply to 5.15-stable tree
To: jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,vandita.kulkarni@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:19:18 +0200
Message-ID: <2024100818-doorstop-clone-45d6@gregkh>
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
git cherry-pick -x 0289507609dcb7690e45e79fbcc3680d9298ec77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100818-doorstop-clone-45d6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


