Return-Path: <stable+bounces-274758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ml2aI3k4V2piHgEAu9opvQ
	(envelope-from <stable+bounces-274758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:36:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFA75B7E8
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:36:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KoXslAMM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274758-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274758-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFF0C3003727
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0403C09F8;
	Wed, 15 Jul 2026 07:35:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBD3B7B96;
	Wed, 15 Jul 2026 07:35:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100952; cv=none; b=M8V+wdLUyRnt1HWkNmwOfzlADjHxjxxlr1knqWbhQbQ09tOG0UmcxEfqKdc8gv5MlOu3uuJc5/kOdH7aqttYJ5qyvtzriCeBy5mDjLFf101HARzpxgv5zPma0II5b4+qnTCfw/CohLINlfOytczqBzrcJmgOBNxV7L3PejKaSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100952; c=relaxed/simple;
	bh=NptDMkS6Qr1yixQJUThm0z6U00IUO35X14f2lvHWgPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUycDMCs3GAAaw42Z9H8me/EIRW0YJGwzbAmLqWgw5hjeqMHbz9JK7uRqT1vw4l2JGOsrEggz9+xcyfhpvHhuJOuV8jqAffEsyeJdQrYovON8neVkNOlwqPaQ/XoaZzFSXHHWeKfneED8QHfeeqqNzsUk+ZSewowRAI61FJxAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoXslAMM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FADF1F00A3D;
	Wed, 15 Jul 2026 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784100944;
	bh=vOrSGgvjfu6AlrRDbJK8SzilZUKXB43aBCWFKatGaw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KoXslAMMJINuAQGsJNWtQ+lLOUhDhlf3IKGAL1uZ88QrKUJg3DSiOLRN5+x9k2Nu5
	 JvfJmWp5JE3kXdebKvLD4sGs+uXVb2m9cjw6Jcod11ct7o+sqn7yH6cOlao93CTAzQ
	 NABQb4e7+w5dp5RNSFDNNz1mxRw8M+i01v8xTKAR+IM3kCayePMAp2S+dxXKoQuKRu
	 r9Paw5AFd8hyiu3Y1htVzLNqYb3xTLyM3yiCcolqOvy3dZXrZkJUvg9IeYHApec8Dt
	 Dxk7sgu7XmoWT+L0PXJfE/R73nE6Z+JbP0++KMHrYVGsCzZYfv/XyeBtFX3zW+8K4o
	 6bVRzC1KMGqHg==
Date: Wed, 15 Jul 2026 08:35:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, david@kernel.org, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region
 registration
Message-ID: <alc4HsXeNaJczPSi@lucifer>
References: <20260715063626.65899-1-pankaj.gupta@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715063626.65899-1-pankaj.gupta@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pankaj.gupta@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:bp@alien8.de,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:thomas.lendacky@amd.com,m:hpa@zytor.com,m:david@kernel.org,m:yangge1116@126.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274758-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,alien8.de,linux.intel.com,amd.com,zytor.com,126.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86CFA75B7E8

On Wed, Jul 15, 2026 at 01:36:26AM -0500, Pankaj Gupta wrote:
> Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
> encrypted memory regions") added FOLL_LONGTERM to
> sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
> MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
> FOLL_WRITE on the pin.
>
> Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
> guest memory, such as virtio-pmem host memory-backend-file mappings
> (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
> mappings since:
>
> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
>
> Region registration only requires long-term pin to prevent page migration and
> does not write through this GUP pin.
>
> Drop FOLL_WRITE and pin guest memory only with FOLL_LONGTERM.
>
> Fixes: 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
> Cc: stable@vger.kernel.org
> Suggested-by: "David Hildenbrand (Arm)" <david@kernel.org>
> Link: https://lore.kernel.org/all/ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org/
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>

Nice and simple, works for me :) So:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> v1 -> v2
> - Remove FOLL_WRITE when the pin is not used for host writes
>
> v1: https://lore.kernel.org/all/20260701144543.39582-1-pankaj.gupta@amd.com/
>
>  arch/x86/kvm/svm/sev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 427229347876..5f2998761462 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2752,7 +2752,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
>  		return -ENOMEM;
>
>  	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
> -				       FOLL_WRITE | FOLL_LONGTERM);
> +				       FOLL_LONGTERM);
>  	if (IS_ERR(region->pages)) {
>  		ret = PTR_ERR(region->pages);
>  		goto e_free;
> --
> 2.34.1
>

Cheers, Lorenzo

