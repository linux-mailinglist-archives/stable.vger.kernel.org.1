Return-Path: <stable+bounces-254511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKfQKHSsFmp/oQcAu9opvQ
	(envelope-from <stable+bounces-254511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 355325E12B4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32256305861C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86FD3DF003;
	Wed, 27 May 2026 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSPDs2zB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FA3DEAD5
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870749; cv=none; b=b+PsX4h0MNz0z0TK0jateXjUmaAuXOrcsMdb4THJaDmJd1DoImhUtXQB1Cvy9/GFvzXziSmzq4heGEVSPOBeg7hUUrpYZRAY7t16MLea/L3+yrL8NxehzkauA0Jo3fMIZZlkQA0mEtGoOi0NXOAD+e5J3PE7CGOorPiira+6HRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870749; c=relaxed/simple;
	bh=cwHIjHAe8KJf/GMsGK3Swi8r1zcSw/mau5aBaAmzT30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCjxJIPRv68sB3321UpFgqzWQ1qUoLSlk17I8BEF+9tPH6yooJu3kEy2riv7O2m0Dmm2ZTiuCirIwcGSvNupU+W6DovLOUKSMvhDEIELt/7B58r6oDJYAsH+AY6CiN8menfEHx7tHHTHW69Nr2Nm/VjneTQtP5eL1WOtrzVqJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSPDs2zB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4585a116a4aso9512984f8f.3
        for <stable@vger.kernel.org>; Wed, 27 May 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870746; x=1780475546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dy1tdo3WsNXJ1hXO7TcI9ffqFZPej1pmbFWn2tPCdc=;
        b=SSPDs2zBYgZg0BihPYW2TJowzlUdzhGHkeL9ziT7Nt8egtgg0jmYAnCCYoXENdFyQq
         +D520CyTwSJNYgkfYBrbQVAq51ELthYO7eH7UNUqQ81vInyidjyY6n4Uc6noiKBiPAJg
         mrpfIW45qihGHbWeLyq8Qt6JdJ/fhxjgV379PN6FU6gQSaS5I/emIAPkmtALH+R6UVSg
         5r6/CTlLqS3+WOtrVe72/V70rqQIjrER/kud6g3xa1b7vvtoI8nK5XvNGRt/WGI3cnE9
         FiXz4K30l46YsnXIdgPNUq+qU9r0jGjDkHWGdzg0Mfmfrn+6bz73sugYJyU5w0LYyNOz
         3oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870746; x=1780475546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dy1tdo3WsNXJ1hXO7TcI9ffqFZPej1pmbFWn2tPCdc=;
        b=ZjqV2YOG9dJCJeYvLtLd4bfik5jfLXue/j6z5Z0dsu5GG8pp/tjGCx2jCEbPdGvAlw
         T3iJpScOAnMh0vWo/5rXA4YcXOuRCAGCn45RaqpZdBtA+OsbWtF5vQggh68FQuKoEsqR
         eFnQTAzplC4NIIwWcUM9zRNG9fCPS4orekURBKqT4TvCVW71QsguqWVYbJ+7jTBBXWh8
         EcUT/TKfes7fyX0972wwwkYPaWo7tdNmUq2MlZ0JnNdCS+BO7aqT1Hl2COBf9L7U/nzw
         eWLS18vAGcL14Yq/kOQsimup0FMQ2p62gxTX7PLQybGEeK7/VKOcpD2gVYgGoi3ICLow
         /DmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y67Bs4l01tZN+oOw3M89vceUD9GrilrZNbrFTRqbYz/dXAuJniUHwFVGeHY+3mTnmOPfw5ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhcuYMJrkz6CF+/7Ys7b5kKpkL5tYFJwuIwQyfQnRIj4N2rsA
	0kTvGVCQ64JrCTYcqK9zzlC4ICFFcP6jYN+8/0t/3Jn9op/jsj1pKJHz
X-Gm-Gg: Acq92OGkveL14LOAJG8nLYn0RjZ+iD5q/qQ5UuFQVVavO+/UANAl8xyI7mJJV8IjY71
	nNNygJE6T4OwhyBA+ux/Bv01rCt+JTZMIkcnBecqPA1qKkAEhIIrV0FZAG2i0riHnF5ppSr6H4N
	uMqHRntyPL9I/f9u94q6j/BN27Nn7ycxPbPzfvkmAS/112VuBfRoVI/gncBLWglOJamw95Jf2kz
	nLA09DUP2Etvg2qxmGzuC5OklzbD1giXR2ydOm8xNfRAjMI17T6ltmg2qwaXXnexdrT2UxKvLJc
	47bDwE8GTyZvTTA2k0gDxRgkeNpspSWi5WccDMvg6K+bNy7z01PP7bSA7vQUddqBhSrfsSkiOAF
	R61fogqrF5LSrk3DyDjZSIiAZDfFWDCl+BnrXav8iy2aQQtNUVcCKYtOn40EdXr6+f0902VzcfR
	ns7n/eqlX+WOURGAW/nOm/Clkir8xPX3dmkQ0=
X-Received: by 2002:a05:6000:25e3:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45eb38a6b5amr32754854f8f.35.1779870745674;
        Wed, 27 May 2026 01:32:25 -0700 (PDT)
Received: from foxbook (bfe246.neoplus.adsl.tpnet.pl. [83.28.42.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm7444880f8f.10.2026.05.27.01.32.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 May 2026 01:32:25 -0700 (PDT)
Date: Wed, 27 May 2026 10:32:21 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260527103221.7f8b15b0.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
	<20260518083339.507e24bd.michal.pecio@gmail.com>
	<CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
	<20260522110328.0d3eecd8.michal.pecio@gmail.com>
	<CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
	<20260523022944.59799d83.michal.pecio@gmail.com>
	<CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
	<20260523102815.5c05c70a.michal.pecio@gmail.com>
	<CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254511-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 355325E12B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding Intel IOMMU people.

Context:

Desnes reported xHCI issues duing crash kernel boot after SysRq
triggered panic. Turns out, the chip gets an IOMMU fault, some other
devices also do. Faulting address is a successful dma_alloc_coherent()
allocation in xhci_alloc_erst(), no evidence that it's freed before
the fault occurs. No problems during normal boot.

On Wed, 27 May 2026 00:47:53 -0300, Desnes Nunes wrote:
> # grep "alloc ERST\|free ERST\|ERST\|Device context\|fault addr" kexec-dmesg.log
> [Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f06000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f19000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [Tue May 26 08:41:57 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f1c000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [...]
> [Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: alloc ERST at
> 0x0000001075140000
> [Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: ERST deq = 64'h107513e000
> [Tue May 26 08:42:02 2026] DMAR: [DMA Read NO_PASID] Request device
> [80:14.0] fault addr 0x1075140000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> 
> ^ PS: Different address alloc on kdump though
> 
> > Otherwise, it seems you were right that you have some IOMMU problem.  
> 
> Thus, I started to investigate this front now. This time I gave some
> more attention to these dmar messages:
> 
>      [Tue May 19 08:17:49 2026] DMAR: Intel-IOMMU force enabled due to
> platform opt in
>      [Tue May 19 08:17:49 2026] DMAR: No RMRR found
>      [Tue May 19 08:17:49 2026] DMAR: No ATSR found
>      [Tue May 19 08:17:49 2026] DMAR: dmar0: Using Queued invalidation
> => [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from  
> previous kernel for dmar0
>      [Tue May 19 08:17:49 2026] DMAR: dmar1: Using Queued invalidation
> => [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from  
> previous kernel for dmar1
> 
> I started wondering if maybe on my system these translation tables
> can't be fully trusted for some reason during kdump?
> Maybe iommu is copying root_entries with the Present bit clear, and
> thus generating the fault reason 0x39?
>    -> bus 0x80's? Both ethernet and xhci_hcd fault addr were on this bus  
> 
> So, to test this theory out, I tried to disable translation and
> allocate a clean root-entry table right away if I am running a kdump
> kernel:
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e236c7ec221f..de673f34f4e1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2135,24 +2135,31 @@ static int __init init_dmars(void)
>                 if (translation_pre_enabled(iommu)) {
>                         pr_info("Translation already enabled - trying
> to copy translation structures\n");
> 
> -                       ret = copy_translation_tables(iommu);
> -                       if (ret) {
> -                               /*
> -                                * We found the IOMMU with translation
> -                                * enabled - but failed to copy over the
> -                                * old root-entry table. Try to proceed
> -                                * by disabling translation now and
> -                                * allocating a clean root-entry table.
> -                                * This might cause DMAR faults, but
> -                                * probably the dump will still succeed.
> -                                */
> -                               pr_err("Failed to copy translation
> tables from previous kernel for %s\n",
> -                                      iommu->name);
> +                       if (is_kdump_kernel()) {
> +                               pr_info("DESNES V2 IOMMU kdump kernel,
> disabilng translation and allocating clean root-entry for %s\n",
> +                                       iommu->name);
>                                 iommu_disable_translation(iommu);
>                                 clear_translation_pre_enabled(iommu);
>                         } else {
> -                               pr_info("Copied translation tables
> from previous kernel for %s\n",
> -                                       iommu->name);
> +                               ret = copy_translation_tables(iommu);
> +                               if (ret) {
> +                                       /*
> +                                        * We found the IOMMU with translation
> +                                        * enabled - but failed to copy over the
> +                                        * old root-entry table. Try to proceed
> +                                        * by disabling translation now and
> +                                        * allocating a clean root-entry table.
> +                                        * This might cause DMAR faults, but
> +                                        * probably the dump will still succeed.
> +                                        */
> +                                       pr_err("DESNES V2 Failed to
> copy translation tables from previous kernel for %s\n",
> +                                              iommu->name);
> +                                       iommu_disable_translation(iommu);
> +                                       clear_translation_pre_enabled(iommu);
> +                               } else {
> +                                       pr_info("DESNES V2 Copied
> translation tables from previous kernel for %s\n",
> +                                               iommu->name);
> +                               }
>                         }
>                 }
> 
> Didn't had time to check ERST or HSE yet, but with this I didn't had
> any DMAR faults, vmcore was collected normally and system rebooted
> smoothly afterwards:
> 
>      [Tue May 26 22:52:58 2026] DMAR: Intel-IOMMU force enabled due to
> platform opt in
>      [Tue May 26 22:52:58 2026] DMAR: No RMRR found
>      [Tue May 26 22:52:58 2026] DMAR: No ATSR found
>      [Tue May 26 22:52:58 2026] DMAR: dmar0: Using Queued invalidation
> => [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,  
> disabilng translation and allocating clean root-entry for dmar0
>      [Tue May 26 22:52:58 2026] DMAR: dmar1: Using Queued invalidation
> => [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,  
> disabilng translation and allocating clean root-entry for dmar1
> 
> Seems like a lead on this iommu front.
> 
> The funny thing is that the comment in this section literaly says that
> doing this could cause faults, but here clearing it actually seemed to
> solve them and made kdump succeed - commit
> 091d42e43d21b6ca7ec39bf5f9e17bc0bd8d4312 ("iommu/vt-d: Copy
> translation tables from old kernel")
> 
> Let me do some more tests to dump and check the root-entry table
> before clearing, as well as to check ERST allocations and HSE value,
> and I'll get back to you Michal.
> 
> Best Regards,
> 
> Desnes
> 

