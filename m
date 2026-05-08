Return-Path: <stable+bounces-244704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKaSBe+h/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:42:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B24F3D61
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CADAB300BB90
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446CD37F00A;
	Fri,  8 May 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="IL4ujfAt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9833B95A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229738; cv=none; b=E44FMDCuw9fLKJPN56t0T/IgC0AE40CnmzikgMrOUk6JzAxjt0my1SC8b/QUY9RNz7QjQt1zIgb1NogH/sx43XOhECagdhGviadsPwJohnjmhlYMmk7zd1BQ5C+8ZNLSS62fJ4Lss7DTuglwQp10aXwlOx84DKBhNw1zz9H3QAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229738; c=relaxed/simple;
	bh=u85YHATecIVRgKpfNOIDwDcORK6VX1SNuGbFdKLd7N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYStnQSUjLeG+0meRJmCOdt1qmsgXNSBXQ9eXpV2yYmjsAUEJXEGXlThIw6zDM3/zIhlSnKwVWUu9Bc+2l3YATLFoh8J7YozaDruxsZFMdERsDKS1lZuVS3HGOH1LfuRPMWpIf583HLDqKM47XItd8zA1/Tugx6FyfG2GG06qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=IL4ujfAt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83945063f70so1296730b3a.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778229734; x=1778834534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bh9Icwt5+0ETWdyXuUVRLGVBe+vK407pyrzUFu3GVs=;
        b=IL4ujfAtNAEIbusQ8vzuchyPT/TW52DszL+15k57jP8pipzuJmwDQfK6i730kg7wg6
         wltpmAVWvvXceeYJnL5jkSPPknbBTrphcXJbQWU+gU3HTdS2crmsJG96QFwR01hRWxPJ
         8TCpybZZ2UYbMc/p/jxMDBJGqr4NfwAjJ2C6lKMW4AqnkhPX2oaIrXIOU9rCy2dIFGE7
         syjcm2vaVVdeIB0gXJTbxa06zwcI9YoVycx8QGD2VWgB7mJ++R4TZWrXr7BUuS5iEfqI
         T/oKu0sLn93WJvo2sef7r/Dye4qAkQoooas7Ov164BNQsZTJcy6k5BSlpk9XyCPxo2wk
         IxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229734; x=1778834534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Bh9Icwt5+0ETWdyXuUVRLGVBe+vK407pyrzUFu3GVs=;
        b=h3ITvNBnZYCcroT9a0WbYq/Ql3d8McQVMn4oypglMavEMJBjv/i4eF0JEGuPoURu74
         kBmM91B5HUadDq5HNrM9Xjf9SRY/c5bf9Akln7MiKydzscpNfthVEYZVJfr/rS6mWFYi
         q9LRFwBBdnI8qyk11o9qcDWU5Hw5Xx/9HUKN+Y804FlIW/pQkQxSl0N6ofGk1D4iYa/0
         4izWHodsd1CmwG6wd/KaWwpqkNlOVsiNqSSPW+6GpWgdwzmRDBmMEchdT2unQbJsuF4L
         0gTvoebCWWYY6j4Ge7m8DL/83k1sMfIWioFpdCX/QYphXDM5AZbGIAbI3sfZouQ/89Pe
         0H3g==
X-Forwarded-Encrypted: i=1; AFNElJ/Sb+8Uk0mYeqf4D8Rc/V7VC3MX5DcT/0Arzs5dpoGXeLuILVbwnZQ3QW2fjR+nXutfwZoyJVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAU6M8q9/YqVHzVojdXnjxvD2qIteAC5sJm4YBB7K/faxvJMK
	qG8g05t/xGl2qPOnrKwH7eK7PllNaM8+MFW4t2PckU+xcDvfp9PC5hBj0vTYw7DOmZ0=
X-Gm-Gg: Acq92OHBeFrqXsZY5PtRVnpmhXQFB18NoPCrhBs14BIc1MmOlKqODjGptQ9aEl5JuJO
	jOuSsrn5gJXhSPlZROmXVGdNbw73V+JqvrS6dKkEPkJ8HGSIww4PEYNsPXmOxs4IomYL9OSJtxy
	/ZXIE3jxkte/OBPVru+AZpJ7q6ixAYUuy4k2Xwa+hcs0DbKnv580A7scWx95OLMiIDER3gUtTU1
	Nrj0iiQM+RWa0I+qS/Gz3WTJZ7HdqC5GMdOFJsHjSbNRsBOwRXBZqsG2rr2XYLCbV2PjXsHg1Lt
	WN++ru1XNCQZa/beqsoUFdmuYdnTHa5BSI3GCDpj10Ty+d/gnYHADxjTn36jaSGvHmF6Xz9Yk6l
	Xl6229IXc4DXj34kwGjXgj07yfJyaq4nb7GxJZwKmszifiy3Bf9yRYR8whp3jQbRH4RmlIrEFf4
	6t/UyEQQf9riLdnAHu7/d8UiiwOTNHXChUqKBx6pcdeDP+m/b6P2UXFDhAPdysWLo5BmywITMMb
	KGsPk54uWTsN/jrffPJCId9jO09yc739MMhTchIQXLgcxqe03IgUTq/Ag==
X-Received: by 2002:a05:6a00:3c92:b0:82f:47ec:944f with SMTP id d2e1a72fcca58-83bb7aba933mr5031440b3a.16.1778229734627;
        Fri, 08 May 2026 01:42:14 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm10518149b3a.43.2026.05.08.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:42:14 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix potential memory leak in virtbt_probe()
Date: Fri,  8 May 2026 14:11:53 +0530
Message-ID: <20260508084158.68765-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D72B24F3D61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244704-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The memory allocated for struct virtio_bluetooth is not freed on the
error paths. Fix that by calling kfree() on the error paths.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/virtio_bt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..b34dd5ddd631 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,7 +311,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -400,6 +400,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+free_vbt:
+	kfree(vbt);
 	return err;
 }
 
-- 
2.43.0


