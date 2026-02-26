Return-Path: <stable+bounces-219740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPssBQOfn2nucwQAu9opvQ
	(envelope-from <stable+bounces-219740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:16:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B519FC36
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA2883006D78
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF5C3624A7;
	Thu, 26 Feb 2026 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBAchVwL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192F1FAC34
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068606; cv=none; b=gObiviLnCMoQocP3CvX9wZhoz3BcKbYViqoCM2Zjj1eKfv+CU7Mi46d96PIL9HAdAxAjBXK+c6SdF05CTvfLFxRQEPeHA/NTAx4HTdvV4CiNYMVQ1ANsRGhDEO4Lhckf7Yt4j0+7H2klWROS4EZzD3xd/y14Tqyhq1a1BbR7B9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068606; c=relaxed/simple;
	bh=ENqURwaU8/1yRCEgfkhafxoMbf8j1scSOZPIwFQMbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/N1Nk6NtlHXqZv5JDWNv0axO5fgqoz0kXO+EC5wVL5nAZ6IlySURSpyPIGUAug381EhjSETEihocJDBfFz59bmASG5Zh73bd+TaezpteJZv1Z2oYWh2kCHTStd/9sRtwlalKwpRXZVuwEOPCj0wRHYcxpnSe+hyAMJ+i/So9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBAchVwL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70c112cb61so157308a12.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772068604; x=1772673404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2crz5lIBVPU51U00I+WoWcNetEa5OXzY48VN/urTqI=;
        b=HBAchVwL8bEWLe+Ja8gPSWu8TZiQoD4D18tSFOJkvM6iIPaoQHveijbcmCEgRX4vRL
         6uIl8S2ZbkP5RUhVJeEDHOoWRE0wugn4TgNubOwyHVfOTSBiZW/TpcB1oVmGidwfMD5a
         IKduhtM4tvY5y6RK46VrSUBuP2b8Nc/PLDv9ggvMffQZgb84OZnx+6JLqj1WEM1Q65qr
         gaVbq40hl8OiqUdO9EScxgE7UNDPooC5XAiFRs52e+oD41pkA8ZxhK271pY0sJ2QcAZ2
         MNh0MjK4dPrDO4/mjVsb4helzud3lOwkkG/Kwo1+a5y2qa+i0OGLgyL6U06JZ8GTQxkk
         3e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772068604; x=1772673404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2crz5lIBVPU51U00I+WoWcNetEa5OXzY48VN/urTqI=;
        b=dyguHIm/VxG7oLGY5zuFuro27G1ircMehoDcwqk1vYKx4M+mR+Gfv6p6Zxhrri4B9+
         PFWtbfiTxgcUetN+O0q07wYKoaqJ5I4nmj4bTNF8/XllN4os7sBojleIBhgfKdv7Ax8H
         MVJSlEfz+qsWqohIJNK6Z1vb+VfM/Vuelketx/KoX2aCbpf+wb4B6RgwZUOTvFp7N4k+
         4XmPckIuXZbobNh//RCdHPem4pqNqEDMgh5Z/KTcCaiRtxkIcOaWyt5PO0k0fJ+LkjaV
         jnAMzOOyvAgm1C28Xzi9fMbYzbyY1XQ1tZIHEOEjK7Zd4wm2zrV4wFxYZ81kSfiygboQ
         WXjg==
X-Forwarded-Encrypted: i=1; AJvYcCX6QJP0swmGCb9hmKYnxIoWMop3YalDmj/NNlPW0U46dd3BmUwb7I/f9fjnD9mUqE95EHFFlqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+JfzR5qmOPjqx02IFpdnElc/aAN1ycinRr2ilsYOn5wxATQZ
	3YkA3KzKNwp1Rm5dwQ0cUbpiyWPT4A/FUwUsH+D1GIQ87OKw6urFGLyNycGurDIK1vM=
X-Gm-Gg: ATEYQzwIJJunllPj/VqaflnJ+wcBoQO3jYSfJcIY890mIOHrLQZUrcTLlrrc7BqYWgt
	Z8dKToz/+pue+PpNZKjwqWz8/OiQmH7s3naNVJl9VJ8+KwukrZtmj0ExQFL1Su1Z4I+9PAkMtF/
	BJ1zaQL5mIYpbgP+AoR0nNb3F37Ihdr6TlKC0DxxODy5roiskGxyyPXlkqVQYx7Pb8JcOJdHLJA
	EjE2mdE23iTpq/utGFwmm6UcbLr8+dnFiB/b4/VLGml9fepnZaVJDU9FU5TP9CHAyZ+xn6tyNId
	qf91aXPeB4JzzrgOg9wvnhcuXhs8cdasSmYlwGG3H7BRd1spFCrkgYO7onYkuewh6utr2+NOfOH
	jojlienfxI5ye0ekng3qqZH1Ao2uNxuykIwStJuzTtTwmhxHmOZ7hKElzJltPkj4IofmvjNvRdc
	pBwvQrTawd+Djc6Cwv4G1HFjPY6Lu2MXc=
X-Received: by 2002:a05:6a21:730e:b0:38e:c789:4f39 with SMTP id adf61e73a8af0-395b4963ff9mr478589637.49.1772068604262;
        Wed, 25 Feb 2026 17:16:44 -0800 (PST)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801963sm224387a12.21.2026.02.25.17.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 17:16:43 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] uio: uio_pci_generic_sva: fix double free of devm_kzalloc() memory
Date: Thu, 26 Feb 2026 09:16:32 +0800
Message-ID: <20260226011632.4186353-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219740-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 434B519FC36
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


