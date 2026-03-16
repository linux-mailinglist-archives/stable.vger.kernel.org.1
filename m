Return-Path: <stable+bounces-225542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFT4HrYJuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:46:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27E29AB35
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1843301077A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1239A7FE;
	Mon, 16 Mar 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="Wr5VZNp2"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF839A7F3;
	Mon, 16 Mar 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668689; cv=none; b=mfLt/z7UcprwLhzzv0o4hTY8n/qxOLWUPwjElAt0/GsvLAsfKsGmsldUhmzSq6wWMfglBaTtNwc5w0zHdwlv1uhUJg/xh621bHmd5YMwash3gX4RoTHRf6ReQd8N9Pp2poEK3JuP8FmN1BRj6wCuTOMRydrdyK9Hh5VZXRd9kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668689; c=relaxed/simple;
	bh=IYoR/aeNFvXs6xvvHYmhrWnd6HiAvhJw6VHvael+joA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2lI5GWrqvhsy70zs+/0GKUsL9xeNXvnYk3y/M67gPHIaGtXKQcM9Emi0zq3zaLJnZ8G+Ua44tfJ4jgoZ50zwvbK/CbhsCfhP7D11OhTVLkhpYiQ0QVK3/rqIchLcTB5bCe0nIaR3JOJ++VeE1fYfa3EOB8X7Ucg9Ych69pxalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=Wr5VZNp2; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de [94.79.177.42])
	by os-cillation.de (Postfix) with ESMTPSA id CBD7CC06C7;
	Mon, 16 Mar 2026 14:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1773668686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EYAMF/Vdk0rGD6InCzHqj4d+RFQzTMwNzItRTQph0PI=;
	b=Wr5VZNp2WQtEKXUurh24bzQZe76NDVrxnhxpbEwFRe6Ch0PS+vWeUb5bPUYePHOjV5o6fE
	AznIv1cqHq6a4rOoTq2Y7vs1sgGE9HGcwcKKgMyL4lCTfYKfbEnADkgsXIGIUhVreZVBfB
	XlKTVvRiX9tGt+LX96IZCB1K4wdEW105GZdJv7saFySxG3MHXioPHhyg2EJpT5t1/Jov1e
	wuho+9fy7l4pb88LbvxYzT/lzuMJxHpJy5JKdVWME6xeSegp215dIdtVgwQbCmjh/3Ktbg
	OcEA2rMNoKABkcbMydPwW13ToN4lVUj7Og0VUKmYNZoEqeC4Lkvl+2TiH1D0Eg==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id 7458C200EF0;
	Mon, 16 Mar 2026 14:44:46 +0100 (CET)
Message-ID: <b64cf15d-3c7f-425a-a72c-8798ad43caee@os-cillation.de>
Date: Mon, 16 Mar 2026 14:44:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is
 not available
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>, mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
 sanjaikumar.vs@dicortech.com, stable@vger.kernel.org,
 tudor.ambarus@linaro.org, vigneshr@ti.com
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
 <20260311103057.29-3-sanjaikumarvs@gmail.com>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <20260311103057.29-3-sanjaikumarvs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[os-cillation.de,reject];
	R_DKIM_ALLOW(-0.20)[os-cillation.de:s=202409];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[os-cillation.de:+];
	TAGGED_FROM(0.00)[bounces-225542-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hd@os-cillation.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dicortech.com:email,os-cillation.de:dkim,os-cillation.de:email,os-cillation.de:mid]
X-Rspamd-Queue-Id: 8C27E29AB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 3/11/26 11:30, Sanjaikumar V S wrote:
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> 
> When the SPI controller lacks direct mapping support, the fallback path
> in spi_nor_spimem_write_data() uses nor->write_proto based operation
> template. However, this template uses the standard page program opcode
> set during probe, not the AAI opcode required for SST flash.
> 
> Add check for nodirmap flag to ensure the code falls through to
> spi_nor_spimem_exec_op() path which builds the operation at runtime
> with the correct program_opcode set by sst_nor_write_data().
> 
> Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> ---
>   drivers/mtd/spi-nor/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8ffeb41c3e08..cb7f4d447156 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
>   	if (spi_nor_spimem_bounce(nor, &op))
>   		memcpy(nor->bouncebuf, buf, op.data.nbytes);
>   
> -	if (nor->dirmap.wdesc) {
> +	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
>   		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
>   					      op.data.nbytes, op.data.buf.out);
>   	} else {

found a board with

   spi-nor spi0.0: sst25vf032b (4096 Kbytes)

for testing. Tests are on top of

   94645aa41bf9e (mtd/spi-nor/next)

This patch fixes write errors, easily seen with flashcp, which tries to
verify writes:

   flashcp: verification mismatch at 0x0

Tested-by: Hendrik Donner <hd@os-cillation.de>
Reviewed-by: Hendrik Donner <hd@os-cillation.de>

Regards,
Hendrik

