Return-Path: <stable+bounces-16153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167683F103
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29E328188F
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B851DDD6;
	Sat, 27 Jan 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/RCHnXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353361DDCF
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395285; cv=none; b=gCveWZTaE5mqS3QyWCEUzIyXEm5G9nIZc7A7ZzJdoPXdLH5jHzyo195HeDxMavgTVf48EtDZx/5cRdJvrg/taBXrRm5yOsAGJBlg7Y0RlyqA7jh0Jh6EF01eLFaAlQjgbMKF5b9dyHrCtbOf766GMnOlyLgBM3S2QvJS/qIdP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395285; c=relaxed/simple;
	bh=GUHJlVjslKBWoOtz0ffd2IDa/L/tJc4Vx2o4Y7qkAeM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qrqzzRN9t4XlZHNbi7/zBW0PdKybilvhK1JaRYAFjHuN5mLJikNUug5FKDAIfxL65QWp0pA8EMdxoZknJXlRhp88dW9yfFDl1dH38bOJYpvQHNE6IhenvGPDCwURIXHXidAfQ3fKA95upRuLXu12LsBhLsYLaQKJFwm/pqCB5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/RCHnXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76AC433C7;
	Sat, 27 Jan 2024 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395284;
	bh=GUHJlVjslKBWoOtz0ffd2IDa/L/tJc4Vx2o4Y7qkAeM=;
	h=Subject:To:Cc:From:Date:From;
	b=I/RCHnXz7Upx/lm2E87xEQqDqNXT8qMYapfQq2B1qhxFCslDq1vnf2/NlYuU6RqtW
	 DafuaJO3dMU7wA2d7ZirIei5qT4w2EV9u3AgHfLdLduBC3FllprAZrk5Vu48W6oTO0
	 6OYmZRm3kQHIWxhkuCdDf8mCkCSEiHjVU3EtNxx8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Increase num voltage states to 40" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:41:23 -0800
Message-ID: <2024012723-cheek-opponent-4d4b@gregkh>
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
git cherry-pick -x 75a3371e8ffdab2e504f4326daab60f8fb15fdf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012723-cheek-opponent-4d4b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

75a3371e8ffd ("drm/amd/display: Increase num voltage states to 40")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75a3371e8ffdab2e504f4326daab60f8fb15fdf1 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Wed, 8 Nov 2023 17:16:28 -0500
Subject: [PATCH] drm/amd/display: Increase num voltage states to 40

[Description]
If during driver init stage there are greater than 20
intermediary voltage states while constructing the SOC
BB we could hit issues because we will index outside of the
clock_limits array and start overwriting data. Increase the
total number of states to 40 to avoid this issue.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2cbdd75429ff..6e669a2c5b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -36,7 +36,7 @@
  * Define the maximum amount of states supported by the ASIC. Every ASIC has a
  * specific number of states; this macro defines the maximum number of states.
  */
-#define DC__VOLTAGE_STATES 20
+#define DC__VOLTAGE_STATES 40
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1


