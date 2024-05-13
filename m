Return-Path: <stable+bounces-43711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070F8C4407
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622091C209A4
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AFF539C;
	Mon, 13 May 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDiPeIvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC644C84
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613522; cv=none; b=E6hyYcRAnuLI3P2u/Jfe7ngF85WZZ9dYIEn9kkZMLm0p8IysaLLRmYAb7JbwFxvCv0OuKOljAt42u6o1eFXv0W0BLvM4uU+MK2o4cm0i+8cY2BuUOySJXtnhaibovoNqfy5yuqPEFHMjyd6NZhiDge79xmdGJUzcoTDS+sLG5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613522; c=relaxed/simple;
	bh=e/t2RnHcAvcHWJd4esiBugcYTMZxwp/Gg2vkECG8Pz8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DTQ33pMC1QTcUTaZcsJ0LOMTl+5YsFzN08gXFvqm22dxMwam6zgsdtdMxXL47Y8H7CHLWOp6KscFct188allMr6hsy8CC6Xac1xDwKVq+/DcjS1YcYi9vID1jjmjkgcfv8/jnXU24vuRRECQQa0WUGgT2O9NqvVPvr1Qa9Y+1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDiPeIvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F79C113CC;
	Mon, 13 May 2024 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613522;
	bh=e/t2RnHcAvcHWJd4esiBugcYTMZxwp/Gg2vkECG8Pz8=;
	h=Subject:To:Cc:From:Date:From;
	b=iDiPeIvZU8qQQJvQ2b4FhxZHvDmiIKJsza+fokIXHP7I99n6DYViMe/HqBDDcGA/F
	 JBGevX2VCC3IO6weo1eoVQihE1dqFCGv3hcqgdty6wtXUT3c3GfG+f6A4pYniPMIdZ
	 95P6SZEXfo7SCp4m0g/iit0gGvDpz+5cCZSQ53M4=
Subject: FAILED: patch "[PATCH] misc/pvpanic-pci: register attributes via pci_driver" failed to apply to 6.6-stable tree
To: linux@weissschuh.net,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:18:39 +0200
Message-ID: <2024051339-strut-alienable-25c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ee59be35d7a8be7fcaa2d61fb89734ab5c25e4ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051339-strut-alienable-25c7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ee59be35d7a8 ("misc/pvpanic-pci: register attributes via pci_driver")
c1426d392aeb ("misc/pvpanic: deduplicate common code")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee59be35d7a8be7fcaa2d61fb89734ab5c25e4ee Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 11 Apr 2024 23:33:51 +0200
Subject: [PATCH] misc/pvpanic-pci: register attributes via pci_driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In __pci_register_driver(), the pci core overwrites the dev_groups field of
the embedded struct device_driver with the dev_groups from the outer
struct pci_driver unconditionally.

Set dev_groups in the pci_driver to make sure it is used.

This was broken since the introduction of pvpanic-pci.

Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Fixes: ded13b9cfd59 ("PCI: Add support for dev_groups to struct pci_driver")
Link: https://lore.kernel.org/r/20240411-pvpanic-pci-dev-groups-v1-1-db8cb69f1b09@weissschuh.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 9ad20e82785b..b21598a18f6d 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -44,8 +44,6 @@ static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
-	.driver = {
-		.dev_groups = pvpanic_dev_groups,
-	},
+	.dev_groups =   pvpanic_dev_groups,
 };
 module_pci_driver(pvpanic_pci_driver);


