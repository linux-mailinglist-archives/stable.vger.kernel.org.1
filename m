Return-Path: <stable+bounces-16047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D018983E8C2
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D81F24220
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60423D8;
	Sat, 27 Jan 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7OJjmH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BE635
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316683; cv=none; b=Mv7Ued+VlHob7O7Y5f3K51LMzj5PAfHvUvyBuQrrzQqJc7c7TfzpFGtqThJ25vN9wcUtJXiX92ObM6FD/jpeZJe0lPsbffWfyWQovVDGbhvf8GbjdWfBq1PAjiqmReb08qkgCmLpQK2YYERa0ls7lV6qLhtwdk+qdPei1xPIIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316683; c=relaxed/simple;
	bh=V4NyPfUpQiapPuoTC9fHj7kUIvXaueCsJm/ATacyhPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdjTn5EWK7YyykuruSEEIPvqCS4qFz22ugpKuDEeoyOGcYG+L1+kJIb5lG2n3slugQiWtoahEmR5eIhnd2yNGkRnJT5TFjmbdN+Z+JdlveAO/Wf1p4oNTMDobQ6EKUXFs/ss0vmh2cSMD/DfQuUbUGmg/ztOUGrnFJU+kgEl0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7OJjmH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D325BC433F1;
	Sat, 27 Jan 2024 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706316682;
	bh=V4NyPfUpQiapPuoTC9fHj7kUIvXaueCsJm/ATacyhPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7OJjmH10Uuw9aQJ0jsMEKTSFdxIODjXES9/ClGpIVnGW1IkAWuN5I+8/b1O7K3ms
	 rR/3T9rjF90ATYJMz18qg2OZ4ztz8tZ38mg+PTs1+Xx8ima4Wd8N2n5pch8328/Jq0
	 4uogkdBLRbsFRhmGo+TXDCNygVOEhecMMsIYK5dw=
Date: Fri, 26 Jan 2024 16:51:20 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oficerovas@altlinux.org, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>, kovalev@altlinux.org,
	nickel@altlinux.org, dutyrok@altlinux.org
Subject: Re: [PATCH 0/2] kvm: fix kmalloc bug in
 kvm_arch_prepare_memory_region on 5.10 stable kernel
Message-ID: <2024012612-stubborn-sprain-870a@gregkh>
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
 <CABgObfaoremaWjiOCFJey4EPMLt3MKbny+QuU8Gut18MxwVhCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaoremaWjiOCFJey4EPMLt3MKbny+QuU8Gut18MxwVhCg@mail.gmail.com>

On Fri, Jan 26, 2024 at 07:04:51PM +0100, Paolo Bonzini wrote:
> On Fri, Jan 26, 2024 at 11:01 AM <oficerovas@altlinux.org> wrote:
> >
> > From: Alexander Ofitserov <oficerovas@altlinux.org>
> >
> > Syzkaller hit 'WARNING: kmalloc bug in kvm_arch_prepare_memory_region' bug.
> >
> > This bug is not a vulnerability and is reproduced only when running with root privileges
> > for stable 5.10 kernel.
> >
> > Bug fixed by backported commits in next two patches.
> > [PATCH 1/2] mm: vmalloc: introduce array allocation functions
> > [PATCH 2/2] KVM: use __vcalloc for very large allocations
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks for the review, both now queued up.

greg k-h

