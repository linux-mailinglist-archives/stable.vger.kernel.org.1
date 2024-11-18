Return-Path: <stable+bounces-93762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0149D087B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 05:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5861F215A8
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7357DA81;
	Mon, 18 Nov 2024 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNpHxkku"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C28E8
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 04:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731905732; cv=none; b=Afa86UAME8Wdchp7FV++hjjXInIKxdHCeA4eythx8oUO27nmiRgwRWzG9rhonP+Q/Zn7Sjk5Dto9qRaJJBq5OHPXcpl8HEyyo/ESsgu5e6AWKHBRcgDAxvIyTpMK5lSwtw4M+1oxTqfUMLmgMNvdYllKVEZ9nqz+EJWl/923vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731905732; c=relaxed/simple;
	bh=JLdHjcZJU0u6rquREJ2EUrF9NAVM7qlMxeRq3I8W5CM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HA9dEQuqChlBS4n7SNYo8m7IbiL/wgwMy9HjQ+Z2SKfCg3maxAAl9+Lg0slUwlts2N8kY19LOpmIrVp72LYtSWcv64WvM+zaNFCC8Hiue4pXlCutxyqd4xYtRTKX2qzl+onHBaAVEPgyXlY+0b6qy1ipTNon4o1j2gzcu4GgDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNpHxkku; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21116b187c4so8665435ad.3
        for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731905730; x=1732510530; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6vY+aSsnuaRE7lvXSjbw/Ba6Iku0uNLInPIFfnHcyo=;
        b=aNpHxkku3+AMSSp6QcTwG1H2GVA8pn8YhgD07gVusJHnZy9g41Nc80+dM8FQhr1dx6
         o8J8S3i4TmsmzwS1Sf5WZTRomim0qcBQ1QyX0XLS2NNaRkkfGZSupOhwJZScNIAYFhs1
         p4FovJK1w5ucZyendyWakt+MmnXlnmh/5NtHg5H89tCFfpGY54JzlrV8ii+/SFVoQsLO
         6lwszg9DLR/Axvqrrbs+WDMEsqlQcNZo9vWA6lpASs6L5gXNnv8V+ByvYLXPZ3DbI4N4
         h4W8yj+q8Fi9HuG7RYxroycTPHniqBSxgegnJSnpC7w9EVwR9l5m29BpHdz90OrohEN8
         7nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731905730; x=1732510530;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6vY+aSsnuaRE7lvXSjbw/Ba6Iku0uNLInPIFfnHcyo=;
        b=ERQnob0rMzO2ww7H/Czr4c+nAJAFMPhgV2/tHIbexoCFGZUWJ+kAJI/OziLbRdOqha
         E02rHpAVGnqQpJNutQGXERKCnuFrwSMbl1UyKzIw1+PpOnW3DTaaBHvvoKZ+wmCMYFgP
         4FiPibQx5Cgpji6dxQ2QN9Oi45+LIFAO+C3+BWzhK/ezRPIvMBzK86xvYD0NFlz+EjNZ
         4f+fx8J9I6fVnFUGf3Aa2XdYg2FNdu9EVKYjbr+ncQR3phYNTFKMjNi/pFUVtz04NG8U
         /like+5vzb4zYk+lCHSDqaf3UfPNBFSUWNbf0MG0rKXj1JoBcDd49XU0mo5vJbgw2cgg
         CErQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuLGtFYv86tZ4XKkJPCfPKqzeyKUWbbPe/jAXNot07Gxng02IefnnjnwhCA2FYbUKx/Ops4+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mx7N/NC6StunwOJNME4PafokitsW4eahpEJiczBG5dOkkI0j
	zcCLDykvR56nDTLV8V367g6omqUG2rc7VhxTsmgG4NRzyGwXSGJcJfaCu+iUaQVFrWT5NBpwADB
	/WQ==
X-Google-Smtp-Source: AGHT+IHfNkRKjo417tJfIU7LMPlBxNgYZAMTEQtF6yehSNTM7uxcN5HgTYUlArPNQeryaO9TJbEX5A==
X-Received: by 2002:a17:902:d4cd:b0:211:fb9c:b1ce with SMTP id d9443c01a7336-211fb9cb652mr79229265ad.17.1731905730360;
        Sun, 17 Nov 2024 20:55:30 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34f2fsm48187495ad.159.2024.11.17.20.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:55:29 -0800 (PST)
Date: Sun, 17 Nov 2024 20:55:28 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: akpm@linux-foundation.org, aha310510@gmail.com, chuck.lever@oracle.com, 
    hughd@google.com, stable@vger.kernel.org, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.10-stable tree
In-Reply-To: <2024111703-uncork-sincerity-4d6e@gregkh>
Message-ID: <a83ff8e9-6431-d237-94ec-5059c166a84f@google.com>
References: <2024111703-uncork-sincerity-4d6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111703-uncork-sincerity-4d6e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

For 5.10 and 5.4 and 4.19 please use this replacement patch:

From 98dfa72dd24347bfcbb9a60ac65ad42130ff44f5 Mon Sep 17 00:00:00 2001
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
index 8239a0beb01c..e173d83b4448 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1077,9 +1077,7 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
-	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
-	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
-- 
2.47.0.338.g60cca15819-goog

