Return-Path: <stable+bounces-158993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45464AEE750
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107563AFE29
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9A42E719D;
	Mon, 30 Jun 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QysighSP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549752E7192
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310471; cv=none; b=dkIvA6aoh0/jRFxuNYpCXQSuxnUNts6H41fFZ0+PyLmGwPwWe1TDmkCDL/lyGBjiIejAQHEpysy9+XjOvAmqZZeYmDFr3nW/OMNaRkkn3W+ejPPfqNKSsgQ+er3sChTy7kxbSmowZlKm5p3JsKV5GVTZykkiwJz8aHHzNC8nQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310471; c=relaxed/simple;
	bh=fZfTk5Vh6fk3qEeQcDy4mPHUEYnCIWWCDffCZM4Mbko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C7ktOzo/t5kwSaCIPeXdRch0DrN0c9f7ia7XtTwI50NCDe/b7oo97QuRzY88BFVYmH6zRwMl/zm57IuEJapSxdy21DN0jYPKa76q+ZHc2NyupDparw9oZa/7hndzk9Z6siwv25rvTzAGnxSgawMHYcDSknAfmnlomCznV7c5Xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QysighSP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453a1208973so11875e9.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751310468; x=1751915268; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXx0muI33yyrsJI+RM5hAO2k29pecRZJHRerqdYdA4w=;
        b=QysighSPx++2K4p7lfNc5QclhM1Iu5k1LU9V+v9rsdOGkq91C99RcRwGSHE3MnNpY2
         MgxlD6zRR6a4Ksd/sADGmiZjdZezbX6IgwACz4q3vCBM3E1SU8HK+h1OrNORBb/618sN
         w475etu55qOEb/CBg2m45gyj48UWDaMNvq8zARmxYx+jD7pH9rbPEGg35freQTd3g5MN
         4u5Bg5BN2k63WBnZbynJAXHgoTM0/+PrZWR423+0AF/Q9qyQyvjFp3oya71Oaj7alkGU
         Y63ON8GVTKrMdhUvG1jmHe5Y/d1slUzOOiKp1VXoLDdOVnMOlnF90VoFKsdUJi0bAHHW
         6afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751310468; x=1751915268;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXx0muI33yyrsJI+RM5hAO2k29pecRZJHRerqdYdA4w=;
        b=lvV+1/PLshisvJeBT4kliatn065ukBWTxlL89jFv5KWa9QyZ1yfFnbLY4glaN4omzw
         +VXE4hMex+3J5TpoSJ4lB/YlS0U/N8C0KBXXr00KC/fWLozbPa3H/YO7UTKViwHG8dzC
         huTwEDG1rqSZP2BoK7aRLvBEeO4wfbg7DVj72UA0extG9XHL/0/7Rw0QacScKj/gJcy2
         zqmA0ZzNcXu3pcw5KHIYK7hQTAcPEO2wHdmG4H2g0jCQpYnDtQmynamT4YzOShotoXQ+
         CtAEmesx2B5geDzy1/6P3t2MVIZ4TF7MxmlUOWyaJ16R68pk3362ziUQxAUdbjYByXwf
         EYZA==
X-Forwarded-Encrypted: i=1; AJvYcCVLIeN0X+Ek8TRw0LG57J713WZEmAJJyXual10CtQyqlpPb78v0LfRjztp4uWQuKhe9rXSA4ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVdJtxmL53KcKyISlDpvapwf4+GX8WGk9jH1DliA13dYhhxoz
	sltz85/Ni9FsVDy6KtRneD7IAG5FzmKD6xUfNq2jObK34jPdMTVOHdvWYEmxfgqsDQ==
X-Gm-Gg: ASbGncssdLwjEHGLNdisPpPEzD2xPG8eCBcLYT1A9miyHcw7UyAtg+iLm3cQMMUgXc3
	TcCZyk+e5ZYTPTyuEG20KCKDJfTbIkiLt3byH6D7mrkmUs/2eMFs0FQNqR0vaJ/ltBRsK57SnYf
	wICCUwETHn7UAO1yjwUIpwe9NOuFnifkZZ0aInZMoLbCEPbAwDVo3kb0mRqkQBO47zaBF0cYP4D
	ueygpZaNzgXNE8nuDySDfbZa4uwZFOhNJP0m32TaRy959Sdv/clM8gqQSExVLx0l9nbmcrneTIV
	OAKzz3sSXUapSX+RxMqlmGWPOIb7TS45iQMy/RyO4i/qzhEeHg==
X-Google-Smtp-Source: AGHT+IEOtpexKrK9C200H5QylvI7By2axtMWEC2awkl7w6Yep+kOnYzpwv7SNg5/2NVyrrB7n8uhfA==
X-Received: by 2002:a05:600c:8b54:b0:453:7d31:2f8c with SMTP id 5b1f17b1804b1-453a82f541dmr100835e9.3.1751310467398;
        Mon, 30 Jun 2025 12:07:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:efbc:81c2:63ca:f4bd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453a85b3211sm171495e9.1.2025.06.30.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:07:46 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 30 Jun 2025 21:07:34 +0200
Subject: [PATCH] x86/mm: Disable hugetlb page table sharing on non-PAE
 32-bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-x86-2level-hugetlb-v1-1-077cd53d8255@google.com>
X-B4-Tracking: v=1; b=H4sIAHXgYmgC/x3MQQqAIBBG4avErBsww4iuEi2yfm1AKrQiiO6et
 PwW7z2UEAWJuuKhiEuSbGtGVRY0LePqwTJnk1baqKZWfLcN64ALgZfT4wiWbTW3DlYbM4FyuEc
 4uf9pP7zvB5jCzAFkAAAA
X-Change-ID: 20250630-x86-2level-hugetlb-b1d8feb255ce
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Vitaly Chikunov <vt@altlinux.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751310463; l=1751;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=fZfTk5Vh6fk3qEeQcDy4mPHUEYnCIWWCDffCZM4Mbko=;
 b=kvQS4ouJ3b19TCoh5GA7p1y72qr1wSvm2vBPrDtuH/ptozufVWlQnwIJEVJgZVGCD4avNN+Ph
 sdoHh9GDeRFB/3o80OYgEquVoPd1SnKDwWdYKGd/UzJKzG59yxQgeHs
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Only select ARCH_WANT_HUGE_PMD_SHARE if hugetlb page table sharing is
actually possible; page table sharing requires at least three levels,
because it involves shared references to PMD tables.

Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
has 2-level paging) became particularly problematic after commit
59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
the `pt_share_count` (for PMDs) share the same union storage - and with
2-level paging, PMDs are PGDs.

(For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
configuration of page tables such that it is never enabled with 2-level
paging.)

Reported-by: Vitaly Chikunov <vt@altlinux.org>
Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..917f523b994b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,7 +147,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if PGTABLE_LEVELS > 2
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64

---
base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
change-id: 20250630-x86-2level-hugetlb-b1d8feb255ce

-- 
Jann Horn <jannh@google.com>


