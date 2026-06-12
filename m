Return-Path: <stable+bounces-262924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9PrBX4LLGoUKQQAu9opvQ
	(envelope-from <stable+bounces-262924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 15:37:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87810679E3D
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 15:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XwrXLtFZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262924-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262924-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5079232C1534
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A13EB801;
	Fri, 12 Jun 2026 13:28:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287D31ED8B
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 13:28:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270896; cv=none; b=KtF3hygtYwwJ1mzL9+LSHG3B0fxSvIyMsM2IM8xC757tGoCJi/sqjsbIES8fyGFLnpZ43Hy4msa7g5sZmeMku8S9MqzleFO2tR5RE5HQD2KcAw96uEt0oc6Oky+/BOH+HRZvrDp3VL8awBfB5yqOg6XEnS+CH4kaMluMUN9nsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270896; c=relaxed/simple;
	bh=Qmn08evHSMv43v0YQCFOwx+bcM/SBxpKzIKiC36SEYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr1cQ4VVroftBJvyiqWDTnZd9br3n8g9x2DUbuM+4LqaKALZbZ4CCwf9g0rpS1XqcCcFRilojlaPLucx/Qh2CNVHObDi8hyMawqgwNO+XEgFLhV4jvhJqevXOm1wJRyC47tbMzROftofV6MvB6V/sRdFXgfj3TfX2zZwZdFLgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwrXLtFZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62EF1F000E9;
	Fri, 12 Jun 2026 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270895;
	bh=ch+yj1d1xkzfN77vmuNFUc+RE3Ma28b1qL2J7+Wwpio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XwrXLtFZu0cYo0VsvAzGGWQxsiuhprgFN6uuIaAcoT50FCyGnbLkikPtvpaa6L/cw
	 mVbiF85+bI1U/QlZyHoQ9bH8GMYsougELaMNGRU7ydYqK2muhA4SDF8oY6JSgCoRpp
	 INLlVP4JfrpmSJslGc3SRz8LkbGv/NHVDg8GmvGLC8AjlWEA08COsuFFqRoeT5G1rs
	 mr0Iruqh0RPhkfJhJXLtkJlo9IDKaCUlshgcwYI67ZMPT/1XwVFvyfpbjkwqQCBGFl
	 u78f6X/L7enyc5+o/+phLuv0S7cG5/qk3fmA+52i4liKEkgQ2BReLWv65C8ETUIziD
	 nwhkRaqGvTdRw==
Message-ID: <598af26b-0f1d-4015-a3c7-b738a7364ab2@kernel.org>
Date: Fri, 12 Jun 2026 15:28:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org
References: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262924-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,ellerman.id.au,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:npiggin@gmail.com,m:maddy@linux.ibm.com,m:sayalip@linux.ibm.com,m:mpe@ellerman.id.au,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87810679E3D



Le 11/06/2026 à 03:09, Ethan Nelson-Moore a écrit :
> CONFIG_E500 was renamed to CONFIG_PPC_E500 in commit 688de017efaa
> ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500"), but the check for
> it in mask_user_address() was not updated, causing
> mask_user_address_isel() to no longer be used on E500 hardware. Fix the
> check to use the correct name.
> 
> Fixes: 688de017efaa ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")

Correct Fixes tag is:

Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")


> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e98c628e3899..619270bb7380 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>   
>   	if (IS_ENABLED(CONFIG_PPC64))
>   		return mask_user_address_simple(ptr);
> -	if (IS_ENABLED(CONFIG_E500))
> +	if (IS_ENABLED(CONFIG_PPC_E500))
>   		return mask_user_address_isel(ptr);
>   	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
>   		return mask_user_address_simple(ptr);


