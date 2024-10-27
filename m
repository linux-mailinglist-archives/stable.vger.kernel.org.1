Return-Path: <stable+bounces-88230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07439B1DB1
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953A4281B5C
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4947A5C;
	Sun, 27 Oct 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnR5XCp8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0014A09A
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730032450; cv=none; b=ABRz2wPRZUxT5mIDfBFN+Vjt3h/oi14gPx0ekSw1yURJ1p/9Y+5mljcrqNlwY+db88TvYxYHlWrEaRjfVY5qnlzn5LS86SjSh5O2Y4JMK5EMCqbKuAThbhiXvec2lYDtS0DC557iKuChK3/DxN3uJiVKSfR2SAGvdUHm7k2XIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730032450; c=relaxed/simple;
	bh=wIs7CJU97Ku5VoaChlOOnvThoA3A5SEB4XWLBqtx4M0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tfgQdReCmeu5R/kA3ZCiqb+Bdphoobc2cusUYZfwI3SyGSip1C03PBJ9nL1AJ0a9QfCCcc4XS7PeAUxl79eEOApiQhQ9Q4msMHb8WB/kXH8yvbBwFTt8L4ruXs1eGtwROA7D05Wf+TLXlkfZDT7zLuhI7YN+fAyveH0s0pyTcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnR5XCp8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso497113666b.1
        for <stable@vger.kernel.org>; Sun, 27 Oct 2024 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730032446; x=1730637246; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7UJg7CptzscS9Fr/jO4VfwyEb8teWcA+vqkElKWHVg=;
        b=mnR5XCp8Gn8fiqJasKL3lvIJOo3Sj5Xk9T7H6ltRozPTuOjEv1nhW8pe96CVTeWjrO
         TTXfiKVmuUBnEzZJa7tNDjkmIzQx35+8kaAxxkGarCFlbc4/gr4AhkXsUZYvP1evw/pO
         ECT2/yz9or6wQ6tBg4YDx3KKU/UsUdtFt7z8kdnWE84rw8h1HYjGH8b9E9xwJo7NcMxR
         U7F7pWq9lxFmWuMdyTdsEHWuxegm2nekE0tRJSdlAnp1KW/tjFFJxVvRn6YTv7udW7tc
         NfBtuEgsaYg5U66D1UnG47afQ0cpDN8Ksa+l2SuhO0xwEQk6GS8sWeO66/3By18uGUqv
         cOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730032446; x=1730637246;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7UJg7CptzscS9Fr/jO4VfwyEb8teWcA+vqkElKWHVg=;
        b=aC9aQSWFqVgOwCkUZMSSraXXgR0ybf9QqnlKtMMMq/vBCAsLJOq/7GOuEztcHbTI1x
         aI0OFKxokoqfCQKKHg5sMHcFIvXmsg/56oUVv2iEuJODDTS8B39sBfzzx847Jw4jARhM
         XF0lYQuXH6B1hhn3lXy0MxXNEYQnsxV7N5pFnEfewngxYW+aVgg5mZKeM2+fvRNcCIkB
         plSJsHlpPwpCZNOpyPXn8DK556Hes5YwmBYWXykSWnSRkFT4kECgs+O9Du5TBFnAX0ra
         ZU1wkxpp5zBgHf/JluL++idJ1EXx0ls5WwE80bvfxX+R1SmEV3KuDBD2LAQh9QBig4Tz
         N2cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKNuW5ixAn8TkfIxN3v28ap6urBLoamKSxGtAaByd90L3GLx7iGTus7sll0siBlALTYRvU73c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgtgBJRcvDBO8ZGscjzA79ktiqZ1xu0QTulnawFtnJlqxqGYb
	PLXBnSJMjUOCx8AJzk4c/bA9JUIL3yxep7W9SEWdAcpy0RzP4s6a
X-Google-Smtp-Source: AGHT+IE9vgA8d0uwAw7Ke3lr7wIhuoX3KLIoobOll5sgPrOrrug9juMea6m7DhuV1YElfcjhZdywMQ==
X-Received: by 2002:a17:907:6d0d:b0:a9a:147d:fe9c with SMTP id a640c23a62f3a-a9de61d5d59mr458423366b.43.1730032446143;
        Sun, 27 Oct 2024 05:34:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086f6dsm272539466b.214.2024.10.27.05.34.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2024 05:34:05 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Jann Horn <jannh@google.com>,
	stable@vger.kernel.org
Subject: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Date: Sun, 27 Oct 2024 12:33:21 +0000
Message-Id: <20241027123321.19511-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
pattern for mprotect() et al."), if vma_modify_flags() return error, the
vma is set to an error code. This will lead to an invalid prev be
returned.

Generally this shouldn't matter as the caller should treat an error as
indicating state is now invalidated, however unfortunately
apply_mlockall_flags() does not check for errors and assumes that
mlock_fixup() correctly maintains prev even if an error were to occur.

This patch fixes that assumption.

[lorenzo: provide a better fix and rephrase the log]

Fixes: 94d7d9233951 ("mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.")

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>

---
v2: 
   rearrange the fix and change log per Lorenzo's suggestion
   add fix tag and cc stable

---
 mm/mlock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index e3e3dc2b2956..cde076fa7d5e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -725,14 +725,17 @@ static int apply_mlockall_flags(int flags)
 	}
 
 	for_each_vma(vmi, vma) {
+		int error;
 		vm_flags_t newflags;
 
 		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
 		newflags |= to_add;
 
-		/* Ignore errors */
-		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
-			    newflags);
+		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
+				    newflags);
+		/* Ignore errors, but prev needs fixing up. */
+		if (error)
+			prev = vma;
 		cond_resched();
 	}
 out:
-- 
2.34.1


