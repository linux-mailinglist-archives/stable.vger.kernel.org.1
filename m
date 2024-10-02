Return-Path: <stable+bounces-80579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC998DFCD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9919D288166
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC01D0B9B;
	Wed,  2 Oct 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYzaFd8L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DB42AA2
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884232; cv=none; b=W7VZOU2GKW5sCfWjjpKafxIgHV6p7FKnlSuIUtvFONDpMBBvs0f24TCbwRCcGSX/rK+bK5Ly48Dd9u24xKSycapb2uoHhi9JQRNyAsj+XfY6i9F/2d3Y1ysj3Wcj95wFEhzC0rzcCeudkhjEvnzk4/Okr49G1y/CyBVTneI4N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884232; c=relaxed/simple;
	bh=j6dEgihpibfT3gDsKKoI8CmyZ9XzHNp6HIdRJ+OqQ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTwLwA4jd/zB4t2oYQJikSYWuR428xO9IZYG3rSJ6rmHF1jagDw/+L7AT1K81cAoC54GDnuiwM1M9jK3bZuH5R+ksLF08sBcE2dR4a3s3gDVS8RBL596Q6Hcin1HBOuRlN/azP1oPoayBpWFTIboDciEBAUhP8miCNZTYEAxc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYzaFd8L; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d00322446so672754f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727884229; x=1728489029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APnLCyvlFfHjnxfVKTC4dkrYVgGL8uOmo/gayE076/A=;
        b=DYzaFd8LyMJh//zOwCwlk2z8oYldr7ziNiEpAmH/zlykFcVyoNvGx4OnZZahBuWqRj
         DwrH+aGjpzEz/xn6Rg8X+0Uf/kSF2Qkh6Ex9Z/SZDpypCtUR9eG3yeo941wd7ikOJyFo
         WbCL6Ds4stUYg048pbej2Dy5vG7eRpLd3zR3OcZPWg2FCDIiTYxuhzpirAJnjAoHDITY
         4n0RDzBo1vFVdJquaUSIprXXQ9qAuz/m8+xaQo4XlNK0O9+B4c8rZGqiNMUCm7bVYBiE
         vhrs5hiLgqxsJMzpcnBagZ0dNWilJ7sP+Ex1/L07TyY2PmPEMCR5ZtiRoRyU0M4Ap0So
         s8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884229; x=1728489029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APnLCyvlFfHjnxfVKTC4dkrYVgGL8uOmo/gayE076/A=;
        b=Rmk+uKR48VuPlIlpQMQFS+8WNWswpREeZ6RTuokTnQP/HqrSSs6z6Wq4mKscZ6NDJY
         AzDg7AvHIlF/UupL82Zh0ynf2w5/U9ZRj3hNRBZclzoe1C5JZRRlgBwi/zBFUSJ6sQ+z
         l7oSnfbCE7Q749zAJ2NWHvNBaMf9QmkRQFJkCkYbEMrRzfxQkGWIMA5HYXulguXrUfMf
         yKs1gm4Gh3LRdhfC0MRL5Rns3SnQoN5dyFEWTaxS8I2Z5xfXsd193dzF1377kk9xEX3P
         XRikcsJZDNlKtgO5BfCXL0hwShxbVoOn79G6YUl9t9PGbd7fjwVUXmUmXTCepkuhcHvA
         2M+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+xuQU/M4ZDRYHei261p0WrDxPVNTvohj4+ndQMZJg7eEyJS0KtEWLmVzgqD8ZOUFA4NN5QdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5u8SWxJd7iB0iuD0PtCYWd1oUj3zNFNJXLA6balSlA0ASOSp
	sDc5fS43lLkutkMN6/IGwDlnWVR1po22o4bOzhX7auatMk1witS5RpKzzUnZo9Y=
X-Google-Smtp-Source: AGHT+IFc8OdIf3PaiiyBgKi+RY7YJBLQcHpRCF+cuMnEGLaBwEiaaUTm5b78xvaqRWuNYHhjcPzs2w==
X-Received: by 2002:adf:f045:0:b0:374:be10:3eb7 with SMTP id ffacd0b85a97d-37cfba0a7a5mr2484226f8f.38.1727884228895;
        Wed, 02 Oct 2024 08:50:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730e92sm14210937f8f.80.2024.10.02.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:50:26 -0700 (PDT)
Date: Wed, 2 Oct 2024 18:50:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
	mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org,
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
	chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
	ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
	florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
	kirill.shutemov@linux.intel.com, kuba@kernel.org,
	luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
	rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
	yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
	yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <0c664087-e9af-4744-ac81-1839ea6b4051@stanley.mountain>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>

On Wed, Oct 02, 2024 at 09:26:46AM -0600, Jens Axboe wrote:
> On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > Christophe JAILLET (1):
> >   null_blk: Remove usage of the deprecated ida_simple_xx() API

It makes cherry-picking the next commit slightly easier.  There is still some
conflict resolution necessary so it doesn't help very much.  Could we annotate
these with a Stable-dep-of: tag otherwise we get a lot of questions like this.

Also when we backport patches from 6.6.y to 6.1.y then we can drop any
unnecessary Stable-dep-of patches.

> > 
> > Yu Kuai (1):
> >   null_blk: fix null-ptr-dereference while configuring 'power' and
> >     'submit_queues'
> 
> I don't see how either of these are CVEs? Obviously not a problem to
> backport either of them to stable, but I wonder what the reasoning for
> that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> surprising :-)

The definition of CVE includes NULL dereferences so that's automatic.

regards,
dan carpenter

