Return-Path: <stable+bounces-47897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4408FA72C
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F061328602B
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 00:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AE79F9;
	Tue,  4 Jun 2024 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsDhQu6W"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6541A957
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462078; cv=none; b=IFdEhTp5VLPgIr/ExdK8tMArARl1PyeUXo/xkzMJhWRBwYc6NtRrOHsITf6jRL9MLQY9/ijlUvIA2c71NK3pduu+lSQ6+6LlKXnlWNmTJn6+68ZIXYu/oBRPdeTXRN58xQ74q1HPVOXbweJVrz+gY1X1vGE22GKBnIMiCTzlEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462078; c=relaxed/simple;
	bh=imt/h6R0KDJUhNMq6RtsOmE9r8XZHrTLbAUZzMX0K3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxW+DUva+SSs/qAiwx5Yc0lH/cfyGsim8naTfmYTbbPNa76jRq44qMkTEiVL9pbpNkZmLKZiiaW58/4ihAdjYcUHQxNQSmbs233VCZEX2d4Ajfq8whenmBJO4VoVpU88qs9+g782v0YkrrTkkloDTsOQKx+btVVClm5014TzzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsDhQu6W; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d1fb4ccc75so217695b6e.1
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717462075; x=1718066875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFtF0VrXCpkLTzgg9Zi5Bik9l+2xEHBdEAucZYu9GvQ=;
        b=AsDhQu6Wi9HPXpLVtDxb8gMj8Hxg/GCpeBYYw989qZniYK479ZEHy7X8CvUYCgePS9
         qM7YpjrCzo+ww6M/baNOkerf/R+3pHyhgPCilVdu44mTIGIqpS+wukUO9w4qDshBIX/x
         gMIyADkMqi0YEwptQX92a8HHOmXhkYuHrDdNTBUT7GIwKaAdzqwfMM+llYPM7SNl+rd6
         W5a6lvmpxAWq2cCKlNZLmnIlEoNW8+L2Ao6gobiXyuPqciFRTcZ77TYdIrDbgKtfg5/4
         eqeulJhWoyQuN/nwdw3TBivmhMDkXVdBZP1ZwzNKw6L93sKfZJh+aUcSEncQKxjYraod
         sm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717462075; x=1718066875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFtF0VrXCpkLTzgg9Zi5Bik9l+2xEHBdEAucZYu9GvQ=;
        b=aBZrhYE3RcAK17XVyVT5Lw7nlDbIrNKddXzlalU55JKLhjSejNUeiUBypd+m73w7+6
         W+LY1AFnYxUrFTNbWcCEUxVjZr7Jhpa/442vw5wuSIaLKOVs+uEaP0D1B/gL3IJoLdf9
         s21jYuOEFnkqhfDwZGwQ1b1MYPF5rq++h+cz2Azv85eCtKxH58ADHcPnLTcQR3Zf9VNm
         6MZL8As2sPltm6a1KSo5minztdzW//1nKcqPEGZngh44NkIORvEZ+RLRbf1sBNbxvyBX
         gb1WxcB4Jy9O5tGpGwzxGXuVg8cJBguZ79Pu/z9CDY4cq0wvFDeAij18Bkvq+9NV+nbW
         jHyg==
X-Gm-Message-State: AOJu0YyXGyk8rDvdfA6E/g0VEDFeBQpumbgy0FGj2DDA5KWtta8XXQH9
	VmUI72sqaUpXWxs1FSXpXaN2F84CZ5vXyN4YfqP/M8EjE11dEOs7Gdlw7Q==
X-Google-Smtp-Source: AGHT+IGtfBWzoeV3ePt3FCCDs1bO/S7D7NVm+jqgrm3QjrZ69B6POU0IH836miAIlAMQNhxgznysEA==
X-Received: by 2002:a05:6870:a11a:b0:245:57c3:8b01 with SMTP id 586e51a60fabf-2508b366a24mr12084176fac.0.1717462075360;
        Mon, 03 Jun 2024 17:47:55 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2a3:200:8c37:1ff4:8ba2:fb45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2bcc4sm5904493b3a.187.2024.06.03.17.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:47:55 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1] backport: fix 6.1 backport of changes to fork
Date: Mon,  3 Jun 2024 17:47:51 -0700
Message-ID: <20240604004751.3883227-1-leah.rumancik@gmail.com>
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

Fixes: 0c42f7e039ab ("fork: defer linking file vma until vma is fully initialized")
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 kernel/fork.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7e9a5919299b..3b44960b1385 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -668,6 +668,15 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			hugetlb_dup_vma_private(tmp);
 
+		/* Link the vma into the MT */
+		mas.index = tmp->vm_start;
+		mas.last = tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+		if (mas_is_err(&mas))
+			goto fail_nomem_mas_store;
+
+		mm->map_count++;
+
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
 
@@ -687,14 +696,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/* Link the vma into the MT */
-		mas.index = tmp->vm_start;
-		mas.last = tmp->vm_end - 1;
-		mas_store(&mas, tmp);
-		if (mas_is_err(&mas))
-			goto fail_nomem_mas_store;
-
-		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-- 
2.45.1.288.g0e0cd299f1-goog


