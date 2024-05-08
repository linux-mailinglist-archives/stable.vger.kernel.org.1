Return-Path: <stable+bounces-43444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34568BF66E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2231C21BCD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA7B1EB3F;
	Wed,  8 May 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="cL+qAbND"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE681DA53
	for <stable@vger.kernel.org>; Wed,  8 May 2024 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150511; cv=none; b=cyWH5hhQkcHntymKe2q47I2A+lCoHvRKTDnsJjyXqlz9YfBnCC4UcKBT7LkfN2UP0mEBj4+ip+bunyXpxatxZ3xs/99nlvgFmPEvdK6EGGkrMeSe+JTvwXX1QqmJ8XpUEZJ6tftUXu9hYOPKt3X6a+4K9UstWgYLPVK97IBmOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150511; c=relaxed/simple;
	bh=V2NUkMzfvWhK2ZEd5QFdgQintIXX3xSmJQMur2Ma9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFABoLZuB9rY/CSIhXT6e4J1Pu2ZFDHsp2xL6BwbMr5evM0ZXJh2a8VZMVAsf8cZMV18vbBkIAP/Jp2fJnRYpVUhpWHGkoBniWS2E8srw7HooyCqVd9iEzcrgkFd93dUpTZZF7YOkp//XABf21z2VBho7IkXMkGI4m7jZ/ndb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=cL+qAbND; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4402C1487F8D;
	Wed,  8 May 2024 08:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1715150506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6OoEksKaoMJMftePwSYkDUWexbh0YId9wFcw5AtRcgY=;
	b=cL+qAbNDUpTEsslUQMeMoGb5X9ObZlmWtegaKd/dqNWbonjS5IFBhPy3ccLsUd5priurt4
	mWabOkzvuXlMUiSpdGeQ8OaH24SlRle4NbsBTw0Vx2PrvNhXUfwYng5KWiAUYuoH6fFr3X
	OvrE1zW0WvoykhTEd+ughSXI5QSqMTFcw5bNaN5XclQZYdOwcHHWj24JV7ZuuBs/39pprp
	VM+lRXlWWzdaBf6UrIPKslP/tIOaXJX+UPTurWL4In5SAoRXupJRt4/lL3Cwyv4/CV7W7N
	i7vS/mt/d8HXYoTAA0zdgDyqpWuVkmfXn+/0Ocdkhfhdte8ZKzYn6MQJd1d5Ww==
Date: Wed, 8 May 2024 08:41:44 +0200
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
Subject: Re: [PATCH 2/2] mtd: rawnand: Bypass a couple of sanity checks
 during NAND identification
Message-ID: <20240508-patient-cover-54085f1981d8@thorsis.com>
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
 <20240507160546.130255-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507160546.130255-3-miquel.raynal@bootlin.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Miquel,

Am Tue, May 07, 2024 at 06:05:46PM +0200 schrieb Miquel Raynal:
> Early during NAND identification, mtd_info fields have not yet been
> initialized (namely, writesize and oobsize) and thus cannot be used for
> sanity checks yet. Of course if there is a misuse of
> nand_change_read_column_op() so early we won't be warned, but there is
> anyway no actual check to perform at this stage as we do not yet know
> the NAND geometry.
> 
> So, if the fields are empty, especially mtd->writesize which is *always*
> set quite rapidly after identification, let's skip the sanity checks.
> 
> nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
> identification in the very unlikely case of:
> - bitflips appearing in the parameter page,
> - the controller driver not supporting simple DATA_IN cycles.
> 
> Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers")
> Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers")
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
> Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 248e654ecefd..a66e73cd68cb 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -1440,12 +1440,14 @@ int nand_change_read_column_op(struct nand_chip *chip,
>  	if (len && !buf)
>  		return -EINVAL;
>  
> -	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
> -		return -EINVAL;
> +	if (mtd->writesize) {
> +		if ((offset_in_page + len > mtd->writesize + mtd->oobsize))
> +			return -EINVAL;

These doubled (( )) are new and I think not necessary?

Greets
Alex

>  
> -	/* Small page NANDs do not support column change. */
> -	if (mtd->writesize <= 512)
> -		return -ENOTSUPP;
> +		/* Small page NANDs do not support column change. */
> +		if (mtd->writesize <= 512)
> +			return -ENOTSUPP;
> +	}
>  
>  	if (nand_has_exec_op(chip)) {
>  		const struct nand_interface_config *conf =
> -- 
> 2.40.1
> 

