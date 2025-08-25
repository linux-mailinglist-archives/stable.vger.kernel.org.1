Return-Path: <stable+bounces-172771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53DB3347B
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 05:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9827AD83A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 03:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392A23BCF8;
	Mon, 25 Aug 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MapA4Qaj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CA18FC91;
	Mon, 25 Aug 2025 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092474; cv=none; b=ULuc6xElAIsarPd2oWVQRX1vE0cNPSc7SOV6eCS8eqTUGXX4BxsbLkxz2cgV62K3C1AxQPrPk2HmZ5zevgN8v2A3utbJnukf72j6pAo+3bhRtGk4AhvqejYwOht50HeO2Io2QlVbqe1bAHomX6hR4JwKTKkRj6mxj00Gy4fWU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092474; c=relaxed/simple;
	bh=nUxe3lSxwuyyKWXdqrX6byaN+Kz7apsi4XZf32m/e3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os2zfFOJBeLLQNfVZg9lO40lOT64k8IstDRXSI9oeVIn3BAsT3XlZiGoUDrqmvUFljXIzj0doUwCQUnXZ371uTmJzTF3ejnM0LMP1JtWsTfa5YKuJKMLETAIGSq7Pcu1O1ZYL8UFnPJP7lS7xNX0VFMDU625w9SFRDz30/azBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MapA4Qaj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso1489346f8f.0;
        Sun, 24 Aug 2025 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756092471; x=1756697271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jerr00v6pjlEVXRP5Dl23B9B9cCcjX8VSV7tuhNw5dk=;
        b=MapA4QajtaD9eiAMqSEwm4HgIZ5OypZGRsOBnPR86ANBSxSQzgDIm8/8smSDwGUqZd
         zzOB8ECuPX507rCIqds/DwTPWy+1fzLRijGl5aHZuy+PA+1s9e6Vx5xng63xTXdFBqFp
         6V27AJL+f+6H0vQyOKe63oaKCdyE6hj3B+Bs8PvlHXOb+Tthj+nBlnnsBoGrTKA3l1yg
         C89qRE3iue3cuEGbwiUl73Qj8rwWYf3Nx8dSL+zL7+rIcP0lVtC9qsGb8WC70/qYjwow
         v746A1y09AMIomOglbm6JA8AkcgUGwW1+AiHeUznDb0r9mmgdYWlPqK/Qz0tnpvSbL9J
         aqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092471; x=1756697271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jerr00v6pjlEVXRP5Dl23B9B9cCcjX8VSV7tuhNw5dk=;
        b=po70ZakFSKuh24TN7AKlwqXOekdW8wnHs8oE6i8rcBiLK1fgzmCd7Rr42jRW+ikZXZ
         sjLBJR0JU7ZZmeyM00SIO8UMrvrClPEbL4Rw8bJtlggAJs3VrKbApDx7CsGteAY3fntQ
         UpxKKWy0gMoD9pMIF0cRP9IZ+nRaUkiJmgd6r+fkoV4hdoEJQOzPd/jOKfle7HcYtWyC
         TSm8mHMbtkNsH0Mm5z45AFrqiSFFzAPBy+4fg9xbuQtobrvxnXkxEIQNw8yRNj3bHYlf
         DfcDl07QfbYnvYGtt8r43qbAYps9cYav5fk7o8GHA87k8l0Z0ohovyCD2mCknVqAVXRW
         9oRg==
X-Forwarded-Encrypted: i=1; AJvYcCWqgPITBaNz7gmJ+am++Y3cQaW4EVWb0c7Fg7r3BCOiKyr8a5ri330fPqIvitts3eXx0G72pSoSNsgKcc8=@vger.kernel.org, AJvYcCX9a3ubQdJLsaZHQBuepJfTUIxrvgQN+OmA6csM0JmxFVe3JYQyp9h8VwauPqJEkpDGEmdZTPed@vger.kernel.org
X-Gm-Message-State: AOJu0YyzluzClP0+avF61k/LupZimVIhmu8zAXeWRXF3QYBIQtXPsbki
	aa1rWycubzGP87ll8Usa7HBrtxS03TrYQ7vDciX+IVdEW7A6rsUTqp3n
