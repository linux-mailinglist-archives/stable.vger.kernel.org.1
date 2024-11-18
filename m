Return-Path: <stable+bounces-93761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B609E9D087A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 05:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B4DB2115A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 04:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7E7DA81;
	Mon, 18 Nov 2024 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX60CQtD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01128E8
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731905601; cv=none; b=gZhMbbco7r4tXV+VX+Yjxh2piYpxc8yuXBIfCvSwwsChZbKauEASKNnMj7sDjhBogTQSFdqKgY4TctQbuKb9ZvgX5cv/j0g4EnpXZ6NIW6DivbiIlqgAq5OemqbuMo3lRcvZ6BrfQD8CxvVXUCN94KoYIJpve2JxkRJkIc4tblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731905601; c=relaxed/simple;
	bh=9kcG2ckhrrpy7SQinGIk2pjWe+fFBKDvTOvgxUXo8Jc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AWKBMzRPEnKnY4wkKpa4TBfGR0d6ltjRJ2266JeOxyd/3ySoEReqVhg4qBu4M7fKzRGwmxaAq34p4A8i+f0Ys5tnnh9pz9SMtfRcush3xjwQjGhSK6fK60HeWt5S1MRdE7af2UlMGowDCobo38vwhTDaxgaQLZoMXm6HQF9Qa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX60CQtD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-211c1bd70f6so27039745ad.0
        for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731905600; x=1732510400; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHeERZAknwemQpzWI3pi2Cp+Ti/hO/9f+w1YiT3hr6U=;
        b=iX60CQtDaUMsjl6tj1DR2ZIu0uTtMY6Ktk93zP9pW65AHeTWT+gpoaFFRESqfW8dqH
         TjPRPOze2x5B2EbT0mYpLyyO+9QwIlaz+Fo6NDF0bJ4YA88erGIDBv6QzkYYS+892H7P
         /KqZSFHrpOeT3g3VGLQi6kAbLBCxYo2FR9jBGBO6RIbJr7qxt6Mr8JvwV0JxTHbYp76K
         /O6wk+PgLTCqu7yZZNjS4GJcVcqaAWxsZlZY80Cr4Qf7HkTG0AtB9SkX0i2xP+bWW2mx
         KFh58Pg89JW54BkvHrf5KN5qo0U3Kn5haV4yad59159BZkLQ+O6GcmiJ5Cnde+FNwIsV
         JwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731905600; x=1732510400;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHeERZAknwemQpzWI3pi2Cp+Ti/hO/9f+w1YiT3hr6U=;
        b=MReFAxYJuD9O+W9Rb/0906z1XYwqYfE1Vafg1Vf9C1J6qbcZpzU+KHv/YwvjZPcflK
         wODQfuH9yyW1YvI4/tBlmnBitMJUWgKYQoH9v2LfkLJnul38fA3D3xLZBoCUX3xAoFYx
         flCnUyIW0S+JzaQ5EQkwGBntqNZfNyxAAXrWl3qk2vRcYKnRGglwqAjyGAHDCoTmc3nz
         w24I5pIl6JhcEEbJ4Ak4cHnJko5UbtQqjmnvxU0WnupzGHqSNqbTiPmm4glyTJOCUhQI
         nD/C2xZAN1xRxG+RvDtTUqiRc3ivreaxTcS8vXCqh5p+a78BKGinwNwy9MeBHqUca8CU
         8FAA==
X-Forwarded-Encrypted: i=1; AJvYcCXEnid2Sk4dhNk9urhJY489OZPEia+AUXoKP0Bgb0wsx6/h4vIW65k2459eLn+1ON7SPdAoNkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wTN3SNUaKuuajWHkSUZaSkxEXTM45rM+lCMa1V8qn9jvbEaB
	UMcNQmNm0N/alI4a0qJ0DEevYXm6G8r8kh5EMJZCzQgJyigmDlz3THnJmkOiOA==
X-Google-Smtp-Source: AGHT+IFqteQpaSMnvlHhaRUyJyBok6kQjOB0iu4EazYg/GDSUuyC61NqacxVWVgzM5VnTXM8CCRLAA==
X-Received: by 2002:a17:902:d4cf:b0:211:f10e:2dc1 with SMTP id d9443c01a7336-211f10e3491mr67692665ad.3.1731905599606;
        Sun, 17 Nov 2024 20:53:19 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e201fsm5254911b3a.151.2024.11.17.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:53:18 -0800 (PST)
Date: Sun, 17 Nov 2024 20:53:17 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: akpm@linux-foundation.org, aha310510@gmail.com, chuck.lever@oracle.com, 
    hughd@google.com, stable@vger.kernel.org, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.15-stable tree
In-Reply-To: <2024111702-gonad-immobile-513e@gregkh>
Message-ID: <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
References: <2024111702-gonad-immobile-513e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111702-gonad-immobile-513e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

For 5.15 please use this replacement patch:

From 975b740a6d720fdf478e9238b65fa96e9b5d631a Mon Sep 17 00:00:00 2001
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
index cdb169348ba9..663fb117cd87 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1077,9 +1077,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
-	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
-	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
-- 
2.47.0.338.g60cca15819-goog

