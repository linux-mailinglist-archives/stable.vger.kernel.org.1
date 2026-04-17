Return-Path: <stable+bounces-238452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNGaIAzq4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:06:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953F41862C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A60AF30EDC93
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB83368A6;
	Fri, 17 Apr 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmd0TAEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5EA3603FE;
	Fri, 17 Apr 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412415; cv=none; b=ZxdBZKA5kA7NVXZuDBGo43UC67fAy/9ypNKRBYPnsmjFTRwfKX9Z2YHmhh4tjoVcYJGPJFqN2eeYNLT7yPRX+NXecNlQI2XsJ2QujDBTqCqkaAF9Q/ElX7O9aeDJQoFPLGH1pLyLJVHybvdT0gQC6V7K93NAowLlNFyzgXf6SCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412415; c=relaxed/simple;
	bh=WYFBone+RdKeGJANQB5WksvtqaVQPIIUpwB7FrTJxLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flwe6aSblXTh2qKdgrb3cTbTs66vgZ0eCUtObyCy0xtvjXcF1DRRDzNrY2xWccBTnvCsSO0B9OdxMA3C88iRVn7cFQKc2vBcltmLHn0KocgvUu/RQ9y+7Up60JPaQ+j+AbRn5nhuX2hRtx3en1ZbRyNywDRU1jknXutCYOe8WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmd0TAEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B01C2BCB4;
	Fri, 17 Apr 2026 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776412414;
	bh=WYFBone+RdKeGJANQB5WksvtqaVQPIIUpwB7FrTJxLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jmd0TAEBDIPG0Wdexll4igX5vJLTTiFEO2Vzr1ZATAQqRdKR7yCGN9dqo3BiyJ7yv
	 6F8Al4rVG+yKRdXCrVAYTdpRRnrt4ZOmkd6sOf4LRJc5nbBxTaGtAnExo0XW8fX/LI
	 lA93sJzFI4wCUpfbuUqJlxbSrBH6F0TVxM19wu2JvwQUwTAibpvB2mYK0CbcnoqcXO
	 CfPZtOkY9pc/4UorT96so1Y5/txDF9xe+dB9RT9A1d3mrtYGz3s/QtHCyN+TW4/WEu
	 RSRnz9qk7dZ6w7mfxbro0ILPDO9ysqWv3YajgzCd7qyU1iYBKzY2b7/5MD0d00HaxA
	 CYBiz5uqIqD5w==
Message-ID: <c9c667ef-40d4-47fa-a3b8-591d2d3a7a2c@kernel.org>
Date: Fri, 17 Apr 2026 09:53:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/fadump: reject empty bootargs_append writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,suse.cz,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238452-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9953F41862C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 17/04/2026 à 09:39, Pengpeng Hou a écrit :
> bootargs_append_store() indexes params[count - 1] when stripping a
> trailing newline from the sysfs write buffer.
> 
> kernfs passes zero-length writes through to the store callback, so an
> empty write makes that newline check read before the start of params.
> 
> Reject empty writes before looking at the last input byte.
> 
> Fixes: 683eab94da75 ("powerpc/fadump: setup additional parameters for dump capture kernel")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/kernel/fadump.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4ebc333dd786..03ab5565e420 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1479,6 +1479,9 @@ static ssize_t bootargs_append_store(struct kobject *kobj,
>   	if (!fw_dump.fadump_enabled || fw_dump.dump_active)
>   		return -EPERM;
>   
> +	if (!count)
> +		return -EINVAL;

Why return an error ? A 0 size write is a valid write, it should return 
0 I think.

> +
>   	if (count >= COMMAND_LINE_SIZE)
>   		return -EINVAL;
>   


