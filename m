Return-Path: <stable+bounces-144803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36045ABBE05
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9213A5E59
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536E278E63;
	Mon, 19 May 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BCrYUE8T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0920C00E
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658222; cv=none; b=Du4CmsY0L5BRSwN6lg5E4gXhjM0flFRNzwGIoruiPCaXbpWTYzhFkpY5cxSOtMfmg0aGI94uNwd4F1tg6Yi7hfw2lIE+jV4ahZ52T+pezZzGU101bA+iEy/wzYWnTGU3s9qVJGHCdrF5Bifiuh9RIB3lvCJxbSVOJ+185/H6Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658222; c=relaxed/simple;
	bh=bdoibA9TD3aN02iHry/WvAtT4Vi7sxqvqozTCPUSbkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LsMUNvNodWBAwfB6YJq3XsORvMOjhzCP9tQQ9dij/3dftBTLeWNoTBg64hKXC1q0YsITQBz2dsNGgtjPRpiSyXYuXZvPl1yvdEf+crA9dCfZ3fjChYkivYZt7RnHjRKhC/i9MmHQCz/Pd3HVKbuA3AVOnJWCgPAKSODvlzidJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BCrYUE8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C9C4CEE4;
	Mon, 19 May 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658222;
	bh=bdoibA9TD3aN02iHry/WvAtT4Vi7sxqvqozTCPUSbkY=;
	h=Subject:To:Cc:From:Date:From;
	b=BCrYUE8TJwM4bvbOejlBYXpGHT/hMaKPmSNLr8aHMzUy4w/dgkFY7STX4jeixxRqg
	 j4q2JIYewc7CoeTX6aviqdnAoThsN+xTMlm0lPtbZ/c3mKESlMjITJ/AWuVQMVzFZo
	 65dkrr24GEuzYeroVVth7cBfDtI9gWCXxgRGVWUU=
Subject: FAILED: patch "[PATCH] i2c: designware: Fix an error handling path in" failed to apply to 6.6-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,jarkko.nikula@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:36:56 +0200
Message-ID: <2025051956-employed-unranked-500c@gregkh>
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
git cherry-pick -x 1cfe51ef07ca3286581d612debfb0430eeccbb65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051956-employed-unranked-500c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cfe51ef07ca3286581d612debfb0430eeccbb65 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 13 May 2025 19:56:41 +0200
Subject: [PATCH] i2c: designware: Fix an error handling path in
 i2c_dw_pci_probe()

If navi_amd_register_client() fails, the previous i2c_dw_probe() call
should be undone by a corresponding i2c_del_adapter() call, as already done
in the remove function.

Fixes: 17631e8ca2d3 ("i2c: designware: Add driver support for AMD NAVI GPU")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v5.13+
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/fcd9651835a32979df8802b2db9504c523a8ebbb.1747158983.git.christophe.jaillet@wanadoo.fr

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 8e0267c7cc29..f21f9877c040 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -278,9 +278,11 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
 		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
-		if (IS_ERR(dev->slave))
+		if (IS_ERR(dev->slave)) {
+			i2c_del_adapter(&dev->adapter);
 			return dev_err_probe(device, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
+		}
 	}
 
 	pm_runtime_set_autosuspend_delay(device, 1000);


