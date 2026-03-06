Return-Path: <stable+bounces-223393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOVAN2xYq2l+cQEAu9opvQ
	(envelope-from <stable+bounces-223393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:42:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 418232285C6
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9349E30484D1
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276B35A927;
	Fri,  6 Mar 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b="TSV7IaZJ"
X-Original-To: stable@vger.kernel.org
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177154654;
	Fri,  6 Mar 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.165.83.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836968; cv=none; b=nc/DMJqS22XbVPaE1kwrBrkj2nKPSlu36Mh3sFZqVaHdTzFDFBn45qOI1ga4vTTcCo2ZzEkjm93MuuRaWIRanzCMi1eeoDnzHZQOuTQXF0dfNo3yHlf7lQSkrS12ya0i/DRCdXm6kjzRBNaitOjSHrl8SkeNyLBzOvtlVmjrxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836968; c=relaxed/simple;
	bh=EdHRQH/d8cPJ1c7LM+NYLIhujLcLqvm2DdubABF++m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifz/Il5zJbILlo2+c17kS2K6HTaqZlDm1lvAV2m+59aro3dgJ8mPMmZ2asrYmWpfAZ1QeG8595dAlQnhbm6AfOUJAC54b8QZYzHe/LxuoT9j6EJm7nfIanYNvFUG41wSbafIT1Jfoz6Tzm0GQGavtlPbDYr2pwGk+01tXlhAMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de; spf=pass smtp.mailfrom=os-cillation.de; dkim=pass (2048-bit key) header.d=os-cillation.de header.i=@os-cillation.de header.b=TSV7IaZJ; arc=none smtp.client-ip=213.165.83.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os-cillation.de
Received: from core2024.osc.gmbh (ip-094-079-177-042.um30.pools.vodafone-ip.de [94.79.177.42])
	by os-cillation.de (Postfix) with ESMTPSA id C3A4EC000E;
	Fri,  6 Mar 2026 23:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
	s=202409; t=1772836570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nvJl8y1qB9qLu9K93WnMqOlOXmvjXuSFTNGRu2gtesk=;
	b=TSV7IaZJG3GnQXEK0OntRnPSJpq1P6kaRKTBIzOr5XcJVD/GF0osiVOAyKVVgBgsrxkqxi
	WppljGWIxxScq57rB+7KItRUL4R0S3B8oxfbOxd/fMVo7eEguCAuS65lJGCRO8pzLBiraN
	38MhvWTKz1yd4eoWiF6QWTeNIQvOtA3gZPGmdVj62zj+7FhI8KUIbV+ImM6dhmpaCiaSuT
	5heNrKwMg4rmw4OsVvoTAQRMNXDu8eEu2I5vvth1vGOJMIxC4BdVIGOvupuBlevQD5elyn
	c+at2cbB7LuyKzya8+HouAYPrmCLeR6r535lcN6Q2VkfTNYI4/yeo4d0o08fkw==
Authentication-Results: os-cillation.de;
	auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from [192.168.33.33] (openvpn.osc.gmbh [192.168.3.111])
	by core2024.osc.gmbh (Postfix) with ESMTPSA id 004342009AD;
	Fri,  6 Mar 2026 23:36:05 +0100 (CET)
Message-ID: <8a1db3a5-09b3-4ef1-87e8-66553a81ec27@os-cillation.de>
Date: Fri, 6 Mar 2026 23:36:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
To: Michael Walle <mwalle@kernel.org>,
 Sanjaikumar V S <sanjaikumarvs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
 sanjaikumar.vs@dicortech.com, stable@vger.kernel.org,
 tudor.ambarus@linaro.org, vigneshr@ti.com
References: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
 <20260223091733.47-1-sanjaikumarvs@gmail.com>
 <DGM8HPC181AF.3FCCS4MIE4A43@kernel.org>
Content-Language: de-DE
From: Hendrik Donner <hd@os-cillation.de>
Autocrypt: addr=hd@os-cillation.de; keydata=
 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 li+2
In-Reply-To: <DGM8HPC181AF.3FCCS4MIE4A43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 418232285C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[os-cillation.de,reject];
	R_DKIM_ALLOW(-0.20)[os-cillation.de:s=202409];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[os-cillation.de:+];
	TAGGED_FROM(0.00)[bounces-223393-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
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
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,os-cillation.de:dkim,os-cillation.de:mid]
X-Rspamd-Action: no action

Hello,

On 2/23/26 10:29, Michael Walle wrote:
> Hi,
> 
> On Mon Feb 23, 2026 at 10:17 AM CET, Sanjaikumar V S wrote:
>>> Raises concern about writes ending at odd offsets potentially
>>> having the same issue
>>
>> The odd end address case (trailing byte) is already handled in the
>> existing code at lines 243-255:
>>
>> /* Write out trailing byte if it exists. */
>> if (actual != len) {
>>      ret = spi_nor_write_enable(nor);
>>      ...
>>      ret = sst_nor_write_data(nor, to, 1, buf + actual);
>> }
> 
> Ah, I must be blind. I stopped reading at the write_disable.
> 
>> So write_enable is already called before writing the trailing
>> byte. My patch only addresses the odd start case where BP clears
>> WEL before the AAI sequence begins.
>>
>>> Suggests simplifying the conditional logic by removing the length
>>> check
>>
>> The condition `if (actual < len - 1)` avoids an unnecessary
>> write_enable when len == 1 (single byte write at odd address, no
>> AAI follows). But if you prefer unconditional write_enable for
>> simplicity, I can change it in v3.
> 
> I know, but I actually don't like repeating the condition in the for
> loop. So I'd prefer to have a local "needs_write_enable" boolean
> which will be set to true. But then, I wouldn't care too much if
> there is a write enable followed by a write disable for a rare case.
> 
>>> Notes the patch lacks runtime testing
>>
>> I don't have the hardware setup to test odd-address writes at the
>> moment. The fix is based on code analysis. I have tested patch 2/2
>> (dirmap fallback) on hardware.
> 
> I'm hesitant - because like I said, if there is really a bug - it
> would have never worked correctly, since day 1. But yeah, I've also
> read the datasheet and it clearly states that the byte write will
> clear the write enable latch.
> 

i can confirm both patches fix real issues, i have similiar fixes
on a kernel tree i always wanted to clean up and upstream. Diffs
based on 6.6.127:

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 197d2c1101ed5..eaa50561ede2c 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -155,6 +155,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
                 if (ret)
                         goto out;

+               ret = spi_nor_write_enable(nor);
+               if (ret)
+                       goto out;
+               ret = spi_nor_wait_till_ready(nor);
+               if (ret)
+                       goto out;
+
                 to++;
                 actual++;
         }


diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e4..646bfb2e91a65 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -276,7 +276,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
         if (spi_nor_spimem_bounce(nor, &op))
                 memcpy(nor->bouncebuf, buf, op.data.nbytes);

-       if (nor->dirmap.wdesc) {
+       if (nor->dirmap.wdesc && nor->program_opcode != SPINOR_OP_AAI_WP) {
                 nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
                                               op.data.nbytes, op.data.buf.out);
         } else {


I think patch 2 of this series is the better approach though.

Regards,
Hendrik

>> Please let me know if you'd like me to send a v3 with the
>> simplified unconditional write_enable.
> 
> Please see above.
> 
> -michael
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


