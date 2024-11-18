Return-Path: <stable+bounces-93760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD09D0879
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 05:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DF281B5C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B557DA81;
	Mon, 18 Nov 2024 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwuGeCEi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673178B60
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731905539; cv=none; b=AoGx9bVefbBs7gIE8e9q1s1/kHzIHwYMGcI3zVwN0W1v+p/hZMYe9V/yamWlhbluafAwOdHa9piQmLO+C3uKjeIFODMtsLm3Hks5H38iOyWouZ8NvrBZMIHo58BWQF17O0Zftf8LncaqXFGnN+uw4N8W2Vr4/XZZmfFpArYoQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731905539; c=relaxed/simple;
	bh=nDJWB3YUAqaMjOx6/FAF1KQ9F3MqPpHJFZ04NGlRyOg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EKHCROgveMGJDDutPaf4HFDPbkE9lqG75T/l7zfP5vXiQc3YoEcbjcy/QhPXCa9Alfrg+OqiMxMXmnBOxx+ZnCI2sIIOX1Fwu25pxZ2h6sSCFX0mbM5ahZ+LD9gatgrZoIr4nJLx4/JlMLbXw0ccQ7qYrMsnEh/BjgvU56Rx07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwuGeCEi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2401582b3a.1
        for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731905537; x=1732510337; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FZ3L8/lo3GvVOyjurWEIb5G/3f7j6lpaQBqEk9rogk=;
        b=fwuGeCEiOwT5X6ar3oml/2sJ5mx7EFMhRN2oZIX5xjv9cQcBb9Mrf3wB/s15kn2VsG
         8D4zqfup6LTSzBqckVY30S/4Re7ZIcbDb1siVlopRIUi92xGBDYqMkuw4+U1ToasR2PM
         20Ly5oHuG4WIEK+bJhcq7ql1r6Dprb1ACtQs4/KaGYRAbBpmV5bPU8HoQgmnGiYrGP3z
         nUbjwpu6wE2pEaqbRr1WA4SWcr/TQCXIoTbotSl28pTPbq2EK5LZFMPPWCyhWlZWxNyf
         PEjhOXSCtiqDPkj3DKBjj1n7i3TbdD7SehhgRkCB8kOyngj5gMPelv8/ATNIMlBAYLbU
         ejpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731905537; x=1732510337;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FZ3L8/lo3GvVOyjurWEIb5G/3f7j6lpaQBqEk9rogk=;
        b=xRgBjjNx7JZ2TvCLPTlE0IlYwBo95HG0OWO6h17CjauP8W06zojQDQD0tY7wau/grE
         6DpA8XNJFqwZOLc6vBNuSnGTi+Mp0SgXyvJ6922RMsfY+cmuM+uv6+sOEgtGM9CCEvk/
         5HYix3yFxF1F4sSdtq3RxBYTxWgu0twvMJJNBUb0YOTyvsNG89NuYyq6LcDPo8pjuEgS
         h7wKwEb5ldQ7sxXUwEaIk4dLuUYewOxShTZprIMvPUV6p8krdecnKHKxzmO2pEYoTHjb
         zHukhw5RWNpYBMy3wj49zOe4gW79UrmMohtcI0dv9ZOf2ffOyyK0eGPJp91ZYp1jsSDJ
         8qWg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Hu3ZVJ9Aj38WBJJTAX0XulOoUvKV5bHZ/Iv5meRWL0JAz4P+mGjNfdC02UAjhNxQIco6VmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vsc0OIKNE2MX1ZeFG1oVmTnZPdTsg0K7LIdAWFZJz8mfip+S
	tZPhLjeGQj0pMS3QBrPUzuTDpjDxcza1cn4s3f2XSKlO3efqH/nZ2qF1M50cVg==
X-Google-Smtp-Source: AGHT+IHo7qiqB+ra6gI6r2HQcTuqiu880XHZewCcpYMM/mF1iVkfDuEq/og+3dwQEaVK1SsXcVERTw==
X-Received: by 2002:a05:6a21:9983:b0:1db:e501:682d with SMTP id adf61e73a8af0-1dc90bc88e0mr14508878637.33.1731905537185;
        Sun, 17 Nov 2024 20:52:17 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c1142sm5390493b3a.109.2024.11.17.20.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:52:15 -0800 (PST)
Date: Sun, 17 Nov 2024 20:52:04 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: akpm@linux-foundation.org, aha310510@gmail.com, chuck.lever@oracle.com, 
    hughd@google.com, stable@vger.kernel.org, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 6.1-stable tree
In-Reply-To: <2024111701-film-pantyhose-59de@gregkh>
Message-ID: <b3c9649c-59c7-a116-9477-3787159ddd48@google.com>
References: <2024111701-film-pantyhose-59de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111701-film-pantyhose-59de@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

For 6.1 please use this replacement patch:

From f6a8e058ad34f16109d54218c64e0c215bcc04fc Mon Sep 17 00:00:00 2001
From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 15 Nov 2024 16:57:24 -0800
Subject: [PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"

commit d1aa0c04294e29883d65eac6c2f72fe95cc7c049 upstream.

Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
NFS.

As Hugh commented, "added just to silence a syzbot sanitizer splat: added
where there has never been any practical problem".

Link: https://lkml.kernel.org/r/ZzdxKF39VEmXSSyN@tissot.1015granger.net [1]
Fixes: d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()")
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeongjun Park <aha310510@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0e1fbc53717d..f7c08e169e42 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1086,9 +1086,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
-	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
-	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
-- 
2.47.0.338.g60cca15819-goog

