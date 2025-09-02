Return-Path: <stable+bounces-176924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90509B3F2F8
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 05:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208311A81C23
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A9269CE6;
	Tue,  2 Sep 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgtoCQM7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1953257851
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785105; cv=none; b=kNCeedmn8dvyY9YqTuBVMsuXiFscfrp1KqnFrPXIOEo107kwE/gn9inKRHUCAd3uf5GwrovvXUhgq2KOG8vAVN68T0q9mp0djfMx8UKEr1NHS8Fk8/XSx/ggcu4nqr+2R+XTMXpOJ4P8E4r37t+nuyU0aIcvNB1AQYX3FzpnQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785105; c=relaxed/simple;
	bh=n2mChHJOpuovt3EkOwskBKLM9hbBlkGgtvGxWx7OgZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6dnsQcdGB2RLsK+6SqmBYEEuce7Fi0DzZhFODQq1u9iuVMtaCkOz/B6cy8zyby2NZhg0PgEi5tEGlopImnD5gn7u4txkc150EOi8c155ykM8Rmbxf1+5zlf/nA9xAtZy8+1QNPg4qSR496aJ2t/4R0iDCJI5fBCdgrXFSLMXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgtoCQM7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so2294177a12.1
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785103; x=1757389903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhO72zhYOJiaCs0Sw3nOH7x/q+Nik5NH+Mprbd215KE=;
        b=fgtoCQM7XbybdCKXtfi8M7K8IWSP1CSDM0HPnexAP7HXm86gEERCKyTsWanEm0Uzfc
         QjFBBzjr3LXP5xB30YdSLNcwdBQrzirNVgd0H0To68iCmfRHphXnSPxSk3mX4PWORd5c
         Aj/0CZBL5XOlrrwHnJ1tMHry+oc121DQOmKmMPSKLG00UXOsssKPDeLrn+cQDFU6RhBw
         qp7vwiR+bE4F3I8R63Ic3SgJDMywRxB4whG/RWdhRwIjp3UpQzFLKQ1B4YfpWnS0N5sI
         Sc8lIsUJoY8Q22dpm4X9xJht8v18uQx6SzEcAXrQgA0TDZTKDolLAURO73qW7bv0nwe5
         BojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785103; x=1757389903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhO72zhYOJiaCs0Sw3nOH7x/q+Nik5NH+Mprbd215KE=;
        b=Fe1aPwTl5Fj48SvlxslOv25FiwBtUW8RYoN//Wfz2BhrYcUBj35ukPiKyIqIHBbOKb
         iwiRSYsrUX8xufrCpTFK9s0U14ZX1ZbjbUW9hqaZELMMHtvKeUrMM7JxIaajsLMtpnRD
         c/80WpCjoF3R0wms4N2lU29tR8qEFxw5yE9x5hiME+CfFAEh0eqJrNlVx8E5yvEnYM30
         DbXuyh3DwNd87/HARMqiETH5BOE/o7YVqzVf2otGRN2Hw+MzqzhHabM/BDgVR4A/fLDR
         lvNh9G3U1luRCiAPegruzl9+t/qqvrD/PTtXnBfXj07vcjFU/8deyys3noR8OF4I52C2
         VZFw==
X-Gm-Message-State: AOJu0YwU74UFVr/uCL6GgXgCQ1ILbLEcXyl1UxKtF2Ubg/8jslO8/unI
	oFfuJWOK51dKl6Jilqq98FvWDJmI9TE8vzD5alZjrfRzJ7eaG91VmC8iAkkrwLZlqEI=
X-Gm-Gg: ASbGnctZzr3nLmg3V0o2JkfR0L6+H1UQ4BzIfivDF7CUT+yxmsUjM5h8/QPslQ941sn
	dvU1iebby8mZhFukTzPQOgvIGEzvBy2hAqgj9o0ivNeQYv2uQ7BZUduPPYcEFk7uEIPy6J6tT9c
	7Z4A90xVcMPZcC6PVjIHEOAxdQWoAG654TxMn08we0YgSKRkIyWgMxfveIaeAX2tDHeYxzKylUY
	AyXfICGAzpfWmxpNxXptS+ETvpzlpZg9TH/9bArwJPGvGErek4E5UKGZuFYpjY8oKpe1dC351c8
	OBs1ZRG76hNrpFs1IzHQHBUOqY8N/jwACYBzARmXGfdPgn7Dn6tQEX24KWr3qSbwR3vnahujUw7
	xIVofQA9MHx7/pph8Hm9xJAfHzxHHJTaM3mc4SnAQ19qSPmQS5p9uiPCGnozLXZdwwa7mS+uQ1g
	+H+0qqFYDOyKWizaipZYrzPAfIo5a6Z/GtS+H71dbcWArA62aUZbBUix/A
X-Google-Smtp-Source: AGHT+IEylkoLgnfgs+eiQawiS0LvEGhdEfoNRMQRFSMWTcYcFOqIvY3rbC690Jcd1+bF6THJLbVuzw==
X-Received: by 2002:a17:902:ec88:b0:248:ff49:d758 with SMTP id d9443c01a7336-249448dee30mr160639655ad.1.1756785103023;
        Mon, 01 Sep 2025 20:51:43 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.37])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24b14206426sm6295885ad.17.2025.09.01.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:51:42 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: linmq006@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] hisi_acc_vfio_pci: Fix reference leak in hisi_acc_vfio_debug_init
Date: Tue,  2 Sep 2025 11:51:37 +0800
Message-Id: <20250902035137.2350850-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs_lookup() function returns a dentry with an increased reference
count that must be released by calling dput().

Fixes: b398f91779b8 ("hisi_acc_vfio_pci: register debugfs for hisilicon migration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 2149f49aeec7..1710485cbbec 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1611,8 +1611,10 @@ static void hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vd
 	}
 
 	migf = kzalloc(sizeof(*migf), GFP_KERNEL);
-	if (!migf)
+	if (!migf) {
+		dput(vfio_dev_migration);
 		return;
+	}
 	hisi_acc_vdev->debug_migf = migf;
 
 	vfio_hisi_acc = debugfs_create_dir("hisi_acc", vfio_dev_migration);
@@ -1622,6 +1624,8 @@ static void hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vd
 				    hisi_acc_vf_migf_read);
 	debugfs_create_devm_seqfile(dev, "cmd_state", vfio_hisi_acc,
 				    hisi_acc_vf_debug_cmd);
+
+	dput(vfio_dev_migration);
 }
 
 static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
-- 
2.35.1


