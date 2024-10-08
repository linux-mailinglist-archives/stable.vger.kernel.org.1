Return-Path: <stable+bounces-81548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CC994403
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAE91F21BFC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5EE13C827;
	Tue,  8 Oct 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6UcqgHB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224F433D1
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379160; cv=none; b=SW9pjhpprHAtXQ558LjYrJWEgQA/JzWsVV3LXBw2AnLGZtRicty++ADUkn44ywHlY9PYnBnZzcR48SNUaJcT9LDESNiYIXq854XJbknNNpo6G5eae5VS4rXkTWjbSSKTIYhwCkJjyW1qI4q4x/IFQPes8gchQDXUTJXAQ/xyels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379160; c=relaxed/simple;
	bh=DR0rx8enyParejHUbN8vmEG5R649zQaHs+Gsn+NjIU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tpWCjmtCbzJqP4e9kcjzdnqkBtwOwncrdDdcFJ98RiBny2nnFKpjl/LyrDpzdASNFXncRvx8CEsnLwi9SFaW3hBRdZqds9rTSurlt80s+63iR4QbF8qn+oiuQTTpUhPfl3ejn6JZTd4m49sswfa8PaQkqMFFWLPK17YJURzmRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6UcqgHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBF6C4CECC;
	Tue,  8 Oct 2024 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379159;
	bh=DR0rx8enyParejHUbN8vmEG5R649zQaHs+Gsn+NjIU8=;
	h=Subject:To:Cc:From:Date:From;
	b=e6UcqgHBYwLq/3I5hxWVr0xPl84npDnx0KqKwstHLmiSWGE+msuJ2ppj48bIESKH2
	 WI5JtL2dk70hYFlQbKfDliGY1P5Q4COK3uSa3PCZQTUh+JyyeCeL1kNa1aaz2O3Xpv
	 1KUq0DqeJ8N8wEwKR9O2gUc+kXGOkfcpPYg5zjsI=
Subject: FAILED: patch "[PATCH] drm/i915/bios: fix printk format width" failed to apply to 6.11-stable tree
To: jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,vandita.kulkarni@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:19:15 +0200
Message-ID: <2024100815-transpose-startling-abe8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 0289507609dcb7690e45e79fbcc3680d9298ec77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100815-transpose-startling-abe8@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

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
 


