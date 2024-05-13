Return-Path: <stable+bounces-43712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D789B8C4408
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149C51C20443
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFE539C;
	Mon, 13 May 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jnlb/ur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0694C84
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613531; cv=none; b=OxGhUmnyO+f5w0u6JJQLe85RYkYhoyTFF/7WeH4AH63QLAJT9I+V0KulCkR3VyfLLMDmlB5XQlSJzbdx6stvZt7uM/E00ap/tI+TTSB3kfkZs+w659kT0WcusdsY5M0jSJOOvHm0DRFZ8Wjd0dogNzpUyvZKUrTeT6UOgVe/zpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613531; c=relaxed/simple;
	bh=1kWkKsF/r/cVAn9Sag3CQPUW7z8DMBmYTcAfbM7Zm6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V5LkuxWvjWwlrqLEqm1255jwaFI2faF9e4B/+/XKdSlqC3gIyPxR4r0oLsHyXIrfGj4NMO9WrGMU//WgUcs4QKY9lgev5TatOGPh8I/a+EJpPXs7S85EGV1LsxmE3MxKqxUEMbMFKeEVwK9B+AEnVA2MoFQCCJdSdsod20eCBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jnlb/ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1546C113CC;
	Mon, 13 May 2024 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613531;
	bh=1kWkKsF/r/cVAn9Sag3CQPUW7z8DMBmYTcAfbM7Zm6I=;
	h=Subject:To:Cc:From:Date:From;
	b=2jnlb/urGf3EZNs3fpzWU3UTDr5XhP7RejyH2MrEvIr6MQ68oKPpi1GmQPDWmTokQ
	 XEA3YvjYdDi4bl7Q3FzP5vCBJyIKFeJ7ICcz2JTqHmU+0oAbWm4qG8EsRMYMD0lL9m
	 KlYRXwF6nNzRE25RWqHq8AkIdlR48zdC6lmU1tYk=
Subject: FAILED: patch "[PATCH] misc/pvpanic-pci: register attributes via pci_driver" failed to apply to 6.1-stable tree
To: linux@weissschuh.net,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:18:40 +0200
Message-ID: <2024051340-puma-unshaven-405c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ee59be35d7a8be7fcaa2d61fb89734ab5c25e4ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051340-puma-unshaven-405c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


