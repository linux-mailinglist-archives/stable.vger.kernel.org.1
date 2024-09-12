Return-Path: <stable+bounces-76023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18A9773EB
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 23:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448701F25634
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDD1C244C;
	Thu, 12 Sep 2024 21:54:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FD1C2424;
	Thu, 12 Sep 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178067; cv=none; b=CKNUpi8Xn7wEYwBeuOxdRnZTKJ2MryJ5pTpVH/fs7IzSIsHSVHCTi2AXSOcuyqyrtfChVn8zneCa7hIuRhPD5dgdish8XgArxiD3QmveaSLCYPZK2lOYj677mmjjmwWfpgOU7A6t1NrFBdSGS6PSp+64kyg4zL7kwa7jfbota6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178067; c=relaxed/simple;
	bh=Uucssok7TIvls+tebBseLNQG3VjlcIuDadYcy43VwnY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B83zQcR3HGcnfPUu8i5BBUj32gSbyCxIN8gLxk4gfcnIWoOr7lE0uRIX2YZtt9YoMj2eKdpw5QMKlamc3jkJ28yjdUFK6KQ4Lru7XSiIVC76RB/S2r6v9ogfbAxVo7rHhQsOMNCm2oVXp/I+DGtyKRTkgYlSt4RHWprxxtdtmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 2a0062c2;
	Thu, 12 Sep 2024 14:54:18 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:54:18 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
In-Reply-To: <2024091103-revivable-dictator-a9da@gregkh>
Message-ID: <a6392c39-e12f-e913-8f4f-c135b283ce@aaazen.com>
References: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com> <2024091103-revivable-dictator-a9da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Sep 2024, Greg Kroah-Hartman wrote:

> On Tue, Sep 10, 2024 at 03:54:18PM -0700, Richard Narron wrote:
> > Slackware 15.0 64-bit compiles and runs fine.
> > Slackware 15.0 32-bit fails to build and gives the "out of memory" error:
> >
> > cc1: out of memory allocating 180705472 bytes after a total of 284454912
> > bytes
> > ...
> > make[4]: *** [scripts/Makefile.build:289:
> > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.ho
> > st.o] Error 1
> >
> > Patching it with help from Lorenzo Stoakes allows the build to
> > run:
> > https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> >
> > And then 32-bit runs fine too.
>
> Great, please help to get that commit merged into Linus's tree and then
> I can backport it here.

Thanks to Linus and Lorenzo and Hans there is new smaller fix patch in
Linus's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/media/atomisp/pci/sh_css_frac.h?id=7c6a3a65ace70f12b27b1a27c9a69cb791dc6e91

This works with the new 5.15.167 kernel with both 32-bit (x86) and 64-bit
(x86_64) CPUs

Can this be backported?

Thanks

richard@aaazen.com

