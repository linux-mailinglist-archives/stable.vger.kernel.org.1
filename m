Return-Path: <stable+bounces-225541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKxTBgcKuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:47:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C5929AB62
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DCA303AA94
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28F39A071;
	Mon, 16 Mar 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="dGxbqzpf"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF22253EB;
	Mon, 16 Mar 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668688; cv=none; b=kYJtEFRKuF42KTY1UUd+RLvD/a5UGM8bB7ac0rPb+O7LExln0DzBse/IOUa/MTgmImbZEbgTsmklA5cIhQfH2Sh4WLvZXqcWMAHgQieZy878AWaK6/1BIhcY+21qPO6RYeEQ4PTqaJgq+BKhCp22hRVqUqQ36+o6K9wey80+a1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668688; c=relaxed/simple;
	bh=1uigPK22o3/EKF5G1wKKq68Rx61xM13Z4PxAxsJsUSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SrXhN8jyOQoxe49nP/tquMEbOMtqkUBWSwQwy0wK09S0S30dYYToR6OT9h0V9MCY80lRdJN44IpuJ9MTyV+lqh1vAW34GSWJNnuZQA+laHxoQmOO0GGCF4BD6hnNqJr8MzmClfm3aQ4yFvfVOV3JB6tixzY00bt1v7UsfegAJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=dGxbqzpf; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de [94.79.177.42])
	by os-cillation.de (Postfix) with ESMTPSA id 50C4BC06C4;
	Mon, 16 Mar 2026 14:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1773668678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xs2GL3fzG5DdJwAquzy5MyIEQPZUdmAb8QjJf+1ONQ0=;
	b=dGxbqzpf9aBZr8mqE5/bmBgH7OjT1GKW3e5TYdTpzantFr+SaRZ6CeCcqkkqlLL+dQ7h18
	fdsCVKVv0NFjGz686diGdHlLugDsrZqcbar8EBIt/HPCxOStLwaJpmpgpRbc0z+07c+XJn
	vKa9Bb3qjebF+v7L/X99JwsAPL+cSQZzrYLFD4PF8aGGD1xPsYGEdoohVWjN6QI0Bkr831
	wRLJEclWTaPfbFecFNp4gHLSzv9QX7WOhcHADV/MVSFNMi5tH6OpEVDsENfPcqDf/z2SG0
	qqndvB8ntrmJSvvATQdyEfRXrHGtHrqIIpqcIwKcOcyCFyGlGTeDUbnCvArMBw==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.3.45] (hd2022.osc.gmbh [192.168.3.45])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id DC9FB200EBD;
	Mon, 16 Mar 2026 14:44:37 +0100 (CET)
Message-ID: <229484e3-d1b1-4cac-ae80-e483b7b90597@os-cillation.de>
Date: Mon, 16 Mar 2026 14:44:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hendrik Donner <hd@os-cillation.de>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>, mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
 sanjaikumar.vs@dicortech.com, stable@vger.kernel.org,
 tudor.ambarus@linaro.org, vigneshr@ti.com
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
 <20260311103057.29-2-sanjaikumarvs@gmail.com>
Content-Language: en-US
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <20260311103057.29-2-sanjaikumarvs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[os-cillation.de,reject];
	R_DKIM_ALLOW(-0.20)[os-cillation.de:s=202409];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[os-cillation.de:+];
	TAGGED_FROM(0.00)[bounces-225541-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,os-cillation.de:dkim,os-cillation.de:email,os-cillation.de:mid,dicortech.com:email]
X-Rspamd-Queue-Id: 86C5929AB62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 3/11/26 11:30, Sanjaikumar V S wrote:
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
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
> ---
>   drivers/mtd/spi-nor/sst.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
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

found a board with

   spi-nor spi0.0: sst25vf032b (4096 Kbytes)

for testing. Tests are on top of

   94645aa41bf9e (mtd/spi-nor/next)

This should be done according to the datasheet and fixes that only 1
byte is written on writes to a an odd address and following AAI writes
fail, resulting in something looking like this:

ffa9 ffff ffff ffff ffff ffff ffff ffff

when

24a9 91b3 7cb6 f01c 2994 c368 fdad d3a2

was supposed to be written.

Tested-by: Hendrik Donner <hd@os-cillation.de>
Reviewed-by: Hendrik Donner <hd@os-cillation.de>

Regards,
Hendrik

