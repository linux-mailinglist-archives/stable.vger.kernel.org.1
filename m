Return-Path: <stable+bounces-223309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCHTIm1pqmlORAEAu9opvQ
	(envelope-from <stable+bounces-223309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:43:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0A21BC6A
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E153046BA5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19936CE1E;
	Fri,  6 Mar 2026 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SNQEI8pl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940036D9FB
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775741; cv=none; b=kKwktR3KOI9Cz2SWCG4xolrMC9HOpOBp9oHJiF+WwEDnK+bV8qHbs+gmWLAEJerLAVS/nJwXhsfSExwx6vuWC64qJAnT/1iBUUSxTye99FhOKGu3rhuvYZKeHUW6P7V2zUVqDXx4QY/zA19Y/X8SNeQFKQW+6PfycTVL0FkPovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775741; c=relaxed/simple;
	bh=lHtClqQODz2/glyZK4vJ7nvGDP7fzlPgPf1O3N4lSZs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pofz+yumIDdjC0ccBeCnT4iywT6YlMTL8Etb5JakcstRDixNimf+B5B+6vOMOq7u6iwyB3RjiJpwJGiJ2Bzcu6pqMVA9hK3xVzXsFzNdfnTiThR0xnv3Y98UHrnrQdtGeP4oWtnBu/5uersnFiwHQra/XhdJPmQgDW3zcWNYj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SNQEI8pl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483bd7354efso115649025e9.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 21:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772775738; x=1773380538; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXuimAwpOjteei+zeJ3XJ05LznjxPAq8p3+xtzsfeMg=;
        b=SNQEI8pll2W2z1N+M9dJzKPobfNuQg/1v+xQrq0XfWh555sEdx8V4GpbIvkDFsmF89
         gbpAqL422/MbXydQbs61yMIkaLlXvyNkh5cJO7z265PcIP1srBvGzjLNALmjOLUHdlPU
         uT3BV6N8wsvngHVxVgS2hDb10hEFl6QannVAJpWCM43XYnhzCgZkE9uTIAPkqH9IRB0J
         b8429z0msj6VvMUW/Sz+gahldsFUNcBc/7Bh3sNbmmeGuIVYq9qOTH1xZQeHGQO5PKF5
         OYPUfSpd0thXPus4Mp6zLGwCfR6ZVwb9yS2jR+V5yoVXUr2nw2X/7oW2pxJfnuxHop+S
         ixlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775738; x=1773380538;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXuimAwpOjteei+zeJ3XJ05LznjxPAq8p3+xtzsfeMg=;
        b=bto9hr106Efx3+oi/Z/wkUHrVmPZCjcA33KXSKDJ3m56t/aqS89MSM3PEkcfxhdTHm
         I2mqVE/VdQK0W1pwFsC9na+b4gDeMc+P2wjWFd8sOLrGBaxoL5MtKcPiX4mkuNeg0vLd
         e8aAMocakVxMMzeS+fxUy98pVL8d1tqjJAdW5lh6Pxsk6l7ME6aCAx+Ml/278D+EILaj
         +TP/Pa+55XyrvTwVq8e/b3o6RCGso3tdCt3usIpxxutR5kN5jtQsneVRSiJ5dXGXWpui
         0F+TQvYA83zpbS6C76e7ziC7esWQL+krZ2ULSnw+WhYpLega2p5sUhAyM//OrAwcLiNm
         0gSw==
X-Forwarded-Encrypted: i=1; AJvYcCWNTgg2Cqc/JcuT/4zGW/oVwvoOf8wqiXKB6f35Ci4X18idh5CEb/z23q75WDoBJ/QcPH6v45o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iSpA0C7c6w5OGAfRsIGmtMoLMN/aBj1VciKQRp0L4iPVhcQ3
	Ua1OpfnEZOu29LcxuJ9031WriMlLgICvfd3Wizje4LBpB2E/dBoN5yHkGaJGALFGnUI=
X-Gm-Gg: ATEYQzzX9rKyrxx2RgYEI0pWOJvoran/Vj4Ihn4rb8Vxw2YQ+lVKOFymO7RYJavFO20
	AwsvLzZWMmXx3F2ZUiI79LWQd5aDICoVTOLAaORfRezD/8ej/wcu1voYOtKhpXrvjGAlDmG9TP5
	3HGfj2Pq063fp9WxBraU2cGRGqneYy4FmXeVuqFmTol8HaejBBGsX+vO1ryPSYIxOJicVK6REEq
	Uf+WL7te73YiD3/ajOLAZJ4tsaCFe+1qmj7HfCdeHv79Ml0Q5vP4YqKEJ08gpMPs49vICiRqq2y
	KeM5ek+aRaD/qqcm6I5nDuygesyooRPuC8doam9nLnjxE7aDvGDBkNc8u7WKRM5nfHDQ0Lv9Qeh
	rSE1kuCw5kChrEIkrvR1eTlLN8czf5v73oU73UEZnCl1vSdJc4R9E1/S4SDDFpYWkXX8Y6/lpxO
	YIH7uQC6RmDY+Vjs+Imgg/UhKGAgMbPADNH8tbiGvbX5s=
X-Received: by 2002:a05:600c:4ece:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-485269305a5mr10886455e9.13.1772775738190;
        Thu, 05 Mar 2026 21:42:18 -0800 (PST)
Received: from r1chard (1-164-74-26.dynamic-ip.hinet.net. [1.164.74.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48648d9sm458470b3a.31.2026.03.05.21.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 21:42:17 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Fri, 6 Mar 2026 13:42:12 +0800
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/kexec: Copy ACPI root pointer address from config
 table
Message-ID: <aappNDfdssz9WuGc@r1chard>
References: <20260217163532.5166-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260217163532.5166-1-ardb@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Rspamd-Queue-Id: 39B0A21BC6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223309-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.lyu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026/02/17 17:35, Ard Biesheuvel wrote:
>Dave reports that kexec may fail when the first kernel boots via the EFI
>stub but without EFI runtime services, as in that case, the RSDP address
>field in struct bootparams is never assigned. Kexec copies this value
>into the version of struct bootparams that it provides to the incoming
>kernel, which may have no other means to locate the ACPI root pointer.
>
>So take the value from the EFI config tables if no root pointer has been
>set in the first kernel's struct bootparams.
>
>Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
>Cc: <stable@vger.kernel.org> # v6.1
>Reported-by: Dave Young <dyoung@redhat.com>
>Tested-by: Dave Young <dyoung@redhat.com>
>Link: https://lore.kernel.org/linux-efi/aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com/
>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
>Unless anyone minds, I intend to take this via the EFI tree as a fix.
>
> arch/x86/kernel/kexec-bzimage64.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>index 7508d0ccc740..24aec7c1153f 100644
>--- a/arch/x86/kernel/kexec-bzimage64.c
>+++ b/arch/x86/kernel/kexec-bzimage64.c
>@@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>
> 	/* Always fill in RSDP: it is either 0 or a valid value */
> 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
>+	if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
>+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
>+			params->acpi_rsdp_addr = efi.acpi20;
>+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
>+			params->acpi_rsdp_addr = efi.acpi;
>+	}
>
> 	/* Default APM info */
> 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
>-- 2.53.0.273.g2a3d683680-goog

This change is good to me.

Reviewed-by: Richard Lyu <richard.lyu@suse.com>



