Return-Path: <stable+bounces-6844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBE814FEC
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33682286918
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD83FB11;
	Fri, 15 Dec 2023 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ie4nYvuc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5824A3FB0B
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 18:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA1C433C7;
	Fri, 15 Dec 2023 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702666752;
	bh=QMWqrgoMVmHokKD72uCnxLlfo6Vcc/wP1tNnOGEHnco=;
	h=Subject:To:From:Date:From;
	b=ie4nYvuc0YD6Ry/ZZD9g0Hk9mkFtkhe+Psk1+uhruhKlb/gpqu2JgMOLR3c7S5KGt
	 2C3TRNDMJyV1gLbQpOojPdmGeXTm6lVNavdWb50WxFrD8VE7L8BsxpA9PHg9P+lZz1
	 2oaP9PeZT2mMZWcVCTJgJmqtXA0+Armw4U2UOUbI=
Subject: patch "parport: parport_serial: Add Brainboxes BAR details" added to char-misc-testing
To: cang1@live.co.uk,gregkh@linuxfoundation.org,stable@vger.kernel.org,sudipm.mukherjee@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Dec 2023 19:59:10 +0100
Message-ID: <2023121510-landmark-bounding-be8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    parport: parport_serial: Add Brainboxes BAR details

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 65fde134b0a4ffe838729f9ee11b459a2f6f2815 Mon Sep 17 00:00:00 2001
From: Cameron Williams <cang1@live.co.uk>
Date: Thu, 2 Nov 2023 21:07:05 +0000
Subject: parport: parport_serial: Add Brainboxes BAR details

Add BAR/enum entries for Brainboxes serial/parallel cards.

Cc:  <stable@vger.kernel.org>
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parport/parport_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9f5d784cd95d..11989368611a 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
-- 
2.43.0



