Return-Path: <stable+bounces-164519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D52B0FE26
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265C2568846
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C7C147;
	Thu, 24 Jul 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZWferC0a"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114429A5;
	Thu, 24 Jul 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316714; cv=none; b=YcguRlCkeuE0f6NyI52TJHSarA5FYWFTfZSof715fmFawlNX+AnBMzbvu1mb6zt3g3fdDbtlxBfBkfDxAx4kp6cf1EAsBfCV1PONpcQ0t08Msw7MHbXncGOh84vxnxB92qWygaKg3xfg6aMhuAA/JOyRKHcy7MalvKQUa/nAj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316714; c=relaxed/simple;
	bh=cLerZr0tZ8QXPDtAFY4uTuC7HkPyf5EiiSgMN0+9LyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pk0a8QkXfoI7+50p7Fy7orpcd5MNpQJLqvZtEOdlg/XYSFMFcnIimLQmUTinthLSyjSWAoexdDWi/QN8kpFmCjKnvBKWDMtjKIII7E2N4TAvWG8fNi/jqad18NPI9FgXDMMy882hns2E708fb9w32XsGMp2R69SqsAsOvk+/d7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZWferC0a; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56O0OW3m1470900
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Jul 2025 17:24:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56O0OW3m1470900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753316674;
	bh=gLOtS/+ev6HyXuX1XCQhk3QZeKPDa68Coh1pDfdCFB8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZWferC0a/rXtsnMJll2BVlI8xLSfnjZ4gRcg5TdiE9oTAbtPNAMBMUZASl0SgH5gv
	 ti0+l634cOAfdsdBOC3tUKq8hv1spIQFkIiOWRuaDsGVsEP8IvP6KAllbb8LKfB8Np
	 Tb86fDvXldKFvBPHZ0fqJJI7QFxXBQnyNEJt4lBrHI70HUBY2jpYbK22jVpoNOIQSK
	 OdievzMnOXLyQw28idUs2fH6j+Wm3RVP3KW0EVzfY/h9Qnp7HXoqXks7pJOyUuTS+3
	 387tCKdpNVYFAS0bwZTU2vyq+jVU+JaQ/P6ooZqzrYlrgjaCvemJzKorTx9XAMVQTm
	 faJBOHp5EgPIA==
Message-ID: <a3761d4d-32a6-4822-aadc-8b8fe1b7e254@zytor.com>
Date: Wed, 23 Jul 2025 17:24:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
From: Xin Li <xin@zytor.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Xin Li <xin3.li@intel.com>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, stable@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
 <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
 <2025072347-legible-running-efbb@gregkh>
 <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>
 <0e52c9c5-006e-406b-8ae0-7f5c5273cba2@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <0e52c9c5-006e-406b-8ae0-7f5c5273cba2@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/2025 8:52 AM, Xin Li wrote:
> We need to investigate the root cause of this bug; and this seems like a
> regression caused by my patch set that automatically generates CPU 
> feature masks.

My bad, it's not caused by my patch set.

The bug is there for a long time before the patch set was merged.

And it seems we need a different patch for older Linux kernels.

Thanks!
     Xin


