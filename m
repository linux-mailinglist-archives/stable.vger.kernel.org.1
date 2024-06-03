Return-Path: <stable+bounces-47895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB458FA680
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D711F292DD
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29A83CD6;
	Mon,  3 Jun 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNbZoY2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08783CB4
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457144; cv=none; b=k+sN1vWdMyXVshd6JEQ2b503rTXIBjy14BUB0SpUmb0w+PdOGiTxPmtcEcEIZXQ+K1QLhLbPG4BvykFVeE0H3qHJLL/aaW5IQV2PkaN382xtA2ek1ItaS1rqSV2TZ4ZU3H7dOgKBpkymG4w1RfQhQzTCBR9FYblpNUSgPtTpvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457144; c=relaxed/simple;
	bh=0c2TQLD3k7RRTLx675/U3MyHzGZDW2jF6q41DdHpxtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU9F4hxQingB9ejGXD8rR1TnQFhE7szYsrJWmkJRWAgsd8F1hLjtjk60qEqLB6PGcvYfoBH6B2yKREdJIjVLqKCr6yFEMZ42JJltxLXGpP5BYDNPNS6w6k5xz3zplYT8ZWt0JZMF+rpWSzwe3Yk4CoQgi1UKFUWbEhd8bpjgSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNbZoY2E; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so3957079a12.0
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717457142; x=1718061942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcknPabiH8mte/IT6JhJQXjafGFxDKBrdeilmY1S2sc=;
        b=cNbZoY2EcameY9EAE+VZ1bdkAuaY8jSWN5B621jc880eMEaYy/HmC92XNZC2zYVPmA
         Ryp2DUyu1RorOi42/rqUtsD2njItabKccg6Dkm9iscLOB5XwH2ybuDI/eAActku+laCe
         hWXMdcTqh+qVq3Pu1rqfZ5b5nF0l9YaJGqij1C3GVnURgrJBp33CA+htArdB/yZHq/pJ
         dnsWZTzLXiKtjfBtkaHxuEftL4q5q1vxydZSo6L9VaJ9Fg6Lca17yU+RN6bfxgclXBr+
         IW+ojiHLzCb9aHh1reygt8DNinSt4v+1mZEGe1bVjMHITtSPi4Mg018xBU40yjwPYRFd
         MM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717457142; x=1718061942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcknPabiH8mte/IT6JhJQXjafGFxDKBrdeilmY1S2sc=;
        b=QXfA3d8K9sMP/i4FdPPb182jXWDFiYDSEICUBAWTuDbaNdanWYRKylx+HyO9SVKBZJ
         S2jVqWMP7ov42HCfz+OICdtX7i+aM4SDzOaXnQMOymPqykP36GveeuY260akCpke4ed4
         1ND/5FqdAkRlyoIRsyUyvLsw5KfNmM1FBNsP8jNOMMDzZde/YA3nUoUACOZvSw9AHbhP
         fVesst4Ac8pSp+gcLmdPTfG2M4GRmUCbkZ4E2RBguTs/jeEwviADuGvqbDi5vqy8/44C
         M52lByV5h/8GU9qraasFaXHhBjDmpWE2HzdFbqPzGmEr5SDimJwd6N6m1otxvX05epJr
         6CzQ==
X-Gm-Message-State: AOJu0Ywl0PNBr8nqVKM2ZIpZZVrfS2RkXvvKVMxfknuExglpU/ddFyL+
	p2D0BWNXV2k4/+B59z5OPsxDocXq+DKG7ikdn4V+AIwWr62HHSZ8kF2xLg==
X-Google-Smtp-Source: AGHT+IHaT53P2wydBmnXDfPoiAkbOpLb8zdOxSlcELsDLfA/qtjz7pujKwLZUCtUKzhAu2wBxL53NA==
X-Received: by 2002:a17:902:e54a:b0:1f4:b43f:9c18 with SMTP id d9443c01a7336-1f63704143cmr133235725ad.33.1717457141945;
        Mon, 03 Jun 2024 16:25:41 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2a3:200:8c37:1ff4:8ba2:fb45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f664677c7asm37327135ad.33.2024.06.03.16.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 16:25:41 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
Date: Mon,  3 Jun 2024 16:25:30 -0700
Message-ID: <20240603232530.3801675-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original backport didn't move the code to link the vma into the MT
and also the code to increment the map_count causing ~15 xfstests
(including ext4/303 generic/051 generic/054 generic/069) to hard fail
on some platforms. This patch resolves test failures.

Fixes: cec11fa2eb51 ("fork: defer linking file vma until vma is fully initialized")
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 kernel/fork.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2eab916b504b..3bf0203c2195 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -733,6 +733,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			hugetlb_dup_vma_private(tmp);
 
+		/* Link the vma into the MT */
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
+
+		mm->map_count++;
+
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
 
@@ -752,11 +758,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
-
-		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-- 
2.45.1.288.g0e0cd299f1-goog


