Return-Path: <stable+bounces-20581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D377685A86F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F61CB21C68
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1853CF48;
	Mon, 19 Feb 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQLp/ZUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2F38F96
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359174; cv=none; b=DRT5aX6+EETQ0DKbHTZiKz0m1c1vLEFuIleH9Mt+SDLRV9Q7lng7cREEl2/LgJbZiTQViSHWgAUZMW9A6wkImMjK1d4Vc6Zmh2w8+bGawoWkXQHO9HsQKJ+hxxpRoFivl/tKP5/+uZiDURPeIlkN4O392c3AGB3sZYyTOX+qIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359174; c=relaxed/simple;
	bh=o7xVHP9+MfNPmVMlIn/24yWfEke5i5sZ39R7t+1WaT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=de4V8fkJ+nr/8iO4i7n/XII7s3pWHVtsWh8fT5HNqlJgIDc2YjxQCQLcMR2jqKYaVQEWBBgq8feIMo1aBZp0sxFI88O4LfND6yQU8yqeJXmRN+Y6mwlrO38PKwqVGSGsaIjl8wi/kqTn5JSgaZhlBBofG9VyB/0uguIWKO/LkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQLp/ZUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C97C433F1;
	Mon, 19 Feb 2024 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359174;
	bh=o7xVHP9+MfNPmVMlIn/24yWfEke5i5sZ39R7t+1WaT4=;
	h=Subject:To:Cc:From:Date:From;
	b=OQLp/ZUEleARNoX4aw+6g2+AP8U8QYnmi4HMe03+H6T8uHPnPGUwr8/KSODBQF4Iq
	 oUMGIEBktG0vs2ZRCFJYOESii6C8+JOJwxZg1VrncImotPZf+1OLe4DG8DLtejDYAp
	 cQU9SMYvZDjuU4bipNKWMj/KHYt3kxHBZd5OmKqo=
Subject: FAILED: patch "[PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other" failed to apply to 6.6-stable tree
To: kernel@wantstofly.org,cassel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:12:46 +0100
Message-ID: <2024021945-robin-felt-tip-fd20@gregkh>
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
git cherry-pick -x 51af8f255bdaca6d501afc0d085b808f67b44d91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021945-robin-felt-tip-fd20@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

51af8f255bda ("ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts")
20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers")
3bf614106094 ("ata: ahci: add identifiers for ASM2116 series adapters")

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


