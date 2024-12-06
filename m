Return-Path: <stable+bounces-99065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B49E6F0B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A583280EC0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6752066DC;
	Fri,  6 Dec 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="171oKA8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97B46426
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490847; cv=none; b=t8pxIDikHI3WEnydxZz6Jyg67KpzwC67GYjag82rhrWbBx/rNgJJYefYtduj/DGKPaNbq6jIGj6wXU9Wwc/5HzTsr1pXjz8mN46VnIHXXPd4W1kUOYsNotmLuuYTxZug93+TWLBqCM4Z4VJq4lrMtxRWkXP0P48388rQNE+UEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490847; c=relaxed/simple;
	bh=n1ijw5golRSMKibB48BSXHza8+Pv7afyPb2AHhr3hHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XCm9LMUGXP1YX0tuQDq57ZUJbYtTUURFtqvI8twTCr0R6HdWoX1Sqhs75HvUD4vZ6LiR/AChvASKqAStsEhVG49nHaierETOtYPEwplVDV/AU5mmyZ3/+XdK9gjcQivgrKvKOKNYjY6h3SHGj6SB2XFg8rkjeIvX+YXipfCFR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=171oKA8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96499C4CED1;
	Fri,  6 Dec 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490847;
	bh=n1ijw5golRSMKibB48BSXHza8+Pv7afyPb2AHhr3hHE=;
	h=Subject:To:Cc:From:Date:From;
	b=171oKA8RWH2a2dJAn/u/C24ERvwA6/maC3r1a0w0YmB6dteUSMDEqjobkjS1XY2Nm
	 40TGFDG9Nbw9LHPJlwBh8s3RIHUUJ7hsY/Q1nJz5ZMMk6PJFWhaM3WBrHa44ijlkWP
	 1VYgdZt9e4+sRk++xHhlITxv4qKbnrdD62VmFjzI=
Subject: FAILED: patch "[PATCH] drm/sti: avoid potential dereference of error pointers in" failed to apply to 5.4-stable tree
To: make24@iscas.ac.cn,alain.volmat@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:13:55 +0100
Message-ID: <2024120655-quartered-resurrect-32d1@gregkh>
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
git cherry-pick -x c1ab40a1fdfee732c7e6ff2fb8253760293e47e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120655-quartered-resurrect-32d1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1ab40a1fdfee732c7e6ff2fb8253760293e47e8 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Fri, 13 Sep 2024 17:09:26 +0800
Subject: [PATCH] drm/sti: avoid potential dereference of error pointers in
 sti_hqvdp_atomic_check

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Cc: stable@vger.kernel.org
Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patchwork.freedesktop.org/patch/msgid/20240913090926.2023716-1-make24@iscas.ac.cn
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index acbf70b95aeb..5793cf2cb897 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1037,6 +1037,9 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
 		return 0;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;


