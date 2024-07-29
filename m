Return-Path: <stable+bounces-62442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F093F184
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84C9283A1E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22A13F42F;
	Mon, 29 Jul 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1T8lLxNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A513DBB1
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246454; cv=none; b=uwgtnXvTPi81dZKdJCctqHRX5rAPGx/PshGdUP2pWQCJgDjTgC560TPxSkKzZN7NIN3/5P8UD99Ew8wKIsPBIgIqBwt44sNPvGZl/M3hGxJHtwVq8SpBm6v/hLEofat3+GWP5wF+Nxz9pNYjVmfIAVn9hCk9+3WsZtOk9mryNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246454; c=relaxed/simple;
	bh=N2gCqsvygQddI5i7RbAM0fdeMNrbIprvlHXPSNKwjBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hJ0GE5WKJ8Judagr846iUKIfHjS+mnrCbIbfmMX33df8UJlJUTU8NAltlPAiDC7YR0lt3m8TDJDUIMOz4xjJJ0aMpCapH7o4KaWQ0DB/EzxB+O2SMuNa55G/xhm8Jelj3pT/ywDZUWLZrRrjVrkXNjuWcoE40eKKl+AX/NyCNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1T8lLxNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A78FC32786;
	Mon, 29 Jul 2024 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246454;
	bh=N2gCqsvygQddI5i7RbAM0fdeMNrbIprvlHXPSNKwjBM=;
	h=Subject:To:Cc:From:Date:From;
	b=1T8lLxNH2LZ4AEIpnUlK4t1rrBBh1hTBq6ToLG8Xw7zgaz5oMb2aLP/UG9lnMdQPl
	 DI+SqSGjMHKot3zkIe41F8qQ4LfFl8l1oGTuS+lchcaTT3z5AsJKm+lwj8Fh0I5LDL
	 4oEcjFuAUNzYALXTky9EW3XVgzyuaBNd1hdtNoBU=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove ASSERT if significance is zero in" failed to apply to 5.4-stable tree
To: rodrigo.siqueira@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,chaitanya.dhere@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 11:47:17 +0200
Message-ID: <2024072917-footsie-stopwatch-c5d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5302d1a06a2cd9855378122a07c9e0942f0f04a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072917-footsie-stopwatch-c5d7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

5302d1a06a2c ("drm/amd/display: Remove ASSERT if significance is zero in math_ceil2")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
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
 


