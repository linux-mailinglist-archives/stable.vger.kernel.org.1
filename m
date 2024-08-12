Return-Path: <stable+bounces-66626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB394F06D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE80281DD3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDA183CC8;
	Mon, 12 Aug 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvEaDkJ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE0183CBE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474198; cv=none; b=ZPw2+eyXIgetjvrYSM2KOjy4qGkcV2kxaN3MiCsi1vO2uc0Fnp/4O8wX081WZnVByJfMIjbtyrkeYM72Zlr3zGK7bV/HXI3sXDbYo+UKbZO/hO+K62zFLUazInG9l0I8NpVubn1fpBeVt11k90wqm3hzQhVy2L0CORkCJuEyU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474198; c=relaxed/simple;
	bh=u3N0udQCM4rMjLI3iSSzxpOKYL3Q6Vg+6KDm1ZbpsaA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n/bsI94uE8+rDKxwOAKGAoYT5Iuta1vecDiEfwjiHg288fnc4zvrQlFlhNS26Lrp1Z/DLP9TzkDUHPOPDx0btnGK8LIrYKjO7yj7FfL0McW+gVXiNBevRrfapDAIxrLnbFq5Hh6OwiK47U7XW9CTW6vSFzcx3CqRjopv7NRTGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvEaDkJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0040C4AF09;
	Mon, 12 Aug 2024 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474197;
	bh=u3N0udQCM4rMjLI3iSSzxpOKYL3Q6Vg+6KDm1ZbpsaA=;
	h=Subject:To:Cc:From:Date:From;
	b=yvEaDkJ6Djmhj8HbgFUcZc8ZPjxIJV3xR+ePYth7bWeSM5B+TtTXDNeLHhgC335hd
	 31GuOEnypGHDmVLS8TjX51KumcGDD9MNIMBw83unfGRnuzVgte0hk/kLldl0wrpZSx
	 6o7MN5QrMdcyXMdK2EFuKNG9HKUJhTrVK1F1XRKk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor issues with ODMs and" failed to apply to 6.6-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:34 +0200
Message-ID: <2024081234-streak-spectator-8acc@gregkh>
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
git cherry-pick -x adcd67e0bbea5fb504d6de50e5ccf74ebf96bc29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081234-streak-spectator-8acc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


