Return-Path: <stable+bounces-43713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0D8C4409
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0728716E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12C1DA20;
	Mon, 13 May 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esCWYFcq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1314C84
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613534; cv=none; b=SzJ9761/Fz4zun3cI9mTnsUKifeTtPoIUZKt6/yyqP29iqECMQwXjhWI8LVyOLagR23nyQkXd0z3z4jO8R8ZQKLmc+s1+Uu24oMyVWramuXfym6NyHxcc2UX3Jm3z9/4tAqnlx1bVKAcghlE/uAl+7wy03Xz6bCKwM5d1RcM6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613534; c=relaxed/simple;
	bh=UZXF7xWu7gLQwZUd40pbPwUmKR3PypjXWzyxKnlIwC8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SaR2wS9I15Ez4oU09Xz15HtdkwYRtmhUPXIPo4myxu1V4F4hoLE6H5SEW+1JPzaug2cprbu5O8aomckJvrLeMUia7g4nlGvWfQ0EA2fPur0KORUb9h6otBMDuQB9d3mWuvgpTxsfa7V6JPYuDkTqew00ia011fwdPvmGRGS80vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esCWYFcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DCEC2BD11;
	Mon, 13 May 2024 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613534;
	bh=UZXF7xWu7gLQwZUd40pbPwUmKR3PypjXWzyxKnlIwC8=;
	h=Subject:To:Cc:From:Date:From;
	b=esCWYFcqYROzt9j0dlJNZomeBLpYmuspO275tE4z3oHRaKmonsjFzQWaxpYtKi9KQ
	 3Rz2sAy8AUzVSyL/uN9KOAUEIAssrqHzTkVk7UrYJyne6NxUyaCr4SP/FCtLz4nJLI
	 Lq4PfX0PCUz/IaVioO7SBEsf+6KDIrmXR9KpwsO8=
Subject: FAILED: patch "[PATCH] misc/pvpanic-pci: register attributes via pci_driver" failed to apply to 5.15-stable tree
To: linux@weissschuh.net,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:18:41 +0200
Message-ID: <2024051340-destitute-overlaid-3681@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ee59be35d7a8be7fcaa2d61fb89734ab5c25e4ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051340-destitute-overlaid-3681@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ee59be35d7a8 ("misc/pvpanic-pci: register attributes via pci_driver")
c1426d392aeb ("misc/pvpanic: deduplicate common code")
84b0f12a953c ("pvpanic: Indentation fixes here and there")
cc5b392d0f94 ("pvpanic: Fix typos in the comments")
33a430419456 ("pvpanic: Keep single style across modules")

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


