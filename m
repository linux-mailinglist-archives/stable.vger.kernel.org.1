Return-Path: <stable+bounces-65590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3B94AAD5
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCA1283324
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB127B3F3;
	Wed,  7 Aug 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nj77ev62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284983CD2
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042673; cv=none; b=brGT4dpkKELOE3obbe3EysBr3XyrmsYrvbklKjE0FYXLadc8PFCKRd8PyLJEUn7MwABu7cN0g6gsFPd+FWFWafePD+Yp4n5tFU40kGZSU8VJL8sCtQFCTmV3Vz7uB3L9t4JROuvM3J6kuT008sJce8DfvfYYTbBSk6ZOO+Q1gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042673; c=relaxed/simple;
	bh=1nioZ66sLOsJWMoFw0HjitHDVp6qTvT2W5cG2RxZrhY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dhCJ/Znka9E2Ow6oS87dhLgnyPAb0T0AEozC841o5UMfK+nG5GTodDhJ6SbZEixmkFymqi4uhrbm8TcsiE2lBUjFYZUjk0J3dEsZpD8SNpywTx1U99yP9fZeZnqVd5+iu5cK5xHfwpHVaBPGrleowtkxW3SiDeSdbQVdtQO+u/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nj77ev62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08012C32781;
	Wed,  7 Aug 2024 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723042673;
	bh=1nioZ66sLOsJWMoFw0HjitHDVp6qTvT2W5cG2RxZrhY=;
	h=Subject:To:Cc:From:Date:From;
	b=Nj77ev62a8FqA/1QEEVfbpwMdZvZBd1byI8fqxrhkZpRLIdIp1lDBMTSlNqj6PYQ0
	 k5aT2yujtB2AeLkZsShbDEWhIV5F87VfbXvl6HhYUdw4Y316xmvB+g6Mc8HlSwl5rg
	 etWY2OmhvZjE7Ka1UKu65yWPFF6tNHel5d0bozLM=
Subject: FAILED: patch "[PATCH] drm/ast: Fix black screen after resume" failed to apply to 6.6-stable tree
To: jammy_huang@aspeedtech.com,airlied@redhat.com,cogarre@gmail.com,jfalempe@redhat.com,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:57:50 +0200
Message-ID: <2024080750-lance-overcrowd-731e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 12c35c5582acb0fd8f7713ffa75f450766022ff1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080750-lance-overcrowd-731e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

12c35c5582ac ("drm/ast: Fix black screen after resume")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12c35c5582acb0fd8f7713ffa75f450766022ff1 Mon Sep 17 00:00:00 2001
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 18 Jul 2024 11:03:52 +0800
Subject: [PATCH] drm/ast: Fix black screen after resume

Suspend will disable pcie device. Thus, resume should do full hw
initialization again.
Add some APIs to ast_drm_thaw() before ast_post_gpu() to fix the issue.

v2:
- fix function-call arguments

Fixes: 5b71707dd13c ("drm/ast: Enable and unlock device access early during init")
Reported-by: Cary Garrett <cogarre@gmail.com>
Closes: https://lore.kernel.org/dri-devel/8ce1e1cc351153a890b65e62fed93b54ccd43f6a.camel@gmail.com/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240718030352.654155-1-jammy_huang@aspeedtech.com

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index f8c49ba68e78..af2368f6f00f 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -391,6 +391,11 @@ static int ast_drm_freeze(struct drm_device *dev)
 
 static int ast_drm_thaw(struct drm_device *dev)
 {
+	struct ast_device *ast = to_ast_device(dev);
+
+	ast_enable_vga(ast->ioregs);
+	ast_open_key(ast->ioregs);
+	ast_enable_mmio(dev->dev, ast->ioregs);
 	ast_post_gpu(dev);
 
 	return drm_mode_config_helper_resume(dev);


