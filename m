Return-Path: <stable+bounces-219640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLx9H78Mn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:52:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8D199036
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9658304B13C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B83D4127;
	Wed, 25 Feb 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBvcyq8J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A033D522A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031123; cv=none; b=I0HIAGVB05capqmhPDBLmz4hMwhqH9vnKt4l2QFPp6Mcl1RHKOy9fghOwAzo2FR8mGw+E0NEZ0kAbdjKdG9QGkXMJnf2BqI48VfJ0Vs3b+FzYbYrXWP9GTJtBqU886cCMzK8c05PQihiu7do18hz1M40pd4iGW5ESkrFEmQExa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031123; c=relaxed/simple;
	bh=3IxvlCODT6iC9kjqAnEA1tlUeJCP3/wAXHVGipXOjnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AluCJdhSvLZxGZkQinqjTmq1Qme2RttJ07TEJlH6loeSGlGhdfP0WZGJjQ7IgkWfDvbVN1fLSll7LGqXMUhlEeIKS3BwsIF02H1KqtghnghenANPhAVefm9KoVysrfMXivsO4yNbjrtRTJkviK0on0YtcJpdDhE5McSIAMycPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBvcyq8J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad21f437eeso7750725ad.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772031120; x=1772635920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfNau1M/iUZ9Epsumwxydxt79wpVi7OJC8HyYJDVNkM=;
        b=ZBvcyq8JAgrU30iONEAc+FzVW5fpnh+XCp20si1i63QGSw0QYNaGuhlJbtjCH5iQaa
         1JusDHahNq+QFlbXFReNbFx0A4MRKpAfV+uN3JltKo2AxS41K7/no7ZzpO8Jcv/cGf6z
         0xJ5z3daQ5diuvWXJbOrEG11AZ02QK9rLr4gu0zlTMVoybj3eLuN5rfpcQqRv6rI1OJW
         Z8twRTsWAbqDnzt/n5eEgxU9hKSZLm3BQ7yZQMwA0yWmhhWFjab9bTaHdMwFELZSblg2
         GtzproIcJEODUtVZKd1EMyv/qz1GwBI5yLse/cdiB0/jyYxVQXILa4yLGEUPZbCzYPGk
         1InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031120; x=1772635920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfNau1M/iUZ9Epsumwxydxt79wpVi7OJC8HyYJDVNkM=;
        b=scmyYjZmh24PyWHXY57BP8U55yuJ+wvm3PWp9XRRljaCY+6+nuRYBU2Is/pMoxXgMc
         GuHXDuS9dSdZrvfuMgqEoc//naI+ficBCvTK44xr8bljgRX2dzzT1zxsnWG1FM4rOBFl
         UXJgHmxKi3Gnh8StEdbRrnbf0tz2Hcmu+zlIFO/0Fq3qL767+y/eWmB+6a98dkBi5m3s
         /4X0fuKDxsVJIq+TRseAKAEBjAfAJOSvofERjHDtVqdrZTiwRUlYCYHLaZvG+UPubzrP
         +QL0pNXbldSvUb09GTesnlSqajNQX3nsUjiPRmFgvsLxJRd2xC2gbgNzg155oGqebMfr
         M38w==
X-Forwarded-Encrypted: i=1; AJvYcCWFe4q2irM01j70BIRZpF2Rxbp4WiOuPKai8tGtDKUkMErkP5+UKXQvnYZQLodRj62IVRcb9Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBSuMvX0sLWqz6kMO/z0mDdnqqUsMiT52Y5nxxo8srJ0fU+Uq
	6/FgLoE6aDFOk9162ZMdLsBjMGHirYRJNLsGRYl5/wJFnmtMCHRqrSsl
X-Gm-Gg: ATEYQzyTWy2E3SYIoVejaBu/cJA/Arc34Cc4hkkumpYr1I2qK54KlkqO1loNOPF4gJS
	v6a3uf+BmTNF3GxhKFESmb/qsdzsr37pNpjMFI5ZeO6tUXkIyvjSDnLBKFxSNl5SiOck7I9apgn
	fTJe2GdCvejD9UEAh0P5frtGoITLesgLX6ogooY1Q9YwXGuWOLk5s1EMVuDs5euAwt2bn1KEh4p
	FxOZ6zWGnzYuSQNOFcE2h+sCxsYPqm58eGdz4yBB3PeG0wR5f/gyBtY5N+bzn4/yAXToU3pD6fx
	Qnp7FNssQ434MBTNaTz2XmYFtSgAbU0xCl/5Y+fihxX5uSCUlUEqbWWdaONuHrLleYsRWVXgfDR
	3PHIXXcmAW6HeXVU5XtMZ8z3a5oAaiY4OC66l2F0cQHc1mpZhp8RGI0yq9QpYOMFgfs0roTbwUx
	WzRs3pQ3qiLIjE2w==
X-Received: by 2002:a17:902:ce0d:b0:2aa:f5b4:9a2e with SMTP id d9443c01a7336-2adbdc4beb0mr39325875ad.11.1772031120176;
        Wed, 25 Feb 2026 06:52:00 -0800 (PST)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adaa3d0f6bsm51730585ad.12.2026.02.25.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:51:59 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] uio: uio_pci_generic_sva: fix double free of devm_kzalloc() memory
Date: Wed, 25 Feb 2026 22:51:31 +0800
Message-ID: <20260225145131.4178163-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219640-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21F8D199036
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
bound device.  On normal driver removal, remove() frees udev and devres
will free it again when the device is detached.

Fix by removing the manual kfree() calls and dropping the now-unused
label.

Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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


