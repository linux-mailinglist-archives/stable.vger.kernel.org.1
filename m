Return-Path: <stable+bounces-263609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rC+iK3zgMGr7YAUAu9opvQ
	(envelope-from <stable+bounces-263609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:34:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B468C32B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lGe+T+Gt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263609-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263609-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D1743020114
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376333D25D8;
	Tue, 16 Jun 2026 05:34:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13E3D25C6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:34:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588090; cv=none; b=MJWmIHXWZF94FYutB8d9b+UaI17KBCal9TRqSO6hiZjZtznipsuuW7wX46X5s9Sl88241dYOiWe473NfIGawRX+IjnTv7nwWOl6Os6gLENvhmhXLpNXfch4ZPrp56BFUInMf0zE0o+dUl9vjf8MM5DjrA7u2BJxFr8eWea3O9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588090; c=relaxed/simple;
	bh=OJAJRu0n0XMwis98w/W/bi9BjMgB+VA6wjfyMyjd+s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld1r5IlYloyL4216orYo8NvEkAIPC/Iud/Cd9IPsyud7lOG3GKJ/KNsPTpMHj5qC8/HR0OAeQvI0r265OReHJwqxmPiKPp1XA2bkdhw1SqN7NycCzLbT2hbss3zUlR7lf/US32n/jBMQTpkj255ZKI+Qk6p7VXzTM6IZkRpmYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGe+T+Gt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11321F00A3A;
	Tue, 16 Jun 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588088;
	bh=kRgeD23SDOXTEaBOW3fA+2SN+82jwDbS4FXKc7M2R2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGe+T+Gtixkz1cmQhwOapVfCYwxS5P1xxHtqk4gh/xGreBY+ooSaKPz5MEh94MLOK
	 AajxufIEP+BqlipeKj8abAu2kcNoOnPOwy2ffzml4hQfmBOR/rg9l/D7mQF2KZdC7m
	 h11vL8ZasN8Wd5OnsGMfg2ecGGu5l22hvrAFPLiWpAxi3qf2gWZBgofP7Z+d7JPiK3
	 BsfRgEQx1IdIGOkJ0Jcbg41+YnJwjDgUW3AmxBPkV89TqBZA1zxEQAnTcb/oodWirc
	 9JcUDbatjMxjUZ8d7qQkPqnyAI5Y8KcQN0JuL4FvXnlaMcDYUsNbr5wgJgLW3rYTL3
	 RcsIQci5aezgA==
Message-ID: <095d4604-b3d7-492e-b119-2bedcb63217e@kernel.org>
Date: Tue, 16 Jun 2026 07:34:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:npiggin@gmail.com,m:maddy@linux.ibm.com,m:sayalip@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,m:mpe@ellerman.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,lists.ozlabs.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263609-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 396B468C32B



Le 16/06/2026 à 01:37, Ethan Nelson-Moore a écrit :
> mask_user_address() incorrectly checks for CONFIG_E500 instead of
> CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
> E500 hardware. Fix the check to use the correct name.
> 
> Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> Cc: stable@vger.kernel.org # 7.0+
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changes in v2: Correct explanation and Fixes tag (thanks Christophe)
> 
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


