Return-Path: <stable+bounces-43702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E68C43FA
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BDC1C2218E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0163C1;
	Mon, 13 May 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NkIbEgDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2A5672
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613423; cv=none; b=IkZ4kea/TXAWT9HVhDImkpmb/u7QjkmG1YDAaWcd+5o8NGF/+C2jQA8GpD8T7QvbLZ2guuNAx2ky3Gl/n22rVjinBKup8c8V8M5UJnrPTUNHy/o7dUxg8GDyxn4qF1lOxSLoa3FLe00EDpwslbfYLuqquMjI48IWITxEAnigeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613423; c=relaxed/simple;
	bh=fIKu2oKAviGpmgNIUdkAeJCt6pCVTmEc60xU73BnJXc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I5D4f4iuoms+kAGzzzxSn9CTl11P0p8kc34X0QVwSI5ybrM2r325tKad4oMUZNUQLOhC1ZSMJdTNOi8dyMMrTAZP1Iy4mPqBmQEIZKBQAui0mfZ5P+WT5jRnm9DHug7i+PSZUn9rRRaCxA9BvyR32GwFSb+gkO4ER6RUOgSk+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NkIbEgDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37B1C113CC;
	Mon, 13 May 2024 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613423;
	bh=fIKu2oKAviGpmgNIUdkAeJCt6pCVTmEc60xU73BnJXc=;
	h=Subject:To:Cc:From:Date:From;
	b=NkIbEgDlmnapmcxEh3wqi0iA91iV58CUFL9C5Lw+vbhTHp5p8GE7vAsMpAJEbM+rn
	 xfKD/0nGc1fCggXWJ5dScvhOVaGvOiYwacpGbadTbTUvsZXUiug26CnA5OH1YX/28V
	 tphV3B7flNwURqT/QnehQgMpvvXNRg4cdWE2Vgmo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Handle Y carry-over in VCP X.Y calculation" failed to apply to 5.10-stable tree
To: george.shen@amd.com,Rodrigo.Siqueira@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:16:49 +0200
Message-ID: <2024051348-unclad-penpal-8f46@gregkh>
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
git cherry-pick -x 719564737a9ac3d0b49c314450b56cf6f7d71358
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051348-unclad-penpal-8f46@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

719564737a9a ("drm/amd/display: Handle Y carry-over in VCP X.Y calculation")
3bc8d9214679 ("drm/amd/display: Add DP 2.0 HPO Link Encoder")
83228ebb82e4 ("drm/amd/display: Add DP 2.0 HPO Stream Encoder")
61452908a79e ("drm/amd/display: Add DP 2.0 Audio Package Generator")
926d6972efb6 ("drm/amd/display: Add DCN3.1 blocks to the DC Makefile")
2083640f0d5b ("drm/amd/display: Add DCN3.1 Resource")
cbaf919f3313 ("drm/amd/display: Add DCN3.1 DIO")
cd6d421e3d1a ("drm/amd/display: Initial DC support for Beige Goby")
2ff3cf823882 ("drm/amd/display: Fix hangs with psr enabled on dcn3.xx")
8cf9575d7079 ("drm/amd/display: Fix DSC enable sequence")
66611a721b59 ("drm/amd/display: Add debug flag to enable eDP ILR by default")
42b599732ee1 ("drm/amdgpu/display: fix memory leak for dimgrey cavefish")
e1f4328f22c0 ("drm/amd/display: Update link encoder object creation")
4f8e37dbaf58 ("drm/amd/display: Support for DMUB AUX")
1e3489136968 ("drm/amd/display: 3.2.124")
77a2b7265f20 ("drm/amd/display: Synchronize displays with different timings")
97628eb5ac20 ("drm/amd/display: 3.2.123")
ef4dd6b2757e ("drm/amd/display: 3.2.122")
6fce5bcee582 ("drm/amd/display: move edp sink present detection to hw init")
f1e17351984c ("drm/amd/display: 3.2.121")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 719564737a9ac3d0b49c314450b56cf6f7d71358 Mon Sep 17 00:00:00 2001
From: George Shen <george.shen@amd.com>
Date: Thu, 16 Sep 2021 19:55:39 -0400
Subject: [PATCH] drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Theoretically rare corner case where ceil(Y) results in rounding up to
an integer. If this happens, the 1 should be carried over to the X
value.

CC: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 5b7ad38f85e0..65e45a0b4ff3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -395,6 +395,12 @@ void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
 				x),
 			25));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 25) {
+		x += 1;
+		y = 0;
+	}
+
 	switch (stream_encoder_inst) {
 	case 0:
 		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL0, 0,


