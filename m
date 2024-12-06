Return-Path: <stable+bounces-99069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4499E6F28
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A64164E70
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F5206F1F;
	Fri,  6 Dec 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1mK+cMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A61FF7D4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490935; cv=none; b=G1+8FtDw7sJxWqzouKZ1z/QLqsf4h2wQilnAPnCWG6jDX++Tz9Tm9jdgdasSj3C10IhLX2Osn6ZSXWt89ChM8ZxY/4iFP80HVl8PTyplaO21tSgN0px3ncAOf+O3ghZo132h0npQZC6SH4DBzgHQz9/ykrIBF5fjbJDBJA5vmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490935; c=relaxed/simple;
	bh=iEnckB1SLCcvWUvsDIUv/7BuXCQDMGIgVUA07/5umyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HvV5NwJVRLcFUosvaARf6LuBf6BC8dEKQK9Cu8o/TRJ67Qdx73muH229TOtPB8058GOWw7c1N0ZCvuKf+anpmLXGuZTlAQAqbd0uy+MhAeTYyKpEOyynzk1ypyFQCl60R+yWtGJUXs8agnwXQ6EvjRZ8L+Oplg+ThqzUOQlBOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1mK+cMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F09FC4CED1;
	Fri,  6 Dec 2024 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490934;
	bh=iEnckB1SLCcvWUvsDIUv/7BuXCQDMGIgVUA07/5umyA=;
	h=Subject:To:Cc:From:Date:From;
	b=O1mK+cMv+1eA4wmBQiJnVFnSrgf6k47fGrtl28zaVUzk9U5nAkQ+DRFPMngbbC3Dx
	 ipGlAeKl7k/9080xBp0Yi50aqEw4b+6snWxRtYOn5Q1jZdBljlbC7jrVuil4VR98cO
	 1NdmW5YAdJM90BK30N70extx2IA/lnmDueT5cock=
Subject: FAILED: patch "[PATCH] drm/sti: avoid potential dereference of error pointers" failed to apply to 5.4-stable tree
To: make24@iscas.ac.cn,alain.volmat@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:15:22 +0100
Message-ID: <2024120622-footsore-silo-9e55@gregkh>
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
git cherry-pick -x 831214f77037de02afc287eae93ce97f218d8c04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120622-footsore-silo-9e55@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


