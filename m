Return-Path: <stable+bounces-158916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734CAED8AB
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1613ADB41
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD023BD02;
	Mon, 30 Jun 2025 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhaEChTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E2238C0F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275616; cv=none; b=FZ4BiH8+jFK2KJtVkXf2LH0eeuQppAswwVENpWYrk2pf1kvfcXC2uun9PG7EyqyoZ2mgPuAqgaV5ldonYuXwM+zmsUTwlEzPA0LW1+7oAR2QeNPmqneF8hcPDqFt2R0xye97VYMb50OXhgcoRTwN8kib8Sce+kwYVNY/23gAYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275616; c=relaxed/simple;
	bh=23U66rCChJkG+sCgEVrl82MrHWHilSme2BPUC9jHoTo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=adMbQt4QjNoOj8azTvi6KNuMho44AfkLgQaVStBvGFjWQiOvPuFpMa8go6ZpB+47gmOvHz8L7CdrjY0SpCtMacNj+0eyTVGZ+wDKXpIqAMubAa6upbaYaoDrbn4/lA4I7UtfY++JKgYUsM06oMMz9WAnY7HI3npKaNS7l8MK36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhaEChTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB93C4CEE3;
	Mon, 30 Jun 2025 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275616;
	bh=23U66rCChJkG+sCgEVrl82MrHWHilSme2BPUC9jHoTo=;
	h=Subject:To:Cc:From:Date:From;
	b=MhaEChTBmiRfV/AG0uzVsPoqMVMwfFy+FtWljzIVaXtoODvUjuUXv50BcKuDEwGfn
	 kyF4Kxnex0NuFTPuEjKLnMDLc6EB9KuL5c7BrcYpJ0XNs8mQp/CANMikU+sOsQhXQD
	 4sV9bc0sfrQf6Qmw5mr+G5M3eAykYfcJFfaLSwk8=
Subject: FAILED: patch "[PATCH] drm/tegra: Fix a possible null pointer dereference" failed to apply to 5.4-stable tree
To: chenqiuji666@gmail.com,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:26:53 +0200
Message-ID: <2025063053-vastness-consuming-8fce@gregkh>
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
git cherry-pick -x 780351a5f61416ed2ba1199cc57e4a076fca644d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063053-vastness-consuming-8fce@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 780351a5f61416ed2ba1199cc57e4a076fca644d Mon Sep 17 00:00:00 2001
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Wed, 6 Nov 2024 17:59:06 +0800
Subject: [PATCH] drm/tegra: Fix a possible null pointer dereference

In tegra_crtc_reset(), new memory is allocated with kzalloc(), but
no check is performed. Before calling __drm_atomic_helper_crtc_reset,
state should be checked to prevent possible null pointer dereference.

Fixes: b7e0b04ae450 ("drm/tegra: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20241106095906.15247-1-chenqiuji666@gmail.com

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 56f12dbcee3e..59d5c1ba145a 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1393,7 +1393,10 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		tegra_crtc_atomic_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (state)
+		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 static struct drm_crtc_state *


