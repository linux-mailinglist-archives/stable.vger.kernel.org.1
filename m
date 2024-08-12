Return-Path: <stable+bounces-66628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064B94F073
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7541F21BA8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF99184534;
	Mon, 12 Aug 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/CSQAZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54925184530
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474205; cv=none; b=h/SwR9GUYdQIdF96n/mMFZV7VE/OKGJxf4fk5k3PDvJI9dtm/Yyaui8meXWO/APV4d8mKjFytLDh8drq+yO+dwoCG94FF2jiwzKU/Y7YoEOvCDOoqJkkb5/E2zJJC9K53PP/a35A35ZPxOf/iCDrvRc2Pjyv5cBJ06wBq1hHgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474205; c=relaxed/simple;
	bh=QUOazHceRdCoYjt66MFUL45puVv6OGe7Xt7/rP7qVwU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B9wBjfJKfP6el5agd6GkZyAhKLBICZn8yZ8dvjJQd0lmA4bsv7epnZNHBhh8+RFvTa9PJ2EKP8lXjabQOygN2kalipXUQDT3+dpgkEi61stAVeGjKouC+QH5ve2+gmsPxFiFRGWnxXAAU3E3P9do252SxloUPcKRmtvDRL1RAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/CSQAZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C0FC4AF09;
	Mon, 12 Aug 2024 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474204;
	bh=QUOazHceRdCoYjt66MFUL45puVv6OGe7Xt7/rP7qVwU=;
	h=Subject:To:Cc:From:Date:From;
	b=C/CSQAZiwMqb/TYBs3Zb+EVBxjIbMhAY7izCdiN7PDAo0AKVYUe2vUYVHNUdhgUb5
	 F7/6M+sYwVn+1R2QSJfJfgADqZo9aF8ogbZ1M6Hl+rdgMzFC+6xzHH05lc2th5N3Tg
	 bITQdFBTopT2sJMS+7AKUfjAkQXDZQ3r2ZPUvY+A=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor issues with ODMs and" failed to apply to 6.1-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:35 +0200
Message-ID: <2024081235-doorbell-dart-e9d7@gregkh>
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
git cherry-pick -x adcd67e0bbea5fb504d6de50e5ccf74ebf96bc29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081235-doorbell-dart-e9d7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

adcd67e0bbea ("drm/amd/display: Fix cursor issues with ODMs and magnification")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From adcd67e0bbea5fb504d6de50e5ccf74ebf96bc29 Mon Sep 17 00:00:00 2001
From: Nevenko Stupar <nevenko.stupar@amd.com>
Date: Thu, 13 Jun 2024 17:19:42 -0400
Subject: [PATCH] drm/amd/display: Fix cursor issues with ODMs and
 magnification

[WHY & HOW]
Adjust hot spot positions between ODM slices when cursor
magnification is used.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 79a911e1a09a..5306c8c170c5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1177,6 +1177,15 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 
 	if (x_pos < 0) {
 		pos_cpy.x_hotspot -= x_pos;
+		if ((odm_combine_on) && (hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION)) {
+			if (hubp->curs_attr.width <= 128) {
+				pos_cpy.x_hotspot /= 2;
+				pos_cpy.x_hotspot += 1;
+			} else {
+				pos_cpy.x_hotspot /= 2;
+				pos_cpy.x_hotspot += 2;
+			}
+		}
 		x_pos = 0;
 	}
 


