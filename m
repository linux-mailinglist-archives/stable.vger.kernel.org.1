Return-Path: <stable+bounces-144804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B955ABBE02
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BE717E1D7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF426AA93;
	Mon, 19 May 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAEQdjuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E619DFA2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658225; cv=none; b=hL+XSFR7RTGsbh5XxuaJGbqIAZWAYvwUH0kVdddUHqmEFoJE8HkyKgczrf0wNYzQpEREKTodTLDM6b35YBW3YfrPERVZ794CIndz0srKW31cTsgLbOMzXL2jHaGI0sFjoDBER5X1l5aHSKMSUbtzVrBTgw060sFku010fx3VRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658225; c=relaxed/simple;
	bh=z85wXD+jlsYZVdQwYdc4p2GTBKyK0un3iilAFvwh0pw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=elucirjtJMjs9YW918edc5FqeUeen6BbaGL4KgbFsyZIT+9yrF/L0gt2/MVPl5CxPN0WHfozJsdt/DCHb5862O+rPmgbkH2dclPQlJx8lvECgzeGnBQFGHdVl18MTdNHfVDzENDH1gTa9k16FKrjE4IRf1+Ccz8WoZM809wSrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAEQdjuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322EBC4CEE4;
	Mon, 19 May 2025 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658225;
	bh=z85wXD+jlsYZVdQwYdc4p2GTBKyK0un3iilAFvwh0pw=;
	h=Subject:To:Cc:From:Date:From;
	b=TAEQdjuv8vWuEckYcUNRDF4XEEUzw8f5Og0tDO7LrD0WNPYjb1jS3N0uQir3hmxIL
	 /e2y/XUN4OLOKYuNw78wmYq4cCMFMmlHwCsZ50Tr508LnUDT5hB+uQxRhVTsv2d1BD
	 /uXHKNE2TFiPXULgiFDdIEDEdmJt9wyJ8CXeWmvo=
Subject: FAILED: patch "[PATCH] i2c: designware: Fix an error handling path in" failed to apply to 5.15-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,jarkko.nikula@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:36:57 +0200
Message-ID: <2025051957-stagnant-footsore-4840@gregkh>
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
git cherry-pick -x 1cfe51ef07ca3286581d612debfb0430eeccbb65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051957-stagnant-footsore-4840@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


