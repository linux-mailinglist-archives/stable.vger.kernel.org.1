Return-Path: <stable+bounces-70167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C9195EFF3
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EA11F210B9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD2155351;
	Mon, 26 Aug 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ou5V31Yl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067615533F
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672358; cv=none; b=qXmvow72EQNoDCUrFmGBAZXoqo2SS2d92ckhSv7NDtUzK+srIQhG6xs8f5XzPbWx2/VlOUhmIbFw3c7nTYmdtqXIMh/nDfQZ29teyutqj6aBH1hSvBvD1MimTJ4mKEvCnFj1XwePPVPWPjk05Gk/FgMj3aCHP7SKBjKZtHbuIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672358; c=relaxed/simple;
	bh=IOaTyFtxHdXOmwherz0wRE+m6lv0FyxTSlCNmP1uwoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=frZCP5kw5HZfUj/kZOyKGcx8ZryCLQsssqL0vJYu2G9SNZ9G7NKMg1I8b8jYi9TG93QZsfSJzlFxZj//+0oBdBEbCEpTpinROSVJjPDWg/yeHZqnDB76pvs5ojrsjx9sZpdZ7utg7yFFfRw6gZx5K/310/0KPWQiNNvtilQZaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ou5V31Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8102BC5140E;
	Mon, 26 Aug 2024 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672358;
	bh=IOaTyFtxHdXOmwherz0wRE+m6lv0FyxTSlCNmP1uwoM=;
	h=Subject:To:Cc:From:Date:From;
	b=Ou5V31YlFJvi1K1Lk+MOnP6t/VUp48/+URNe99dfhERx4HoIuPrLC+tJ5zOkocwAq
	 k7Xcf1AAF9GK+lr/BHDbwhZTq95pqdNKLAVOCJTmPvYOg1rk5TR7vTNCR+E4K06nS6
	 T+I74tzTtKQqaEdhWhD+00Ju1mX/B0ulG/k7gYKk=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix eGPU hotplug regression" failed to apply to 6.10-stable tree
To: alexander.deucher@amd.com,Hawking.Zhang@amd.com,Jun.Ma2@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:39:14 +0200
Message-ID: <2024082614-overnight-phonebook-e864@gregkh>
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
git cherry-pick -x 9cead81eff635e3b3cbce51b40228f3bdc6f2b8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082614-overnight-phonebook-e864@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

9cead81eff63 ("drm/amdgpu: fix eGPU hotplug regression")
b32563859d6f ("drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in SRIOV")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cead81eff635e3b3cbce51b40228f3bdc6f2b8c Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 19 Aug 2024 11:14:29 -0400
Subject: [PATCH] drm/amdgpu: fix eGPU hotplug regression

The driver needs to wait for the on board firmware
to finish its initialization before probing the card.
Commit 959056982a9b ("drm/amdgpu: Fix discovery initialization failure during pci rescan")
switched from using msleep() to using usleep_range() which
seems to have caused init failures on some navi1x boards. Switch
back to msleep().

Fixes: 959056982a9b ("drm/amdgpu: Fix discovery initialization failure during pci rescan")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3559
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3500
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>
(cherry picked from commit c69b07f7bbc905022491c45097923d3487479529)
Cc: stable@vger.kernel.org # 6.10.x

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ac108fca64fe..7b561e8e3caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -278,7 +278,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
 				break;
-			usleep_range(1000, 1100);
+			msleep(1);
 		}
 	}
 


