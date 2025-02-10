Return-Path: <stable+bounces-114591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B74A2EF03
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820481885099
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E82309AC;
	Mon, 10 Feb 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTCbaFj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636D22E406
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195793; cv=none; b=RvaRrCLu0cu0JUHtZ+IhZia0WRtDLENZXB301x/LctBWFxShd0sJXH6/ESXXMqj38aORNnLXcoTe4dWqkp449sfjurQT5LA6L/PJogS+gBCy0H/DiHV7KNybxxzsNXJJ8eZQ05d56SZk1r1ORn+biQhpXVxFC8o87WZ0PZn0Rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195793; c=relaxed/simple;
	bh=KkF0op5ZgXyRaFZfi7wTcjCAn9WdHxq4KeTxFlnBXOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ATVEolZNhfb05PKFiOJUAf+2VSfpb9IVQeH5UYNSBchfMOJv2GfJz9gR59TJME5gmXXJiGLNy0jPj2QI5FFjZWKg8VH/oyadrrT6mKXOT1zB1FuZSWZXW+z0/Amb23TZ4jzm3Wz0v5Edfjoibsg7HJXFGuzUTKhFUd9nEl158wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTCbaFj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101A2C4CED1;
	Mon, 10 Feb 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195793;
	bh=KkF0op5ZgXyRaFZfi7wTcjCAn9WdHxq4KeTxFlnBXOg=;
	h=Subject:To:Cc:From:Date:From;
	b=zTCbaFj1eLAEKXN2goU/DF28itQ2ad2bkK0P7WvAsvolnLmVVMgl+QsXJoJILL7Xv
	 QtAwtP/d6ih4oj9fCiAYQ01sy0IAG4wSvdnwd2FKQSk4llSNK65/A63Q43Y6CjEz9F
	 pbG7tytsqCGJsRDwwYLR39RYyIHCaKBK5xS731PU=
Subject: FAILED: patch "[PATCH] PCI: Restore original INTX_DISABLE bit by pcim_intx()" failed to apply to 6.12-stable tree
To: tiwai@suse.de,bhelgaas@google.com,pstanner@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:56:22 +0100
Message-ID: <2025021022-broadness-afflicted-47d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d555ed45a5a10a813528c7685f432369d536ae3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021022-broadness-afflicted-47d6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d555ed45a5a10a813528c7685f432369d536ae3d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 31 Oct 2024 14:42:56 +0100
Subject: [PATCH] PCI: Restore original INTX_DISABLE bit by pcim_intx()

pcim_intx() tries to restore the INTx bit at removal via devres, but there
is a chance that it restores a wrong value.

Because the value to be restored is blindly assumed to be the negative of
the enable argument, when a driver calls pcim_intx() unnecessarily for the
already enabled state, it'll restore to the disabled state in turn.  That
is, the function assumes the case like:

  // INTx == 1
  pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct

but it might be like the following, too:

  // INTx == 0
  pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong

Also, when a driver calls pcim_intx() multiple times with different enable
argument values, the last one will win no matter what value it is.  This
can lead to inconsistency, e.g.

  // INTx == 1
  pcim_intx(pdev, 0); // OK
  ...
  pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0

This patch addresses those inconsistencies by saving the original INTx
state at the first pcim_intx() call.  For that, get_or_create_intx_devres()
is folded into pcim_intx() caller side; it allows us to simply check the
already allocated devres and record the original INTx along with the
devres_alloc() call.

Link: https://lore.kernel.org/r/20241031134300.10296-1-tiwai@suse.de
Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org	# v6.11+

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index d1d97a4bb36d..3431a7df3e0d 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -419,19 +419,12 @@ static void pcim_intx_restore(struct device *dev, void *data)
 	pci_intx(pdev, res->orig_intx);
 }
 
-static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+static void save_orig_intx(struct pci_dev *pdev, struct pcim_intx_devres *res)
 {
-	struct pcim_intx_devres *res;
+	u16 pci_command;
 
-	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
-	if (res)
-		return res;
-
-	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
-	if (res)
-		devres_add(dev, res);
-
-	return res;
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
 }
 
 /**
@@ -447,12 +440,23 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
 	struct pcim_intx_devres *res;
+	struct device *dev = &pdev->dev;
 
-	res = get_or_create_intx_devres(&pdev->dev);
-	if (!res)
-		return -ENOMEM;
+	/*
+	 * pcim_intx() must only restore the INTx value that existed before the
+	 * driver was loaded, i.e., before it called pcim_intx() for the
+	 * first time.
+	 */
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (!res) {
+		res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		save_orig_intx(pdev, res);
+		devres_add(dev, res);
+	}
 
-	res->orig_intx = !enable;
 	pci_intx(pdev, enable);
 
 	return 0;


