Return-Path: <stable+bounces-20579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19D85A86C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730812877F6
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148B3C467;
	Mon, 19 Feb 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smq3fpnW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C73B7A1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359168; cv=none; b=rSaDsn9AYnN9BugjXAvB7sZtmwGdVaAnj+NaVQbA04Oi232c1eyKQxx7XyhY1T9r/rn1Q+f4Bkiw2COSuvWOBY+bwhJVWhYFWMGHkNgoZBPxvJRpKnJkgVK/XmjPgS/EP7oY+luZtPlDKKK1xKqIyRLNam0vnUg/TEuliHibjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359168; c=relaxed/simple;
	bh=sFVSlGOrupLNSU+MlxkQc0aeQ7Uxfo8Jz5dcS/nCuyk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h8ue6ojm08kbCo/y5LtJecrQ63cjn7C43t1QjSnxS5MBOIYAny/ASjZ0LeS18/s8yPWHOjBWYsk8728vyxlbJdRg64OclOc9h8xdlVrTjcTwlSFYemmZ7oHSEW7J+Fl1FOwKAtevz5t6v0drixz4xgejhwuZlr41fYZH9kPkdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smq3fpnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC42EC433F1;
	Mon, 19 Feb 2024 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359168;
	bh=sFVSlGOrupLNSU+MlxkQc0aeQ7Uxfo8Jz5dcS/nCuyk=;
	h=Subject:To:Cc:From:Date:From;
	b=smq3fpnWeReEpPGaW9mnjsp7PECJS9Co0w4wYxoy2arS+3qV2c+R3JQumDGQqbZT+
	 Lqdg5zEgdm7lKJkXY0jbA7RYrgV6hOO6ORNMMJJrGw+pF3io84NCJZSmlfXMmd35S2
	 EzCBoxcr8fDtobmPsj6PrhE0Hp2Y+x8iPRO1AaU0=
Subject: FAILED: patch "[PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other" failed to apply to 6.7-stable tree
To: kernel@wantstofly.org,cassel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:12:45 +0100
Message-ID: <2024021945-jockey-spending-9e68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 51af8f255bdaca6d501afc0d085b808f67b44d91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021945-jockey-spending-9e68@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

51af8f255bda ("ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts")
20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51af8f255bdaca6d501afc0d085b808f67b44d91 Mon Sep 17 00:00:00 2001
From: Lennert Buytenhek <kernel@wantstofly.org>
Date: Tue, 30 Jan 2024 15:21:51 +0200
Subject: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts

ASMedia have confirmed that all ASM106x parts currently listed in
ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
into on the ASM1061, and therefore, we need to apply the quirk added by
commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
ASM1061 controllers") to the other supported ASM106x parts as well.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-ide/ZbopwKZJAKQRA4Xv@x1-carbon/
Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
[cassel: add link to ASMedia confirmation email]
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d2460fa985b7..da2e74fce2d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
 	/* ASMedia */
-	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
 	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */


