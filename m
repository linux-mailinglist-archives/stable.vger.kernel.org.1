Return-Path: <stable+bounces-88973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5039B2998
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7482817FE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BA1C3302;
	Mon, 28 Oct 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvNsGOBK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCA190472
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101503; cv=none; b=XCg3ak/8gZILzNarc2NGB3ZyOe/X8ZMwTnkis49OIm+fnBXFti37w2AVVyPLJKJFJ9j+tCK6etuO25uJVotDOd0pjJ7KZ1fYdx4W2pVOL7LfZmy4sKnE8FImN3J8SyWF4Q5IKkL0t4NYDBIi1f0QWu9SwrIsPDH/bVjx3onv+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101503; c=relaxed/simple;
	bh=PEZr0dlQokSOg0EnOX8DNbTQF91ffCeHj6qA1SGw03M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CusiDZYzh91lf4sb245QeziyszqaaG7TpbgXMi8nhanVocIU+R8yJW0Vu8hFlhrVhRsxjz/53RspsObE6czVZhiw7sObcBGjjGKtatJpdCkhKgZWs3Bg06I86zbUOHOdsuQGLrg3Y/FjNt0VvEVqZaITZRlfLZgPkORt1WYaw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvNsGOBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730101498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
	b=TvNsGOBKVn06rVFRyUh1lwM4XkthQxFNKDtC+2ODR2aS1aAhhxbAh8TXvgymsnNNn0C6sM
	WAe7gz4VxcKh039ckt1IE/S/nOANuLuwcBcnFrGdWRdaEeVBxWQGPLNDYmw+KYvylhH2Of
	m3zB3R7HGwJywmhHqexOhfLOizuuGmU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4Dl9PGQoPFKgAFrlW_agMg-1; Mon, 28 Oct 2024 03:44:57 -0400
X-MC-Unique: 4Dl9PGQoPFKgAFrlW_agMg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbe933e877so73143006d6.1
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101496; x=1730706296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
        b=FHdBf9Sk9kWjCuFq83aWWpI0Fa4Bo0A5Se/zNGVKSTXB8xS8fytDffSkMgJwJRLulP
         NGGEtcay8Od2uz54nFUdogX2DKwGFqKfNrll9lMrQni/Jni5plWDsmOMAqBVDxKBmS75
         rbjb1Hp3UK0ADiEA5k90DGUFE6dSX8BWH6dsgG7owUuxd18BCB6s71QAiIzrMtOsiBEB
         NhiTRGmi2z9w+mDd7Py1MhG09B14oRkUtb1lqpaAI1dDW51xnboL39Q2TbXf3h9WsNV9
         00JKibDDTV/TnX4YEE0w9ou0TvzYHmlNbPJ6JB4VLPlWPLkEtbr6ijQ5w7+QUftl8130
         6NGw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEAJtR+wou2q0+58WlEVvzYI8qnVjqU55/OccVJVaFhByXHFkjm6p2oygkXdqS70GPU6kKmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgI4n1vYb4pKFUli8VvioAxI0m6h30zmRpAqBtvGJjq9Cn9Dk
	1Q9AflW8g0Hmkq84y5Y7Qp7kkzVHI3vxsaQuOIqI44x7qwNd5PdaWeyECD3Endw6RiXzKeCj/OJ
	O3pjsxSNk3JXUn5Y/+nQXXscCBX1rjash3DYtQ2RLJGtDAZ5rLgn+GA==
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038976d6.45.1730101496513;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYrXXTQPuJOobZASjIKDFRnHrChhHyjJipSBygd3ZhctAHecyDi+Abnul9u/vpmNdW1daW7Q==
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038756d6.45.1730101496220;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f566sm30237716d6.13.2024.10.28.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:44:55 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2] vdpa: solidrun: Fix UB bug with devres
Date: Mon, 28 Oct 2024 08:43:59 +0100
Message-ID: <20241028074357.9104-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
Changes in v2:
  - Add Stefano's RB
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.47.0


