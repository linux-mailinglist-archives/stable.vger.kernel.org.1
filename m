Return-Path: <stable+bounces-43443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7B8BF657
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 08:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E81F230B7
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D584A94D;
	Wed,  8 May 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="BM5MwsgB"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604F20B3D
	for <stable@vger.kernel.org>; Wed,  8 May 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150238; cv=none; b=W+AXjJOE6gxkZHmxxzeLVqrHvdNIO5jB1vor7F0OYgVbsqBtI/Ibys7YlwI6iexZIBCmxkL5B/5F1vPk5KVo3dH9l+uTSBgQNaioXBAUoL1fs6roY0yO6iy4YkBfD0NqyefTuBDEv6v7kOpkzGjnGJMQyvPTbdK8iYOB9muE3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150238; c=relaxed/simple;
	bh=erb+TCNJaw5WL8VUOd7il59pOVSkZuOGFiyConzKwWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0SqtSrcr3Q6CGxEdrhejGT7vGSwI/LzkhUNquarWipMwj1la0tnCBO3FhtGrAlIZsXZUQ6lzZXARCVnxghOav1+TAFso2fYS+4QYWWSDMqe8lziNmxwF4EddaACmsGTaCgGTunHqnCJ/cLrghe5FFVk3NL2VbV2QaXDqveMt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=BM5MwsgB; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02F5E1488174;
	Wed,  8 May 2024 08:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1715150227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BCDMUHxH7zhVa+DyU5CH1wIgdcR2YUBiJ5C+ZREWqJE=;
	b=BM5MwsgBgiPNNEs5y+B8IcJlStq/s9A/JMbJkY3Iecq9q58iZ27dCxKkih3zS7vbDuX9Hw
	/aL41xbYH4bktvLsd8pZ9lDRwlat8+DWqQ4rHYemIOGtLW4wAGnQegbW72eCD4NsML0ZpG
	39MWFArNQyq+1d73GFyFjvk51Q5mXyoO1SrxsSjLVGavjgNfILhfogV6wfjQxWaIDX0KEI
	+PybNIg5SMhauDZ+7ZumIPJsEI4lao3znT8Wu2wSYgCUIbKlM7TkAEBC+ZrnYMxTXLrlGx
	ZyFw+uFgYp5oIB3+XrhG+0k0LDLrd2WPnk30h9XqbRHXJPpgCg+5tUoTZOmqXA==
Date: Wed, 8 May 2024 08:36:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org, Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: [PATCH 1/2] mtd: rawnand: Fix the nand_read_data_op() early check
Message-ID: <20240508-griminess-residue-e376b3315f55@thorsis.com>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Steven Seeger <steven.seeger@flightsystems.net>
References: <20240507160546.130255-1-miquel.raynal@bootlin.com>
 <20240507160546.130255-2-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507160546.130255-2-miquel.raynal@bootlin.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Miquel,

Am Tue, May 07, 2024 at 06:05:45PM +0200 schrieb Miquel Raynal:
> The nand_read_data_op() operation, which only consists in DATA_IN
> cycles, is sadly not supported by all controllers despite being very
> basic. The core, for some time, supposed all drivers would support
> it. An improvement to this situation for supporting more constrained
> controller added a check to verify if the operation was supported before
> attempting it by running the function with the check_only boolean set
> first, and then possibly falling back to another (possibly slightly less
> optimized) alternative.
> 
> An even newer addition moved that check very early and probe time, in
> order to perform the check only once. The content of the operation was
> not so important, as long as the controller driver would tell whether
> such operation on the NAND bus would be possible or not. In practice, no
> buffer was provided (no fake buffer or whatever) as it is anyway not
> relevant for the "check_only" condition. Unfortunately, early in the
> function, there is an if statement verifying that the input parameters
> are right for normal use, making the early check always unsuccessful.
> 
> Fixes: 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only once")
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
> Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index acd137dd0957..248e654ecefd 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -2173,7 +2173,7 @@ EXPORT_SYMBOL_GPL(nand_reset_op);
>  int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
>  		      bool force_8bit, bool check_only)
>  {
> -	if (!len || !buf)
> +	if (!len || (!check_only && !buf))
>  		return -EINVAL;
>  
>  	if (nand_has_exec_op(chip)) {

Thanks for tacking care of this.

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex


