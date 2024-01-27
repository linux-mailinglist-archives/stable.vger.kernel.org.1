Return-Path: <stable+bounces-16152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CF83F102
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5371F21CF0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DD1B5A2;
	Sat, 27 Jan 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2JgYOO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639571B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395284; cv=none; b=YCr+nMelvBz5ertQxJNNb+wqcuPDvBuqEffsM+MsAzyvUzDlLAy/NXhHDsWyQA0UwjDVpf8XAOIBif1IUDCG7Bsbn/rdwNuA8IYbfaDi8pAx4qJlbaTL8IhCHORJIOW1yIf0zSZB9xX6spITqxOZQ3rH5esEUGf/SAw2Qr6jXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395284; c=relaxed/simple;
	bh=HXcmH+W7rwI23pcdZ7Je1HSZuYX0V/YEOyThqTuQFhY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ksPKTfjho3QH0bFy7TF40x+enGhF1TelengK6Kf106JsOWWG07GGhoWMEjNteQdoCSDVgG29D233ilqo4kvZgjyCNtUsiXa77emGh6/6IjuE+BXhA6N+u32DCLqpK+jvFKCZpTmYiMyJ07srg1DEFbLS3BqHLkJCVwVf92JHcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2JgYOO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FCDC433F1;
	Sat, 27 Jan 2024 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395283;
	bh=HXcmH+W7rwI23pcdZ7Je1HSZuYX0V/YEOyThqTuQFhY=;
	h=Subject:To:Cc:From:Date:From;
	b=p2JgYOO/6dXDJuPPHoJ8U4LbPcAEQr6x7wHQ/GC/d6Nf2T2LyuXeiXFP3nZxdSJ3G
	 GTFh+xeZZ+Pvh0ro0d5nzlO1wubctqVVRXw0F34Qx0TEpQuRpSTR53SG3kAW7XCPeA
	 VISFCsWVpQ1Q8hs45OBq1SZvvxlsILCETE+bPejo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Increase num voltage states to 40" failed to apply to 6.7-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:41:22 -0800
Message-ID: <2024012722-opium-say-bf9e@gregkh>
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
git cherry-pick -x 75a3371e8ffdab2e504f4326daab60f8fb15fdf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012722-opium-say-bf9e@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

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


