Return-Path: <stable+bounces-225661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZXFAtSuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:55:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BF29F5C4
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6428F308F8DF
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD83E6DEE;
	Mon, 16 Mar 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7Tqo6HE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E43E6DD6;
	Mon, 16 Mar 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687167; cv=none; b=Fw5VCgTnf2rvgSa+JSqMgu1o9xn/k0eIco1cPyXghKH0fF6HnYfl7QQR3A373vJBn5nLGFPoHHRnqU3+NjGUftpsb6RyiX60VDLJlYzcEGziSha8CEz7/LIsVRZ4XWi6YHnYOJm18EDPnjBpOmsiA6MjAHCrTFs9gEr4FTNF21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687167; c=relaxed/simple;
	bh=X2WRgow73IXJgxoQWmrjEMGdBEIYvdEfm5UJNxPJNZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNpTlQ/Gfn8aJIdyQYgBTq7o/7rLrBZrsewYC7EnDE9FEOxh8rz7wqxV2E/Ht1gYn7n3YW/V76uuHiQdbrTXAujMWqHIgsDtG38Z5Fx1UFy27aBC5wV7KReyAZdIIZCXY2yAp7pSNcfzHAqC7sOFaPELz44QkmdsnaEdSsfBaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7Tqo6HE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773687166; x=1805223166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X2WRgow73IXJgxoQWmrjEMGdBEIYvdEfm5UJNxPJNZQ=;
  b=h7Tqo6HEejjUqdVshbpQFqcSvs1UH46CMTvJCiJCv5hF2c5JaVyfbGi9
   byKBpaLz0hsblFRuU1MNv84r8pexUw0PdfnG0eVJaPibdG9eCS5kW9aUm
   CQodwV5RDgUpT1Zj9VL+ntFyxoO+U/UXIoYaUGy+w6Fe8o/2LvhMBPRJa
   X81D6oHYmY5mMUrjOg15gn1E9SSmOPi/T1DtCALM8HUsWoF6msbZcpSkr
   galDOHCLt8z025nbDoN2F7Ubb0OB61qaa+ohycPiP8caJImFYFWTH4ue7
   Lir19gD9oxlS4ScYEIUd2xaqZ/ce1CtgQbSuv9XrPTojM2mpxZ2tiwbN5
   Q==;
X-CSE-ConnectionGUID: QF5hZy2nTe2k2jWfbts4jw==
X-CSE-MsgGUID: EfejeFGZQACKND65gewAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86068646"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86068646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:52:45 -0700
X-CSE-ConnectionGUID: MEVmIqu5RwawiTzdLyaIQQ==
X-CSE-MsgGUID: 5oi9YWQaS/uORmMZVA7DMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252522056"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:52:43 -0700
Message-ID: <378be028-fb82-4208-85e8-f47dfd424515@intel.com>
Date: Mon, 16 Mar 2026 11:52:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vfio: Fix VLA initialisation in
 vfio_pci_irq_set()
To: mhonap@nvidia.com, dmatlack@google.com, alwilliamson@nvidia.com,
 ankita@nvidia.com
Cc: kjaju@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260316182025.3383443-1-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260316182025.3383443-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-225661-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: AD2BF29F5C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/26 11:20 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> C does not permit an initialiser expression on a variable-length array
> (C99 Section 6.7.9 constraint: "The type of the entity to be initialized
> shall not be a variable length array type").
> 
> vfio_pci_irq_set() declared:
> 
>       u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> 
> where `count` is a runtime function parameter, making `buf` a VLA.
> 
> GCC rejects this with (tried with GCC-9.4.0):
> 
>       error: variable-sized object may not be initialized
> 
> Fix by removing the `= {}` initialiser and inserting an explicit
> memset() immediately after the declaration.  memset() on a VLA is
> perfectly legal and achieves the same zero-initialisation on all
> conforming C implementations.
> 
> This fix is self-contained: it touches only the existing vfio selftest
> helper library and carries no dependency on any other patch.  It was
> originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
> RFC series [1] but belongs on the vfio list independently, as noted by
> Dave Jiang.
> 
> [1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com/
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Jiang <dave.jiang@intel.com>

You can drop this tag. I didn't suggest the changes. It's your patch. :)
 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fac4c0ecadef..3258e814f450 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -26,8 +26,10 @@
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> +	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
>  	struct vfio_irq_set *irq = (void *)&buf;
> +
> +	memset(buf, 0, sizeof(buf));
>  	int *irq_fds = (void *)&irq->data;
> 
>  	irq->argsz = sizeof(buf);
> --
> 2.25.1
> 


