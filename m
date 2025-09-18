Return-Path: <stable+bounces-180550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F2B856E6
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A0625D39
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CE30DD26;
	Thu, 18 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xpv9dlsy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70930C0FE
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207678; cv=none; b=sEvCFSrEP5NCB8i+/6RglQXMhVy0pKumh9Ob9rNh5uy6jz2kOp+OCZ71xBwmiR30NctDdb1BUzBgXuOp9IO7ivqOlIdu6B+zb8hHgptlKXGT5hyj9Jh5jNkvcswWgQBRbfW1Y+6vnewPp7F6m0IWR6ZneOXzgORMuZzbcqNK7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207678; c=relaxed/simple;
	bh=hm0HQnFHDuepzpar3SZ/hafXRi94TxogLGocQLL+sSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onpaFi3tssSc9PqXWuABd8dj635bGBOF0v3IzPWH83tLgWQN/lxIhGmvXiSVIX1fUwAuWQDQldWNGhZAnWyoNzf+yxBQZE3plsCJLG7IbbeJiJCrV4PPf2WHgGAFQmkLlqlPohfjsMz7Jk/TYTCIPuyetj7qR7HK33IzjyEZnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xpv9dlsy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-265e92cc3aeso11668125ad.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758207676; x=1758812476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jaAVY6WwUqvQw+1OWwzrgyRuZwO/IzJmVcJETm6qRc=;
        b=Xpv9dlsyarNgBCNc5vklsSRf2570IBW2zqcBCUNUTJ2NYOWOx8GJtwF49gZyn5xlxb
         PiSdI67i+MUYY2XvxAWl17uOX6DmK0hka7gpbAjmt1ZT0sCvyDjbFwr7k0GCggAzLQpl
         /zw6G7E61p6UcOFwnoW2A+0uGqDAcEonCSB7K9GTSoTRdXhfbo8lcpkOAbyBRZFV4iXV
         twhoqGu3jP0sTZX+ia5M3nmOvtE1B2OfvYLu/ntco9YnrMeTZm94ISvwMG8AcJrNloKb
         zUZqMHta6bGFgXyGEwop7BpeKm+dqBiDGD3sLZ2sDj9fjtZoRlyFSUzQV6N9PyGZNc3N
         o1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207676; x=1758812476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jaAVY6WwUqvQw+1OWwzrgyRuZwO/IzJmVcJETm6qRc=;
        b=fy/1UJRJDZzNKfZBgGMs7/N0gUvZWXXT2yip2mOuKkthMWoOm2PJbbo4ZAMpXGY1JP
         dDXJUtQ+s/eZcqPrTPIyCg9ZegdgkLa34D6Qc3n08odHYAXpSvjI3IQux8WkC/wAsUIz
         ufp752g7C69pPqoIx1c3B4r2CUCe8GJNdKbtkBMBNmJWttmD7xaAE+Cu5BYPNca3kUE0
         fD+135MDdgnAiS8CJfag8ULmadP4oMMCQVHmEntwy4sjSXF5jmeNFWmWvemx328NSxpn
         2sMyaQ48cN/xObmTNq9uiupVnSwjcO+YbO3JUrUEgC4g7aYPQX4sQ9KtMFuQYXNnMCMW
         xmsA==
X-Forwarded-Encrypted: i=1; AJvYcCWbE18PBYUB9B6q1JvsDGZhe/EO0qOAdcROO0+upQaP5nbLlw91dMp13qRt4y2b/Du0V+A+ex4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4KXDuY9svtBuH7a8LLak1KvswIeovGxK3IBsB/MYEMv8YXsV
	omEfJUUj3F+0xX7iEfZoo1RF/FD5ow+Cc1rWX/RUEC9E5Q9egfYTsbTfldwEy9pmbQNBMFfDQh0
	MunYsow==
X-Google-Smtp-Source: AGHT+IFfK0oDh2ycr/Osr/E7Cn/yD1up1u2d31r7i+s3sYnsD2rX8bDF3WlsXIrIGTtuwXqE52kl8QvwPX0=
X-Received: from pjs1.prod.google.com ([2002:a17:90a:c01:b0:32e:ca6a:7ca9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da81:b0:269:a23e:9fd7
 with SMTP id d9443c01a7336-269a23ea2c9mr19135195ad.26.1758207676208; Thu, 18
 Sep 2025 08:01:16 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:01:14 -0700
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918104144-mutt-send-email-mst@kernel.org>
Message-ID: <aMweun6GrCSn3lDD@google.com>
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, ashwini@wisig.com, 
	filip.hejsek@gmail.com, hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com, 
	stable@vger.kernel.org, zhangjiao2@cmss.chinamobile.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
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
> 
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

Gah!  I was too slow.  syzkaller found an issue with this patch.  I _think_ I
know what's going.  If my analysis is correct (wasn't able to repro the issue,
but found a bug through inspection), then I don't think we want to take this for
6.17 as-is.

https://lore.kernel.org/all/aMwdsFGkM-tMjHwc@google.com

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
> 

