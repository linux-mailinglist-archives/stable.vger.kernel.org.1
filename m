Return-Path: <stable+bounces-161847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19900B040C8
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25D916B547
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016B254AEC;
	Mon, 14 Jul 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cf2Ne+IK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A9253954
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501445; cv=none; b=lHOFUe6tHr3nqKesQdI32rbUVOTVtgDVrNmvE8KrC7RLFn7YuQ/Y0Anl2oTnygCytYgU3GLWcHgfsNBzG2aokWiADvB435pdqrNQfaL9slDp7Rahc6sN5h/r9czRTZdfxxiEl8ixvK6goUPZHnP8R/+AkGfKU8yQDI93UsKdkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501445; c=relaxed/simple;
	bh=lIoWUmXvWj86sMKGqu+ntXXIgWMsTnjd2dZeMhtEubE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgiH7yTsed2LV7pqyvZfOPOyaFj7eV0zk6FWx1JFZthegjxneVuIhUg5GCCEwaTNOX8A8c7N+Vpub/2I/XD+ceOnA5CcTFFGmyWWDMLxFrvcRKVQuDeuPIAVhulpK3u6ZP3EVhC3coWU3m3lXPjsGOoryjEwjamz6p4JhNQDvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cf2Ne+IK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561b43de62so55635e9.0
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752501441; x=1753106241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/W3q8fvXyiB8GSS7p6uoLRJWawx0nxrBlyiHcj2vnE=;
        b=Cf2Ne+IKr8XUw3dZR9gYb4DvA1PI7RrhVAV3TS+iDkWXnU1+FvQdrs2Tta/YJWp/lM
         kh3mKdjVCKkCVZz8PknaGMzfYf/mQB8xXkzI7EUH7K3GWnfJcFBDRnOvIC1KLxLftb/R
         7PIVM5dv7X1V76oplt3ORsvPPhnFqP8s0bVDIWDehVlWtuLuVVeIdNAmKmBuhVUKfqxj
         v/HoHVmXnU8vKZ4yiPHMQswjs4cdfD3tU1V5twZRdeAeB5KeZRXOHJv0o9CBfYOYk8mY
         O4Cdf+BXfKmUrLrAqbXn1w1zJFNgdJLCPD2hOA8AdNWpvMgLUmql4Djzs6DDn5fUE4KV
         wjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501441; x=1753106241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/W3q8fvXyiB8GSS7p6uoLRJWawx0nxrBlyiHcj2vnE=;
        b=d2k2nNA6rFOYnntNYbqeyH898Y3SXxK6/oZswl8esZTww6BGSPI3OHJ7UBtHcWRJ00
         kkbTfDp0Q1nrVndBkowbHVBaozmx4adRSk7cCSgt71KfffKwDWerNIQ0TnPyr/zmHpjq
         GmURSNbHKUPwqWb1uKT+BJctx7AV5zTu7uXivwI3u9jRFecvhCCoCkxheHq9W/1srAyf
         foHLfDDxxYLzY5I4YxKwRvpuIwrZDSG0HSq6ftXMabflhKwYqHHbRO5PKIaWm2TrGLj5
         Mlr3D0gLgm14yct7B8Om0ASFtvT6B3H4tE0QGZhoSJ41YM4hReu3iIIHbtGcki+kRUv9
         hZtA==
X-Gm-Message-State: AOJu0YwwFp/ooqG9QZoguxPHV1gJ2uhL/WOFFFNn79AevDw1WVn0X5Gu
	C83pUGKSO7W0cP72QynDcPpKoCp1bygdigTsuzJWaBgd0IW006u0FgPqErH4jTZmJPtUcAQm9Sg
	S7l38K9V9
X-Gm-Gg: ASbGncvGzaAimcGvrXT4u1m7B0YCXNv5eHgSVzWXueuuY57aaYQ6e0fNTLmvl586aHB
	5uiIokGKSakIe8h4Xt4FQk72BBYSSwR71QYkY3Ve4GCzBOw+CtPZlCzjl/KRA71StVjiKBMa13X
	XGC0fGrH7F7HQrphXU3XR9WHP5d+SoqDn7TGwWHpDLIHEVGccOkevc2+xc3xaQyP3LaK+R72Qmo
	GPp4lST08xGR+GTVmYO8iylw6bJfSeip7cWBsD/fUnPLgU9jK1SqLxONyTEm4+3PS2rw5yaZW/c
	3MebTCdkxjrG061/bH6XxXmYz96o+ElJnYrgfyh7hbsNPENUIVoBMAvn0JqX+H71iw0NWW3BnIf
	iiXiz27QKeAf2V5iVaj8E
X-Google-Smtp-Source: AGHT+IF6yOWh2nfG/LDWv5YhpQ+NUu1hvPFAaOdI0apzeRMAAeVs2YUa5pFkLIoFujeU2LD0ih99WQ==
X-Received: by 2002:a05:600c:5023:b0:453:79c3:91d6 with SMTP id 5b1f17b1804b1-45604733553mr3507795e9.1.1752501440652;
        Mon, 14 Jul 2025 06:57:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:46a:594a:89a5:b3cc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc3a62sm12349780f8f.40.2025.07.14.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:57:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] x86/mm: Disable hugetlb page table sharing on 32-bit
Date: Mon, 14 Jul 2025 15:57:18 +0200
Message-ID: <20250714135718.361404-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025071422-target-professor-6f97@gregkh>
References: <2025071422-target-professor-6f97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only select ARCH_WANT_HUGE_PMD_SHARE on 64-bit x86.
Page table sharing requires at least three levels because it involves
shared references to PMD tables; 32-bit x86 has either two-level paging
(without PAE) or three-level paging (with PAE), but even with
three-level paging, having a dedicated PGD entry for hugetlb is only
barely possible (because the PGD only has four entries), and it seems
unlikely anyone's actually using PMD sharing on 32-bit.

Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
has 2-level paging) became particularly problematic after commit
59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
the `pt_share_count` (for PMDs) share the same union storage - and with
2-level paging, PMDs are PGDs.

(For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
configuration of page tables such that it is never enabled with 2-level
paging.)

Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Vitaly Chikunov <vt@altlinux.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250702-x86-2level-hugetlb-v2-1-1a98096edf92%40google.com
(cherry picked from commit 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf)
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 93a1f9937a9b..6b4f232a00d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -102,7 +102,7 @@ config X86
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_TABLE_SORT
-- 
2.50.0.727.gbf7dc18ff4-goog


