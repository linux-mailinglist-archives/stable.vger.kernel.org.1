Return-Path: <stable+bounces-91967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3029C278F
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 23:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6518DB21616
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C71E203F;
	Fri,  8 Nov 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K90bZHWP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C81A9B51
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104956; cv=none; b=OQoslaNwaKp8cqBu0W29uBUp53gh8di/hi1DN/v1uylLlji9gP0ALQZiQ4fLya/NJ7helL7Ir3r76QO+YykfV3MtX+i35lqVVKEZJ9Vml94IZwNUzd5C+IOpjwRI6KLG/KQSWB4G7vizjXs7B/IKrAVArw5NShCgGGYdMFKfWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104956; c=relaxed/simple;
	bh=aHyY9gMPQDfeKmEy7LSeN+zZi+bC+Kj9cSMN7Xos+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYsBVI5pzGE/Yz91KPWYCINHLlpGqInT90QXX8o4v3aUx2uosUfMTcw0PfVPf4YEQNFXeBdZsANSD+3vlR5iaSdsoFMO6aIUweA4OO8jVh4FfeDJwZYYrV1uR1B1OfYuNezT5jPlyZEzPqJkFqqHAEK2cHma0vvsp5heVA0KSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K90bZHWP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caccadbeeso29358025ad.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 14:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731104954; x=1731709754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj0d84oBofIEIDvNao3ns8H2WxtU3MqpnpN3A73IJOw=;
        b=K90bZHWPs2umm4es1u70arQIwgzmhKIP4vvcArpMo50FQhCWu+Ta53cOMyduGgvW7F
         JnRMySqZso3fCpwqPw+aFVnJkIpPhLUAu+/H1CnLyXgyQg8xWisJXw1wYQQYCDTUo+/3
         gj+CQnyfBQTlZl5mltmaQipVjlv/bEqeG28QQrfu0XXXXFY2RRhMUvIUbaxgig5a9gSQ
         W6Y3SOLR0QTqC9+K8AoYNIxLZ+GHy+wRaVGFMzFmkhajBOBOHe5FQ8ZlJM/Nd8Fi2ZhQ
         gzXjTihjgzbWGMh4di5p4DEO/N0fnccLNpfg/kiUvPWtjsx61DYAfY3D4Bv8tNTusowV
         qF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731104954; x=1731709754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj0d84oBofIEIDvNao3ns8H2WxtU3MqpnpN3A73IJOw=;
        b=O+F9USpDbYgSZqX33cCj7b8gIYQZukO1yDXGwIN3W0Q78dULUbqpszmGIZAtmLbrxL
         wwWz3U5UzYpUVgSP+WcvyyxnVrCDYCpyaZ1UAPACXwjzpGaeEn4VHtZFQsswbGVlHVXr
         jKB2idz3stQczAdos7NwdnfPgzREQW6zleuR0/JIpblnH22giuJA+92JU+tZcev3NBQ5
         54zPpbhtK0egGMhVdU3gIjt+A4VJKNd2HWtRsDOKPlx7LZqptxY3ZQt0SXOb41+bxDhA
         QmBh2r0v2zcIyzC9tUlngHpzn6KPZA9VEgmeqDUxkxlZHBvq7ZSgVmY4Baq7xjoLvG5I
         QBsw==
X-Forwarded-Encrypted: i=1; AJvYcCXKpDV5mQIDKoC5bIKd0B2JoNnuRJzga1PXt5gEwBlzx0RJOzsFqbUtaqfLIlnIVSFckDqBVHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZLz1NKX2pQkuUuzucrdECmVIOHHl7VT8xLe5j5bsI4kE+wn7
	km8iJfbULpbnUXS7xC+qFFTnQjPvBfTx9N3hPV4+V7LwiUP+QBVq
X-Google-Smtp-Source: AGHT+IHCTwP1JxMlTUvRwhHQEwpeVarcG4hNXGPXy1QEQIYpnJQaRTnVT1DK4itvXZyHolX4IgMaIA==
X-Received: by 2002:a17:903:190:b0:20e:5ab1:2c80 with SMTP id d9443c01a7336-211834e00c3mr57153205ad.7.1731104954233;
        Fri, 08 Nov 2024 14:29:14 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f645847sm4073785a12.65.2024.11.08.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 14:29:13 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AC579DB5131; Sat,  9 Nov 2024 07:29:06 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: maple-tree@lists.infradead.org,
	Liam.Howlett@Oracle.com,
	Hajime Tazaki <thehajime@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nommu: pass NULL argument to vma_iter_prealloc()
Date: Sat,  9 Nov 2024 07:28:34 +0900
Message-ID: <20241108222834.3625217-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deleting a vma entry from a maple tree, it has to pass NULL to
vma_iter_prealloc() in order to calculate internal state of the tree,
but it passed a wrong argument.  As a result, nommu kernels crashed upon
accessing a vma iterator, such as acct_collect() reading the size of
vma entries after do_munmap().

This commit fixes this issue by passing a right argument to the
preallocation call.

Fixes: b5df09226450 ("mm: set up vma iterator for vma_iter_prealloc() calls")
Cc: stable@vger.kernel.org
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 mm/nommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 385b0c15add8..0c708f85408d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -573,7 +573,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
 	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
-	if (vma_iter_prealloc(&vmi, vma)) {
+	if (vma_iter_prealloc(&vmi, NULL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
-- 
2.43.0


