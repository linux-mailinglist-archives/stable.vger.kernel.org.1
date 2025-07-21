Return-Path: <stable+bounces-163525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD2B0C033
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F817BAD6
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255D289E3D;
	Mon, 21 Jul 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6biUjBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEF4A0F
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089900; cv=none; b=XGjPyvu6F/qwMZMlc1ErEqy9lm5CrI+kla0/8/42yNHMJKEFzl3fPtWEuNj7rhP02M/VfMQqLW8WLMLLA7zWyJaFJcOj7VhC5H5/S8LtZyCcTuFVJLpWXa0mBDvSyuKlkE7GvjtDiDRtyiB//Atgy+WlN20rOM9/aWn9oMjBIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089900; c=relaxed/simple;
	bh=PpUeND3YVH07Nz5cluupdl8gL3BfnbQgNyPOpKjebus=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tCqBc5fWlSdI1FEthEOlXAuwcbdKlbXmPzixWTAlm0g6DsbdBSMv8qxTqxyuLspYEaT75vdbWR0z2sGOQQMy847EvYRsw5YCcaQ7db4AULDCdFi2mejCp2gxsTjVfNdXEWpy5InP9mJhe/qTt79IY/INp3G8v2aa4yfiUFy7BvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f6biUjBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9B5C4CEED;
	Mon, 21 Jul 2025 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089900;
	bh=PpUeND3YVH07Nz5cluupdl8gL3BfnbQgNyPOpKjebus=;
	h=Subject:To:Cc:From:Date:From;
	b=f6biUjBayHLvZYrhnzCSZccbGmY7lmYnWOE9hLTUdBhQjIEGmo19Ba33voiDdaTjw
	 1hBa7GQ9wY8ZYQKzWpZCBpShkUvtnlUKy4iBtRjcd/Mg4eoJxRcF9CCJ5aHDAWbhKU
	 gO2HBqM9+i0JQKI/3FvmfNq6zVrUSFZbWDkX1Gqc=
Subject: FAILED: patch "[PATCH] i2c: omap: Fix an error handling path in omap_i2c_probe()" failed to apply to 6.1-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:24:31 +0200
Message-ID: <2025072131-concave-saddlebag-ab4b@gregkh>
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
git cherry-pick -x 60c016afccac7acb78a43b9c75480887ed3ce48e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072131-concave-saddlebag-ab4b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


