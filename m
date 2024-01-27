Return-Path: <stable+bounces-16125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1283F0E2
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C81F213D2
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D831B271;
	Sat, 27 Jan 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7dgHJVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDA200A4
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394964; cv=none; b=Qq2NnA+UX5lXuFj/oubqm8rAQ1fecH0NXtrCzr4QMnqecmZj3x0DmVtpSqCLaGsMrNEQVkyLCaSc5ac4DEIv3hxCq9Noj4ot+SOO5SUd/D4Dg9T3mqugof6ff7jgyNGOVYO8cg/sPv9JDO28lZyFzo2zxABKHHWeW+kbrzqIJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394964; c=relaxed/simple;
	bh=UuLcy0clwVJ5QuQcYPlAKyONmmUE3EaD4P6HzayNS6U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OoBgklvvK9ZmU9pNkhqIysjnACnxOsakX2A3NCX6vbuUz+ZYBOKTd48pgJpa2tl3W52uryJadz+Mwt3XZx1B/97Fm/2WH+n+noHHM3c5rhnwW2IMJL5ZoUU7Fq25VamXLz5zN6CrxcgOcKyFDr/+3zHoPzWnFIg6mT+Q88fcDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7dgHJVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD20C433F1;
	Sat, 27 Jan 2024 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706394963;
	bh=UuLcy0clwVJ5QuQcYPlAKyONmmUE3EaD4P6HzayNS6U=;
	h=Subject:To:Cc:From:Date:From;
	b=A7dgHJVChXctXCf2TNqW0s0d0B9GdzXm1UN40gY8q+gMegIhZsULlhtlD5Sjw2aZX
	 ecvFP6VFPSkeX0lDfJUktjC/eAJlwg6VlxtUTppBuDfTWPQ35Dg4tXXrR55uEF/1JR
	 1Tmcz2ECrtz97uB6fM45ZRfM+37V1XgGiNoPk2MI=
Subject: FAILED: patch "[PATCH] drm/amd/display: disable FPO and SubVP for older DMUB" failed to apply to 6.7-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,mikhail.v.gavrilov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:36:02 -0800
Message-ID: <2024012702-liftoff-superhero-dd66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 65550a9cc5c371b4027c8e8199293899cb2f5af7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012702-liftoff-superhero-dd66@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

65550a9cc5c3 ("drm/amd/display: disable FPO and SubVP for older DMUB versions on DCN32x")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65550a9cc5c371b4027c8e8199293899cb2f5af7 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Fri, 15 Dec 2023 10:37:39 -0500
Subject: [PATCH] drm/amd/display: disable FPO and SubVP for older DMUB
 versions on DCN32x

There have recently been changes that break backwards compatibility,
that were introduced into DMUB firmware (for DCN32x) concerning FPO and
SubVP. So, since those are just power optimization features, we can just
disable them unless the user is using a new enough version of DMUB
firmware.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2870
Fixes: ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/r/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5c323718ec90..0f0972ad441a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -960,6 +960,12 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
 		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+
+		if (dc->ctx->dmub_srv->dmub->fw_version <
+		    DMUB_FW_VERSION(7, 0, 35)) {
+			dc->debug.force_disable_subvp = true;
+			dc->debug.disable_fpo_optimizations = true;
+		}
 	}
 }
 


