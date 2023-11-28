Return-Path: <stable+bounces-2933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC347FC451
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779D5B21437
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A646BB5;
	Tue, 28 Nov 2023 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+J20q1a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4646BA0
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 19:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0837BC433C8;
	Tue, 28 Nov 2023 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701200133;
	bh=lxc7+yRR93qS43z9K3jLP0pjuyVV1/PH37ubYpkeJjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+J20q1ahFdYIqMF33WkHv4iP590yKV0Nvn2zy/SbIWQyLUiqGrd+KYXCDPpmIJfK
	 GUFNGPFgwdt/8mZBchGXzwWjzsm1ija/z9rnxNzvBWXM2PCkKZ0+elbp+Qd2a1jKeH
	 CFgo10876cHuOk9eSGLbfzPbxcVLUBAQP8t9IBsI=
Date: Tue, 28 Nov 2023 19:35:30 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.1.64
Message-ID: <2023112843-strep-goliath-875c@gregkh>
References: <2023112826-glitter-onion-8533@gregkh>
 <7f07bb2d-bb00-4774-8cc0-d66b7210380c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f07bb2d-bb00-4774-8cc0-d66b7210380c@gmail.com>

On Tue, Nov 28, 2023 at 08:22:22PM +0100, François Valenduc wrote:
> Build fails on my baremetal server on scaleway:
> 
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:215:20: note: previous definition of
> ‘evmptr_is_valid’ with type ‘bool(u64)’ {aka ‘_Bool(long long unsigned
> int)’}
>   215 | static inline bool evmptr_is_valid(u64 evmptr)
>       |                    ^~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:55:
> arch/x86/kvm/vmx/hyperv.h:184:6: error: redeclaration of ‘enum
> nested_evmptrld_status’
>   184 | enum nested_evmptrld_status {
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:220:6: note: originally defined here
>   220 | enum nested_evmptrld_status {
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:55:
> arch/x86/kvm/vmx/hyperv.h:185:9: error: redeclaration of enumerator
> ‘EVMPTRLD_DISABLED’
>   185 |         EVMPTRLD_DISABLED,
>       |         ^~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:221:9: note: previous definition of
> ‘EVMPTRLD_DISABLED’ with type ‘enum nested_evmptrld_status’
>   221 |         EVMPTRLD_DISABLED,
>       |         ^~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:55:
> arch/x86/kvm/vmx/hyperv.h:186:9: error: redeclaration of enumerator
> ‘EVMPTRLD_SUCCEEDED’
>   186 |         EVMPTRLD_SUCCEEDED,
>       |         ^~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:222:9: note: previous definition of
> ‘EVMPTRLD_SUCCEEDED’ with type ‘enum nested_evmptrld_status’
>   222 |         EVMPTRLD_SUCCEEDED,
>       |         ^~~~~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:55:
> arch/x86/kvm/vmx/hyperv.h:187:9: error: redeclaration of enumerator
> ‘EVMPTRLD_VMFAIL’
>   187 |         EVMPTRLD_VMFAIL,
>       |         ^~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:223:9: note: previous definition of
> ‘EVMPTRLD_VMFAIL’ with type ‘enum nested_evmptrld_status’
>   223 |         EVMPTRLD_VMFAIL,
>       |         ^~~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:55:
> arch/x86/kvm/vmx/hyperv.h:188:9: error: redeclaration of enumerator
> ‘EVMPTRLD_ERROR’
>   188 |         EVMPTRLD_ERROR,
>       |         ^~~~~~~~~~~~~~
> In file included from arch/x86/kvm/vmx/vmx.c:54:
> arch/x86/kvm/vmx/evmcs.h:224:9: note: previous definition of
> ‘EVMPTRLD_ERROR’ with type ‘enum nested_evmptrld_status’
>   224 |         EVMPTRLD_ERROR,
>       |         ^~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
> make[2]: *** [scripts/Makefile.build:500: arch/x86/kvm] Error 2
> make[1]: *** [scripts/Makefile.build:500: arch/x86] Error 2
> 
> The configuration file is attached. Kernel 6.1.62 compiled fine.
> Does somebody have an idea about this ?

I just tried your .config file here and it builds just fine for 6.1.64,
what version of gcc are you using that causes failures?  I tried gcc-12
successfully.

thanks,

greg k-h

