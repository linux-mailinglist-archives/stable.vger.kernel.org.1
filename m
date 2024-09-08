Return-Path: <stable+bounces-73904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743D970771
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA684281FBC
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B46158207;
	Sun,  8 Sep 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2pxKkSw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938F14A624
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799009; cv=none; b=AwIH7ezH7kV4mM94JugYwn6K0U5+YDYlEMNtrI4RpaVHN6uQdgK/cyroZL20f7cYZtNDGyh74pJXiYFZHToZcV9fzF3zuHYQursvxvMPkn0+jfdCgms02VTxrrT6NQ1eLqjsB7ix8JFZSNK+rw80cIyZAMxJnCC+VLbPxSvmgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799009; c=relaxed/simple;
	bh=lfMBWd122olt6j0VUJ+GU1mAJr96Tnw5DZVJki+ck9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W/iMtdx11RV/Dp0JNcV9ZBC5HtO/b1vzLpU4lqo2UZ3con8RvNglyvqESkFbCwoPi4em8S/SExkZmHCnzMel2s/6cEWVZM/awTVGuHyygddN2p0ROUg88ChftmG4cP67CQcuU2dCqGkWB1coPWIPdfl7r9LWJ9AMEIc5Dci14Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2pxKkSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68164C4CEC3;
	Sun,  8 Sep 2024 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725799008;
	bh=lfMBWd122olt6j0VUJ+GU1mAJr96Tnw5DZVJki+ck9g=;
	h=Subject:To:Cc:From:Date:From;
	b=d2pxKkSw9+ENDeBLF390VYT+ziyJEKXeVRJzuRn/I/UOXZEC3XpXPoTPwI0BzC67Q
	 BZLl/GIFvcb9fHIzc/AozWPkvpjDlu0j74FZEYSU+daJ/Y0TgsEQSqiyUKTl85QoMH
	 y/lOggOthg7/ce3gPYobiCz6UiE7hSUD4A3H7iSs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Block timing sync for different signals in" failed to apply to 6.6-stable tree
To: dillon.varone@amd.com,alexander.deucher@amd.com,austin.zheng@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:36:43 +0200
Message-ID: <2024090842-uncounted-lustrous-8af4@gregkh>
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
git cherry-pick -x 38e3285dbd07db44487bbaca8c383a5d7f3c11f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090842-uncounted-lustrous-8af4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

38e3285dbd07 ("drm/amd/display: Block timing sync for different signals in PMO")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38e3285dbd07db44487bbaca8c383a5d7f3c11f3 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Thu, 22 Aug 2024 17:52:57 -0400
Subject: [PATCH] drm/amd/display: Block timing sync for different signals in
 PMO

PMO assumes that like timings can be synchronized, but DC only allows
this if the signal types match.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 29d3d6af43135de7bec677f334292ca8dab53d67)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 603036df68ba..6547cc2c2a77 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -811,7 +811,8 @@ static void build_synchronized_timing_groups(
 		for (j = i + 1; j < display_config->display_config.num_streams; j++) {
 			if (memcmp(master_timing,
 				&display_config->display_config.stream_descriptors[j].timing,
-				sizeof(struct dml2_timing_cfg)) == 0) {
+				sizeof(struct dml2_timing_cfg)) == 0 &&
+				display_config->display_config.stream_descriptors[i].output.output_encoder == display_config->display_config.stream_descriptors[j].output.output_encoder) {
 				set_bit_in_bitfield(&pmo->scratch.pmo_dcn4.synchronized_timing_group_masks[timing_group_idx], j);
 				set_bit_in_bitfield(&stream_mapped_mask, j);
 			}


