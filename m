Return-Path: <stable+bounces-116780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B526A39E33
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD9C1679F6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53125A650;
	Tue, 18 Feb 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EfXVtLi+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2D267384
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887349; cv=none; b=ekVca1ki1LIlrWTzr4re9gx9WQSBGf3/ZOyuFb9b5mMshtMCvL3MoUMlcHoshMOU3mqQizUw7jUykoYkiD8pcjNnUvP7CT4JKBLBz14NR9hBtUxcqWHv6YDf6NMoetE8hh4CdWmkY8voPcQtUJhyATzNYrjbyySKdxg3AEZqIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887349; c=relaxed/simple;
	bh=PcNKHqcxyKR7Ss+nENG3JL/oJCdsfYJhXCcgF0pDSN8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uBqdN5TM5ePDjNpQvWgAuQ5zvrS+LF41iTTan0Rgvw/nmDJ2A2dKB7GGSMc6VD6P8fdJ08RQyAN8Y8FFg7gXfFzZXuWXW1nRujJvl5pK4QYIW7lCk5rTLnAx1QPrml7bIyzsG/2fU6PW8aqHCQHxPoVVuUaCur3J7TJgo68lk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EfXVtLi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B90C4CEE2;
	Tue, 18 Feb 2025 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739887349;
	bh=PcNKHqcxyKR7Ss+nENG3JL/oJCdsfYJhXCcgF0pDSN8=;
	h=Subject:To:Cc:From:Date:From;
	b=EfXVtLi+UEJpg3n5ubEIcjFeBS+wzUGRtZbiIoVybglaS/Xjak+QNI0goC5WS68tE
	 u5qIwOi3Lii37rNAlujQgNkMtVig4Ynlh2e3nKYpVC4SPon0TkHpehLgTCkcy42akK
	 6GpqBaZXjBjREBR++HE2HHwfg7nyXehhSL6A+nJg=
Subject: FAILED: patch "[PATCH] drm/msm/gem: prevent integer overflow in" failed to apply to 5.4-stable tree
To: dan.carpenter@linaro.org,robdclark@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 15:02:17 +0100
Message-ID: <2025021816-flail-manger-7c9a@gregkh>
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
git cherry-pick -x 3a47f4b439beb98e955d501c609dfd12b7836d61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021816-flail-manger-7c9a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a47f4b439beb98e955d501c609dfd12b7836d61 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 15 Nov 2024 17:50:08 +0300
Subject: [PATCH] drm/msm/gem: prevent integer overflow in
 msm_ioctl_gem_submit()

The "submit->cmd[i].size" and "submit->cmd[i].offset" variables are u32
values that come from the user via the submit_lookup_cmds() function.
This addition could lead to an integer wrapping bug so use size_add()
to prevent that.

Fixes: 198725337ef1 ("drm/msm: fix cmdstream size check")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/624696/
Signed-off-by: Rob Clark <robdclark@chromium.org>

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index fba78193127d..f775638d239a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -787,8 +787,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			goto out;
 
 		if (!submit->cmd[i].size ||
-			((submit->cmd[i].size + submit->cmd[i].offset) >
-				obj->size / 4)) {
+		    (size_add(submit->cmd[i].size, submit->cmd[i].offset) > obj->size / 4)) {
 			SUBMIT_ERROR(submit, "invalid cmdstream size: %u\n", submit->cmd[i].size * 4);
 			ret = -EINVAL;
 			goto out;


