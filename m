Return-Path: <stable+bounces-87666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06B9A97EC
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 06:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200E21C231EC
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647C811F1;
	Tue, 22 Oct 2024 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFbYyg3Y"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813F7581F
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729571629; cv=none; b=TD1ZPC0r/9O2SsvJRxAmN5vDdTZB0AGc1AJ1KBjtEcZQpWM1VEcIadszWmleLW7hbrjoO41slC+MS02YSpA4YOEb8B7QnMifB4bo8lc3DcNmI7drVYDUYfeC7EwVNtn2F8XxNIe3aho17gMpHFKWSbJvf8s8pmCwLCLEzbjH9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729571629; c=relaxed/simple;
	bh=Sa3oORQqqGKaLUUCrGj70IwTcSiY1Q9b956Lzj6Bt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZHaI1YkBgXgXBNDV0ykgYoAPcewlG7uWi0oWGm8cGMTyR8WGV7INGFiCVXA2+m0la1g3mzpIO4j1pd+2/4wlWGbomUxpoYJd1vPU/Nn2NzdWRrvb/e5Pi44Dwzz71gwAAlZ2n3STHuZVL3svxkg+isHryeqTLijqKFZCWCdVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFbYyg3Y; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 04:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729571625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYudzfRvqnvDrVSQ5OS6WPxzQKmU/bqfR5hedKDTCKM=;
	b=dFbYyg3YUK5pfW0S+Y1TI21U+iPDscaGB1HzfEXFatq9rMNJJkVi2nG+DQwaJrcRBYZI1H
	Th850TVnIIpBYxQnhBBV8zJSSE/GpQJ1k2DzyQ2uEpuY2XRhmD5TkrwsTOlNmi0g0KJFIq
	JrPZwYPHeuKYoKW+vmq6/+QruuYEul4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZxcrJHtIGckMo9Ni@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org>
 <ZxcKjwhMKmnHTX8Q@google.com>
 <ZxcgR46zpW8uVKrt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxcgR46zpW8uVKrt@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 04:47:19AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 22, 2024 at 02:14:39AM +0000, Roman Gushchin wrote:
> > On Mon, Oct 21, 2024 at 09:34:24PM +0100, Matthew Wilcox wrote:
> > > On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > > > Fix it by moving the mlocked flag clearance down to
> > > > free_page_prepare().
> > > 
> > > Urgh, I don't like this new reference to folio in free_pages_prepare().
> > > It feels like a layering violation.  I'll think about where else we
> > > could put this.
> > 
> > I agree, but it feels like it needs quite some work to do it in a nicer way,
> > no way it can be backported to older kernels. As for this fix, I don't
> > have better ideas...
> 
> Well, what is KVM doing that causes this page to get mapped to userspace?
> Don't tell me to look at the reproducer as it is 403 Forbidden.  All I
> can tell is that it's freed with vfree().
> 
> Is it from kvm_dirty_ring_get_page()?  That looks like the obvious thing,
> but I'd hate to spend a lot of time on it and then discover I was looking
> at the wrong thing.

One of the pages is vcpu->run, others belong to kvm->coalesced_mmio_ring.

Here is the reproducer:

#define _GNU_SOURCE

#include <endian.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_mlock2
#define __NR_mlock2 325
#endif

uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};

#ifndef KVM_CREATE_VM
#define KVM_CREATE_VM 0xae01
#endif

#ifndef KVM_CREATE_VCPU
#define KVM_CREATE_VCPU 0xae41
#endif

int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  intptr_t res = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/"/dev/kvm",
                /*flags=*/0, /*mode=*/0);
  if (res != -1)
    r[0] = res;
  res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/KVM_CREATE_VM, /*type=*/0ul);
  if (res != -1)
    r[1] = res;
  res = syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/KVM_CREATE_VCPU, /*id=*/0ul);
  if (res != -1)
    r[2] = res;
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xb36000ul,
          /*prot=PROT_SEM|PROT_WRITE|PROT_READ|PROT_EXEC*/ 0xful,
          /*flags=MAP_FIXED|MAP_SHARED*/ 0x11ul, /*fd=*/r[2], /*offset=*/0ul);
  syscall(__NR_mlock2, /*addr=*/0x20000000ul, /*size=*/0x400000ul,
          /*flags=*/0ul);
  syscall(__NR_mremap, /*addr=*/0x200ab000ul, /*len=*/0x1000ul,
          /*newlen=*/0x1000ul,
          /*flags=MREMAP_DONTUNMAP|MREMAP_FIXED|MREMAP_MAYMOVE*/ 7ul,
          /*newaddr=*/0x20ffc000ul);
  return 0;
}

