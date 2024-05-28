Return-Path: <stable+bounces-47566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6071F8D1BCF
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAE4B253F6
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AFD16DEA1;
	Tue, 28 May 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bp90HijQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278716D4F4
	for <stable@vger.kernel.org>; Tue, 28 May 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901011; cv=none; b=QZR/uOCYoyvvLLfT13JdWZO5+16IPYlDpB6bZk/dlxWgsdo1wE4tVNLsi4Jqg1QmmJkYwP3GfE1qLnPU85XC3Frx6GyhZD5VcaE1XdzrgPSEAkVhqi75/uyP6IXcMRIpP/7sh4WbVJFGAHlcjWevI+MGHvcpRz/clw8BI0rb43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901011; c=relaxed/simple;
	bh=t2lYJZE3I1GCMRmE8dQbZmlshZxpMe2Hp+kMcyTO3fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0gg7wLo3QffHmrHb2DXwtIcke9Yt562nftIyeikuKNHXKlpNPHLbmyuqbxqG4qWx3bEQvyHVYFGiH9o19nP/FisMo4s7woX42GM0AhhQ3EpFx3e25kRslReM+Pu5R5+g+NFtXBh86Nqp3VYcCkov7YjkhXEfKDF2/ux4noVBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bp90HijQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cc765c29so27172566b.3
        for <stable@vger.kernel.org>; Tue, 28 May 2024 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716901007; x=1717505807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKO5pF0AuV1bNrDCOnTfXew1j1QeUsaF7EgHEwrkyxQ=;
        b=Bp90HijQ4mv/oHIDqIbPUcr8FTly2F8b9NyUJi9C/mZOfQ/NkhpIwLmNQVXPaiVHwU
         tyQNDmN+4ItHSbjrSXGrCza2JXyQNR/GXK+9BGWJwpdDudf5Vd6qrajFLXyDn+bxXuJM
         S4sK4NUX8htlKHNsr3Ko51ncOVQJO+/Aj+38d86B2m+BblWfmITMqI+wXvkozrkntS46
         Zf2yxlFtx/Sqb9tBNJy1UpSKnRiGa5nzm5QjOgvqV1qlyIWciHVporSkyz7Sgq0SXtx4
         Y6yGsjpVrxqu3Qk5VFyrMCHMHjDgkZqbNfuS0StxCyPI/ilBQa+/jrYjacnlDCS6bpGQ
         QcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901007; x=1717505807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKO5pF0AuV1bNrDCOnTfXew1j1QeUsaF7EgHEwrkyxQ=;
        b=od7AsmDhJ83nex6uMbfp4fEAOJESdkeS9qnG99Ky/hOs9AWas/J/PnYZqdHDeHGoir
         Ua5sunWFEaqUWdrQ92cNswjJccV6uiPJmvwyFceidqijtB0sA3+NA8ub5aCnQhaZM6Pw
         d5yjuNqbnYoAKyE4R2TvS8LgwqmoJQgjKz7Y/dBMjiOHIAi/aQ7SonhXOJMZr3Y+o6RL
         bvVEKb2d02hJtdmgi5eZ/9/rYat1Q2mqsWMtXDFqRHP6HQTj4Fl2phdQgv8AbZJvJgWg
         qYQ8a65ueyJKuc1k8f7FIP1r2GRjaT5XJpD6S2giRAWX8tL1Lkz5zefpUoDyTB27aR9B
         4FIw==
X-Gm-Message-State: AOJu0YwZMde9fEf14JmaQJ/sTibnaUR8QH8QIZsPBWeh3TisoK2DHkV7
	fh21q7SCF3JZpt0uDmz4ypUqqYWKFNmblzKwa81YKrGXEiSaB5ih515Cdn/i8s0iPKThCyXpL5U
	t
X-Google-Smtp-Source: AGHT+IHOiGiSxeg0Z6jHmUu8nh2M1BlKRDGSc7iXkeKPNevCo2TqBxYSAtMJcUWemYo2FMUZfXtVIQ==
X-Received: by 2002:a17:906:6d88:b0:a5a:6367:7186 with SMTP id a640c23a62f3a-a626536e538mr707619866b.70.1716901007554;
        Tue, 28 May 2024 05:56:47 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8b980sm608662466b.154.2024.05.28.05.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:56:47 -0700 (PDT)
Message-ID: <293200d3-5fe8-44da-a0c3-95e6f9899670@suse.com>
Date: Tue, 28 May 2024 14:56:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/pci/xen: Fix PCIBIOS_* return code handling
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Ian Campbell <ian.campbell@citrix.com>, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
 <20240527125538.13620-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240527125538.13620-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.05.24 14:55, Ilpo Järvinen wrote:
> xen_pcifront_enable_irq() uses pci_read_config_byte() that returns
> PCIBIOS_* codes. The error handling, however, assumes the codes are
> normal errnos because it checks for < 0.
> 
> xen_pcifront_enable_irq() also returns the PCIBIOS_* code back to the
> caller but the function is used as the (*pcibios_enable_irq) function
> which should return normal errnos.
> 
> Convert the error check to plain non-zero check which works for
> PCIBIOS_* return codes and convert the PCIBIOS_* return code using
> pcibios_err_to_errno() into normal errno before returning it.
> 
> Fixes: 3f2a230caf21 ("xen: handled remapped IRQs when enabling a pcifront PCI device.")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


