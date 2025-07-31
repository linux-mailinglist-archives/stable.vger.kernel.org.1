Return-Path: <stable+bounces-165675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E93B17415
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037321C23A58
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B71D5ADC;
	Thu, 31 Jul 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elLu8CEu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980AD515
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976687; cv=none; b=iI9SAGSo89APioIEKrSx17KavpPhRoBH/tWfINFkri9H0hMJFlOwP3G3aUVgADgInl602Z27Y1lc5knEQClTI7bk+ObX2dR2IcqHi8stZkfR0kb87L2qYV/mre2wl9DXeVQ53Ri2c8Agn3r1vlrYboLcidhZwBe65eT7I4SJYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976687; c=relaxed/simple;
	bh=OTA2x4bKnGUx3VAQlS2BrqHpdMgIv8m6sktHVnnjfbY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bdUhi5DW8uzr1ojFyvhCqOmkNkd9gHrBtpSi2QJazQdVfgJRj6UBFYQe9cYnst2NUND0fJ/7Nmxvkgti/5Fd6N9cCr1nd/kQwAHwjubWXyG+rcCwoN+LBddoGASZhTbZC3gpxvMu51zB4obQxaeL0v2iEwYnvM4AtWXQWA7Fpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elLu8CEu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31ca4b6a8eso403030a12.1
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753976685; x=1754581485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8D6H3TovcRUpDHrrv443Wy2kKrliHPbwf72lIkroPTg=;
        b=elLu8CEuxWIkjFWmb6U2eUeRTAVWvwFtNbf204tcWhPfNHxvOu3cj/67UsAD68naVh
         80EvcDN0CTyh2tpNpOlcTk0AvxV2l58Lf/9yyPFN8+E7zCHzVaObjx0GQdZGdu5DCWIl
         RjTTsM2DGpYwkJf9J3oCTq+vOsjPS4cZgz1xi81YrWkwj6tAnNtxa5rLOLCreZpGKVFl
         UqJWIouJ4EfDIOqO6giMxZtskNjqKjiwoUUCj6x09x5wBau34IzgAyDIE8zRAzqgQMax
         qeaoCfEBYqSgTHH9xeu/5i+7ul1Rmp8tp7scEEcWkYWN3zH6D+dXEVi1EyXxqXoVaNmb
         R/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753976685; x=1754581485;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D6H3TovcRUpDHrrv443Wy2kKrliHPbwf72lIkroPTg=;
        b=kDfeO63j49cbPCFyR8fqCt6jS5Jtsz3mmsJep+CV7jitNM8i+FyYNYjoJuFIKKOt9R
         w8tQ7zFsuoHv2wgokIwc5IKM7nvu7FVkGbWlz2brtZkaQ/5YwPumkRGKscM8EjXxKzH+
         E7jgCU59sZ44AVZWY73eG8hKAMloqzLQ8nT4ugKlZRe8VNyL3y8UK5Z1miP0LDsOW/LD
         ZjSNyzK6gUj/biFngxudD+V+9/GurLVzx4DVx6OdLLpn59osSLjX+OWkx1YfpwHdsLUP
         DhETiY4e5NhjEkbPvsYUrvI0lXFXHhzgIuqB6rEXlB1an7/gHBGbqHQn4tQyLZ+U3VUj
         YwVg==
X-Forwarded-Encrypted: i=1; AJvYcCXrNBz296l2qqglLi71J71QQcW/koc4x9yFUJxI43IuLKPN6CjrTFM/IEa3DWfxmewheAY9Kdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTeiKLlag+ayMwEHJVA/z3IsrLTNHcOP/6bcvwsw38ynr9hqg
	gfo+/oWOeEF0Rw5djhSGhuSGZoCuBlI7Ce9D4p7aiNzadkuMczdAvfZUt7OWO667uRT7CpEt+XT
	fOXZ0Hw==
X-Google-Smtp-Source: AGHT+IG5srnDugZwbzwxdO5CMVzSLz47ALstUwtxD0ry/hJIfF+IqAvaHkQ39SziNPkrw/OnSv1Kvb0DGBw=
X-Received: from pjbqd15.prod.google.com ([2002:a17:90b:3ccf:b0:314:d44:4108])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:562b:b0:312:959:dc4f
 with SMTP id 98e67ed59e1d1-31f5dd6b53amr9841464a91.5.1753976684978; Thu, 31
 Jul 2025 08:44:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:44:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731154442.319568-1-surenb@google.com>
Subject: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterx@redhat.com, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
encounters a non-present THP, it fails to properly recognize an unmapped
hole and tries to access a non-existent folio, resulting in
a crash. Add a check to skip non-present THPs.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
Changes since v1 [1]
- Fixed step size calculation, per Lokesh Gidra
- Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra

[1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/

 mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbed91b09640..b5af31c22731 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			/* Check if we can move the pmd without splitting it. */
-			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
-			    !pmd_none(dst_pmdval)) {
-				struct folio *folio = pmd_folio(*src_pmd);
+			if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
+				/* Check if we can move the pmd without splitting it. */
+				if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
+				    !pmd_none(dst_pmdval)) {
+					if (pmd_present(*src_pmd)) {
+						struct folio *folio = pmd_folio(*src_pmd);
+
+						if (!folio || (!is_huge_zero_folio(folio) &&
+							       !PageAnonExclusive(&folio->page))) {
+							spin_unlock(ptl);
+							err = -EBUSY;
+							break;
+						}
+					}
 
-				if (!folio || (!is_huge_zero_folio(folio) &&
-					       !PageAnonExclusive(&folio->page))) {
 					spin_unlock(ptl);
-					err = -EBUSY;
-					break;
+					split_huge_pmd(src_vma, src_pmd, src_addr);
+					/* The folio will be split by move_pages_pte() */
+					continue;
 				}
 
+				err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
+							  dst_pmdval, dst_vma, src_vma,
+							  dst_addr, src_addr);
+				step_size = HPAGE_PMD_SIZE;
+			} else {
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
-				/* The folio will be split by move_pages_pte() */
-				continue;
+				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
+					err = -ENOENT;
+					break;
+				}
+				/* nothing to do to move a hole */
+				err = 0;
+				step_size = min(HPAGE_PMD_SIZE, src_start + len - src_addr);
 			}
-
-			err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
-						  dst_pmdval, dst_vma, src_vma,
-						  dst_addr, src_addr);
-			step_size = HPAGE_PMD_SIZE;
 		} else {
 			if (pmd_none(*src_pmd)) {
 				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {

base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.552.g942d659e1b-goog


