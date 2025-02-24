Return-Path: <stable+bounces-118733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91580A41ABA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23953A43C3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3B23F439;
	Mon, 24 Feb 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DY4YSOKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367838DFC
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392506; cv=none; b=lxrLpy8MGKJDKyKcGnMt0NjpnXNtqs4lZhH65kv9l24c//REyrK20yIngNcz+ZQmzRCchAOCcIs1o1V/1iExt15UDrQbSPRt50wnJN8LJAJUq5z0F/xwXQNkFm4Cq2qdPkqctzlDmcaA1KZGc5G60JMosU/ZcPxp6SkPRgyd6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392506; c=relaxed/simple;
	bh=qqIvwbnyUDX2DFMJoOwUA4XKU3fv1FlYj2U7w202Dsc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I35uIxnjnlJzsNNSuEjT+0OlAQWukn6Xuh/jbKxODd6HvOc/Pd9THiADLh+ZDRNUHhCwbN6maHDmi6RUkeqC7E/GmfN88TRyXuZZ0EOfBn9jI4xAturiWBqf/ymmHywzFI+8pM1L3qppUqME2zC6LtlyuB5jEMbLl+LbheRk0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DY4YSOKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD69C4CEE8;
	Mon, 24 Feb 2025 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392505;
	bh=qqIvwbnyUDX2DFMJoOwUA4XKU3fv1FlYj2U7w202Dsc=;
	h=Subject:To:Cc:From:Date:From;
	b=DY4YSOKp5gvVaISiLq4BA8N91az21Y/p5WEeQdt3pF8geqZRidP2OnJOUfaagm14Z
	 6JtZXZ+f1Ll9WbEb1A7VGfPPGvDgpjfCvjXP3erz3lNdoQ8uUwRVDFo9zGZUvsTDdw
	 awNk5gPew/79imnpE2ta+hWuLjqMSQhfK7ZjaRzU=
Subject: FAILED: patch "[PATCH] drm/msm/dpu: Disable dither in phys encoder cleanup" failed to apply to 5.15-stable tree
To: quic_jesszhan@quicinc.com,dmitry.baryshkov@linaro.org,quic_abhinavk@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:21:14 +0100
Message-ID: <2025022414-briskly-payday-2d07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f063ac6b55df03ed25996bdc84d9e1c50147cfa1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022414-briskly-payday-2d07@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


