Return-Path: <stable+bounces-238455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAsRCS/o4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5A418495
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 128563012214
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D63603FE;
	Fri, 17 Apr 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBOpVpJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E735FF6E;
	Fri, 17 Apr 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412707; cv=none; b=BybN89ynPaFlxvhghFEpowFmGB22769CTL3cLLkbfkyoVI/noSMigINeyeRRb12Qdg7kveUgjkFCGEvdHFAL9hWnClmjSRQBwoD5JUyhuHRhKQ9YUw34N3XkkzGhZvs/hJy90AjVPaIhunFKHDg0FGRHcX0VzP5KHHU7Nn9Yvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412707; c=relaxed/simple;
	bh=VQUKrR9nWoPJsROPvUoUyOlHujMLWC88AwwtyCd0cKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glEthbgsDyGQMjjbLrObwhsxWObojXE1telacqKOUmK9zufNkMgJzx4f6mXOn4jFBVhpmftch3uaE2rTigRzDUQQTYOVcFMUhBA545jlLQhuqMmiVN5oBDIQlNy9MM6EInT0NRjDEQk+ZMPH33ogmuwMuIVQeP5HmfSS4ZrJ3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBOpVpJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2086C19425;
	Fri, 17 Apr 2026 07:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776412707;
	bh=VQUKrR9nWoPJsROPvUoUyOlHujMLWC88AwwtyCd0cKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IBOpVpJgooMO5weqdtaWKIw5U1JbNTBM54JOf/4zV/Kr+ECkCLA9/Ho9PE3A+sei6
	 U/ynTePxGr4L9Gukk9q6spzWkSKR8CYi3uL6C7qylZgTDhMyE7p/X8Bgao+7TFvNnh
	 4ftsmv4HSqn9O9H1+yjQrKha24xFb3c2aMQAA+DXpmeFmzeRUZZM29X4EnErkFDMbg
	 KeP/iQ+3GI6mQlwTyfghpWZvCU4g2P6HF/iM2S2Df3kmYhy6jh5feLydOEb2rRxVHk
	 3h12d5X+jXELk5ev+/szz0RWCYnw3jvQVxar2pXcC0tT4dDBPk5sPTjwVvTlvhedyg
	 BJuDrbnFncZQA==
Message-ID: <b0c30cf3-751e-4f65-81ea-393c568dde56@kernel.org>
Date: Fri, 17 Apr 2026 09:58:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/perf/hv-gpci: bound sysfs formatting with
 sysfs_emit_at()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Kees Cook <kees@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238455-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: E3B5A418495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 17/04/2026 à 09:48, Pengpeng Hou a écrit :
> systeminfo_gpci_request() and
> affinity_domain_via_partition_result_parse() hex-encode hypervisor data
> into the single-page sysfs read buffer with sprintf(buf + *n, ...).
> Both helpers only check PAGE_SIZE after the formatting loops have already
> advanced past the end of the buffer.
> 
> Switch these appends to sysfs_emit_at() and stop once the sysfs buffer is
> full.

You are changing several time a single lines by multiples lines that 
look pretty similar. Can you refactor in a helper function ?

> 
> Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
> Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/perf/hv-gpci.c | 56 +++++++++++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 5cac2cf3bd1e..325b80f01629 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/perf_event.h>
> +#include <linux/sysfs.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/io.h>
> @@ -134,6 +135,7 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   			size_t *n, struct hv_gpci_request_buffer *arg)
>   {
>   	unsigned long ret;
> +	int len;
>   	size_t i, j;
>   
>   	arg->params.counter_request = cpu_to_be32(req);
> @@ -176,9 +178,17 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
>   		j = i * be16_to_cpu(arg->params.cv_element_size);
>   
> -		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size);
> +		     j++) {
> +			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[j]);
> +			if (!len)
> +				return -EFBIG;
> +			*n += len;
> +		}
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len)
> +			return -EFBIG;
> +		*n += len;
>   	}
>   
>   	if (*n >= PAGE_SIZE) {
> @@ -465,6 +475,7 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
>   			int element_size, char *buf, size_t *last_element,
>   			size_t *n, struct hv_gpci_request_buffer *arg)
>   {
> +	int len;
>   	size_t i = 0, j = 0;
>   	size_t k, l, m;
>   	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
> @@ -483,22 +494,49 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
>   	 */
>   	while (i < returned_values) {
>   		k = j;
> -		for (; k < j + element_size; k++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; k < j + element_size; k++) {
> +			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
> +			if (!len) {
> +				*n = PAGE_SIZE;
> +				return;
> +			}
> +			*n += len;
> +		}
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len) {
> +			*n = PAGE_SIZE;
> +			return;
> +		}
> +		*n += len;
>   
>   		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
>   		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
>   
>   		for (l = 0; l < total_affinity_domain_ele; l++) {
>   			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
> -				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> +				len = sysfs_emit_at(buf, *n, "%02x",
> +						    (u8)arg->bytes[k]);
> +				if (!len) {
> +					*n = PAGE_SIZE;
> +					return;
> +				}
> +				*n += len;
>   				k++;
>   			}
> -			*n += sprintf(buf + *n,  "\n");
> +			len = sysfs_emit_at(buf, *n, "\n");
> +			if (!len) {
> +				*n = PAGE_SIZE;
> +				return;
> +			}
> +			*n += len;
>   		}
>   
> -		*n += sprintf(buf + *n,  "\n");
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len) {
> +			*n = PAGE_SIZE;
> +			return;
> +		}
> +		*n += len;
>   		i++;
>   		j = k;
>   	}


