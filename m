Return-Path: <stable+bounces-219828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ap8O7hnoGkejQQAu9opvQ
	(envelope-from <stable+bounces-219828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:33:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCF1A8C65
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3EDE3016AC8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC573F23B9;
	Thu, 26 Feb 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAxmhlY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A23F0775
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119986; cv=none; b=E1YnWeWj/8m90HHffACaz7dXYmVRiFK6YhNOFu9epq6HWAWmHmRTYRARBMTtF+fnkW+qeudNm7inudD7BnqibxiEg4QTSUViL77MzRjizAJ0dtcBp2Y04yhrM/MxpRm78zKuqCnzHRNNN377dCw5yyvE20tzQBgbWtk6p4YjTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119986; c=relaxed/simple;
	bh=c1SiJQ+mtrwggWTRz06IeBax2Ht6wj3Y5QVnKautFIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P12VUgim8vJJBBJgthl/0eVA0239B8uEkgANftZhjyKYzMA+5WGQRbJAWoFJucbzOLrmZ7x7OnKckb8FW6wo0AFTE6rzMtG5CCRp68NebG3BAHuABUKCBY3NaLR60sdfK+sVQ6EZq365c1vmLIyhJUjlLjKJ6xyyg28LJzcjRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAxmhlY7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaf9191da3so5856215ad.2
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119983; x=1772724783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czT64XVAAmaM0nwz2K1ZEj7YNNi99MV6HlVNHnaACJw=;
        b=AAxmhlY7jWlsp1V9sBt3fEbFw/vT3lCo8V7oJ7kodinpuy1msag0ijhMtd+f8jvamw
         AUfUrpYL5+RhkEIRHPtn7tg5+iixu9HivhKtBPA92An3t6I3Y8E/o2HNKdxPDH2qzyi/
         5kjn6ltTxQbSwGKackbS2xL3zVdPZmxkK68009k3M3ywt20NTY2UG0aQK12lJ3nI3+eV
         c6/ft7/5stQpwbQuKqTAzi466FhmpZIGFIYR57lN7lEZvdUSdmsfHbT5bFoAC10UCces
         1kUFcgZwT+tKP3lAe6vjwifTb6ZWiiX2I69GJgiOZM/bQS3vcRT+5CE1usEuRTIRfbBz
         7WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119983; x=1772724783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czT64XVAAmaM0nwz2K1ZEj7YNNi99MV6HlVNHnaACJw=;
        b=BuUd0uyeHKb6I7iOw7myGYv2kN9euIi1c3Li71HWvUl69uHIUZUF8dutT83bxBdxIT
         1tIq6eRQJtNzW4l0RjKx7sGFj5poTlr/DtdR7da+lca0DoTmE8QOYjmxniQD/5357TaR
         lbLg72eo4FpSkmhYddEe3RFRuwSHzIgE7grgmSMaua3Sr21TLS2Luz81vxa/Xe0HZ/UN
         FX97nU03v2Cl1NBm73pK9OaB1N+O46nYrsrzHjvcDMXAsGhFoxgkSEGnj/KYQDTePbme
         kyaafClhmGlKWk0CtmcS16iP77lkX2EegPrQ3ICeEeWjhM+njPiA/0Z0VpqhhQj2XvqX
         9SlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRXnrst/6+bzweLbpIx0LrncFbNhJw70xzSQtK7R7PEtmm3O/8gSZ5kNjeBMx9xHlx1eY+3aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfj9lx7fdemBIexSOjS/9f7xHH3+0p8iV2Z7X2MIQ3NFJOejad
	aTzEsnxarN9L7+E43M+mQnrg7FnUVGGrU+MKKQwHIvNihMPj69AvhvmK
X-Gm-Gg: ATEYQzwFjj8eGfFbLZon+4VeQ1kN98S9MBd916fWC8h2M0vacSDmLKsxzOUV3MCaaLk
	szyQm3TYd89pKbfwN2HOZtHasNBOS3T2PZBoBZBt2CAyzYDmRvkP/vOw3dyqxk6d95uDOoeumvQ
	LTc1IPmgtV3e4oYNzKqbUSo7W9pRXC/gp3d16WLYUbHBC/iS7QmowGEv2ujv1VnHQhNE/ocLvJN
	ifOMw3b0lrwoGpR9ph78e5alZaYWW/DHGTf/KJ4pvH6aNZ3SrgM3bBCej1Cw1mDLZiiJOu4yuC4
	eKysmbAd245dt0Q+s/pE2WcgxctfP+bAFaNxWUd55qdK7JoRaMe97SEkgvhNMJjT82mvcb6qikb
	2HiBsETPDsYI+1AHl8HcMPy1jBS8kwHdOOOo4anq+L4/veXMyezG7S+sPUtMCbldFtqiympkT2T
	TNkdu79ca9A+Rzv31xhumeThLn42iKAmM=
X-Received: by 2002:a17:902:d4cd:b0:2ad:9421:6136 with SMTP id d9443c01a7336-2ae0305ede6mr25763805ad.1.1772119983292;
        Thu, 26 Feb 2026 07:33:03 -0800 (PST)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f996sm26706535ad.50.2026.02.26.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:33:02 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] uio: uio_pci_generic_sva: fix double free of devm_kzalloc() memory
Date: Thu, 26 Feb 2026 23:32:50 +0800
Message-ID: <20260226153250.18079-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0FCF1A8C65
X-Rspamd-Action: no action

uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in
probe(), but then calls kfree(udev) both on the probe() error path
(label out_free) and again in remove().

Because devm_kzalloc() allocations are devres-managed and are freed
automatically when the device is detached (including after a failing
probe() and during driver unbind), the explicit kfree() can lead to a
double free.

If probe() fails after devm_kzalloc(), the error path frees udev and
devres cleanup will free it again when the core unwinds the partially
bound device. On normal driver removal, remove() frees udev and devres
will free it again when the device is detached.

This issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix by removing the manual kfree() calls
and dropping the now-unused label.

Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v4:
  - Add description of how the issue was found and tested.

v3:
  - Add changelog below the --- line describing changes since v2.

v2:
  - Reflow commit message to keep lines within 75 characters.

 drivers/uio/uio_pci_generic_sva.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..152201047334 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -129,15 +129,13 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = devm_uio_register_device(&pdev->dev, &udev->info);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register uio device\n");
-		goto out_free;
+		goto out_disable;
 	}
 
 	pci_set_drvdata(pdev, udev);
 
 	return 0;
 
-out_free:
-	kfree(udev);
 out_disable:
 	pci_disable_device(pdev);
 
@@ -150,7 +148,6 @@ static void remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	kfree(udev);
 }
 
 static ssize_t pasid_show(struct device *dev,
-- 
2.43.0


