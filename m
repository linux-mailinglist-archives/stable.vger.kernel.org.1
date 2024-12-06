Return-Path: <stable+bounces-99038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AA59E6DFD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DAE166552
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AEB201012;
	Fri,  6 Dec 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b18iaV4I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B02A1D4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487669; cv=none; b=iN/rxscmV7uUwR0ylXt4yTF9uwWQ4422GMI5ECwU2ASYYeTpvvRPX3aBv+o/ZUcjGZu7TC0ewgex0j+sO+OF+rOc2fgIK0LsEDxU73dsfCdQDjNRfXvDGpsd+Eb4YDZGW5vRMIRuPUuWcecBV4PXkQgbYIpDVaeuQNs145mQ7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487669; c=relaxed/simple;
	bh=TxBi3BhyNG8iDL2sO0QFhQG3tkq/BoH3JaH6lKaxORI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o6pI1kFZP/yTbpobH6KH3KAN90GBSx7y/jrarhyq+9rDXlLJDI815odcXo9IBN/SEPE4RVFTJqZmPkuK49cbovc0juXJZBrUgmXbcJEONxswCLSfH4YwkJZ3l+zVrN8kbqlMPhm2ksErLjuxtEDJNgvEANr7Shg5z52zFqx+NwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b18iaV4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3D4C4CED1;
	Fri,  6 Dec 2024 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487669;
	bh=TxBi3BhyNG8iDL2sO0QFhQG3tkq/BoH3JaH6lKaxORI=;
	h=Subject:To:Cc:From:Date:From;
	b=b18iaV4Icbvp+jMowdh8b7pJlxISS7whNWaxds0eN6F2nQ17vBzGBMxLbhskcuCne
	 8JxEddXLv9N0Rq613FhEu4dcNeP66rNVn25gfCjDdA3tG1+agi7E618xXZo2MNM/0y
	 itl5+V0mi0UaprTcpY9LRHg7FJQtzTKDxnilq9uw=
Subject: FAILED: patch "[PATCH] i3c: master: Fix dynamic address leak when 'assigned-address'" failed to apply to 6.6-stable tree
To: Frank.Li@nxp.com,alexandre.belloni@bootlin.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:20:56 +0100
Message-ID: <2024120655-grumble-camcorder-7549@gregkh>
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
git cherry-pick -x 851bd21cdb55e727ab29280bc9f6b678164f802a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120655-grumble-camcorder-7549@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 851bd21cdb55e727ab29280bc9f6b678164f802a Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 11:45:08 -0400
Subject: [PATCH] i3c: master: Fix dynamic address leak when 'assigned-address'
 is present

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241021-i3c_dts_assign-v8-3-4098b8bde01e@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 1bf9cb138f77..5a089be7e072 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1548,16 +1548,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1960,9 +1953,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Do not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_mask(&master->bus,
 						  i3cboardinfo->init_dyn_addr,
-						  I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
+						  I3C_ADDR_SLOT_EXT_DESIRED,
 						  I3C_ADDR_SLOT_EXT_STATUS_MASK);
 
 		/*
@@ -2126,7 +2120,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.


