Return-Path: <stable+bounces-41687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C58B574D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D8BB228A6
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6252F8E;
	Mon, 29 Apr 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L45shF1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171D4652D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392058; cv=none; b=AOlz4lfjzfg7Vx3G4DLKfPrRkEKH3OJ9uEUZxVTgb0KLeA2RsTBW6XecHbLiaqpwKFF45FygUb40EG/O84JEhl4tmQMt7iQT3HGzRizsveYRDA0tC3Dj8znWynQkkvJGUlo24M5fEDbROaYYkVgI8e/f+sgv3e/UM/+mS2+jhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392058; c=relaxed/simple;
	bh=kMkR9Tbw36Sc6atxuBSvKfpHkGN91Kk9e6mucGMIzes=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wrst2yf0tOf9ppGw/PVhVi+5xvK+LGFGE2ECvI5jFoTyzFyNVtJBkxSjC8R3EclAAKt49xUNTbnKFF55QX3j/Zaha5CGPdu6Guok+R9jjjNjFCo2Tb3ZUdRUdjZ7IqQeZur4K8rSBzrCZQbsExShzGRm53E97V1SuPWtEl7M+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L45shF1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125BFC113CD;
	Mon, 29 Apr 2024 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714392057;
	bh=kMkR9Tbw36Sc6atxuBSvKfpHkGN91Kk9e6mucGMIzes=;
	h=Subject:To:Cc:From:Date:From;
	b=L45shF1qFWzmo5pvXvXyDyDLdifk05VKnXxel2lnMp90RM3Df0u2hmngW0i6/gkLJ
	 0ApmC6zOPmYwXFa7+xZ03uGaUoqrufzP/D7vPII+pXbtqlExLI+ILRFVNe6gxiz6x4
	 bXT3bR7QUqt2TZlddHORpHS8erfDVrJudpJtgWB4=
Subject: FAILED: patch "[PATCH] mtd: limit OTP NVMEM cell parse to non-NAND devices" failed to apply to 6.6-stable tree
To: ansuelsmth@gmail.com,miquel.raynal@bootlin.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 14:00:54 +0200
Message-ID: <2024042954-throwaway-recluse-d3a6@gregkh>
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
git cherry-pick -x d2d73a6dd17365c43e109263841f7c26da55cfb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042954-throwaway-recluse-d3a6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d2d73a6dd173 ("mtd: limit OTP NVMEM cell parse to non-NAND devices")
2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2d73a6dd17365c43e109263841f7c26da55cfb0 Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Fri, 12 Apr 2024 12:50:26 +0200
Subject: [PATCH] mtd: limit OTP NVMEM cell parse to non-NAND devices

MTD OTP logic is very fragile on parsing NVMEM cell and can be
problematic with some specific kind of devices.

The problem was discovered by e87161321a40 ("mtd: rawnand: macronix:
OTP access for MX30LFxG18AC") where OTP support was added to a NAND
device. With the case of NAND devices, it does require a node where ECC
info are declared and all the fixed partitions, and this cause the OTP
codepath to parse this node as OTP NVMEM cells, making probe fail and
the NAND device registration fail.

MTD OTP parsing should have been limited to always using compatible to
prevent this error by using node with compatible "otp-user" or
"otp-factory".

NVMEM across the years had various iteration on how cells could be
declared in DT, in some old implementation, no_of_node should have been
enabled but now add_legacy_fixed_of_cells should be used to disable
NVMEM to parse child node as NVMEM cell.

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we detect the MTD type is Nand.

With the following logic, the OTP NVMEM entry is correctly created with
no cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240412105030.1598-1-ansuelsmth@gmail.com

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..0de87bc63840 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
-	config.add_legacy_fixed_of_cells = true;
+	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;


