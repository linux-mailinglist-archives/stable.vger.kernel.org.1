Return-Path: <stable+bounces-73905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86306970772
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2402EB21630
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1A15B57B;
	Sun,  8 Sep 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQ3IoUNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0C14A624
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799012; cv=none; b=cog9gz24smocpE73fS9fOqzjjWVE9GvB35Xom139AMZqd+6DyoaagD1C85AagU0R0ApBJitwfWbE7qxzh06IuNA4lqO6uAP+04xxlTFFhpNgwd8wQrSczx3YLnE5ipAcssVFalwYNw4T8vIpF/Esq2HIdTA/2NDQyYBRaKaF8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799012; c=relaxed/simple;
	bh=VqgFrmN+72coN5Ux0M1PGwzyWas0rDbiBCa+yrdxmBU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jBEbib6ldejUyojSEECmAySErxz45vtY/zhKWvZzd/ZtW7Wq5lgLsrZv0j8bIJMOqVkdpf/0ryzvIVBf56dS7SpSx58bXG82FYjtkdBEkZcR3nTxHDlNr+BOFByoJCZUi97wi2AN4Lu/cku6OF+qHeattCP5htINlCKy9Xe1Uy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQ3IoUNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52042C4CEC3;
	Sun,  8 Sep 2024 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725799011;
	bh=VqgFrmN+72coN5Ux0M1PGwzyWas0rDbiBCa+yrdxmBU=;
	h=Subject:To:Cc:From:Date:From;
	b=sQ3IoUNyiIKAB5Gc55xvTGPcqOKxKu7g89YLZVpbl1MHEosvxl+EzUgXO0d0l+rfH
	 1YubIVmO5kuVaWh8G9kWRe3PQ9fRsVPxMyhLYPVfg6mDyeahcJ/mN2GY7b1I3WCNmK
	 TkybUQzF9FGNEeKQ/0EjaGLxySGbLkUTs/G5kHUk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Block timing sync for different signals in" failed to apply to 6.1-stable tree
To: dillon.varone@amd.com,alexander.deucher@amd.com,austin.zheng@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:36:45 +0200
Message-ID: <2024090844-speech-subzero-1de7@gregkh>
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
git cherry-pick -x 38e3285dbd07db44487bbaca8c383a5d7f3c11f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090844-speech-subzero-1de7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


