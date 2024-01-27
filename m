Return-Path: <stable+bounces-16147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D383F0FC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333B01F2193D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E41DDD6;
	Sat, 27 Jan 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHhCMT/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011761B954
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395252; cv=none; b=e1K3kki+cFcfs9XxLN53hy9Yu2HcRObNXnm0SU68l+lRvDTl/9pdZNDG1AIZI2T2BeFGmEyHdoqnczjq2CoR+gOkgcaPvRLcqD/qiGUcUXzL8of66O6ZIjn2Du36WFNjtgywTYdeHl3UYUAd1+3nHreo0b6/YT+nDdmqk5WoqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395252; c=relaxed/simple;
	bh=mhJCO3dY7t9XEw045LUbc4X+vGuwJirKrFx/TuhG+oY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YCG1q9JHPIYAhUyVzwJC2AJi1toEs0jU7HpwJcXQr4j/FHp5TrXTHM638kBORp0RzbrqDn9YeM4xirNSMFevHSpWK2KSoplReoP314KJ1f8QpkA4jtt9wK14MD4ynWQHs7cr3ysw8mRUiVXvcDzd3D0bpX2wHQi7fSqMxiKC/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHhCMT/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE8C433F1;
	Sat, 27 Jan 2024 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395251;
	bh=mhJCO3dY7t9XEw045LUbc4X+vGuwJirKrFx/TuhG+oY=;
	h=Subject:To:Cc:From:Date:From;
	b=hHhCMT/XzHqnhOuUn5oW3G1/k3LzGcf6WahyI7t3fSQHhJHzLzGGPgNod2qLKUolK
	 woHw+m8Z6BFuHB+PiAGzbx8nvTf7KoJp/mJkEvX47fgHdgqshPQXWGTR16fA41RCwZ
	 yDHTjymTjOpfWfTbWs4rk39XSMg2JcUlGjZ2z2Ns=
Subject: FAILED: patch "[PATCH] drm/amd/display: Update min Z8 residency time to 2100 for" failed to apply to 6.6-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,syed.hassan@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:40:50 -0800
Message-ID: <2024012750-eastbound-excitable-8ee9@gregkh>
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
git cherry-pick -x d642b0100bf8c95e88e8396b7191b35807dabb4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012750-eastbound-excitable-8ee9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d642b0100bf8 ("drm/amd/display: Update min Z8 residency time to 2100 for DCN314")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d642b0100bf8c95e88e8396b7191b35807dabb4c Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Wed, 8 Nov 2023 10:59:00 -0500
Subject: [PATCH] drm/amd/display: Update min Z8 residency time to 2100 for
 DCN314

[Why]
Some panels with residency period of 2054 exhibit flickering with
Z8 at the end of the frame.

[How]
As a workaround, increase the limit to block these panels.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 677361d74a4e..c97391edb5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -871,7 +871,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 2000,
+	.minimum_z8_residency_time = 2100,
 	.psr_skip_crtc_disable = true,
 	.replay_skip_crtc_disabled = true,
 	.disable_dmcu = true,


