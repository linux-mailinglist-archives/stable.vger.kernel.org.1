Return-Path: <stable+bounces-64119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4858941C2F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C41C2309B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A70187FF6;
	Tue, 30 Jul 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g72vJpxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339011A6192;
	Tue, 30 Jul 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359052; cv=none; b=SmbtphUR4d8iCKCcWb8xHFykEPj/Go3OIqEN7dEznfnXW098EUIEGmo9r9gLqS7f9yt4RxyEUB170UK2KVh0DpzMiOW/i6t7uoZYSA60kbGiFhO6Ww6PWYeNfWtxUVOt09VlJ/gbOU7NFZWn7zKF7w5CWbEGKKUdXtb4omXTz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359052; c=relaxed/simple;
	bh=weHjZo/CHBiuDGn7H3HT5izf9yHayx/XdoZnfaWGGuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQvr67TaxbEGIfHbAdJorf5xKOmZTF2mMDYu0rkT+X7gX47L4tpJUzUGLhZSuoMrhJh5uol6qs+IpTxJ/MV0n0B/6P+qDAA8NuXI4tqfoboi9OSGK0gEUKxpUR2iXEwdWyEqXZfcNg9GITdawPbj1+2YpnrZiLNoYcbJhUPDoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g72vJpxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6CFC32782;
	Tue, 30 Jul 2024 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359052;
	bh=weHjZo/CHBiuDGn7H3HT5izf9yHayx/XdoZnfaWGGuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g72vJpxwzMeDvrfcm2sJKwGoP7DkZ8Xj6JeIxNfnmxL9BLONunwi/eGiVF+nprDYy
	 R/nwcsPsCftMC88ecLYh7M282qwoGcwEy+28oYsVNmTtp5zuaRfUThARSpItWoxmre
	 BD4vVufRoG7j/12z1poy6UkacZPBFUBOBdy5gG5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Liu <wei.liu@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	stable@kernel.org
Subject: [PATCH 6.6 425/568] PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN
Date: Tue, 30 Jul 2024 17:48:52 +0200
Message-ID: <20240730151656.479396275@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Liu <wei.liu@kernel.org>

commit fea93a3e5d5e6a09eb153866d2ce60ea3287a70d upstream.

The intent of the code snippet is to always return 0 for both
PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.

The check misses PCI_INTERRUPT_PIN. This patch fixes that.

This is discovered by this call in VFIO:

    pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);

The old code does not set *val to 0 because it misses the check for
PCI_INTERRUPT_PIN. Garbage is returned in that case.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Link: https://lore.kernel.org/linux-pci/20240701202606.129606-1-wei.liu@kernel.org
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1137,8 +1137,8 @@ static void _hv_pcifront_read_config(str
 		   PCI_CAPABILITY_LIST) {
 		/* ROM BARs are unimplemented */
 		*val = 0;
-	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
-		   PCI_INTERRUPT_PIN) {
+	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
+		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
 		/*
 		 * Interrupt Line and Interrupt PIN are hard-wired to zero
 		 * because this front-end only supports message-signaled



