Return-Path: <stable+bounces-62441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8193F182
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE11C209CA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BD14262C;
	Mon, 29 Jul 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fF2fVvgR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9771422DF
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246452; cv=none; b=S5+o0TZPH4EUklakBy7ow3AGjeWW+FQHqkKrYbwIrIBsMYufFa9pCy8H2d5LUlXwwf6i92Xqhkh4ZmNXJiJquzmTzNouYK3JxBn59IXIXxUTnz7BRcZ291x9FaAw/olhYI8ARWw5qIQnCAz1t1Q9B5Em28+qv8rHkXr8BIU5sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246452; c=relaxed/simple;
	bh=AqqBfMGBAWO/X9CYZ2dLBvkpJwd9oMVgRgYMEyu07po=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L7x+vmWoFXDkPSofxTSaeV945MAfat5UqGfJ7PvAb8OXcOwTGO2wqFA47u5EVwmx3u3WYozh9nsSwUg4IceKuxQ3Ka6mTqujTwU5A998Ydbc0/wjDmYnvg5A9V0ifyAWIRVC9YGadTIHdazoQ10A651UNlO4bjM9XgRSaQaVJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fF2fVvgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C35C4AF11;
	Mon, 29 Jul 2024 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246450;
	bh=AqqBfMGBAWO/X9CYZ2dLBvkpJwd9oMVgRgYMEyu07po=;
	h=Subject:To:Cc:From:Date:From;
	b=fF2fVvgR5V45yYAMLQ9vfco00eXjRg2Stg+Rvd+QpRWrC+vDBmiieKVuxE4dvUtf2
	 vZNIm/tOfAjlgPzH/biC0emcKWtumv8sAGMLmmi2v5x7JBhIv6BLazR7p1zn/ZjDjh
	 8eRCa9PXnlSRYv4PbUpdKrcP7zHn5x1G5qM01LFM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove ASSERT if significance is zero in" failed to apply to 5.10-stable tree
To: rodrigo.siqueira@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,chaitanya.dhere@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 11:47:17 +0200
Message-ID: <2024072916-grill-deniable-ee28@gregkh>
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
git cherry-pick -x 5302d1a06a2cd9855378122a07c9e0942f0f04a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072916-grill-deniable-ee28@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

5302d1a06a2c ("drm/amd/display: Remove ASSERT if significance is zero in math_ceil2")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5302d1a06a2cd9855378122a07c9e0942f0f04a9 Mon Sep 17 00:00:00 2001
From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Date: Thu, 4 Jul 2024 11:54:34 -0600
Subject: [PATCH] drm/amd/display: Remove ASSERT if significance is zero in
 math_ceil2

In the DML math_ceil2 function, there is one ASSERT if the significance
is equal to zero. However, significance might be equal to zero
sometimes, and this is not an issue for a ceil function, but the current
ASSERT will trigger warnings in those cases. This commit removes the
ASSERT if the significance is equal to zero to avoid unnecessary noise.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 332315885d3ccc6d8fe99700f3c2e4c24aa65ab7)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
index defe13436a2c..e73579f1a88e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
@@ -64,8 +64,6 @@ double math_ceil(const double arg)
 
 double math_ceil2(const double arg, const double significance)
 {
-	ASSERT(significance != 0);
-
 	return ((int)(arg / significance + 0.99999)) * significance;
 }
 


