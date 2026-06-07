Return-Path: <stable+bounces-260926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3RL1JLoxJWq9EQIAu9opvQ
	(envelope-from <stable+bounces-260926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 10:54:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E498E64F2E9
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 10:54:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ql2QWOuz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260926-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260926-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E034E3010DB6
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0242A82;
	Sun,  7 Jun 2026 08:53:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209418859B
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 08:53:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822417; cv=none; b=m7SUWD2VHVa/9OqpVYvklE+8haNUlXwIZtIp/F8dPHNxigRFJgzsxtgdXHWj5+s4iZcrD5accBYHh7IX18P0H+bFkJ9Ms2oFiknHxmkapi94I3xKGnxj052mbdkZcxnEibw9j+owjAYznFUnQxAVSmMcxYFmqLngKsU+qAxr83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822417; c=relaxed/simple;
	bh=G4NwAmdQYNsaz3MOxXsSex5bQIwUllTzHht3/K7h/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpCN7P7AQ3ioPYgg6KMM7ko2jEdOVqOTr6NeygtczU78E0cuLU+bOMJVi5SHJlBeZDj3eeTSi2/ipB2bRsYKTKQqgj2LDC9SWoe4d0Glt1bJ7yUzJ+tJiGrzy1tFUUTyLFwPAaOBEgGGIuDD9wrCUU+gYLg+8Q/b7XYUZtOM6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql2QWOuz; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf1cda2b17so24025465ad.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822414; x=1781427214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/fHXPpv25IIf+IqumkILHnKbLJe6zPc+sZq7buAPJg=;
        b=Ql2QWOuz8rP0E9in5pwCitLXSt5JndtnBO1/4fOGa1vb3YCKBeSQod1xgWX4JZXCos
         KTWUZ6/FvQ13aHhTbNb/LwYcFvNjJ0CH785G28k8lF/YZZBtkuCu+935WnZblna3SFiL
         G9QEfI4yzMgQ6a4Xkv+wm0UpgyI9oNWhiV/dtsJSTrp1BTbR9v/B4pSjGFjoa2MINE/x
         dMj3LjE1+Wfo+5iKNd+muIOfKgC1p+gKd4A5ySnqcb3/YI3Z0PwV+ET+k+KgN4dxtyJp
         YyVY8VJMT6KHO2EfOUyvZfeXsrvVWyuWuNLvCFQ3IhQfm5RiZ54z0zRXVwlnXA6iasLG
         wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822414; x=1781427214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/fHXPpv25IIf+IqumkILHnKbLJe6zPc+sZq7buAPJg=;
        b=C+ur1g4sChsVEHl1fwDprQhHd0QuzRRRqm37hFVkqbd0rs1ZRcPqmvtvJ7vFeDDM++
         fWChyd2Vgicmr7hP45ahmR8dKnAovAeMCAXy3vwHIKtgvWE4wQXtLq7NyaI/XNFFf7tS
         t0p0nq82sXmF7gfBWa2k2lbL1UzFPMnJ9w82zstwrUi6xjmaboQtKpTeWb0sQlo3u6Gb
         Y++HX3ck83J6EEnKwLCbCKM/N1gklPKF0HXMupNiHv9DevNAQfYuyFkXAun8kwaRmNOX
         3SOQijGl+J4gAeN211zhRnjCvYzAsyEod2SnEUcoqXK9uKuB00WD4568lX3XZWz14q+L
         60hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8U1cRufJqmPumcx01vtWcjPVyfExfJ9SFaCBUQAW+uBWpBBvoqry9dM8c4finR2RC6seaXBC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2wa4gS3wQVMOBhDYfmyeDnMlK+Ak9ttmx5N2I2CeLPA1OuAm
	2hjGKvcK4zLplsBehlqv6IFrSbphJOSHdz6UpL9L3auuU+zmoPPLVO4N
X-Gm-Gg: Acq92OFAm5gWVhp2sAc9reOI31z5axSwusoR25WCDN6uB83158OVPUeyu/koJMNJdyh
	4nwLvW3nMdRxlFjdGN15zYgrKzRoS/3h4EJzF6SJ2fZN4jc6Zgp1tjtbtaEOQuM+w8Zf7yFJ47K
	k64wseF08rpSVtMQYdp+e+v6miLJzw/h808iOLRvFeQQF27NBL3TaYuRJ4kVzCvmMexkySq5Dxi
	GEapM5Jve8jPKJr+pzHIgqJeM5SetGL1BFq9qlmfG1NHfpQm/7sOYVXQ2qcDwtIhRZ98d25hpWr
	rmF6DIAT+DflH1MFpNoE/ilpzF5Vq3WxGKfTb6gxzu2W4jTH1+VVQyj2CvDew0m+/L8OtE1+4c+
	Xi0nuRBUDOhHFhC2ddRmvFm8h879+BEA7DgZboMLOwSHHG/PbWG2C7apXUKBlkyhU6IvMQcH4hr
	qRSYnHTVALG3CoiWjvT0u+jpwIfO//1j+zbBUTggLNetEJYkQxET/1dHBJ9A==
X-Received: by 2002:a17:903:11c9:b0:2b9:6cde:c34b with SMTP id d9443c01a7336-2c1ec7982f5mr94110965ad.15.1780822413844;
        Sun, 07 Jun 2026 01:53:33 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm145529555ad.51.2026.06.07.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:53:33 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/iommufd: Require write access for writable MAP_FILE mappings
Date: Sun,  7 Jun 2026 08:53:18 +0000
Message-ID: <20260607085320.73274-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260926-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[8bytes.org,kernel.org,arm.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[yimingqian591@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:kevin.tian@intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:keenanat2000@gmail.com,m:yimingqian591@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yimingqian591@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E498E64F2E9

IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
uses them as the backing storage for an IOAS mapping.  When userspace sets
IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
file-backed folios.

The file path currently records the IOMMU mapping as writable, but it does
not require the source file descriptor to have write permission.  It also
bypasses the address_space writable-mapping accounting used by memfd
sealing.  As a result, an O_RDONLY fd for a root-owned mode 0444 shmem file
can be mapped as DMA-writeable and a device, or the IOMMUFD selftest access
path, can write into the file page cache.  The same missing accounting also
means writable IOMMU mappings are not excluded by F_SEAL_WRITE or
F_SEAL_FUTURE_WRITE.

Treat writable MAP_FILE mappings like shared writable mappings: require an
FMODE_WRITE fd, call mapping_map_writable() when creating the backing
file-pages object, and hold that accounting until the iopt_pages object is
released.  This rejects already sealed files and prevents new write seals
from being installed while the IOMMU write mapping exists.

Cc: stable@vger.kernel.org
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  1 +
 drivers/iommu/iommufd/pages.c        | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395b..63e3fd738faf2 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -234,6 +234,7 @@ struct iopt_pages {
 		struct {			/* IOPT_ADDRESS_FILE */
 			struct file *file;
 			unsigned long start;
+			bool mapping_writable;
 		};
 		/* IOPT_ADDRESS_DMABUF */
 		struct iopt_pages_dmabuf dmabuf;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1e..f97d94d9eddd1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1421,13 +1421,27 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 
 {
 	struct iopt_pages *pages;
+	int rc;
+
+	if (writable) {
+		if (!(file->f_mode & FMODE_WRITE))
+			return ERR_PTR(-EPERM);
+
+		rc = mapping_map_writable(file->f_mapping);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	pages = iopt_alloc_pages(start_byte, length, writable);
-	if (IS_ERR(pages))
+	if (IS_ERR(pages)) {
+		if (writable)
+			mapping_unmap_writable(file->f_mapping);
 		return pages;
+	}
 	pages->file = get_file(file);
 	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
+	pages->mapping_writable = writable;
 	return pages;
 }
 
@@ -1668,6 +1682,8 @@ void iopt_release_pages(struct kref *kref)
 		dma_buf_put(dmabuf);
 		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
+		if (pages->mapping_writable)
+			mapping_unmap_writable(pages->file->f_mapping);
 		fput(pages->file);
 	}
 	kfree(pages);

