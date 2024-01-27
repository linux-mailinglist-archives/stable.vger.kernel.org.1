Return-Path: <stable+bounces-16146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5283F0FE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54131B24FBE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9E1B7E5;
	Sat, 27 Jan 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pdNFmo+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4151B954
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395251; cv=none; b=tWYv80OS2v3XDzb077GwjD/cM1Q+1YrJunsxZ4sBRd14qRnngyPKc+8w4C2wU3APcog7yef1uA8KDyH1GxJHx/hwM7v2joOxRYBtyX27NLxIycCYG24RjT7P8V4POH64lmCi8cN3YFogL+Vitjkz6PVwJylD9+3AtSEf5aQbF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395251; c=relaxed/simple;
	bh=GBJU7RnT6FZx7oinoMKH6PCgtXR07IhYdXutjBVCHio=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LNHgPFuShN/kFMUg39jL8s+sKLrRU4ED2j0Xt+QsD2IQHnR+Q1Dn5vN++8oA+0DyHQODntnzfYmQWA7rPOvLCC4d6aw6G2PmbAxHiZoxYEhfkVMJkuocW0m2Bx6d02IpPpWUdIvhBUISwxKzjX7+Yk6JfglYC9e9lRE72/pec7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pdNFmo+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF645C433C7;
	Sat, 27 Jan 2024 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395250;
	bh=GBJU7RnT6FZx7oinoMKH6PCgtXR07IhYdXutjBVCHio=;
	h=Subject:To:Cc:From:Date:From;
	b=pdNFmo+y1ukpWHEjPyW9kxTn2Eab3idnlOU7RpqUJNgUaZUVSvZr0VXurZBFJRE02
	 x4mOFYD/OkQRi/HlOtFrFPAY1Ec4icHAnzwzZYOFsq8hLiSk39Rucy0JzIvYmyX206
	 VzcdVVbkifFq9hRrf3RnzaP2qF2N3opT1Z3ZU8Ns=
Subject: FAILED: patch "[PATCH] drm/amd/display: Update min Z8 residency time to 2100 for" failed to apply to 6.7-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,syed.hassan@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:40:49 -0800
Message-ID: <2024012749-geek-barrel-ea0f@gregkh>
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
git cherry-pick -x d642b0100bf8c95e88e8396b7191b35807dabb4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012749-geek-barrel-ea0f@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

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


