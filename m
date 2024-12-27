Return-Path: <stable+bounces-106217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BC9FD660
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26287A01AD
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3081F76DA;
	Fri, 27 Dec 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvbAu3ZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EE1F76D0
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319353; cv=none; b=VKKa09QJZHQwPjfuMLrV66rk+60X4yztmDZnckodR9p42LjB1dO4yuR0xGRdSSSN3AGplIJPFZe0gdwwQGPhZOTABMZ9VetCb3cnUyDkoPLGsKqbWzLOvcYQSxb30b9iEdWY4smzX11fdUFHZAfrSErnrqDvG8jIetJmN0KBs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319353; c=relaxed/simple;
	bh=NsPeGecPZnG0jUxuCrfJ44zTfPRc2tz6jEWJV8WA/cc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IY/g6fJXzPN05wAPWibSOB60QPLSg5mW5H8zmhsnJ/xwTgLRsrhQsghpYICVyP2kcspRHxp6INY13hmO4uKerQIo9wA1+qVPGq0VbZGVMi0RBsN+jUTu+K4eXZnUowOjmTfOw6nyqe2m+MYarSbTp5SlyuBctOLBD2etltdvxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvbAu3ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37741C4CED0;
	Fri, 27 Dec 2024 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735319352;
	bh=NsPeGecPZnG0jUxuCrfJ44zTfPRc2tz6jEWJV8WA/cc=;
	h=Subject:To:Cc:From:Date:From;
	b=NvbAu3ZKJqgTfJDnemJqZDHMVbU0NO4X6WudsTW9C6Kc8zM4XDppyehWW9moRKNEV
	 VdNPw4mntJi4s0DT31gUn0yAF60qHNSx7Vx7Y0E79pV0HrvS/Bi+sQZAG3gj4/JnrK
	 +mRro2BM1XT3AGgGkhDhPIDAMCAj7wAp/MqLBC3U=
Subject: FAILED: patch "[PATCH] mtd: rawnand: arasan: Fix missing de-registration of NAND" failed to apply to 5.10-stable tree
To: maciej.andrzejewski@m-works.net,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Dec 2024 18:09:09 +0100
Message-ID: <2024122708-spud-properly-0780@gregkh>
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
git cherry-pick -x 11e6831fd81468cf48155b9b3c11295c391da723
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122708-spud-properly-0780@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11e6831fd81468cf48155b9b3c11295c391da723 Mon Sep 17 00:00:00 2001
From: Maciej Andrzejewski <maciej.andrzejewski@m-works.net>
Date: Mon, 2 Dec 2024 19:58:36 +0100
Subject: [PATCH] mtd: rawnand: arasan: Fix missing de-registration of NAND

The NAND chip-selects are registered for the Arasan driver during
initialization but are not de-registered when the driver is unloaded. As a
result, if the driver is loaded again, the chip-selects remain registered
and busy, making them unavailable for use.

Fixes: 197b88fecc50 ("mtd: rawnand: arasan: Add new Arasan NAND controller")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 26b506107a1a..865754737f5f 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1478,8 +1478,15 @@ static int anfc_probe(struct platform_device *pdev)
 
 static void anfc_remove(struct platform_device *pdev)
 {
+	int i;
 	struct arasan_nfc *nfc = platform_get_drvdata(pdev);
 
+	for (i = 0; i < nfc->ncs; i++) {
+		if (nfc->cs_array[i]) {
+			gpiod_put(nfc->cs_array[i]);
+		}
+	}
+
 	anfc_chips_cleanup(nfc);
 }
 


