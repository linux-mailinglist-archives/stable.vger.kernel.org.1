Return-Path: <stable+bounces-203654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBECE740F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15D3D300100B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB632ABD6;
	Mon, 29 Dec 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CC6XiV7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021F22FDEC
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023448; cv=none; b=ENDjSR4v5SLezdExAQAdn1I/+gkwnvdyQrleHVhMKJz5ZlU0XDjBdRlG5UExGeA2RG9GNEReF254KbRB8XNJGUDiKHItvaI4DmX9A18dJWX6F4PFwVHkNBrxAORggJvugIeiZ7KV6txBM7gO1+bRf8I+r6EdDuF8jKRBp8fMGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023448; c=relaxed/simple;
	bh=Gt1Gp6rt6l+WOHp4UFJ4BrwNOlhmdz0CIREh55PHYL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I6ChNql/QvLA2j3myGDfh6tO1EghiA2IoceoSo4egFagslmU3coc19TLUHYcNl6siLfmQazlXchg9MICcQKmYpxHEUDTKP/im25sGUokEcZlYHPath252KUn6Hc/sB2J+YAeETloRpSzWARnCGeVaBpQmMBVbAJEWD54MiiqIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CC6XiV7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDBCC4CEF7;
	Mon, 29 Dec 2025 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023447;
	bh=Gt1Gp6rt6l+WOHp4UFJ4BrwNOlhmdz0CIREh55PHYL8=;
	h=Subject:To:Cc:From:Date:From;
	b=CC6XiV7CgYidtKjO/+p8UCn60nO6gJgdK2SfweihqpnsiGPn7IYiqvklb079i9Hli
	 qIYMO1dJY/YE4I9KgGA4y5nLltUc/WSzpKww0AuSZxMIpXSUN4qUodw62B+U3v2Gnw
	 ofJe/9zzdKcmcP/j1gKPbQaaAdlMwjnTxbC07aqc=
Subject: FAILED: patch "[PATCH] drm/displayid: add quirk to ignore DisplayID checksum errors" failed to apply to 6.18-stable tree
To: jani.nikula@intel.com,alexander.deucher@amd.com,tiago.martins.araujo@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:50:44 +0100
Message-ID: <2025122944-trimester-congrats-2c82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 83cbb4d33dc22b0ca1a4e85c6e892c9b729e28d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122944-trimester-congrats-2c82@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83cbb4d33dc22b0ca1a4e85c6e892c9b729e28d4 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 28 Oct 2025 22:07:27 +0200
Subject: [PATCH] drm/displayid: add quirk to ignore DisplayID checksum errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a mechanism for DisplayID specific quirks, and add the first quirk
to ignore DisplayID section checksum errors.

It would be quite inconvenient to pass existing EDID quirks from
drm_edid.c for DisplayID parsing. Not all places doing DisplayID
iteration have the quirks readily available, and would have to pass it
in all places. Simply add a separate array of DisplayID specific EDID
quirks. We do end up checking it every time we iterate DisplayID blocks,
but hopefully the number of quirks remains small.

There are a few laptop models with DisplayID checksum failures, leading
to higher refresh rates only present in the DisplayID blocks being
ignored. Add a quirk for the panel in the machines.

Reported-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Closes: https://lore.kernel.org/r/CACRbrPGvLP5LANXuFi6z0S7XMbAG4X5y2YOLBDxfOVtfGGqiKQ@mail.gmail.com
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14703
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/c04d81ae648c5f21b3f5b7953f924718051f2798.1761681968.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index 20b453d2b854..58d0bb6d2676 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -9,6 +9,34 @@
 #include "drm_crtc_internal.h"
 #include "drm_displayid_internal.h"
 
+enum {
+	QUIRK_IGNORE_CHECKSUM,
+};
+
+struct displayid_quirk {
+	const struct drm_edid_ident ident;
+	u8 quirks;
+};
+
+static const struct displayid_quirk quirks[] = {
+	{
+		.ident = DRM_EDID_IDENT_INIT('C', 'S', 'O', 5142, "MNE007ZA1-5"),
+		.quirks = BIT(QUIRK_IGNORE_CHECKSUM),
+	},
+};
+
+static u8 get_quirks(const struct drm_edid *drm_edid)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(quirks); i++) {
+		if (drm_edid_match(drm_edid, &quirks[i].ident))
+			return quirks[i].quirks;
+	}
+
+	return 0;
+}
+
 static const struct displayid_header *
 displayid_get_header(const u8 *displayid, int length, int index)
 {
@@ -23,7 +51,7 @@ displayid_get_header(const u8 *displayid, int length, int index)
 }
 
 static const struct displayid_header *
-validate_displayid(const u8 *displayid, int length, int idx)
+validate_displayid(const u8 *displayid, int length, int idx, bool ignore_checksum)
 {
 	int i, dispid_length;
 	u8 csum = 0;
@@ -41,8 +69,11 @@ validate_displayid(const u8 *displayid, int length, int idx)
 	for (i = 0; i < dispid_length; i++)
 		csum += displayid[idx + i];
 	if (csum) {
-		DRM_NOTE("DisplayID checksum invalid, remainder is %d\n", csum);
-		return ERR_PTR(-EINVAL);
+		DRM_NOTE("DisplayID checksum invalid, remainder is %d%s\n", csum,
+			 ignore_checksum ? " (ignoring)" : "");
+
+		if (!ignore_checksum)
+			return ERR_PTR(-EINVAL);
 	}
 
 	return base;
@@ -52,6 +83,7 @@ static const u8 *find_next_displayid_extension(struct displayid_iter *iter)
 {
 	const struct displayid_header *base;
 	const u8 *displayid;
+	bool ignore_checksum = iter->quirks & BIT(QUIRK_IGNORE_CHECKSUM);
 
 	displayid = drm_edid_find_extension(iter->drm_edid, DISPLAYID_EXT, &iter->ext_index);
 	if (!displayid)
@@ -61,7 +93,7 @@ static const u8 *find_next_displayid_extension(struct displayid_iter *iter)
 	iter->length = EDID_LENGTH - 1;
 	iter->idx = 1;
 
-	base = validate_displayid(displayid, iter->length, iter->idx);
+	base = validate_displayid(displayid, iter->length, iter->idx, ignore_checksum);
 	if (IS_ERR(base))
 		return NULL;
 
@@ -76,6 +108,7 @@ void displayid_iter_edid_begin(const struct drm_edid *drm_edid,
 	memset(iter, 0, sizeof(*iter));
 
 	iter->drm_edid = drm_edid;
+	iter->quirks = get_quirks(drm_edid);
 }
 
 static const struct displayid_block *
diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 957dd0619f5c..5b1b32f73516 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -167,6 +167,8 @@ struct displayid_iter {
 
 	u8 version;
 	u8 primary_use;
+
+	u8 quirks;
 };
 
 void displayid_iter_edid_begin(const struct drm_edid *drm_edid,


