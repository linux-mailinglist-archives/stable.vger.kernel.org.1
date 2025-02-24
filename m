Return-Path: <stable+bounces-118734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52091A41AC6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D18164CF6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0424FBE8;
	Mon, 24 Feb 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBZES2Jd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8A24E4DD
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392511; cv=none; b=kuA/louI7M/IddVNhVlwjQ9ihMCPA+ocL3S1dBka8jBVpR0BONxVrHfFDElsyXCVifasiI0SR9t8fHE8T6xZZyddEcrIa0iPW5KqVUf/sWvAGWEWaoxHgUhxpZJ3wjtaZ0R+mvmAccTGXUH+Mc4x/RUaW0JB1tmJ5S3A+lWdvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392511; c=relaxed/simple;
	bh=N27pDiGXhBktUgCXJlmmvAfKt1QJzo1sXe3TLbmnGHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H12tAbwr7cHa6OJf7Eycx3d0eblHBVCIclq+tHR3prhJup8P18jAIxChGq6Kf+fVOLYM2wVXPdh8bjFsp/0dk1Los7EP0dTR3OHAfkq78bZuYdv2K4LNBQ1TQHLzEY+JGyVQYtSXKJjbLReP1pJ1qthojqZA6XcBoEXsr763Hck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBZES2Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487A9C4CEE6;
	Mon, 24 Feb 2025 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392511;
	bh=N27pDiGXhBktUgCXJlmmvAfKt1QJzo1sXe3TLbmnGHA=;
	h=Subject:To:Cc:From:Date:From;
	b=nBZES2JdGzMrmTmlbdn6Wz5jj+z/N9Qsmmtz8iAsUZ60LKJZmnMYHkb8zSlzvwgjJ
	 XalEKpK0Z55zY+XkNYearnvDTnOsJAoggV3W8aPZ07bukzDUM1ohsUVGUnMQvcYM52
	 y+kBmWDCfTJ9GLZFGab0urLu+R1t98KzDZKL0A1o=
Subject: FAILED: patch "[PATCH] drm/msm/dpu: Disable dither in phys encoder cleanup" failed to apply to 5.10-stable tree
To: quic_jesszhan@quicinc.com,dmitry.baryshkov@linaro.org,quic_abhinavk@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:21:15 +0100
Message-ID: <2025022414-magenta-debrief-f7e5@gregkh>
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
git cherry-pick -x f063ac6b55df03ed25996bdc84d9e1c50147cfa1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022414-magenta-debrief-f7e5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f063ac6b55df03ed25996bdc84d9e1c50147cfa1 Mon Sep 17 00:00:00 2001
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Tue, 11 Feb 2025 19:59:19 -0800
Subject: [PATCH] drm/msm/dpu: Disable dither in phys encoder cleanup

Disable pingpong dither in dpu_encoder_helper_phys_cleanup().

This avoids the issue where an encoder unknowingly uses dither after
reserving a pingpong block that was previously bound to an encoder that
had enabled dither.

Cc: stable@vger.kernel.org
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Closes: https://lore.kernel.org/all/jr7zbj5w7iq4apg3gofuvcwf4r2swzqjk7sshwcdjll4mn6ctt@l2n3qfpujg3q/
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Fixes: 3c128638a07d ("drm/msm/dpu: add support for dither block in display")
Patchwork: https://patchwork.freedesktop.org/patch/636517/
Link: https://lore.kernel.org/r/20250211-dither-disable-v1-1-ac2cb455f6b9@quicinc.com
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5172ab4dea99..48e6e8d74c85 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2281,6 +2281,9 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 		}
 	}
 
+	if (phys_enc->hw_pp && phys_enc->hw_pp->ops.setup_dither)
+		phys_enc->hw_pp->ops.setup_dither(phys_enc->hw_pp, NULL);
+
 	/* reset the merge 3D HW block */
 	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,


