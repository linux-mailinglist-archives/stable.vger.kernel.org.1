Return-Path: <stable+bounces-45661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA58CD18D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E66BB20B4A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707313BC0A;
	Thu, 23 May 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GsfsBe75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8E13BAFA
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465299; cv=none; b=tpubaVYRJh8oxn0LNDxzbnkE+LwDNcyS519x5sNOAXse2Qv4O6MIOV7GGC0ZP0Rb2GZ069nDl6WG+UBldd2cRsUUm3XV/QeWO/WCtFXH8i3KK0CkaS2HS+bGWnHfjOc/sbbVtgaKnhGc5ZI+eiNDJSXjkqLQLNLjRDMpxcMKH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465299; c=relaxed/simple;
	bh=o/p6hcHqbfbXYBZHTVEOA7+AOdESDvvQ5NesMEcReek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ3nSMCOBq+UtHKjCsKe2mZJwr1uW/7REvHO7oGHvth0OToGqgsZwPQGlDuvh+hpuOqcR4jInvFJaIE/0LZQPqQZ4458+VhtUbcJNe7I4Do+jqLyBArqAfuIMfDtZ8tbX99i5uuOy5jar15W77UrDi9LDfGs6Q8u3M326IBKc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GsfsBe75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AE6C2BD10;
	Thu, 23 May 2024 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465298;
	bh=o/p6hcHqbfbXYBZHTVEOA7+AOdESDvvQ5NesMEcReek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsfsBe75Rm97u8SbhxaFOi53icvNi9WXfzHTMPUQhSgZwIlSKjg3OKH1tp4y0TuHZ
	 WcVdUjJxW5/KByZgUeNgKATjSdyA+MREP8cyNzFCd29ew1zya5BWVYAsIahrk0mVSO
	 3/7jouEVIXBUM8o5g91qVWahvmGSW3/1jucNQJck=
Date: Thu, 23 May 2024 13:54:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, stable@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.10.y] KVM: x86: Clear "has_error_code", not
 "error_code", for RM exception injection
Message-ID: <2024052348-overhung-sulfite-caec@gregkh>
References: <2023041135-yippee-shabby-b9ad@gregkh>
 <20240510131213.21633-1-nsaenz@amazon.com>
 <Zj5AfN-kdz9UmccT@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj5AfN-kdz9UmccT@google.com>

On Fri, May 10, 2024 at 08:42:52AM -0700, Sean Christopherson wrote:
> On Fri, May 10, 2024, Nicolas Saenz Julienne wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > When injecting an exception into a vCPU in Real Mode, suppress the error
> > code by clearing the flag that tracks whether the error code is valid, not
> > by clearing the error code itself.  The "typo" was introduced by recent
> > fix for SVM's funky Paged Real Mode.
> > 
> > Opportunistically hoist the logic above the tracepoint so that the trace
> > is coherent with respect to what is actually injected (this was also the
> > behavior prior to the buggy commit).
> > 
> > Fixes: b97f07458373 ("KVM: x86: determine if an exception has an error code only when injecting it.")
> > Cc: stable@vger.kernel.org
> > Cc: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-Id: <20230322143300.2209476-2-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > (cherry picked from commit 6c41468c7c12d74843bb414fc00307ea8a6318c3)
> > [nsaenz: backport to 5.10.y]
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > 
> > Conflicts:
> > 	arch/x86/kvm/x86.c: Patch offsets had to be corrected.
> > ---
> > Testing: Kernel build and VM launch with KVM.
> > Unfortunately I don't have a repro for the issue this solves, but the
> > patch is straightforward, so I believe the testing above is good enough.
> 
> LOL, famous last words.
> 
> Acked-by: Sean Christopherson <seanjc@google.com>
> 

All now queued up, thanks.

greg k-h

