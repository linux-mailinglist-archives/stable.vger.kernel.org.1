Return-Path: <stable+bounces-48295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67688FE704
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5541E281963
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FC1E487;
	Thu,  6 Jun 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9aOy6WI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F8364
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678960; cv=none; b=M+L5ggiAp9g1T3P5SBhzuo+Qxi7QOSJ/+rdohQbJSo3i8aS+ln04GWRI3pSCCYglxNxeptQSiIu3+izt18CGu5pWwRoDq1Hd1AkG2Xk7A8vnSTolqpi42iJETyYiKsHx9LTtUgggcSYv8/Xqhm/ce+Rz0n0G3K+ZxMzFkxMWyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678960; c=relaxed/simple;
	bh=KPHOEgcM5r3Ct63BIt1obx3psHtZe4oEQDr3vd2jN7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADcHbEvWMrU55NxF/qhdeGrlS/6QEUlQ9WspIn+yG9jRJ6jb5A1sc2m92iyp5lKbhsgmR1oAH1oViMZm5p8BN9P2jLk77Uy5o8sFekUgCVo+xH0W+MVrZthjBlmbwsppXq+qZMDZ02EB5bcf9MAHCFRZ+1UrylWozU3v1ZKqBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9aOy6WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B65C2BD10;
	Thu,  6 Jun 2024 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717678959;
	bh=KPHOEgcM5r3Ct63BIt1obx3psHtZe4oEQDr3vd2jN7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9aOy6WIb76JfXVgsG4zHxeuNp7P3SqV4mzhSqFOQbtnXRKHbk+C+XPsNOMtfiK3w
	 I/MHcKhssttbCyip2qhHE2BVJyXfL931LyFGAcwAnl0JqpiVrXsAtu25m6Mm8oPlNA
	 QsNJZsL6XCI4cK1dafIR8FNZIjmzesDIUte7a5Dk=
Date: Thu, 6 Jun 2024 15:02:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: Re: v6.6.33-rc1 build failure
Message-ID: <2024060631-zookeeper-mammary-889f@gregkh>
References: <b4cc4d63-3c68-46ba-8803-d072aad11793@sirena.org.uk>
 <Zl9f2XgKaFgS-G3i@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl9f2XgKaFgS-G3i@linux.dev>

On Tue, Jun 04, 2024 at 11:41:29AM -0700, Oliver Upton wrote:
> Hey,
> 
> Thanks for flagging this broonie.
> 
> On Tue, Jun 04, 2024 at 02:35:20PM +0100, Mark Brown wrote:
> > I'm not seeing a test mail for v6.6.33-rc1 but it's in the stable-rc git
> > and I'm seeing build failures in the KVM selftests for arm64 with it:
> > 
> > /usr/bin/ld: /build/stage/build-work/kselftest/kvm/aarch64/vgic_init.o: in funct
> > ion `test_v2_uaccess_cpuif_no_vcpus':
> > /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:388:(.text+0x
> > 1234): undefined reference to `FIELD_PREP'
> > /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> > 388:(.text+0x1244): undefined reference to `FIELD_PREP'
> > /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> > 393:(.text+0x12a4): undefined reference to `FIELD_PREP'
> > /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> > 393:(.text+0x12b4): undefined reference to `FIELD_PREP'
> > /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> > 398:(.text+0x1308): undefined reference to `FIELD_PREP'
> > 
> > due to 12237178b318fb3 ("KVM: selftests: Add test for uaccesses to
> > non-existent vgic-v2 CPUIF") which was backported from
> > 160933e330f4c5a13931d725a4d952a4b9aefa71.
> 
> Yeah, so this is likely because commit 0359c946b131 ("tools headers arm64:
> Update sysreg.h with kernel sources") upstream got this test to indirectly
> include bitfield.h. We should *not* backport the patch that fixes it,
> though.
> 
> Let's either squash in the following, or just drop the offending patch
> altogether.
> 
> -- 
> Thanks,
> Oliver
> 
> >From 5a957ab6d80f4fcb4b1f2bcbd5b999fde003bffd Mon Sep 17 00:00:00 2001
> From: Oliver Upton <oliver.upton@linux.dev>
> Date: Tue, 4 Jun 2024 18:36:29 +0000
> Subject: [PATCH] fixup! KVM: selftests: Add test for uaccesses to non-existent
>  vgic-v2 CPUIF
> 
> commit 0359c946b131 ("tools headers arm64: Update sysreg.h with kernel
> sources") upstream indirectly included bitfield.h, which is a dependency
> of this patch. Work around the situation locally by directly including
> bitfield.h in the test.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  tools/testing/selftests/kvm/aarch64/vgic_init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> index ca917c71ff60..4ac4d3ea976e 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> @@ -6,6 +6,7 @@
>   */
>  #define _GNU_SOURCE
>  #include <linux/kernel.h>
> +#include <linux/bitfield.h>
>  #include <sys/syscall.h>
>  #include <asm/kvm.h>
>  #include <asm/kvm_para.h>
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 

Thanks, I've merged this in now.

greg k-h

