Return-Path: <stable+bounces-169919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED8B29920
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB412060AE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C7270ED2;
	Mon, 18 Aug 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJ4TIkY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A11272E68
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496330; cv=none; b=nn9UuoGnDfMxAVgx8t/juXv7+7ecyTHde989YJKEDOGGsHwnxr/iVn0e9CqYVm951LEK5jm5Z1gZS6TOCXOCI/xAuv2+K+cd+0bTghqsGMJ/VQBE+nadhWUsIB52cOfDK4aC7TMESA+682ywU+WFtChh8ITSDv6gPEt6ufYXLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496330; c=relaxed/simple;
	bh=5CKsuQdGTLRS/tKuMHAv/0cXQVwl3bhT4nd9GOJbh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzJA0FqKmLIwM5YMnkVN7aL3cv0rM7eOd9ZdI86Rbk7AegxcmlgIUocetTW2fTiCvguhdOcMZzhnTrEdxyVT6cGZb8+KbViPI47EfupA6/y7jqq/FbfebFKovKLgAzuaD9ZP7kTYr7k7tWzeD9Yy75HWKJJv9/fI5uE0d92Go/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJ4TIkY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1FFC19423;
	Mon, 18 Aug 2025 05:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755496329;
	bh=5CKsuQdGTLRS/tKuMHAv/0cXQVwl3bhT4nd9GOJbh8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ4TIkY+c97g1rHdbr1/jakbM1GTUkpK5oUI/kZb4Aj1fMLNQ7L3XB6Tg0lnvn2Ty
	 qdNCE2XVA77BClfRZksuFiLg1rNqCg2Alp+MmzqJ/Ws3YxgfC8lCf0Ng125Z4bYxRb
	 TDXycZiu1C35gCfOup7TfgC0omwO8erahKvLM8+Y=
Date: Mon, 18 Aug 2025 07:52:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: queue/5.15 kernel build failure
Message-ID: <2025081837-rascal-unsafe-d1e1@gregkh>
References: <1f29bdc8-986c-4765-ba82-9d7ca2181968@oracle.com>
 <aKI1SJ6YrFiQpR9o@laps>
 <caef2fc2-8e80-4fc8-9e88-f5d030542534@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caef2fc2-8e80-4fc8-9e88-f5d030542534@oracle.com>

On Sun, Aug 17, 2025 at 04:05:18PM -0400, Chuck Lever wrote:
> On 8/17/25 4:02 PM, Sasha Levin wrote:
> > On Sun, Aug 17, 2025 at 01:11:14PM -0400, Chuck Lever wrote:
> >> Hi-
> >>
> >> Building on RHEL 9.6, I encountered this build failure:
> >>
> >> arch/x86/kernel/smp.o: warning: objtool: fred_sysvec_reboot()+0x52:
> >> unreachable instruction
> >> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
> >> vmw_port_hb_out()+0xbf: stack state mismatch: cfa1=5+16 cfa2=4+8
> >> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
> >> vmw_port_hb_in()+0xb4: stack state mismatch: cfa1=5+16 cfa2=4+8
> >> drivers/vfio/vfio_iommu_type1.c: In function ‘vfio_pin_pages_remote’:
> >> drivers/vfio/vfio_iommu_type1.c:707:25: error: ISO C90 forbids mixed
> >> declarations and code [-Werror=declaration-after-statement]
> >>  707 |                         long req_pages = min_t(long, npage,
> >> batch->capacity);
> >>      |                         ^~~~
> >> cc1: all warnings being treated as errors
> >> gmake[2]: *** [scripts/Makefile.build:289:
> >> drivers/vfio/vfio_iommu_type1.o] Error 1
> >> gmake[1]: *** [scripts/Makefile.build:552: drivers/vfio] Error 2
> >> gmake[1]: *** Waiting for unfinished jobs....
> >> gmake: *** [Makefile:1926: drivers] Error 2
> >>
> >> Appears to be due to:
> >>
> >> commit 5c87f3aff907e72fa6759c9dc66eb609dec1815c
> > 
> > I've dropped this, thanks for the report.
> > 
> > It's a bit funny - my version of gcc treats it as a warning, and it
> > actually
> > gives me quite a few mote "mixed decrlataions" warnings in the 5.15
> > allmodconfig build.
> > 
> > Compilers are hard :)
> > 
> 
> Additional context: I copied the RHEL 9.6 /boot/config to do the build.
> I think Red Hat likes to keep the "treat warnings as errors" setting
> enabled in their builds.

It's a good warning to have, 'allmodconfig' enables it, and so my builds
show these as failures too, so you aren't alone.

thanks for pointing it out.

greg k-h

