Return-Path: <stable+bounces-66675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757E94F0AC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7CFB276F1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083554724;
	Mon, 12 Aug 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXM53MCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8318309C
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474365; cv=none; b=VDFba+1IzEQ2Ne1mM4KTr/ljcloOhOWBDYhD3sH3/8MCAXXvHcbdPnvq/DnncwktbufxKEuDCC4k3esFWXS1R2u2GAs2pTGB8oPV31IzG+MjyLVfQpo3FtjykfBgL4k4xbFbexIFsJrDIhj7qRnMjd4z6OEHWUB6LISaPVc8aKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474365; c=relaxed/simple;
	bh=uowLxYKSQvZRXbX5S7yynXW07edj5qUPYi2WECNIatw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sbCyoH4iwsETUC2nEH805CKmggAUztTQ2J6+uDT/u++QH7OlAsnj5tw+7a1thJ+SJe2DcDRprOBfFSFlHw6LW/KqAzdlrOE0GZhMTwANGK1knJC+PIpbQZt/b8TKYCd3XHRviuAPSzmdjCzBNx2MgKhR4RD28w54bch8r+1W2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXM53MCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE8C4AF0F;
	Mon, 12 Aug 2024 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474365;
	bh=uowLxYKSQvZRXbX5S7yynXW07edj5qUPYi2WECNIatw=;
	h=Subject:To:Cc:From:Date:From;
	b=RXM53MCAI2HhJlYmI/wBS8+iJxOlqe7/EQ5lp/6ouxfx3MIo2fqSarwNB2Dei1RA6
	 cO7tvgtK9a4bzy5VykiXUv5lRLE5lzPg9adS/acCyXjjEuxsOlRusEN1kSkbwMOk/F
	 lFPrnt5K3MHM6qagSCsXEfacySA6DH+4/Kzh7Das=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove redundant idle optimization check" failed to apply to 6.10-stable tree
To: roman.li@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:50:14 +0200
Message-ID: <2024081213-waged-plausibly-75fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5745cb2da6fe08899420d695ce436df0166e7807
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081213-waged-plausibly-75fe@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

5745cb2da6fe ("drm/amd/display: Remove redundant idle optimization check")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5745cb2da6fe08899420d695ce436df0166e7807 Mon Sep 17 00:00:00 2001
From: Roman Li <roman.li@amd.com>
Date: Tue, 7 May 2024 16:26:08 -0400
Subject: [PATCH] drm/amd/display: Remove redundant idle optimization check

[Why]
Disable idle optimization for each atomic commit is unnecessary,
and can lead to a potential race condition.

[How]
Remove idle optimization check from amdgpu_dm_atomic_commit_tail()

Fixes: 196107eb1e15 ("drm/amd/display: Add IPS checks before dcn register access")
Cc: stable@vger.kernel.org
Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3bcfc95ad36a..1e263b357c13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9395,9 +9395,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
-	if (dm->dc->caps.ips_support && dm->dc->idle_optimizations_allowed)
-		dc_allow_idle_optimizations(dm->dc, false);
-
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_dp_mst_atomic_wait_for_dependencies(state);
 


