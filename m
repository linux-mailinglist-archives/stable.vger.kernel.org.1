Return-Path: <stable+bounces-247391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHYkMAC1BmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:54:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF7549C70
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA35B303FF0F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A954364E9C;
	Fri, 15 May 2026 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2KpKK6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5336405F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824436; cv=none; b=SklBujftbcTOiW7+JP15gUl9TJotWh2mjeCBJEvt9O+O35r/7xJsCqRnN68g4v+01+eTjT/+JHVhFYR2eaRtvOb+0Chwz7J+Qmer65A/TAJN1FveHqX3PL1oqGyEtGwAvq5FOn8DOKh6s0rj7NewY3sAgjKSYPOS53NvPPpcPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824436; c=relaxed/simple;
	bh=OjQAg4Shf8Yp3Yo0GkNG20rteZ7rYf2bpjkg/m6vAeo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c0wyY5WerXLvOWY+jxAQ6hJIgGQ9ehqE1m6KApNP+EQBE2VMH+MqOgDl9GsVmBgILhFUlM+uMn0B+S7CxfAy7I8y+x3Q76jvtHt0RXAz6Ida7R+mfAGU15h7SmNSx0AK9O/1GQi8aV/YviXtFSow2B2Qph4L80r7lI5G81snHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2KpKK6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AE1C2BCB0;
	Fri, 15 May 2026 05:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778824435;
	bh=OjQAg4Shf8Yp3Yo0GkNG20rteZ7rYf2bpjkg/m6vAeo=;
	h=Subject:To:Cc:From:Date:From;
	b=I2KpKK6gQzyZcZZJR5Rze7OmTFri0QarCcefPks27DjFOaO8xKq0U4u2wT9Q03Lou
	 3uic+clD/5BCAdF5XaA5jK99g9yDB2LwDN14i0gnnb4aZPs9wSjsAes/JWbB3qLNrE
	 DaRS8uHqUTU70ndM3fl7y9Wy9MerB1OGNlXKmIBI=
Subject: FAILED: patch "[PATCH] media: saa7164: add ioremap return checks and cleanups" failed to apply to 5.15-stable tree
To: 1742789905@qq.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:53:59 +0200
Message-ID: <2026051559-refresh-willow-e717@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CAF7549C70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247391-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[qq.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d51c60a498e83c9a79884c8e420f97e3885c9583
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051559-refresh-willow-e717@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d51c60a498e83c9a79884c8e420f97e3885c9583 Mon Sep 17 00:00:00 2001
From: Wang Jun <1742789905@qq.com>
Date: Mon, 16 Mar 2026 20:24:01 +0800
Subject: [PATCH] media: saa7164: add ioremap return checks and cleanups

Add checks for ioremap return values in saa7164_dev_setup(). If
ioremap for BAR0 or BAR2 fails, release the already allocated PCI
memory regions, remove the device from the global list, decrement
the device count, and return -ENODEV.

This prevents potential null pointer dereferences and ensures proper
cleanup on memory mapping failures.

Fixes: 443c1228d505 ("V4L/DVB (12923): SAA7164: Add support for the NXP SAA7164 silicon")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Jun <1742789905@qq.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 74406d5ea0a5..6bcde506adf5 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -888,6 +888,15 @@ static int get_resources(struct saa7164_dev *dev)
 	return -EBUSY;
 }
 
+static void release_resources(struct saa7164_dev *dev)
+{
+	release_mem_region(pci_resource_start(dev->pci, 0),
+			   pci_resource_len(dev->pci, 0));
+
+	release_mem_region(pci_resource_start(dev->pci, 2),
+			   pci_resource_len(dev->pci, 2));
+}
+
 static int saa7164_port_init(struct saa7164_dev *dev, int portnr)
 {
 	struct saa7164_port *port = NULL;
@@ -947,9 +956,9 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 
 	snprintf(dev->name, sizeof(dev->name), "saa7164[%d]", dev->nr);
 
-	mutex_lock(&devlist);
-	list_add_tail(&dev->devlist, &saa7164_devlist);
-	mutex_unlock(&devlist);
+	scoped_guard(mutex, &devlist) {
+		list_add_tail(&dev->devlist, &saa7164_devlist);
+	}
 
 	/* board config */
 	dev->board = UNSET;
@@ -996,11 +1005,17 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 	}
 
 	/* PCI/e allocations */
-	dev->lmmio = ioremap(pci_resource_start(dev->pci, 0),
-			     pci_resource_len(dev->pci, 0));
+	dev->lmmio = pci_ioremap_bar(dev->pci, 0);
+	if (!dev->lmmio) {
+		dev_err(&dev->pci->dev, "Failed to remap MMIO BAR 0\n");
+		goto err_ioremap_bar0;
+	}
 
-	dev->lmmio2 = ioremap(pci_resource_start(dev->pci, 2),
-			     pci_resource_len(dev->pci, 2));
+	dev->lmmio2 = pci_ioremap_bar(dev->pci, 2);
+	if (!dev->lmmio2) {
+		dev_err(&dev->pci->dev, "Failed to remap MMIO BAR 2\n");
+		goto err_ioremap_bar2;
+	}
 
 	dev->bmmio = (u8 __iomem *)dev->lmmio;
 	dev->bmmio2 = (u8 __iomem *)dev->lmmio2;
@@ -1019,17 +1034,25 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 	saa7164_pci_quirks(dev);
 
 	return 0;
+
+err_ioremap_bar2:
+	iounmap(dev->lmmio);
+err_ioremap_bar0:
+	release_resources(dev);
+
+	scoped_guard(mutex, &devlist) {
+		list_del(&dev->devlist);
+	}
+	saa7164_devcount--;
+
+	return -ENODEV;
 }
 
 static void saa7164_dev_unregister(struct saa7164_dev *dev)
 {
 	dprintk(1, "%s()\n", __func__);
 
-	release_mem_region(pci_resource_start(dev->pci, 0),
-		pci_resource_len(dev->pci, 0));
-
-	release_mem_region(pci_resource_start(dev->pci, 2),
-		pci_resource_len(dev->pci, 2));
+	release_resources(dev);
 
 	if (!atomic_dec_and_test(&dev->refcount))
 		return;


