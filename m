Return-Path: <stable+bounces-180551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B111B8573A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535DA188B83B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670E230C0EB;
	Thu, 18 Sep 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErJAgS7h"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD223B60A
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207810; cv=none; b=PnWDRdaz8Lz7eOGvq9TACLqqwkAuSyxjRpd2Wxs0eniw/9CxvGjLwB3RYvMoIQA6D2iE2nUdKu7jNobIO9Yi0delTRa9JvVNxJspnijdbKtYPR7Yh0X69DxpbnuIMCbY5saWd+MpWV6+Pj4ocaa9wIlPXbcCijDoU80I+JECi1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207810; c=relaxed/simple;
	bh=EkExrjB1v+E3308pb6pdcKo1s1yc3WIbaOoY/+f5qXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er1ajjOLSvCadENmHuPgu/MS5z44pFqQG2fqCEgxcl+nam6XnjurY0LyiM6UnUMgl1KtvFhqg8WFnK2zeSIxWodkBYpt3H+sR92p2WdYj9flXScnnQdcBZUvsmePTFA4brYBOto368p6HZI9Nftj9V0Q42jVXAuXbR2zCXUrmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErJAgS7h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
	b=ErJAgS7haUL6Caat2lOSPtQfnYKCTJtRdfRj3/eK5cLJmE7Ctz80teEOwrGb0dCdwx6CSt
	Olkwps6BrTzmJDAwI3x7YvLIVbqHVRcmiZXNdOgqeW3GGgtMLX2csPL166JCS+iXE43Zrz
	EFY5fV5TOE8svACDoOsNzjX5rcSpBJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-cki1ZoUyOJyix5yDwxVXyA-1; Thu, 18 Sep 2025 11:03:23 -0400
X-MC-Unique: cki1ZoUyOJyix5yDwxVXyA-1
X-Mimecast-MFC-AGG-ID: cki1ZoUyOJyix5yDwxVXyA_1758207802
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso7624385e9.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207802; x=1758812602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
        b=rtTSmtb9zNyL1I7f6q0456GDsAlxypxxNIdcrKLyEsVPHayoDydBYunDcNQrx+sNRD
         pZp3gVf3B4sxaWT53IUfarHBxt004N8QoB1kyF+rmwnLaJqF3epUpRqzXLueP4I/nBhw
         DzRx92IZJtkF0e53XK+b4kaQXOXKoba3wlEjbRvUovFYGFmsVe3GFhgwroWUng4G1Bel
         cD6917Zy+lGinm1EXKXKp9t+lGDYfjEmgIHSr8CZNUylDaC9kH+Q7VKW949BW8KK9bjU
         +it+XEWIQZLlI0a7mjhC/D9Vs3/CjakxhzMiwtELYRKG/eqLgM3iDum+Eh1liHslzGi3
         jzuw==
X-Forwarded-Encrypted: i=1; AJvYcCXlIG8M4zVtqf7ujwZHvrMGX1Fbkcpt1LS949kMMFCdserAzIXjErblbPgDqtUSy5M3hUhqwW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iOG6e7vcKuy7ZDKMfQQs6/V+vylg8gWaiMz53MEQn0pd1den
	7mnPR6lkIGwRsnQvsk6bT+qWNdp+qBMoXtKY9UVDDfLdWfSybdJLZG+07uc37XbmpjvELksgTos
	plCCuZX8edAiMn7/1AopSECUExUbCxrUhwldWt2NolO8inIud0s6yu0Mphw==
X-Gm-Gg: ASbGnctAVusXHvs8zJJ0QexjQXk0pzyoBG2ocbFyjKgdcoRMAfD9FtTAnYrJog2f+gv
	Vi8cy9VbMNyzqd+rZGTnOoH0QrOQWk97iNznOEbQ6FI1u/CUOuUls8W4bJDlhmjrWsWAjjKKkyV
	8GOqEPSNh67hshiXfZWnl+sWmjf1Z4QzyhX8bTzi+L87OAyWfEVnAeLSXVjBnMdMAfSWB5b+GnT
	SkjCQUMFFsZ2wEMQc70GprYQ4AAwMAz55LdXm2gY/zMDs1/4+haE6jYU/moHAMip8CVVofQ4q9C
	G+pQI+ialq+aHVZTJMu0svPZL+fnYJVZB/s=
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63892345e9.25.1758207802091;
        Thu, 18 Sep 2025 08:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXMO/8xWkfvQqlitTmfPRvJ7wLVF0bHaOOs2wJAFpxqVjxaTdhQB7sp9EBt86tb48mNkwbQ==
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63891665e9.25.1758207801215;
        Thu, 18 Sep 2025 08:03:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm45758515e9.24.2025.09.18.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:03:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918110237-mutt-send-email-mst@kernel.org>
References: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>

On Thu, Sep 18, 2025 at 10:41:44AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:
> 
>   virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)


Sorry, pls ignore, Sean Christopherson requested I drop his patches.
Will send v2 without.

> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> Sean Christopherson (3):
>       vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
>       vhost_task: Allow caller to omit handle_sigkill() callback
>       KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  arch/x86/kvm/mmu/mmu.c           |  7 +-----
>  drivers/char/virtio_console.c    |  2 +-
>  drivers/vhost/scsi.c             |  2 +-
>  drivers/vhost/vhost.c            |  2 +-
>  drivers/vhost/vringh.c           |  7 +++---
>  include/linux/sched/vhost_task.h |  1 +
>  include/linux/virtio_config.h    | 11 ++++----
>  include/uapi/linux/vduse.h       |  2 +-
>  kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
>  9 files changed, 65 insertions(+), 23 deletions(-)


