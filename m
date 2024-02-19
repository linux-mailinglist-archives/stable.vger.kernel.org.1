Return-Path: <stable+bounces-20582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722385A86E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D571C21B2A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54B3CF4F;
	Mon, 19 Feb 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTx/bPQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEED3CF56
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359177; cv=none; b=KvS8F+Z5pYu2mAmVYKnj3OVDmRwPsfV7kXJ/K6CrBGpuHG6S2yF2EOGjpereR23LctW37qy2WQILii0Jn2EHKc/WoYkXqFS3cUBa461s421fEv1pG6JpLhctxY+MtDOR7Guw/jdkvxaHC5HWRuxPcrDLv3/KtK4tO253tEVqFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359177; c=relaxed/simple;
	bh=loF9EXNeJhdCm7u3xPM3m5lVN4reosAjm37TsQnUYZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M/SP/bXrGfxWh6Sm0MH11RrAq8BwBmigA54D/kc3iXdDK2EA6FvTIbnpJwTv5xaMBUlFpgdqP2Fdldi5NSTmtpfU72dBTudUvYr5IJlOjBeIP6BzmWGWggh+mI7DThJDpT/MACWcVro3u6gQf5zUHpGzJKeq896KNMSpyHa+1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTx/bPQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D47C433C7;
	Mon, 19 Feb 2024 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359177;
	bh=loF9EXNeJhdCm7u3xPM3m5lVN4reosAjm37TsQnUYZU=;
	h=Subject:To:Cc:From:Date:From;
	b=yTx/bPQy3RcDPD/bVU+eeifeFkNm9s3LiLK9owHUWq+ibftLdEYqf2cLlez81XJqk
	 /5Gm34IDLgp30l4nVdNqlOar89D4g/f9sKe/eu4dZluvx25pXX7n7W0xDdQEMrnpuQ
	 Rm1EJfy2b9ifsAYZVhdBt7476gwh7YH8JfKzQPk8=
Subject: FAILED: patch "[PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other" failed to apply to 5.15-stable tree
To: kernel@wantstofly.org,cassel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:12:47 +0100
Message-ID: <2024021947-shy-pusher-ef20@gregkh>
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
git cherry-pick -x 51af8f255bdaca6d501afc0d085b808f67b44d91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021947-shy-pusher-ef20@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

51af8f255bda ("ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts")
20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers")
3bf614106094 ("ata: ahci: add identifiers for ASM2116 series adapters")
f07788079f51 ("ata: ahci: fix enum constants for gcc-13")
eb7cae0b6afd ("ata: libahci: Extend port-cmd flags set with port capabilities")
55b014159ee7 ("ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back")
02e2af20f4f9 ("Merge tag 'char-misc-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")

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


