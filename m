Return-Path: <stable+bounces-163524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D4EB0C034
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA241898C0A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4521D5AA;
	Mon, 21 Jul 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EeuIoXJ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294744A0F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089898; cv=none; b=flXV+3bUe9ZB3IxemJP6cwQojZgyd2kpZVjoZ1hNU1GkE76CikRIDzUpLDo1bzhYRM3k9W9T/Yep2DpSVqL7SVhBlSGlxPdUjm2mJBTl87aJO0g4Jj1A58rPyc4noqpwa4zMHPyjLthDQVejQFN4CZW54eC6DLm9ZoYG9cBGQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089898; c=relaxed/simple;
	bh=K0y9tGIoQJGxGNREBbWx2K9uPMRWss/CXxl/BLDj88M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vCkSdrBUf4DgXuvGQ84RgF1KZyqlUuVVWreSbMNXkDNXQ8b4gMPU1eh7XKxK5RD0mnWZL64bcHKSj+vVmwE6toLVoFqQYY8/FLdOKxIytekQg+F5bPyqibMOTybhhcU/6c6pb4W7jy7EaXSxzxwgCBia8jdcB/5CVUwVlTMgxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EeuIoXJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343E1C4CEF1;
	Mon, 21 Jul 2025 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089896;
	bh=K0y9tGIoQJGxGNREBbWx2K9uPMRWss/CXxl/BLDj88M=;
	h=Subject:To:Cc:From:Date:From;
	b=EeuIoXJ+8F7OCHdyE1dClSdYavn/CYuLJN6BjyTO9suioiVdNwc+NrWo42IrgGFou
	 0vrGM14p0mhwtIHa8mw2dtNNanf+efQTOXXFrz2RGB75CsByzReHU1a7ca26u2OSXz
	 IwbfcefmJsEPZsOsdf+bxzbeoHjfXoM2wGc/kZdw=
Subject: FAILED: patch "[PATCH] i2c: omap: Fix an error handling path in omap_i2c_probe()" failed to apply to 5.15-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:24:31 +0200
Message-ID: <2025072131-observant-cost-1619@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 60c016afccac7acb78a43b9c75480887ed3ce48e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072131-observant-cost-1619@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60c016afccac7acb78a43b9c75480887ed3ce48e Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 5 Jul 2025 09:57:38 +0200
Subject: [PATCH] i2c: omap: Fix an error handling path in omap_i2c_probe()

If an error occurs after pm_runtime_use_autosuspend(), a corresponding
pm_runtime_dont_use_autosuspend() should be called.

In case of error in pm_runtime_resume_and_get(), it is not the case because
the error handling path is wrongly ordered.
Fix it.

Fixes: 780f62974125 ("i2c: omap: fix reference leak when pm_runtime_get_sync fails")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v5.13+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/af8a9b62996bebbaaa7c02986aa2a8325ef11596.1751701715.git.christophe.jaillet@wanadoo.fr

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 17db58195c06..5fcc9f6c33e5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1521,9 +1521,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (omap->mux_state)
 		mux_state_deselect(omap->mux_state);
 err_put_pm:
-	pm_runtime_dont_use_autosuspend(omap->dev);
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:
+	pm_runtime_dont_use_autosuspend(omap->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return r;


