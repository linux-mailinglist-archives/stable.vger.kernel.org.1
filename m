Return-Path: <stable+bounces-119660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D6A45D9E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965987A1D94
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964621858F;
	Wed, 26 Feb 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bASzfkXc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268321773E
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570504; cv=none; b=Wn7O3wGM/BujxIcJVYHix8z4UrLyb/O8ge68nmM9kICyZeSkgiqnF4hCiAPFAy5KCx5L86GIaymXfaTL0j4yR/iE/Sf7y3+e76sWl8oFO/A2xikjK8X9viMidCtyNzQpDIDU2mBOtMeMuC6pUXkhStFl7vuNXicZcmPSaIjCXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570504; c=relaxed/simple;
	bh=NluUjPQ1lcXSGNSXHKkI9g2tFhg8Z04LMSmLkLhacJg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RoUQ21dEE9/VuJd45ccvSs1Ig40Zc+y0o0XQW+gcJhcflvoxPbR+cmGj09u6/AJ91CPAlf2c8fgOLvCiy07tjlz2kNhekd/7PTAcG3Lg8/su63wNy/PeH8+125BGssIfJCgHXCaeYurHtsKdOsZOuS+yR/j+BkTzRTJ6A/F+D2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bASzfkXc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e65a429164so135575126d6.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740570501; x=1741175301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BW2sDZbGgcaHae82O3nWDg50TbU9r5oNGjDpd8Bq0yg=;
        b=bASzfkXcq6uDxnM3z9vcz2+aGdJN4NKqtup4GK2vxVtnyP+fgJVvuMkARXpYDOpwk8
         IeNYqrWvf2DvIibDUErf/peL/5JR+W9MCyRE6yhQJnLeK3CKy/x59dcxKjwcuVNwsTyr
         N9cvyW5v6B+ZL/nO3JO7WfqoA6zYqOA1Gors36mb/aD1SK1A9ZGR5+ql1u6NOuOR4ycd
         0WPia3G/HXFZw2qyfV7W9si6O0hS9uu9fsHffeiDPgwtmSVeEunBS+hDcRkFsGS75+uv
         1rnj3tcxDuZzymkpiv/xNQAcVzWjlsvlzDZdmerOMPVKVdt5LUA7ZhjyA+89UjSISl1h
         vqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570501; x=1741175301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW2sDZbGgcaHae82O3nWDg50TbU9r5oNGjDpd8Bq0yg=;
        b=R4ogr78Wn+on8ekgnr3l/FLD08JPYXwwvDGpP+vRPmdcdqES+B7HFtPxbkjTmmi+45
         tF3/34Eb/4Mqopr5+TGYMYdmxuKuwTE8cNMETGHdaDv1DsYECi0aQlH/0njDtt38ufUl
         d3FZpRHDdLDVqqa2GTHBZH/irJJSeSeEYzGcJFy/6qdyCDf1bPjwCrWnu1tGXatr2U6L
         YHFPdDmZiOk+tcYitSDzXofdIW3M/V+KgIEPelHL8k9xXHgQHK+k0azrX2t+7kZOi7rE
         33xbcQv3pLUrMFxTh0FToykU3tXjDC5M6C1GDVXNkHPAJKDZOR0S2oIPvaTQre2/bv3B
         LmxA==
X-Forwarded-Encrypted: i=1; AJvYcCXXV7xSvxxNRL9aKlgsaU/kHbFeGMq9DrxWz0BFIG3Qhe+5nLNMXLvrUyZhywFRUEit4D73b0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPGAaOHerznLXQMVBkOMOU83cBrgg1f1Ge9ssThza4s/sEH/6
	CDM007FhW8hVeP7OwozvKnyLFbQ+qS/py+yj4cyMJu94amI0P8YvcT01pPOpRyb9Tu/NNSfZylL
	1cjdySw==
X-Google-Smtp-Source: AGHT+IHJUITF5zclnwhhjHbh20BakF71z5r6tgDhP0AK9kt5E28tAnRR/N6wBQQHHEoX4jc66xvFWRnCg9Rw
X-Received: from qvbkh18.prod.google.com ([2002:a05:6214:5152:b0:6e6:62c7:9f79])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:4119:b0:6d8:99cf:d2db
 with SMTP id 6a1803df08f44-6e6b01c6a01mr279510756d6.38.1740570501527; Wed, 26
 Feb 2025 03:48:21 -0800 (PST)
Date: Wed, 26 Feb 2025 06:48:15 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226114815.758217-1-bgeffon@google.com>
Subject: [PATCH] mm: fix finish_fault() handling for large folios
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling faults for anon shmem finish_fault() will attempt to install
ptes for the entire folio. Unfortunately if it encounters a single
non-pte_none entry in that range it will bail, even if the pte that
triggered the fault is still pte_none. When this situation happens the
fault will be retried endlessly never making forward progress.

This patch fixes this behavior and if it detects that a pte in the range
is not pte_none it will fall back to setting just the pte for the
address that triggered the fault.

Cc: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
Reported-by: Marek Maslanka <mmaslanka@google.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/memory.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..32de626ec1da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5258,9 +5258,22 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		/*
+		 * We encountered a set pte, let's just try to install the
+		 * pte for the original fault if that pte is still pte none.
+		 */
+		pgoff_t idx = (vmf->address - addr) / PAGE_SIZE;
+
+		if (!pte_none(ptep_get_lockless(vmf->pte + idx))) {
+			update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
+			ret = VM_FAULT_NOPAGE;
+			goto unlock;
+		}
+
+		vmf->pte = vmf->pte + idx;
+		page = folio_page(folio, idx);
+		addr = vmf->address;
+		nr_pages = 1;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
-- 
2.48.1.711.g2feabab25a-goog


