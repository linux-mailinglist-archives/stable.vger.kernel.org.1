Return-Path: <stable+bounces-125944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5CA6DF7F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC583B425C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9F262813;
	Mon, 24 Mar 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrBe8DwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E7261392
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833340; cv=none; b=TnWT+axSeeERK/4PLS0HUwIVh5KwkuiZGUajO45yxdhUJwAJNQMhFA+65gmi4kKWILv32cyjkXXXv5n1EkQWyTPNyvas3EDJjNPfS2aLb6WL+lhrr1UAaSvvD43Wf0L+zMh+EGpbMCerDblknIKTE2jVKo0Sx6Rkb9wMefwxx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833340; c=relaxed/simple;
	bh=7BevsmM1oUDsRbiGzqMkafdJawDVDSWCNrsMMZdkD4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z2SqatKrI0scSfg7AYwY1DHwzIp4AK3GVW+XbvTc6qLO8bo1mnybOvE0OF+qpAzsGebi5vHtVl53wFi490wtLxsyruyEjATa58oz0vlsrzzUlAy0PdCx4ce0QJn1BJCVZ5q1QWLe2HQ777uvNfej7wwiwIfE9WibQv55wh4LRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrBe8DwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1627EC4CEDD;
	Mon, 24 Mar 2025 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742833340;
	bh=7BevsmM1oUDsRbiGzqMkafdJawDVDSWCNrsMMZdkD4s=;
	h=Subject:To:Cc:From:Date:From;
	b=DrBe8DwZ5hSreRNByerO1S9eYUwWkoq9r9vkMyfQqc6VamscxyfPO1cqoWEJeigpD
	 uWSuyPRcFhxCLYHGlBwx0iaE0Ds63gji3AsMiDdmgSiVEGoTcsghTKDYkA8Men682a
	 B2hVDONACLruGV1KnKO1/d21gD2713T+cPdUZ5Gw=
Subject: FAILED: patch "[PATCH] drm/amd/display: should support dmub hw lock on Replay" failed to apply to 6.1-stable tree
To: martin.tsai@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,robin.chen@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 09:20:57 -0700
Message-ID: <2025032457-occultist-maximum-38b6@gregkh>
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
git cherry-pick -x bfeefe6ea5f18cabb8fda55364079573804623f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032457-occultist-maximum-38b6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfeefe6ea5f18cabb8fda55364079573804623f9 Mon Sep 17 00:00:00 2001
From: Martin Tsai <martin.tsai@amd.com>
Date: Fri, 2 Feb 2024 14:39:29 +0800
Subject: [PATCH] drm/amd/display: should support dmub hw lock on Replay

[Why]
Without acquiring DMCUB hw lock, a race condition is caused with
Panel Replay feature, which will trigger a hang. Indicate that a
lock is necessary to prevent this when replay feature is enabled.

[How]
To allow dmub hw lock on Replay.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index ba1fec3016d5..bf636b28e3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -65,5 +65,9 @@ bool should_use_dmub_lock(struct dc_link *link)
 {
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
+
+	if (link->replay_settings.replay_feature_enabled)
+		return true;
+
 	return false;
 }


