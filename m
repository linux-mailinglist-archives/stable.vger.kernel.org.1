Return-Path: <stable+bounces-244613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDVGJCzO/GlhTwAAu9opvQ
	(envelope-from <stable+bounces-244613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:38:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8987D4ECF57
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB8130086A3
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B533AD513;
	Thu,  7 May 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="JVS74hpq"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EF29ACD7
	for <stable@vger.kernel.org>; Thu,  7 May 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175524; cv=none; b=TFAU580ZMXpcbhvNtalqy6o8LbMgG06wNWPh8/aso//CxslJYMxFRsAiy+cybJjrcN/lTTPM2d1+J5w9r5SXFQaQtTXIwniLusDDCSEj1J03pGbfk3MFO5tfKi0P8fckMOt35/9/vgOMnhiZBxu+5M/xvRArF/HKB0EZT56Oi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175524; c=relaxed/simple;
	bh=KYVFHjMnaBPyqijv/LvOV3x/TaMdsiBl+/0WIQLhfMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGUTSZeaMZTwkFvJDGYB7rye+o1QS0lQF/+uFYKwP3wzigSrd1qh4ORHWDPnMtIJGonFKzJwQsAswdNYyiZ0c5PNrAquYlsmTqqNfrFdb5c4VEyIaq9q42snAnP+dLlPjF5eGsd2a44XM4i1RFoAa7F9bV0vBZSfTTS7AwnbAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=JVS74hpq; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de [94.79.177.42])
	by os-cillation.de (Postfix) with ESMTPSA id EE3BBC0530;
	Thu,  7 May 2026 19:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1778175104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/v7+nSJwhnhXC9plonrtaC/99X8RMF+zEyFn1SGmyVM=;
	b=JVS74hpqq5GLG/E4WOH9Raqz46r7nhOFy0k7bzPYHej7EZ1Fv3smubkp3sjRz8AA1tdMkK
	UIdfWTZshVDV9RItSXnk6osgo8l/k7hqHvE2EZ4RvPA6VjncVw1tuqTx3qMkgTSKFKGCuJ
	tRhsX9jNktZUiBK774i/QEA8vJ9Y7bNujRIEbjaXiBGek9bAYKqdK30YrIRXiHwAI/7ta3
	S46Lf6ABeZzAcwJK7x6km8n919tp8SQ9gFRASv8MA/Dz5DJGUCFZ7m8CXs9WEQjIPRuF12
	ZKVtzgyN5tMp3xajUfdfMdRHJasUqwE8WaZRvOa4XmPZU6BjqevlXf7Iq7fzyA==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id 9A74F200596;
	Thu,  7 May 2026 19:31:43 +0200 (CEST)
Message-ID: <de0ac6cc-453c-46a6-8c6c-9be33720e516@os-cillation.de>
Date: Thu, 7 May 2026 19:31:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mtd: spi-nor: sst: Fix write enable before
 AAI sequence" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, sanjaikumar.vs@dicortech.com,
 pratyush@kernel.org
Cc: stable@vger.kernel.org
References: <2026050405-manly-surplus-9d27@gregkh>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <2026050405-manly-surplus-9d27@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8987D4ECF57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[os-cillation.de,reject];
	R_DKIM_ALLOW(-0.20)[os-cillation.de:s=202409];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244613-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os-cillation.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hd@os-cillation.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dicortech.com:email,gregkh:email]
X-Rspamd-Action: no action

Hello,

On 5/4/26 10:38, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x a0f64241d3566a49c0a9b33ba7ae458ae22003a9
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050405-manly-surplus-9d27@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From a0f64241d3566a49c0a9b33ba7ae458ae22003a9 Mon Sep 17 00:00:00 2001
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> Date: Wed, 11 Mar 2026 10:30:56 +0000
> Subject: [PATCH] mtd: spi-nor: sst: Fix write enable before AAI sequence
> 
> When writing to SST flash starting at an odd address, a single byte is
> first programmed using the byte program (BP) command. After this
> operation completes, the flash hardware automatically clears the Write
> Enable Latch (WEL) bit.
> 
> If an AAI (Auto Address Increment) word program sequence follows, it
> requires WEL to be set. Without re-enabling writes, the AAI sequence
> fails.
> 
> Add spi_nor_write_enable() after the odd-address byte program when more
> data needs to be written. Use a local boolean for clarity.
> 
> Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> Tested-by: Hendrik Donner <hd@os-cillation.de>
> Reviewed-by: Hendrik Donner <hd@os-cillation.de>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 175211fe6a5e..db02c14ba16f 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -203,6 +203,8 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   
>   	/* Start write from odd address. */
>   	if (to % 2) {
> +		bool needs_write_enable = (len > 1);
> +
>   		/* write one byte. */
>   		ret = sst_nor_write_data(nor, to, 1, buf);
>   		if (ret < 0)
> @@ -210,6 +212,17 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   
>   		to++;
>   		actual++;
> +
> +		/*
> +		 * Byte program clears the write enable latch. If more
> +		 * data needs to be written using the AAI sequence,
> +		 * re-enable writes.
> +		 */
> +		if (needs_write_enable) {
> +			ret = spi_nor_write_enable(nor);
> +			if (ret)
> +				goto out;
> +		}
>   	}
>   
>   	/* Write out most of the data here. */
> 

it doesn't apply because of changes made in
18bcb4aa54eab75dce41e5c176a1c2bff94f0f79.

That commit was never backported and is not in any stable tree older
than 6.12.y. So it needs to be applied first to 5.10.y, 5.15.y, 6.1.y
and 6.6.y. It's a refactor commit that should not change behaviour at all.

If that's not possible for some reason the conflict resolution looks
easy enough. I have something i can send out for review if needed.

Regards,
Hendrik

