Return-Path: <stable+bounces-136975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD8A9FD89
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 01:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6A13A60D5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A17212FA0;
	Mon, 28 Apr 2025 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Fb6v8nNZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6F1FDE33
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881779; cv=none; b=qzF+nbg2kx0i4mL6/P1KdRVZ8qNFO9Pkt48A1iGun869PdP2rwlo16ARhRdSLz1x/ZNNy//o66ZWjYnReJft3ojqa9eBXB17xlcHSU14gt3H6u4X1P0Zv/9iGDbIuTYr5vgCZirEJVZ/prb5Tu7VJqtIB/i6oj4frsPzTNOBtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881779; c=relaxed/simple;
	bh=89vT0Sf2P1UCl2hR+GVT3KeUEojLgSDAWizbeGcX9VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDEjuaXcHnJpJHpKyYA21PD76GVmbChDeSxGlPp5AsaiSNPChWt4yyuzPkmSV0otenbJlmgsZ2UZLAIppMBjUyB2Bn85xXICROXnXsLMbiQ2rrlqhjBK2Q4iAMP+HlRbSedtfqPdn9SgRIYervlg5Q8M3n4/s3/OWDGQPmMS+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Fb6v8nNZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac29fd22163so771671766b.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745881775; x=1746486575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuwPRT6I+AQPMIHK3FEvwFoI62Ft+AE7bxY+V5erSDY=;
        b=Fb6v8nNZ0KSGR+BY6+B7xDWz0OXP3+1Cd6O2g1fQc6HI2BRfuOH4czYGV2db+/QzVb
         BQybResJHRTjsZ8GgvabFPXcuh01RdnzGZTha0RYsSDjippDO3u/Ik/qL0bwLPtD+Obc
         mUpbYnzmZMSVTBJ0A3jZWWKXqSXZ88gkJeV7rRSer1vvO7ktAbOZ/QUTPV1KgYT2C7Jn
         eSEkk5GpaGaiN46VYmA8K1/N7mP0p2YLrwxQiy5Z5cytUPMbdLRlQ3P/7exrUiODNa6r
         t0u+yM348fCRwKvmF8bqSjRQsOi8uJIBDLWAiDXGI90jRf7NNEpNvszabHcW/ini6KKo
         DF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881775; x=1746486575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuwPRT6I+AQPMIHK3FEvwFoI62Ft+AE7bxY+V5erSDY=;
        b=gaZMAok4VYSX3zQtqjVWmJzTIsV4uXBuVOJeqCggNUQ3oPQGHxGQ/a7E+NP7fMoY0W
         /bRbMsaHG3S0xtDVNROdrD65d19sJoDCogaEKq8M/bxT0cmQwOWpB8AMBaXmLUo6LsKg
         R5h/EsV1IjI76kS4eOCmtMIn1M75ksA87rScOln7RTK0BXwiRXSDi6Y6AVZ/JuY/1+QL
         ZVkIiia3SUDCjvTfupHtZnkItZlivNoXMWZmq9OfwQ0h+I2z8YMx/p613b3KU6KU/EAl
         fTcwFxs5Ef2RYIKOvzaA1besEXD1pw85Vnf6v/h97XnYz4namegF7Sghs35mizhzPm5v
         EODw==
X-Forwarded-Encrypted: i=1; AJvYcCWAFyJzjue+XWg3HAYsRq04OGVh/KuxZ3gUG3+xitfRsJRtlaTOZFFrNrIMxS32akG1hSemwgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIDckJ/RxGDnPw4PbRRbMxVviVxkrABe3qIaghJ+xZ/gGMBPI
	NX4+U3gTqA5udMLG7aUP5YKiLOiWa9KOw6LVqL3POYXPWPEIjKIl3qU8c/vKxaY=
X-Gm-Gg: ASbGncsLh9Xy2XkGnZbygXEzcy9xMvjVwyYApClk000QOChEqPKwSV1asfHc1Vl6Feh
	pNmj5zvaCgKcFCNLH12CWCO3SeHu1wQWeIpdEUxZzpYbNCE6p/9pE3jOBhPH+1zSKWkzReY20ng
	a2HRgsBZS77ikKZyR66yLBAOytGxDBVnpdfTODVi7Fyl0NgbjXUFJlBUi51ofXSi4BzkpiiJiSe
	JQ+5VOKPOer3GZbOXPhaAUcYl1L2yik+ozAlbxTYhs/zuw15w46LUzYxh/iUKUw/cSTZUE+eV4e
	4324V8eDWCSfMSLqNiCUM5tNBRcVuwPYqTEtynifdLD+sZ7XUhqJA+sO2u1Ut2DvdBZ6cLweKUa
	6J3IdN7XvTV9W/IrY1bCtY4hucXfsHC5NbSBzg5Co
X-Google-Smtp-Source: AGHT+IE5dJK+12G6ixtMDx/8QmYuexDS2b/NTuouKDmQ+p4y/0Up7a/b/rL1ILFQJAuAfI+CdQ8jOw==
X-Received: by 2002:a17:907:940d:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-acec4cdf8a0mr160727866b.27.1745881775464;
        Mon, 28 Apr 2025 16:09:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e595abfsm687547266b.86.2025.04.28.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:09:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/erofs/fileio: call erofs_onlinefolio_split() after bio_add_folio()
Date: Tue, 29 Apr 2025 01:09:33 +0200
Message-ID: <20250428230933.3422273-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bio_add_folio() fails (because it is full),
erofs_fileio_scan_folio() needs to submit the I/O request via
erofs_fileio_rq_submit() and allocate a new I/O request with an empty
`struct bio`.  Then it retries the bio_add_folio() call.

However, at this point, erofs_onlinefolio_split() has already been
called which increments `folio->private`; the retry will call
erofs_onlinefolio_split() again, but there will never be a matching
erofs_onlinefolio_end() call.  This leaves the folio locked forever
and all waiters will be stuck in folio_wait_bit_common().

This bug has been added by commit ce63cb62d794 ("erofs: support
unencoded inodes for fileio"), but was practically unreachable because
there was room for 256 folios in the `struct bio` - until commit
9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts") which
reduced the array capacity to 16 folios.

It was now trivial to trigger the bug by manually invoking readahead
from userspace, e.g.:

 posix_fadvise(fd, 0, st.st_size, POSIX_FADV_WILLNEED);

This should be fixed by invoking erofs_onlinefolio_split() only after
bio_add_folio() has succeeded.  This is safe: asynchronous completions
invoking erofs_onlinefolio_end() will not unlock the folio because
erofs_fileio_scan_folio() is still holding a reference to be released
by erofs_onlinefolio_end() at the end.

Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
Fixes: 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/erofs/fileio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 4fa0a0121288..60c7cc4c105c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -150,10 +150,10 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
 				attached = 0;
 			}
-			if (!attached++)
-				erofs_onlinefolio_split(folio);
 			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
 				goto io_retry;
+			if (!attached++)
+				erofs_onlinefolio_split(folio);
 			io->dev.m_pa += len;
 		}
 		cur += len;
-- 
2.47.2


