Return-Path: <stable+bounces-231234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DiKEBCJymn09gUAu9opvQ
	(envelope-from <stable+bounces-231234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:30:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69535CDE3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0BA230439FE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D73D8915;
	Mon, 30 Mar 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrzkimvW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE73D890A;
	Mon, 30 Mar 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880609; cv=none; b=ekYMIGY96paKDMRC0Si+Nuq6TR5066UlunV5CKyYS19gDFT/Zv4zBFCKHwiqwaoFkPCoscmpZ1jqJZqfBZL7mZHMuPD2pCU1cdpUbswVabmRXbYY7SdBtTnxP4AsqgvrkowqIBSAWEZr614vFfQ91QMpUhS6EmIvW4y+0EasWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880609; c=relaxed/simple;
	bh=e0hg5eoopMhTtmpcjcSal5SyT8XCUR+mbUqFsFXPDKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcMo1y4xeVHsnVE+HSWJw6pQeII3YDaeDkL1bi31d5kMz0GWL/KElAyt8gSBt9X+6S4xra/h/+scGw33iPsHqIsrwKetee9ZqvhoF5SLPOFbzlqBohFn5xxutaM6TdvJiMG7ryMYNhHksXzn2QCJI1H2r54rIqihnGT3nF03cLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrzkimvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF42C4CEF7;
	Mon, 30 Mar 2026 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880609;
	bh=e0hg5eoopMhTtmpcjcSal5SyT8XCUR+mbUqFsFXPDKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FrzkimvWMG+nbVM5UKZb8g2tqwoHEWNuBqtaU1Ez05sztLuk4jBmqLk2SrgOdMVF7
	 0ZBNil9YLv6aaSdfMYRhuAn80iO/4c6Qlf51GLOM8jpNpufcS7+9DAIKdFYyeExIIb
	 LaiWclnLZjomd7StJ8369lyc9AJxTpIlnxMzoEKIpKhm8dqew1uPctyWVIiCB0Pcel
	 +oFJs2MRQlJo5FlSeOCCn6MUyF3wW5ntzPQz1m8Bsn0lILROxGb5KRc8vWwvZ13zuB
	 YviYP/boG8rjOg1MW2uyNEQC4KsCrT20XOlEFBfQx590iW0mMN3cQyswoqFVYeBePj
	 vn4ukvlL9t7sA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>
Cc: mwalle@kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  miquel.raynal@bootlin.com,
  pratyush@kernel.org,  richard@nod.at,  sanjaikumar.vs@dicortech.com,
  stable@vger.kernel.org,  tudor.ambarus@linaro.org,  vigneshr@ti.com
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is
 not available
In-Reply-To: <20260311103057.29-3-sanjaikumarvs@gmail.com> (Sanjaikumar V.
	S.'s message of "Wed, 11 Mar 2026 10:30:57 +0000")
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
	<20260311103057.29-3-sanjaikumarvs@gmail.com>
Date: Mon, 30 Mar 2026 14:23:25 +0000
Message-ID: <2vxz1ph11jmq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231234-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: DE69535CDE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11 2026, Sanjaikumar V S wrote:

> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
>
> When the SPI controller lacks direct mapping support, the fallback path
> in spi_nor_spimem_write_data() uses nor->write_proto based operation
> template. However, this template uses the standard page program opcode
> set during probe, not the AAI opcode required for SST flash.

But if the controller does support direct mapping, won't it end up using
the wrong opcode? Would it be a better idea to update the dirmap_info
with the right opcodes?

>
> Add check for nodirmap flag to ensure the code falls through to
> spi_nor_spimem_exec_op() path which builds the operation at runtime
> with the correct program_opcode set by sst_nor_write_data().
>
> Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8ffeb41c3e08..cb7f4d447156 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
>  	if (spi_nor_spimem_bounce(nor, &op))
>  		memcpy(nor->bouncebuf, buf, op.data.nbytes);
>  
> -	if (nor->dirmap.wdesc) {
> +	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
>  		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
>  					      op.data.nbytes, op.data.buf.out);
>  	} else {

-- 
Regards,
Pratyush Yadav

