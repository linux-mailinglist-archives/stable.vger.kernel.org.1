Return-Path: <stable+bounces-66629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385494F075
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED67EB2267B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2A18454D;
	Mon, 12 Aug 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADZ6PNRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3F184548
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474208; cv=none; b=bt6AzY+QH6iiDv8EFetjMq7C8aLjK+NvscGGsezt2Ul0NN3i8i5fl57OTyZtMe1i/qyHlAR9jEhZDwTtR9sGgrAi7FUkwJu9yytv9b0WyGvl8lEMbiu12LtLUV0oT4No+ZJGfwTkBO8O0+nt0w1Wkg+kJ/CfBwg7CHgjsa+7Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474208; c=relaxed/simple;
	bh=Vo/T7QnQG7k2KAO7hxw5E6xsbuDI+Y6iYRKS6gjvRkc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FqkvIOCFhStaICU8PMW2w10yBIA0tkKoPDjHMMK8pj+bimLFG3BAjBxRfwxt7kWSyj6oOEfYQgTQLLHp0MZ1Kjlzadk48KS6N+oUY3ivSsZV+N/fnOv4OcYDkSkJY1etPQSy9+WEPMxwxrdi21e9cAlcU/v+i7gyHGC61dVR6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ADZ6PNRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD08AC4AF09;
	Mon, 12 Aug 2024 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474208;
	bh=Vo/T7QnQG7k2KAO7hxw5E6xsbuDI+Y6iYRKS6gjvRkc=;
	h=Subject:To:Cc:From:Date:From;
	b=ADZ6PNRWU7XOW/lvjQEiObzobXsuoEpvMINlESXjlToLvqmpN2d23FS9ddCTljq9h
	 NPmCh2Fo/P8NM/hctyh7mLe6dhctUU1PlqilWNfPLG4fk1pJFFEv6jvAt0nmHbMhCF
	 GC3J2KUdj6eyClr9tVAnkMwP3I3q+e31iJ2OweWM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor issues with ODMs and" failed to apply to 5.10-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:36 +0200
Message-ID: <2024081236-getaway-issuing-b6cd@gregkh>
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
git cherry-pick -x adcd67e0bbea5fb504d6de50e5ccf74ebf96bc29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081236-getaway-issuing-b6cd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


