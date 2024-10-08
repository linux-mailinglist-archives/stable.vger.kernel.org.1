Return-Path: <stable+bounces-83040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B099509C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43ABC1F25933
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1F1DF756;
	Tue,  8 Oct 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b81IJVsg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56C13959D
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395371; cv=none; b=U8pGCZZuBfqYg0MPQ0zuoK1hJw0quNmy0pMrwtEu/3otTJmqbnlqodz6e3a2de4IvbtVLnQYDdNZ9+VmVhCgcvI7vhel1/PSxNgXhMz6WO5XGqCHsjIucvFnyrV74Iy+Gzx/SSH/+JW+j+x6n2iwsU8Kf93jyiGJV8bzgLfv0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395371; c=relaxed/simple;
	bh=C7myXz1PzgO5KntaMzSJdRvlacDd6/XrNcUeuxTsbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uzmiin62FuLb38RbxltqDliHDn5zuBxwUM1uI0mqxX1u3sNsZHxzk9FfEkx/wpKD12Qv/CnbmoxfrXH6YxZOnWAmwa+rG7VgScxvvx/+29KpPUJdQXhfHGkLE0rQaDKTDG2oLQWD+Vzped+OLtaesKL+x4YlvVWZMhoefSoReqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b81IJVsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728395366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
	b=b81IJVsgFYbNVcV1T4ayeseVmoJYBJwR+4RZQ2Nn42uHgo76kZGlT5r0zvBJP7pL70BNbG
	HtQtYft4GYNKXank7lWx0HCUuNjvvcGtL5Ejmo15zE4ASJFwykIU7WwLx1nrj4Ttw1bbVg
	hbEAB0bR4XqPwvaEq99Z7hmix1PxnRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-pzWNk5k2OsCjwJvoJ-x8cw-1; Tue, 08 Oct 2024 09:49:25 -0400
X-MC-Unique: pzWNk5k2OsCjwJvoJ-x8cw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42f8ceb8783so25308865e9.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 06:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395364; x=1729000164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
        b=ugCyLKIKedrYjN75+elhOn4hKRsBg7YdRksSOavVqHTmwSsi0on2dipYeAjtTC1bHa
         wcFS61WU7IkrEVfss+ri3JZSBgGbWdplwZdE1koi4TfwpMwd2AjrqL6nJoljz9VuN7QW
         CuZLvr1EUxRh8Zb7BIeS6EBqlbj8n9YFxo1kWL8KniE5sRkAm89ILr4x5fha57tHfe3b
         tfK5072ED1Qa+QtHwDIDP/WlPIcztPtrQKcDQv9yeSZe/YBxjpb9HiIpfVhj7cCZ0Sbl
         WiYGIA/Wp1yQyAzIKHwo0TgG+UyuNvaGmDXnWF2xg/IWRRQdd7wojDIyoIJS/VkAOmHK
         Qydg==
X-Forwarded-Encrypted: i=1; AJvYcCWwqhRBlQxSNdofWH46wrqgX/vJcRkMIdn5FO9CWYuZCl29c8xSbFhFggNMn2qmqNH7MuzgNrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkIGM8wPw3sxhpksC0KAlROYVQe+DrCBHy8lD3iVpBHvFFgyp
	89y7D0akACTzcNSSxqIp9b0hNFVFVf1KgQOeX8q5Apm9QBWn3DVUstoBTx9OkNq9VGYFFxMNdgE
	gAx9JXpP99GGYsg0hGWXPEA5J0Apz2oAhiHuzxEP5nXJoxbdMwfXQuw==
X-Received: by 2002:a05:600c:1ca4:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f85ae9d41mr133159335e9.26.1728395364038;
        Tue, 08 Oct 2024 06:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd8VsV5d3a42MkvhyaGQpxAWiPPuXxOfVyKhGcSzEVblc23t5A1J2pfaLTuLp+DD7aI+pjIA==
X-Received: by 2002:a05:600c:1ca4:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f85ae9d41mr133159075e9.26.1728395363600;
        Tue, 08 Oct 2024 06:49:23 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d43760013399881f4bcf5cb.dip.versatel-1u1.de. [2001:16b8:2d43:7600:1339:9881:f4bc:f5cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ead666sm109780275e9.28.2024.10.08.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:49:22 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] vdpa: solidrun: Fix UB bug with devres
Date: Tue,  8 Oct 2024 15:49:13 +0200
Message-ID: <20241008134912.30295-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
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
2.46.1


