Return-Path: <stable+bounces-190046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F16C0F734
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02070189755B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5252D3A94;
	Mon, 27 Oct 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q95Ns8BC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9C1DF265
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583867; cv=none; b=MGoAa6/mJQlbESpp3z1BGTtCsCoiC0NWQzuCWL8QTVE/9czZyyWJoHoYIjbUh5fz+oDhLfzgA1vcjhF9h1z1rV+kostenAKCbXmDa5bakBjVXpRsqGQQ5/fdE9IPgfwpFD8owAa4mey7yWUETSR+bc//GBD3q3AUqrwnqsY5GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583867; c=relaxed/simple;
	bh=EqepgGC/l3BkBwlCg2C9JuMnjeSRmoKoLRq7E9G076I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzjyjYp9cLOK6PCV+bgOvdXCkkqUUNOZSJIzLv5DqAnOBQeH3nOUFA8RaLRFpzHv+bDd+KIkXwbzM1ITRkxdETZ9o/bsLyvYsdKmgwvHLJ1L8otDzE+WMmPduf/F1RjmcKx9leUmSi9lV2WkPipg3PJAqN6rf/YQgOKiPtZdW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q95Ns8BC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-292fd52d527so49293195ad.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761583864; x=1762188664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=Q95Ns8BC1mIDmzv0mpGrKifIFnoZUW/vak+MzT2rfniEFPd8JOxHe4RMPBCeu18BaV
         09l25kmvgFVNBZr+2ODYGcnze1cTYftMXUa0pStPocmM6uNWxqIjdmCKA+/hC3B0Cf/d
         xZVOkncz5jUyyoFbn0Iu+tjlEzhYXJanRvOZrpUPJjdWg5qGu0FqyzcyxF5OJ6/Ke7NG
         HlzwnVgEt07cgI5GvQToxb7cJ/XUCbbgIrM1XhEexiDKSWM9H2riqYZfDiBjkAqLZOYx
         ZxCY1FMqUQ1ly8AnueK522+6CGCp0F7bvOmvgrBJYWBx97tEne4Anl9emrT8xoUqKr7k
         SMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583864; x=1762188664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=Omfk6zYqT5q/8ysbYKaSTOLvCxRqGGWYPkKWNUd9XebdMWf6ilTNowLjIRd2N7ZzxK
         fk01AncirArlRVts+lnmYnbQlPByvHhoGuPespbyP101rMZt3Kq1a8SHHAovaTDqPUEl
         R35K7z0di05UDW7795iuU11512OVZEzTNDvCkpd/6rCj1z3BKDT0SOmp4PCmj4pF6OB4
         0GHBDMT3grz69SJ+9vIX0xTvhLSua5TgB4rXynRdfEouBDktnjBcz8I8a+dK3DdiMYGv
         CCteRP8EV1cy3/g7zG6uKFpj8oUDkwkAzek17/0DPJ/HsmeP1cPDgCuesHsp4qi6Iyb5
         7kCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/cEbv9SnYa1K4Xks8JMmCp55umqieFJ/+1OYpgc2zsL0moix2JUL/9zA1nUvbHdKwRkfGjs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYgpScGfoo6OCRYl954FEokprZCDYxD5mseqZSsajej13HH6p
	0UnuZ1Xx+7TUoP4zDFEE8/+yu/q+SWbRtE3YcK/bVj8KhG1JNCMkfKnzJmksNLpQAV8=
X-Gm-Gg: ASbGnctcUbdYaoZieeYXodmKQYp76+YB9eQVaxCDYvu/StsOG4JmNFSQxnZo5yUZouk
	x2wPrM96XJROfvVm3LXKhsf+yfPHeWoP3OBBtG9yr2NnV+gmQUZdADUI4p567khziM5SruGlgnb
	50sQseGgPK2ZfFHpaMzF1v6LUBD41ZAl4ckYRh9lHFANLB4a+2chDh2oVcFFC1pWXqKVNsuY3Sm
	/pcnDCwprw4FZ+Mt8Hw4Qb3QY94G0ODtYGCritVEAgd6UIZVqOeo1iklBNQTUWKv1p4BX8H5Qim
	rPlwl3FoBwgDtaQn9a8EsOJhjKsFtgHTRAkHnTz+9I7nrLXQzZLBKAWzwzmwZubse+TJtGBGRtN
	E3JuPRrK6Fat3dX3BCrxM0f/f7wPJzd32ipurQl2UcmwNVq9qxfjhhadnuY5ii8Lb3ZhDxMcf2M
	yKzBoGBbwke5ZlajAVhme9xOhpyWKebaxy+twXUCirikFv
X-Google-Smtp-Source: AGHT+IGjTdmlbc2UYCLdzv9SaAZWrdWKW4UkBxQqwzd5S6LRB2MyeaD63PJEhKAkXPLm5tJfWml8NA==
X-Received: by 2002:a17:902:b281:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-294cb67176dmr3769265ad.53.1761583863479;
        Mon, 27 Oct 2025 09:51:03 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70b5sm9075326a91.10.2025.10.27.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:51:02 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND PATCH] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Tue, 28 Oct 2025 00:50:17 +0800
Message-Id: <20251027165017.4189-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
References: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

Just a friendly ping—resending the unchanged patch in case it got
buried. If there is anything I can do to ease review, please let me
know.

Thanks,
Jinhui

 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..77afd5884984 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1608,13 +1608,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.20.1


