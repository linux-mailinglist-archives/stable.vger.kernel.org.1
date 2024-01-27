Return-Path: <stable+bounces-16154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF583F104
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F56C1C21590
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2DB1E52B;
	Sat, 27 Jan 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uop/i29k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7831B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395286; cv=none; b=bNbEz37KeGLNfUNfqxK9QdclP+wrqzTh5JbJRq2uOc65dMr05jiTqxfIsFvoFh1sUw3hWksEv+usOS2X2S+KJX2JKApPwvgRvv/mkkRxkrKclihNWX1KooNOJ+jJYxLLh5UQQDReU5UcIUefeHF/8ntb5uVaHk0w3aBdUaptCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395286; c=relaxed/simple;
	bh=s0iUcCv0BccTQO8xBKcwS027H6sSiHK5g7ChjdEVR6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AuUgvu7/708BpRCPJ3hkBhLM6V1jNiED5RYWCydH/LHo+uCf/t/k+YbIuqdu2sUIdGS+yDvRhcv6muY0wBjy1FsYAxzLHOYQy0l1xXgsCs9ipT94AXwr1Pu5TrZ20k5N3llbh0qbfOoBd78jC1Ggke29V+KJNX0lyrXi5ACjC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uop/i29k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1079C433F1;
	Sat, 27 Jan 2024 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395286;
	bh=s0iUcCv0BccTQO8xBKcwS027H6sSiHK5g7ChjdEVR6A=;
	h=Subject:To:Cc:From:Date:From;
	b=Uop/i29k7uPAX/NNx2DJAivb611bID2x8DSpJFoaWMi1Qupa2S0CZltMuobXk7zwG
	 tiOgZLQCWweePG67KERKunsIQf3OhyPaR5yU+2ubL26NNJ6iyMHvlOq6xNW/gfBpPC
	 FnHf1z9WbUvWr5mACzygTXS9fZiwOJVSwosZ98Fc=
Subject: FAILED: patch "[PATCH] drm/amd/display: Increase num voltage states to 40" failed to apply to 6.1-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:41:25 -0800
Message-ID: <2024012724-duty-vocalize-d9cb@gregkh>
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
git cherry-pick -x 75a3371e8ffdab2e504f4326daab60f8fb15fdf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012724-duty-vocalize-d9cb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

75a3371e8ffd ("drm/amd/display: Increase num voltage states to 40")
1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")

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


