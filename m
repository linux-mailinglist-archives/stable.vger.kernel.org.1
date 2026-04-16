Return-Path: <stable+bounces-238329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCHhKVYG4Wl5ogAAu9opvQ
	(envelope-from <stable+bounces-238329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A241145E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C7F8302E999
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C52F5498;
	Thu, 16 Apr 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLfVqC9O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A772882B6
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354899; cv=none; b=YI65quSh2ZOBjfk+3KxJIAbQVHBP2TbXomOwIgTGslz4SBx+qG2mp2kIJzpvg7boBGzHWc2nHboWQsu3+LvPH7IAIbJlDeY0ywI678iQJ7SmQSo+ij5/tH+nfpkkIfOamG4MJy7gyn3FT3QjCEghRUvkymbVxyu2Is2u0X+61PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354899; c=relaxed/simple;
	bh=8EDhl73uGgy3sX1dJvVF0X9HKBJU7fvPKNAkIO+qzqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xa+1PHuM8T9iipUBdwwMx2rCqFByoyMAUzeZ+as0xhrCCdRdTOqQmaclqcuwrfT2FkedxV/IXImfNvhd8Lu9xlei7kua41LwUr3asb4KfsFBrzpfHVs8nCFhHB0n/VRxfWLKoTcO0eIrPWUQLdqAUIjRDrafYox6Lv9RPVV46Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLfVqC9O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fdac394so74196675ad.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354898; x=1776959698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5HAQkIF6Z7dNeQ4wY+TYJo8oiocNsiCAdUSK5J3aP8=;
        b=NLfVqC9Oixw2e9to1/qIqVwYtbWpBuAw8mX6X9Yd2HbJyZo0GWrB5dAFerccHWkNIl
         R7fQelnoEli46EQdRZijYLUHQ4ANwr1TuYQlcbSHx9fnBo9Obo/4doj8rdMKrRlUGfSm
         syfM5sx1QdimjrFReAsdRrW+NUjcCvIawNWkRdvCdMgAwtUcTWVQ3dUskOFIPMoFCQR6
         mVLp/G+kC0c97pgslgqczncEeZY9LuPUNmxRNuP2SXV3vtCssFzwVsuOWLqpQ7IvEhjo
         YeqO+b9u+kUoXfoqdNiWhrAqZBhEhU6cHyMfXJzMevbjgyyz1o/fD8/8Pm61zAV/LZXl
         u6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354898; x=1776959698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5HAQkIF6Z7dNeQ4wY+TYJo8oiocNsiCAdUSK5J3aP8=;
        b=QfbvRQfbw/WFyZ2xAKPOEvdFG1jeJ62VwyJUHoJRdKh/6kntU3dMcR5MxJzdAJ1Dk1
         2pIV23zy3DqAgx7TMbtvqjvQ3hOiaWNwBDALM6BRIYengo4rVb8oRvAWgMU7edV6rzUC
         rteI9NclpyL5f1zwdkV78Qxn2liBNqDuQbSQXE2sJ4aWcybnt8k/nb+hf+37Rk6vc1Sb
         KRDF6mPOR9x/98aVOnRj+cd3tk+IW9lZi3EnWl3Kek1HogL9HJyzzcjIzQRrf83G6DK1
         WQmYHoojgrX68QshNJHr+5KLbxBJ+RkRoeJAXTkqSI8DUUpRhS6pAkZ1aivFetm38fUO
         SyhA==
X-Forwarded-Encrypted: i=1; AFNElJ8+hJwCpmqmuaySLFUnyhenb3R1pqeqZx/FT1tkCTYhtxugcxJizXfbcXVtkYK1V8i8GhmUzCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjSlf4RRGlsByjDEUcjRWF/y27aII1MqO4yOINjQCJtzfrEgm
	cZFc5E9IlQppWOGLCwp47F8TMtQiIo5BWt2LrDpOo/liIMt+zhQQd9dI
X-Gm-Gg: AeBDieuNLW3M+RUV8jZez2H5g2/VgEUP/xNorg8i58Odnoc1ldaH3RXj/oydTgvI+2I
	nDRyfsthArheLhDJIe3Licfz/V+sWRK8IbbIYCqghOwNdcPPpog1xA1rJG87gYXXC5ghxtFlpJB
	LnMr2xANBbZ/enAqmOX1dAz5OvFoRnPLGok73saXvv+4ttnTkWiTfGg5/NdLODPBbRJruRa4Xe5
	5uhIVUVuffOOpdCviPrHYNxnsgxZmEYCzaC/lqN3MdG4xfTg2byH3rHE0MjcUc9b9ROfgYG93JV
	cPOAZld1qi/aDUyWFU9LpRd6V/BtdGyNPG19gP2DENFYhjUfrWjmUqzO0J/MDO+fBcjX10RIzP2
	HvIzQ2DTmaAdqltOqT25HZnjFhSugFRePbr8EAqV+s3j86HoRTJqfxG3bOzrIVag4lX12p+AW7K
	M+4q9CnKZca/PSidMXnaFildnNZQd/dLO+5b4t
X-Received: by 2002:a17:903:1a24:b0:2b4:63c8:ce18 with SMTP id d9443c01a7336-2b463c8db7emr176217665ad.12.1776354897842;
        Thu, 16 Apr 2026 08:54:57 -0700 (PDT)
Received: from lgs.. ([2409:893d:1123:1f7b:1c05:52ee:e972:f3bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b69cdsm81555185ad.76.2026.04.16.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:54:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] uio: fix IRQ vector leak on probe failure and remove
Date: Thu, 16 Apr 2026 23:54:43 +0800
Message-ID: <20260416155443.3949056-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E6A241145E
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
 drivers/uio/uio_pci_generic_sva.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..ea531f9a164c 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -62,7 +62,7 @@ static int uio_pci_sva_release(struct uio_info *info, struct inode *inode)
 static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uio_pci_sva_dev *udev;
-	int ret, i, irq = 0;
+	int ret, i, irq = 0, have_irq_vectors = 0;
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
@@ -83,6 +83,7 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			dev_err(&pdev->dev, "Failed to get MSI vector\n");
 			ret = irq;
 			goto out_disable;
+			have_irq_vectors = 1;
 		}
 	} else
 		dev_warn(&pdev->dev,
@@ -139,6 +140,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_free:
 	kfree(udev);
 out_disable:
+	if (have_irq_vectors)
+		pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
 
 	return ret;
@@ -148,6 +151,7 @@ static void remove(struct pci_dev *pdev)
 {
 	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
 
+	pci_free_irq_vectors(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	kfree(udev);
-- 
2.43.0


