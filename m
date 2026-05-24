Return-Path: <stable+bounces-254000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZzANadEmq21gYAu9opvQ
	(envelope-from <stable+bounces-254000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:42:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2955C18C6
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D968E300E399
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C238E8A1;
	Sun, 24 May 2026 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHNvekb3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764562F9D98
	for <stable@vger.kernel.org>; Sun, 24 May 2026 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779604942; cv=none; b=vBYj3yaZoX2rTLeVgOPwMIbuvKUSeRk/gTvxuW0s/VLbn0Cxfi8eknNiHK7y5FEthjY4Bqcx5MEAHOqiv/M3hahHgNWleo3U7Yon46r3UK4Tyq6LT0Xum8nrioO2Z8aEkzuiBiSy+Y8MoXITHLp11GaPSFrfhiMPXxWdcFo73tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779604942; c=relaxed/simple;
	bh=lHwyEJgFw4OE9LRGWpTEQ6xFPPU5Y0dHMJutQ4KxLeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlJJ+jpbmXiE8HAdI9Qu5e5NIO3+va4s3eKmBr22r4SexH9oz4kT+J29jLbFitz+iq0QPhH5f/H4vR1SkAKO0VREzlNtcvpI1DTdhoId5rO/iJvQljbSY8x9qvci1q6z7J/TOWmI0N3b82gsceser1YrmFU4MnKrgsMeCRQ+wYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHNvekb3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba21d32776so63405505ad.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779604941; x=1780209741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkftP+Op/c8v58DKWgVPqjSk1fdvRHWO8kLTuLloiiI=;
        b=sHNvekb3ZQ9lDNiVhZt8u5UynVrQCWdZTg/HWJ3C0TwgR6YLbsDNHpZyTYB7Iz2fQc
         9gCjHDxZVNW95clEXw+9YZSTtxJ491WLgKYzVegb6c2V2gLDmfQ6qSRx9Ko4aGVBbmkA
         +3W53r1Evn1CbJJj464Lywm6WWIogUc+R8EMhsQfbopiHv6raxPKauPs+8kCPaOeGyXv
         WTAINWby4N1DBk5oPED/3Ekl0WCQHectOe5TfDgpXOd/124yRn2s1Tvl1S+TqSyXMpMW
         J+GWQl3H5/1Yhq/qYCKOr73c9k3bsHezONoNTv49Y5j8XPi/rINBAGDNxCA+UvGNx7hd
         RXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779604941; x=1780209741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkftP+Op/c8v58DKWgVPqjSk1fdvRHWO8kLTuLloiiI=;
        b=g1PCQnLHouoUgO4J8RaorIocyxVaHDrK9zHe6vnY6aj20OOHrJHcHavKLT7q5d6tFj
         99zj4gXNdHQ56z4CbqOQFaQ3sqBZtEFpsHITgfijsSURWGqj6x6K1x/CbXNmiTnRdvQJ
         bWUnTFIhhvKf5goM+ZclY+jwmZ4SDVdqS6FtDF+vSjNuxd5F6OEWx0Q1apcWycI86VS3
         EqPOQn/SXb3OMRz8GlVMGUsbaiQYectLli/aatoBahPvznshkaFdKaimX0TEdLgEqnLE
         cSyb5yDGRj1Uae7g8ZuC53H27KXIdKYlCG6iHfUIFzgyTxN9mxA9vVDkmp3vLxOb0P/v
         zCGA==
X-Forwarded-Encrypted: i=1; AFNElJ/iqzmi9BDzQZS6SSn4hjmxkUf2e5bIfVLqzS3dFBw6+wdY7uX/NOAgnJuinMhyuN3NSxKEJNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUEkKZtyslTAkjUd6f1JL28qEg0owrqgAQWE1Eqb42Dh8DCM/
	Q0XGzBHQexerVaHM6GYb4mUEGpeim2mCWimllkUyUuMpcE47GYX4KAOD
X-Gm-Gg: Acq92OHsLfo67w96Zh7N6Khc/LLufOXaukVp0rvQGiqsTelJ6RKzWaKQqOO4YPbQ1Hg
	wPmH9vMuHSUAkG5e+feKvGTO3J9AqHhLpToQG2L20cjFP66fJzA/MyFa1d7R1Anyk+u0gMkYTsf
	AJU7W5MZnVmIGo3nREWAXxcIo0aIRC4uDVUI/fSGRdzGWF1Z0sR1Lcv28iMWyIeo3Bfh2Of3evl
	TSIJomMHe4t3T01r4d0QT9blS3XiS3ad7RkgLkGU5xJzcp9p2KDdswPmr7pqxKhQFvJ3wO0I+Ag
	vq31p3u5j4euQXkltC5HaR7C5VJNkinYkCXEvFFf4qBtYmZbj0Va42Cz/PbCNOKB0ngCEhNLQY/
	geNMoA+olYoBbkahd27cw1Cf8E79a/2GyshPzyY+tq9U6EQp/+7OjSLJfxwfUgx6xqFC+kiqagq
	jxB1HohoytENuzYyIam3RtIIakwDpVHEApMQ==
X-Received: by 2002:a17:902:d4c9:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2beb037693fmr106201015ad.15.1779604940712;
        Sat, 23 May 2026 23:42:20 -0700 (PDT)
Received: from lgs.. ([118.193.33.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f3dsm60218115ad.1.2026.05.23.23.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 23:42:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] uio: fix IRQ vector leak on probe failure and remove
Date: Sun, 24 May 2026 14:42:01 +0800
Message-ID: <20260524064201.1177225-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A2955C18C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

probe() allocates MSI/MSI-X vectors with pci_alloc_irq_vectors(), but
neither the error path nor remove() releases them with
pci_free_irq_vectors().

Unlike drivers using pcim_enable_device(), this driver uses
pci_enable_device(), so the IRQ vectors are not managed automatically
and must be freed explicitly.

Add pci_free_irq_vectors() to the probe error path after successful
vector allocation and to remove(). The issue was identified by a
static analysis tool I developed.

Fixes: 3397c3cd859a ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Change have_irq_vectors from int to bool.
  - Set have_irq_vectors immediately after successful IRQ vector allocation.

 drivers/uio/uio_pci_generic_sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..e216436c9116 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -63,6 +63,7 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uio_pci_sva_dev *udev;
 	int ret, i, irq = 0;
+	bool have_irq_vectors = false;
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
@@ -78,6 +79,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (ret > 0) {
+		have_irq_vectors = true;
+
 		irq = pci_irq_vector(pdev, 0);
 		if (irq < 0) {
 			dev_err(&pdev->dev, "Failed to get MSI vector\n");
@@ -139,6 +142,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_free:
 	kfree(udev);
 out_disable:
+	if (have_irq_vectors)
+		pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
 
 	return ret;
@@ -148,6 +153,7 @@ static void remove(struct pci_dev *pdev)
 {
 	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
 
+	pci_free_irq_vectors(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	kfree(udev);
-- 
2.43.0


