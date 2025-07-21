Return-Path: <stable+bounces-163527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BBB0C038
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F23A94FA
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88594A0F;
	Mon, 21 Jul 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpAHf2Nt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1B28C87E
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089907; cv=none; b=ss/c+yvL9a1D8e3YqdzQl/yJg4NfVzoEC9y2TcsHDWoWLiEkeBAA4729p8xMRSpi7b/l58tBzLWKYqmL2UazvwhYQWOfecUl4uCNMZx3vRdu8hmt+t+qrNYrvwXSrRpmNu8BZPfrXcmCu/PfZqPTtT02QCs74Up9jkv4HywcmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089907; c=relaxed/simple;
	bh=tvzJ/XS8ElDqZ5t+XhgkDFtipOUa4s/f2TldUivNufU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mlfDp9P9qf2CGarrX0W5yhgXpkIfUI2aRRcETds7S8crSGHaAm3/oY2EhDtN0yp3M206cxviOR8IO2SpJDsSm4NqjJWi2PuRMpExTNkjgyoySr3WNxzJ3AbTgMm5GBBcnla1sYfxxHw0tcv8ZYAu8eCYRqZj/9XAbiGgLV2MqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpAHf2Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09842C4CEED;
	Mon, 21 Jul 2025 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089906;
	bh=tvzJ/XS8ElDqZ5t+XhgkDFtipOUa4s/f2TldUivNufU=;
	h=Subject:To:Cc:From:Date:From;
	b=cpAHf2NtKkX/JE6aG1su+W4ou4gXpyL/c4mu3ISoIQhEq5cbmV487manchmQyf57s
	 c9ZkXZeHwXaBJNJWvutuvZBZst4MKiXWAPrYyNh+B2ZMwReIfhii+NrgCoMQAwElYs
	 8I46xhtbwK14TAjcVmSDkXnrVfabm5nXN561BYCU=
Subject: FAILED: patch "[PATCH] i2c: omap: Fix an error handling path in omap_i2c_probe()" failed to apply to 5.10-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:24:32 +0200
Message-ID: <2025072132-jargon-concierge-f26f@gregkh>
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
git cherry-pick -x 60c016afccac7acb78a43b9c75480887ed3ce48e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072132-jargon-concierge-f26f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


