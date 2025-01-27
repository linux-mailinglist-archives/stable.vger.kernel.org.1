Return-Path: <stable+bounces-110828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA09CA1D1D2
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D28E3A3071
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76601FC7F8;
	Mon, 27 Jan 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsmdMoHk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095D172BD5
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964556; cv=none; b=O3SgWMwEbEQx5HoIXriQhYY+ay2ufiBT77ZpBsk3XzosWrTUqs6tw88uBZDQ9Gqfa8Hp4Ey3QKgHT8pFnruZnl8oUGt3tiMR25TQxnEayBI/b9ckGzdF1cjVMiG6b04NYPhR5Z4nydGX45TumTvV4TvPd02SKwWtVSB2t7/mBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964556; c=relaxed/simple;
	bh=e0XkZwTqoZip/EHnW+l+YWba3HCJNAIn6qmZqJrf/+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f0CYussHd6RTV0HGSKkQ46wZiVM6mqZX/Yc5oll9RBGcdNsVJmFv/shFXJ549wGR/gCK2PWdqxqq8Ne7ORkuw+z9cu3zxVGcUqVJXJjqmIYI+uGfIhVvlccP5irHRzOCHqKM0KxOMINRdROdfwxuiC1RmLxc5A/DEY67dq3Zczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsmdMoHk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab698eae2d9so247055566b.0
        for <stable@vger.kernel.org>; Sun, 26 Jan 2025 23:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737964553; x=1738569353; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADd5QPXGRb0ZUjBZ78cLndx1ZBrU1KrHUZpnVuQhnKU=;
        b=UsmdMoHkBdS1x5762DypWNSWlnlPlX0SaPzHah4Y57cE3/PjQlpqVw345ybQTb1XNX
         IYvTdPQ04yiSr+4LKwYY/fLC4IplqqSFl8kJ5O0aLobRIJOG18Air6d9JwfgpkkADEtN
         /ZoylLRxolvj77OY1bjIQL51WHlhiAl1ouvkWIRXrG+MjAxs2WpJ4//y4FdfrSIVKf0i
         DsinyM7xe00QF+HMTN305tgnazk12e6Yb9G2mTHJMyehoqqO59q4Vv6ADz174LkDZNoe
         t2BfJntlR2r4XNkfW8dHUab+MmSDknl8ue3BxJVA2+8WOoDDwmXiMEIKO2ZRJ60+EMnh
         0d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737964553; x=1738569353;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADd5QPXGRb0ZUjBZ78cLndx1ZBrU1KrHUZpnVuQhnKU=;
        b=krV6K/e3qVemhKa3/nep8KHS31MZpT71EjgzREEde7gs5RU+vAJVOoGmbYKHAd9jZd
         eRzics570zMGUDqbgYXc9ir7Vgc6bpwFfGuUbrWWIf5SNL7jUGFma6KR2dcCjpDPis/6
         /b/0H2agocAZIdIfxxk3k4DeN0GkJxAo156+gkEXOV0oB/d7pZYETOfuPmufZin4F2mC
         K2c6ftbnWm0S7QQdb+PgAJxoMUIgG1rConzj2dmRcClFhRbNvYa3Wim5k1nea2mSyvKd
         T4vTwgphtejzfbHks5qMbWkYMb2IwyirHXqaeguuKV5PQESvL4p6Tn+w746NBupeL/3+
         L1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVmTc2iiujO4KFym+m94gaJnIshBv6vvF24yIwGQCUz17SLkKU/QbHupVOhvpuw0XdsJNOwegs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5S66+fLLvkkLvHPFYphYzQQzuavSxuUoMmE4Z4kp31TGcDbV5
	fABA84s+rtTuoQ2gU6hcAdZvpbd8+aRIQQ7q8Gfv5Xu6KCmeVdT0
X-Gm-Gg: ASbGnctBjH1GdYo+GFZ1o6crhInFcp2REwAQSFaxNV126A7HrAVSe7ESTOeyqLjZ1wX
	ZDIrcFLTaj50USYnWi0YOyLLNqhYsMIUwlPYl8EmacmypmQCU+Z5QWw3dW5m5kxOt9xaeyNlTVF
	yzyb8LbA5vggWjx31W1I5cohzTBu4Jzas6bVpArJF4OyOKhqvBGgRigTrosNfhVk0tl3Bh0aZr3
	KC3JlhIQ99W89x8fY9joQQyI34cn9x4y26bn3zOip7YQwcCd9GXL+sawdNW4fnVq5cDUtqUElpf
	rEnL
X-Google-Smtp-Source: AGHT+IHlscf9pv6r0jiLUseqKU8ejlUSjBA5cQSqFQEHoIoA5Djzp67orLWMyS93LOOrQKsWadji5A==
X-Received: by 2002:a17:907:940e:b0:aae:bd36:b198 with SMTP id a640c23a62f3a-ab38b4c6a1emr3326207366b.47.1737964552729;
        Sun, 26 Jan 2025 23:55:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e11ec2sm542120066b.35.2025.01.26.23.55.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2025 23:55:51 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/vma: fix gap check for unmapped_area with VM_GROWSDOWN
Date: Mon, 27 Jan 2025 07:55:26 +0000
Message-Id: <20250127075527.16614-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250127075527.16614-1-richard.weiyang@gmail.com>
References: <20250127075527.16614-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Current unmapped_area() may fail to get the available area.

For example, we have a vma range like below:

    0123456789abcdef
      m  m  A m  m

Let's assume start_gap is 0x2000 and stack_guard_gap is 0x1000. And now
we are looking for free area with size 0x1000 within [0x2000, 0xd000].

The unmapped_area_topdown() could find address at 0x8000, while
unmapped_area() fails.

In original code before commit 3499a13168da ("mm/mmap: use maple tree
for unmapped_area{_topdown}"), the logic is:

  * find a gap with total length, including alignment
  * adjust start address with alignment

What we do now is:

  * find a gap with total length, including alignment
  * adjust start address with alignment
  * then compare the left range with total length

This is not necessary to compare with total length again after start
address adjusted.

Also, it is not correct to minus 1 here. This may not trigger an issue
in real world, since address are usually aligned with page size.

Fixes: 58c5d0d6d522 ("mm/mmap: regression fix for unmapped_area{_topdown}")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Jann Horn <jannh@google.com>
CC: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: <stable@vger.kernel.org>
---
 mm/vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3f45a245e31b..d82fdbc710b0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2668,7 +2668,7 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	gap += (info->align_offset - gap) & info->align_mask;
 	tmp = vma_next(&vmi);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
-		if (vm_start_gap(tmp) < gap + length - 1) {
+		if (vm_start_gap(tmp) < gap + info->length) {
 			low_limit = tmp->vm_end;
 			vma_iter_reset(&vmi);
 			goto retry;
-- 
2.34.1


