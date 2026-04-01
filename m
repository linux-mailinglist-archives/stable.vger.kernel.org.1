Return-Path: <stable+bounces-232808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF9yHrhEzWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:15:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E93AC37DC6E
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2581C3168602
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE6478864;
	Wed,  1 Apr 2026 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="LTDUoNM7"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053303D6CA4;
	Wed,  1 Apr 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059410; cv=none; b=iZWkrzBpZfbZ9sx87uyY6w0a/OMnS/BHKIecKUF1ljei49Xiasw1kIoTHXKA6aO/ucHK9C+wOniFDrpNHCh9rIg2uZPgmp1T3NZ62z11E5SmkyaEdsOrwRyUGnzRuBDwdCDWJfBBrZHLq+SqhzMXB1Ph7PWtFEY71wRMXXhAB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059410; c=relaxed/simple;
	bh=ryT7EeE1+YNFuE51+HAXkF5VlZc6nZnjsyF/z/9eI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDOEtRxQbw7QN5iqBdNrnaveDuMW/cdzh1nFKOD8tAdF8T5hdE+ocihJwDtVLWrdYEkbI0p9SpT3rZKl8OeT1jHOKgbB08/JqaJl9zm05dutMnSsWymGK4mtJ1x4Yznypn7ZKz2qFJ8lvfCtzAf4f4xa7F6knvH/mVhKWVgzMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=LTDUoNM7; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de [94.79.177.42])
	by os-cillation.de (Postfix) with ESMTPSA id EAA44C03BA;
	Wed,  1 Apr 2026 17:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1775058826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nk9pGpxh0vWpesmCd7JlzF8g1U7htln7n+QL1w8SFVM=;
	b=LTDUoNM7VHDIgWwa+2JHihO22XOPOp7Z4UdbimU83p0qFyyAFDqEyeUon/15HVJ7C9uKNC
	k1Lg46IhZMP2Sg3idbWDTDa3UjC4A8McrevfSIpc8VVYp4MQahvm52GyaEceiG/Bk/2Zut
	H3R89nVZKZAbTt2E0rMGHkucQ5NxdCYLRIqb1LNdn/0VByONAsSOiauLvzXXYUpZZx+bVY
	VTPoDtDWo42StKCQ1VU8mGUlH6OMvmAN5v2wD35F20EJnaA0cZL62nAV6NqWdwxzIDJRGo
	ux7LZSB96L0LlRlMX8LLhWOzmw2vMoLz+cte8hh+lYTVy5KLBU+1J2I5l+QNRg==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id 5ACAD20010D;
	Wed,  1 Apr 2026 17:53:40 +0200 (CEST)
Message-ID: <40364d66-f8a2-4efb-a4d3-70f0aa3137e2@os-cillation.de>
Date: Wed, 1 Apr 2026 17:53:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mtd: spi-nor: Fix SST AAI write mode opcode handling
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>, mwalle@kernel.org,
 pratyush@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, richard@nod.at, sanjaikumar.vs@dicortech.com,
 stable@vger.kernel.org, tudor.ambarus@linaro.org, vigneshr@ti.com
References: <20260331095026.38-1-sanjaikumarvs@gmail.com>
Content-Language: en-US
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <20260331095026.38-1-sanjaikumarvs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[os-cillation.de,reject];
	R_DKIM_ALLOW(-0.20)[os-cillation.de:s=202409];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[os-cillation.de:+];
	TAGGED_FROM(0.00)[bounces-232808-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,os-cillation.de:dkim,os-cillation.de:email,os-cillation.de:mid,dicortech.com:email]
X-Rspamd-Queue-Id: E93AC37DC6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 3/31/26 11:50, Sanjaikumar V S wrote:
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> 
> When the SPI controller lacks direct mapping support, the fallback path
> in spi_nor_spimem_write_data() uses nor->write_proto based operation
> template. However, this template uses the standard page program opcode
> set during probe, not the AAI opcode required for SST flash.
> 
> Additionally, controllers that do support direct mapping will also use
> the wrong opcode since the dirmap template is created at probe time
> with the standard page program opcode.
> 
> Fix this by:
> 1. Checking the nodirmap flag in spi_nor_spimem_write_data() to ensure
>     the code falls through to spi_nor_spimem_exec_op() path which builds
>     the operation at runtime with the correct program_opcode.
> 2. Setting nodirmap=true for SST AAI devices in sst_nor_late_init() to
>     disable dirmap and force the runtime opcode path.
> 
> This only affects SST devices with SST_WRITE flag. Other SST devices
> that use standard page program can still benefit from dirmap.
> 
> Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> ---
> Changes since v4:
> - Disable dirmap for SST AAI devices in sst_nor_late_init() to fix
>    the case when controller supports direct mapping (Pratyush)
> - Updated commit message and subject to reflect the broader fix
> 
> Note: Patch 1/2 from v4 series is already in spi-nor/next.
> 
> I don't have hardware to test the new sst.c change. Hendrik, could you
> please verify this on your SST25VF032B setup?
> 

retested, works the same as v4 on the SST25VF032B, don't have other SST
flashes at hand to test though.

Tested-by: Hendrik Donner <hd@os-cillation.de>
Reviewed-by: Hendrik Donner <hd@os-cillation.de>

Regards,
Hendrik

>   drivers/mtd/spi-nor/core.c |  2 +-
>   drivers/mtd/spi-nor/sst.c  | 10 +++++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index e6c1fda61f57..2e4b167cab57 100644
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
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index db02c14ba16f..cd2f04830a6b 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -267,8 +267,16 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>   
>   static int sst_nor_late_init(struct spi_nor *nor)
>   {
> -	if (nor->info->mfr_flags & SST_WRITE)
> +	if (nor->info->mfr_flags & SST_WRITE) {
>   		nor->mtd._write = sst_nor_write;
> +		/*
> +		 * AAI mode requires dynamic opcode changes (BP vs AAI_WP).
> +		 * Disable dirmap to ensure spi_nor_spimem_exec_op() uses
> +		 * the runtime opcode instead of the dirmap template.
> +		 */
> +		if (nor->dirmap.wdesc)
> +			nor->dirmap.wdesc->nodirmap = true;
> +	}
>   
>   	return 0;
>   }


