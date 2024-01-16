Return-Path: <stable+bounces-11231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391582E6AF
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 02:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B9B1F22E27
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 01:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432B1CA92;
	Tue, 16 Jan 2024 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOOs7nMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A61CD07;
	Tue, 16 Jan 2024 01:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439BC433F1;
	Tue, 16 Jan 2024 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367135;
	bh=MaeK466JEYwMZ5I2oAw1p0sY1TckDV79zfSF+Ws9SuI=;
	h=From:To:Cc:Subject:Date:From;
	b=kOOs7nMJpzgyUw5oBD9n0dxIDAatGt6kTrGYdaRHZo5XsIGASj71TfJUtNJ/IgTc2
	 81iy77wf54SFQfdNiWupHT6gqy3vWTzRiFN6OjYTm0PUkJv6GiPA4JZmZ0P1r2W2Ou
	 OFG7Min6Y3U8eL2IVlclI/qJXH9EB+v7MRpamEr9y8mRI+1aw2cLBJxyPUcehEz4Or
	 Wahqpk9IR7wBCX4OcMKLkqpQLSlOschJQDfCdKu2PuZ0KlTwbpeuv1/8eJbEXY61Ra
	 4xsW0O83oq2Gv1a3upkxa5bHhwuQmXYSbvykDmaBS8egNetpmFmTfYyDRxZwVSxyH3
	 t0zBljbuf7IQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	imbrenda@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/19] s390/boot: always align vmalloc area on segment boundary
Date: Mon, 15 Jan 2024 20:04:56 -0500
Message-ID: <20240116010532.218428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 65f8780e2d70257200547b5a7654974aa7c37ce1 ]

The size of vmalloc area depends from various factors
on boot and could be set to:

1. Default size as determined by VMALLOC_DEFAULT_SIZE macro;
2. One half of the virtual address space not occupied by
   modules and fixed mappings;
3. The size provided by user with vmalloc= kernel command
   line parameter;

In cases [1] and [2] the vmalloc area base address is aligned
on Region3 table type boundary, while in case [3] in might get
aligned on page boundary.

Limit the waste of page tables and always align vmalloc area
size and base address on segment boundary.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 2 +-
 arch/s390/boot/startup.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 7b7521762633..4230144645bc 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -272,7 +272,7 @@ void parse_boot_command_line(void)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 
 		if (!strcmp(param, "vmalloc") && val) {
-			vmalloc_size = round_up(memparse(val, NULL), PAGE_SIZE);
+			vmalloc_size = round_up(memparse(val, NULL), _SEGMENT_SIZE);
 			vmalloc_size_set = 1;
 		}
 
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index d3e48bd9c394..d08db5df6091 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -212,7 +212,8 @@ static unsigned long setup_kernel_memory_layout(void)
 	VMALLOC_END = MODULES_VADDR;
 
 	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
-	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
+	vsize = round_down(VMALLOC_END / 2, _SEGMENT_SIZE);
+	vmalloc_size = min(vmalloc_size, vsize);
 	VMALLOC_START = VMALLOC_END - vmalloc_size;
 
 	/* split remaining virtual space between 1:1 mapping & vmemmap array */
-- 
2.43.0


