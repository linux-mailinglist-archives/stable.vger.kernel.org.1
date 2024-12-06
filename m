Return-Path: <stable+bounces-99068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48599E6F29
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B018836EB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCAF206F21;
	Fri,  6 Dec 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lWtpcGCi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CA204095
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490929; cv=none; b=Psa0DeouU7NWVQQD/4dTc0dWvLDpAhuCOyr2zxuuHtGRb8C5tjR6MBzx+4o60Ia3QVS/z0b+USLYjI94XJUPBnTSsrqhsKNQucONHlHx6dsSRTAQXv6AitmmYt+pOjeqn7keV9HuxEbN4HxRwzEOCVGJ9UnqLYLaBJsM8a8oDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490929; c=relaxed/simple;
	bh=hJT1wGNS/z1qZGMDK2nf02jVwjnj4QPl/4aVEgP+LMM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gGgVwn6J8U5yS4pDV6gDa7yDiUOCpOonMFnlmbSmpNTY+IzV4I2XMi0IoMk+32jbyxZo+5HyjLMwP/zGuHnxYCBUqR1FBVtZre17fwVZ1tpbUrH3xs9CHSgYedcHZtqJxvGl1dE8vGFK9r207vQcCT9VGHCBaZX5YTONvJ4fqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lWtpcGCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BAAC4CED1;
	Fri,  6 Dec 2024 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490925;
	bh=hJT1wGNS/z1qZGMDK2nf02jVwjnj4QPl/4aVEgP+LMM=;
	h=Subject:To:Cc:From:Date:From;
	b=lWtpcGCibf7bXrXFQT9De4CH8GIuAao7KyIrMf57Q9qSpEy2YDWNuMykPa4JPoXVi
	 2JCHsFfg+ndCha6Kc7TFiyPS98SiRzkaZg1lSSpekVjjlYHA8rSUjPS828UViNBlCJ
	 95iFXdz1fwkvXXE4QkZ0dfInut/UPLDFw/MMBv2U=
Subject: FAILED: patch "[PATCH] drm/sti: avoid potential dereference of error pointers" failed to apply to 5.10-stable tree
To: make24@iscas.ac.cn,alain.volmat@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:15:22 +0100
Message-ID: <2024120622-rifling-twentieth-0cf4@gregkh>
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
git cherry-pick -x 831214f77037de02afc287eae93ce97f218d8c04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120622-rifling-twentieth-0cf4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 831214f77037de02afc287eae93ce97f218d8c04 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Fri, 13 Sep 2024 17:04:12 +0800
Subject: [PATCH] drm/sti: avoid potential dereference of error pointers

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Cc: stable@vger.kernel.org
Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patchwork.freedesktop.org/patch/msgid/20240913090412.2022848-1-make24@iscas.ac.cn
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index db0a1eb53532..c59fcb4dca32 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -200,6 +200,9 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 		return 0;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;


