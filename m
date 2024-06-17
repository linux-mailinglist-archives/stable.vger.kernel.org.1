Return-Path: <stable+bounces-52554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7390B56B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9945BB34A53
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92196152539;
	Mon, 17 Jun 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRt3TR96"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81B1527BC
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634211; cv=none; b=oWzgZLakwGialNzl2+MynVcfM7zWRlShPsTFNUgm8VB5vhsVhRtPYaQqWZ3dKzLAkswlws93QuWIN8+P7VKa1C92NNVMpscCHikqzL5WSCn/cMTY10hcHtbtKHDkd4v5gnk1FJ7plVOZ4oczRqTkrUQ/QM6nRqzHQYVEWFWReZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634211; c=relaxed/simple;
	bh=zUXku9ki8JZ8XPsUg0O0zMG3q57LEWQMUUy+D2CX8mA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAJ9REpZioGlJlSrEwS9Y70ZtMJDWCBrPaQF7IrjIsq0Dl0Xx4VaZD2tNvlHXcrYSNzcoKz73ryU5yPZ8ULVITOONEb1VGi0r9XG0RMXhpx4zBGgKpIdmRSAICG3m2TN1QIlwHlmAr2LkrFE+EvIgyGz4pCK6/3L+lHZYTfXQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRt3TR96; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6ee1b4414so4074175ad.1
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634209; x=1719239009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODyR8JvwwPLgDOsXJInwfBczv8OEg75ub2B7wdJGles=;
        b=PRt3TR96XcgjSXvGOD0AEbtUFkI3yTQB8kCk/kA/ZIkPYrheLLp1tNDtlD9vpO2oSu
         m9SGggLBWho8ecxH84BHTOWvT/Gx+n25mtlCuwdjONYhW08wdaAXzlgEJGcXpGcFOziw
         t+Uq5UP0f700RV1yp+YxK5+1W0zjYQ+9v06lsfKmV2J0Ovs9d1QiCLPgHjKoS4PHSExx
         sQaa9/27yCLFbn8S/JzexRvfrzXxtjxxgN0qmErdQspF/YcbR7d0E6crXiD0Udf4VuG3
         6Zvp4KF2LJhfpqHzfk5bpn1QO1For4E2JxXdbtJnDyG7GKZ7E7tRq2/P/SzinjAbnyx2
         2JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634209; x=1719239009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODyR8JvwwPLgDOsXJInwfBczv8OEg75ub2B7wdJGles=;
        b=kgIzlQKKzIcIbvOPlBcQFlkuNJcR14VCeITbRxVkv1FdAP50h9O6EPLJ8rSQeiBLK2
         NKwZUjqvU2kB0WxMx500aDbhzSs3z3BhiVTh2E9OJr0CYgTxbIYPWwix8dKaU/Ge7MMn
         QkGcR3zb2mkuvErfZTqGQzrI0UPfQyF3nRPt7jjKRz0XfWl9L/ji0/njiKyB446ZqXe8
         Nh1IS5KEUs3JYtbx5kmjtGG5CW+v2YSKINhlM3i58e6lFGy3dYKpidubPQ6Q6hXnt7yN
         Jzoh4ajfk33cqzk3r2XJqEVZAIhPOCzYx33/rOzLhxVoaveayJSqXMFd2hlXUvClPtRw
         FWhA==
X-Gm-Message-State: AOJu0YxmrzN7Pt6hPuew0JbCluzgeyTl0l1yKJObLNJVaIqM33T+HsmE
	+FelXk8sYWz0lKTI7TbYvWpHjQnGLup0G82ufXtOIk2JWgNByBKJ70XQvA==
X-Google-Smtp-Source: AGHT+IEILinr6llo+Jsk5ElCKKqrjtyPDBKRG+r9I2FisYN78lzESQw167v3IprWlV4gQnbckJx5IQ==
X-Received: by 2002:a17:903:1250:b0:1f7:1303:f7ae with SMTP id d9443c01a7336-1f8629fc618mr122602535ad.3.1718634209019;
        Mon, 17 Jun 2024 07:23:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:774f:1c4c:a7d2:bccd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e82sm79645965ad.22.2024.06.17.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:23:28 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: will@kernel.org,
	mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com,
	nicolinc@nvidia.com,
	hch@lst.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 0/3] swiotlb: Backport to linux-stable 6.6
Date: Mon, 17 Jun 2024 11:23:12 -0300
Message-Id: <20240617142315.2656683-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of swiotlb patches fixes a iwlwifi regression on the
i.MX8MM IoT Gateway board running kernel 6.6.

This was noticed when updating the kernel from 5.10 to 6.6.

Without this series, the board cannot boot kernel 6.6 due to the storm
of alignment errors from the iwlwifi driver.

This has been reported and discussed in the linux-wireless list:
https://lore.kernel.org/linux-wireless/CAOMZO5D2Atb=rnvmNLvu8nrsn+3L9X9NbG1bkZx_MenCCmJK2Q@mail.gmail.com/T/#md2b5063655dfcadf8740285573d504fd46ad0145

Will Deacon suggested:

"If you want to backport that change, then I think you should probably
take the whole series:

https://lore.kernel.org/all/20240308152829.25754-1-will@kernel.org/

(and there were some follow-ups from Michael iirc; you're best off
checking the git history for kernel/dma/swiotlb.c).

FWIW: we have this series backported to 6.6 in the android15-6.6 tree."

From this series, only the two patches below are not present in the
6.6 stable tree:

swiotlb: Enforce page alignment in swiotlb_alloc()
swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE

While at it, also backport:
swiotlb: extend buffer pre-padding to alloc_align_mask if necessary

as it fixes a commit that is present in 6.6.

Petr Tesarik (1):
  swiotlb: extend buffer pre-padding to alloc_align_mask if necessary

Will Deacon (2):
  swiotlb: Enforce page alignment in swiotlb_alloc()
  swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE

 kernel/dma/swiotlb.c | 83 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 20 deletions(-)

-- 
2.34.1