X-Gm-Gg: ASbGncvqSiLzbhyNL1eRmjEY3gMHsMc4T6KHcb0o9f+ms+OTeqsEf0L7XNz7v+TM31R
	ZCMTqYZvvRjnMPPIILekVohLfTSLxInGw8H8wBMO1eBA6tCpeBOEweNJ6qxKn/lopGCBNc50KIa
	2VlFZLqd13tJOxwYoXtvaduoddewQpZipxH2H4DTCJ4ZmtiknSrpxoYObulwl2+xZvuhfoFnQf9
	PI2P7BXn3VLMi+o2s4Lflx3B3nOsaipXZU8ui5OemKD3pkSBIgJJavWSNf33VzZhmF8DIedEzEo
	mso3+3LeEj0PjZ7bTnNS8vGARyHdAmYgdZisbPx7bUvjHq7w1jIRYwTSAAnTqyPsrhv7lofAlq0
	NPUUHyvyqN84=
X-Google-Smtp-Source: AGHT+IH5v4zWHRqDVHmkLqW/uf+Xt5VdTLSGqts9jlByiTv9ftfD5HIUCezlI9NHZqMoOMQWCAbb3Q==
X-Received: by 2002:a05:6000:238a:b0:3b6:1a8c:569f with SMTP id ffacd0b85a97d-3c5dac171cemr7429530f8f.1.1756092471145;
        Sun, 24 Aug 2025 20:27:51 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1397sm9533947f8f.49.2025.08.24.20.27.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Aug 2025 20:27:50 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: fthain@linux-m68k.org
Cc: akpm@linux-foundation.org,
	geert@linux-m68k.org,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	oak@helsinkinet.fi,
	peterz@infradead.org,
	stable@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Date: Mon, 25 Aug 2025 11:27:43 +0800
Message-ID: <20250825032743.80641-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Finn,

Nice work, thanks for your patch!

On 2025/8/25 10:03, Finn Thain wrote:
> Some recent commits incorrectly assumed the natural alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have failed
> on Linux/cris also). This leads to spurious warnings from the hang check
> code. Fix this bug by adding the necessary 'aligned' attribute.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Eero Tamminen <oak@helsinkinet.fi>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: stable@vger.kernel.org
> Reported-by: Eero Tamminen <oak@helsinkinet.fi>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
> the other architectures naturally align ints already so I'm expecting to
> see no effect there.

Yeah, it is the correct approach for the spurious warnings on architectures
like m68k, where the natural alignment of types can be less than 4 bytes.

> ---
>   include/linux/types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6dfdb8e8e4c3..cd5b2b0f4b02 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
>   typedef unsigned long irq_hw_number_t;
>   
>   typedef struct {
> -	int counter;
> +	int counter __aligned(sizeof(int));
>   } atomic_t;
>   
>   #define ATOMIC_INIT(i) { (i) }

However, as we've seen from the kernel test robot's report on mt6660_chip,
this won't solve the cases where a lock is forced to be unaligned by
#pragma pack(1). That will still trigger warnings, IIUC.

Perhaps we should also apply the follwoing?

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index 34e615c76ca5..940f8f3558f6 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -45,7 +45,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
 	 * without writing anything.
 	 */
-	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
+	if (lock_ptr & BLOCKER_TYPE_MASK)
 		return;

 	WRITE_ONCE(current->blocker, lock_ptr | type);
@@ -53,8 +53,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)

 static inline void hung_task_clear_blocker(void)
 {
-	WARN_ON_ONCE(!READ_ONCE(current->blocker));
-
 	WRITE_ONCE(current->blocker, 0UL);
 }

Let the feature gracefully do nothing on that ;)

