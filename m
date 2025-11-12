Return-Path: <stable+bounces-194583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D159CC516DD
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5FC189F2C1
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206B2FDC3C;
	Wed, 12 Nov 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1WFMFF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329329AB1D
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940604; cv=none; b=Z+/TpzS/dFwiVln02vxiB0zWzWJost4WBu0cdGsdNUh2VWIaNw8VIHfaJojMITGP9mLglUrErpJLATSaxDmnRFAxurLnHfeb9Z1p5yXguTHskPXBHa8H8J5cXnrsermrOdI6bKDCg6571c37bhuGwwuFfeyhJ7pC8/K6b9JMseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940604; c=relaxed/simple;
	bh=B/oTr+r8DBtE1IvVTOVfT13oXFG62JkZ8sdE3AKxlpM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3iOPAXTVvMkSyJfTWZdG/t7RMOgPpgf1CYwwqJYQc0KXRYNQwJAb2SKwHoNbE755gnJQAeNW98YPv0I5jYe7riejSmaPNO3Mmjh+dXZngad/9v9XVsQp58FCBF/XiWnvDE3iL4HIItM3sxPXi4b4c+V18eYpa66xWq6NMNgBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1WFMFF0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so3192235e9.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940601; x=1763545401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2sZZR13em2kFK9vuHhMagBqaNxcu6HaXgiKpBFvnH0=;
        b=f1WFMFF0VNyHyNdldo2kq4PK+T54RBd96fAoVdzi7mD8NSupnRgeDXOKBqeerMG87f
         /FUFuW8D8YMQ5cRAwEButLN/XUmavSbNB6/iNBcC7EKMKvra+D7u2Sq5Yw8YbWNVUjXw
         +cmFrR8aNJRd/mKBIkPBCVdl6MHfoQtJIk5vK+WToWHmYNNkF69my4dBnF7w7qenMOmJ
         RRdvrJv6lIWNXwN5UfUVMVcWNuy9sa7NVwza1kjJPpJNLv4SwJ0XV+oApQqsyyv2aLME
         3owaXiP5glu9Lysh6NFvOugEWwpv5pRDqsjq17EmvgfJIS9j0cpE7G+DHNnl0qTMugZl
         W78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940601; x=1763545401;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2sZZR13em2kFK9vuHhMagBqaNxcu6HaXgiKpBFvnH0=;
        b=b+VI9++OOqdKKY04PZrVLDrnd0UT+EnPaxavYsugn1O7Z5UteKn3aWLB5xt9TGPfie
         Yy0x85IYIpJLDB693KVqPgv4amoBR8wUeSunl5SchTyBUyvNk+8p26WetrtB1o2ekONF
         BC7O+YjXGccJBrMylxtmedLH4Daj+WoQ2itwtxcLVws/3N4+fGNYwF7K5KfExPHHeOkc
         dqJ2Q/1SOqDAmgyTc7cv1WDUGFilNDsHLuXVCONcS9IEsD+HuHK9d0TRzhr2pqztRNY9
         aU0c6OWTaFSFoxtaDwQpp7AK+LU+A9XDOHNcSs8TtlIjUrIAZYcvxlgXpHV37SOFfN2t
         x5AA==
X-Forwarded-Encrypted: i=1; AJvYcCXz3jjaI+JAtYfmu2p69Nlu8sVcJsyLOihvh/ObtFA2I256YOaeJn2l6gioY2IiHJ2R2hBgrv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eY/Es3snAEKJ4d0KtE3gNnxoCf6ML6T4Fg0+FcPo2nZqR5nQ
	K8ZFR0jlq7jLVLoBMYd6bmY0rtRCoZMCSa+dfMsd8q9cijsVT1lXD5I8
X-Gm-Gg: ASbGncvt8uPnkhkcKokZwaOob9VL/vmFd5rzFNbM5NV4AxU6PPqPFd6dZrMise2CnRt
	9uD5nWgg5eI2mpwq+B8eEieW7pTGfijAJXyjRHL6Vh6U7uJ3DCkphhF0W8NUVB49aP92FFvwbZA
	ogWfik3ARmMUM2DYZl+UqECNwl6xTR29DgQNtVCrJcSiVO+YngCTpQ3QRpmyuhl/1jRJa+ixikk
	UvEnuuIyjjPwqT0CQVVhCgCD2HgyApCusHdxNosP0o4D0jfJlzw+jV6wDMG0ztrJQYlbZa0ERoO
	6FvVv4eUuE+VASD8nNgcTPpud1BOAEF10dQAtkYa1ln+Y7czz0wQhbouVjCfKGR1PC63F3jznbr
	ymnHGWtIco7eQB+XlcPold/L1R31VCXkCl1aYTFk/Gsm2KVBjDcAFhvQbfHkXzB1p+lHwQo72xi
	ss+gm8GHdCbq+D18lnAlxHfwaDVvtU
X-Google-Smtp-Source: AGHT+IFWRLil5c9QrjCfrciKn0pCpnUeeuzlRecgpwrZi29ini7Fw+ZEevTQknhxTgQmz8r53cyk/w==
X-Received: by 2002:a05:600c:3550:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477870468eemr22102045e9.12.1762940600679;
        Wed, 12 Nov 2025 01:43:20 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e743sm24556415e9.15.2025.11.12.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:43:20 -0800 (PST)
Message-ID: <691456b8.050a0220.3c21b3.5c4c@mx.google.com>
X-Google-Original-Message-ID: <aRRWtShR36d_16eS@Ansuel-XPS.>
Date: Wed, 12 Nov 2025 10:43:17 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on
 subpartitions
References: <20251109115247.15448-1-ansuelsmth@gmail.com>
 <87y0ob7fyy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0ob7fyy.fsf@bootlin.com>

On Wed, Nov 12, 2025 at 10:33:25AM +0100, Miquel Raynal wrote:
> Hi Christian,
> 
> On 09/11/2025 at 12:52:44 +01, Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
> > result") introduced some kind of regression with parser on subpartitions
> > where if a parser emits an error then the entire parsing process from the
> > upper parser fails and partitions are deleted.
> >
> > Not checking for error in subpartitions was originally intended as
> > special parser can emit error also in the case of the partition not
> > correctly init (for example a wiped partition) or special case where the
> > partition should be skipped due to some ENV variables externally
> > provided (from bootloader for example)
> >
> > One example case is the TRX partition where, in the context of a wiped
> > partition, returns a -ENOENT as the trx_magic is not found in the
> > expected TRX header (as the partition is wiped)
> 
> I didn't had in mind this was a valid case. I am a bit puzzled because
> it opens the breach to other special cases, but at the same time I have
> no strong arguments to refuse this situation so let's go for it.
> 

Thanks a lot for accepting this. I checked all the parser both upstream
and downstream and I found this ""undocumented"" pattern of returning
-ENOENT. [1] [2] [3]

For sure it's a regression, we had various device on OpenWrt that broke
from migrating from 6.6 to 6.12. I agree there is the risk you are
pointing out but I feel this is a good compromise to restore original
functionality of the upstream parsers.

(the other error condition are -ENOMEM or sometimes -EINVAL for parser
header present but very wrong)

[1] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/tplink_safeloader.c#L93
[2] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/scpart.c#L170
[3] https://elixir.bootlin.com/linux/v6.17.7/source/drivers/mtd/parsers/ofpart_bcm4908.c#L47

-- 
	Ansuel

