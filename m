Return-Path: <stable+bounces-132883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BFA90DFF
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E522A7AC9E5
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ADE22B8C1;
	Wed, 16 Apr 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtSxJcDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309523372F;
	Wed, 16 Apr 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840171; cv=none; b=g4BZ+gntFu4E7aLVkE8E/LmZ+mDc1I7NWO0wUq90bZ3Gc3tffLUYYAGJcxcuPcv6/8DtuT77tC6lUcKmKUuNGgIZIo1T95V4FaXjAwpBPGGidbevMsbVMGp5LCAa/wjvAREt0m6uq5OO/jkYk+C2OITdIoDYreL7FwR5JgWKHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840171; c=relaxed/simple;
	bh=LmdX5vk/Z5+hgFN04MytdoVTsavoL86ivKVH3/gARZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5oc8VqXe9+dA8BtiCNqOwjuiVQ9G5MB9C4pIlvLNs4ZZB8MlXjl4dkMMhRXBpBG11IbuuGX0vQ0cbbQ9UJSA8pzAlJQzgkKHJey61ibVBTw8VEMC9+cKG2jAji6va8k0ekFO8ou8bjQsup+bNz56nIdGY/FesMbGALFun9f3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtSxJcDM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25520a289so14062666b.3;
        Wed, 16 Apr 2025 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744840166; x=1745444966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuAsoSRWs3XXMkPQiT04hZEE3IG6isgmWWPjEa55rjo=;
        b=MtSxJcDMIF40Xo+w4hl7dt9ilueLJgUx6dX02uB5EmWmuE1Pnq7S425wywUJnesdYV
         e4TtOsNP0TSwC369PGgX/p3SZ+0dBt/aQGsO2RHCuhZwMgs2ls+ge3GgUkFLu5G+Rovw
         0kvD9zOKrAfrGUEt3I0XI9MxvMwydqx7njfGoOBOo/6LtdS3vd4TpBJP8udIz5NRBy0O
         KMWNQgxh6KMVtEllqin9yzhZoMsr2cEiwAjyM94b8m6p8v7xMDjacmwdylO5aPsLH2bI
         gNkE+Jx0djl8HtdpxqcxWObihwfC/NIITVknG0SeigMcy+Yg9PLLdGXXZ8iBcMd38pwZ
         pK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840166; x=1745444966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuAsoSRWs3XXMkPQiT04hZEE3IG6isgmWWPjEa55rjo=;
        b=PYwfoTeU1YJclrJW/U/WTJOWDtZBapcpMHRm+rMSmYLsyG6tGNF6UGyNu+yC/7VONL
         6o/CWMlrGR+WQt9zGIn/tENWAjowpjM64ttgFngcmLa0d260SSXf93NqqhANiGgG8LJp
         O7wuRXDPRKBRP9OE1dc0YTxOkeAwDgxz9gO0ZlH3hKqzdEaLJ4co35VG5BCWkE1ttXer
         hw0K5P2wqHgTmI272ftUOAsPfLZbFqNFYkjt+CM1t4+Ktwlj+Gqfvv9MfN0WDlWCUyVs
         UoJ54tFkcNMx9iy2tRGgbnxBEpae9ntvLaiY0s31JOc8MIJCdmfrsrEKK4ZCceG288RH
         yvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW30W+ALVSCmu2Qyut3rKAxYIyLJJqp0qBG793Bp/+yikC2aZxg+Gf+80OWG3WvocHPsdlt1CtXLFf/Gc=@vger.kernel.org, AJvYcCWx08d4yr7m1p00G6nSNTy4jN95ATCeFN8aZlxVNV4KPK1IM66xLAfp5bXSqVOARnQA7hix5vCQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwusVVejy1sdK8UN9/D/vPktpjTGmlMP65tS85a53ew0knOvJ8t
	4Mivjh9QnER+TBjZMVDaLWaUf4OKk+p5k1t4oj+1CSxuLiS4MAU1CFVNVMRG
X-Gm-Gg: ASbGnctsx7o+zo0g4AQPh3lUONFYNqzPI4u3WxMf2fZ+yt1qyKWwRpuLgELHjLrdHrG
	/wxH/TDHDtatrpXxrfG60ZCbIVKBV+0oIo0xD7tQhpwSFRyBiiLnKjdxVHqWws9qm0UNpw9NKeX
	n0I7AmSL/a5cT+gRYcFgrO9pEdBYFb+EDNW3k/5iQvTX1ZA99GHkuScRXoIiwgFBzms06aIYnRz
	3Czni+WpBupSEpvXlmnuxHs2HW3UmQpNwo0bsYteAXgzT9ZrBR9ucmJWZsP+Xo1s9eKC6KnveJ4
	BwPQs9zVVI5ENASSHXwdLGlY6EYiwSGDLyFjGbPprE2oEsZqsDe0MeTGxC2d4Q3gKFjdb5VLFA=
	=
X-Google-Smtp-Source: AGHT+IG2kUiL7yGVIL+oa4rcD7PDtuEb9dFfWdovybmt7T7ov7aU4NDkdAzlU2k3yGIoxsTNHQ4Z7Q==
X-Received: by 2002:a17:907:9712:b0:aca:d27b:b20a with SMTP id a640c23a62f3a-acb4288cf2bmr327108466b.7.1744840166091;
        Wed, 16 Apr 2025 14:49:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128118sm191120066b.122.2025.04.16.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:49:24 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 20E59BE2DE0; Wed, 16 Apr 2025 23:49:24 +0200 (CEST)
Date: Wed, 16 Apr 2025 23:49:24 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Milan Broz <gmazyland@gmail.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1] mm: Fix is_zero_page() usage in
 try_grab_page()
Message-ID: <aAAl5HdLYQl3nIjO@eldamar.lan>
References: <20250416202441.3911142-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416202441.3911142-1-alex.williamson@redhat.com>

Hi Alex,

On Wed, Apr 16, 2025 at 02:24:39PM -0600, Alex Williamson wrote:
> The backport of upstream commit c8070b787519 ("mm: Don't pin ZERO_PAGE
> in pin_user_pages()") into v6.1.130 noted below in Fixes does not
> account for commit 0f0892356fa1 ("mm: allow multiple error returns in
> try_grab_page()"), which changed the return value of try_grab_page()
> from bool to int.  Therefore returning 0, success in the upstream
> version, becomes an error here.  Fix the return value.
> 
> Fixes: 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")
> Link: https://lore.kernel.org/all/Z_6uhLQjJ7SSzI13@eldamar.lan
> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> Reported-by: Milan Broz <gmazyland@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index b1daaa9d89aa..76a2b0943e2d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -232,7 +232,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>  		 * and it is used in a *lot* of places.
>  		 */
>  		if (is_zero_page(page))
> -			return 0;
> +			return true;
>  
>  		/*
>  		 * Similar to try_grab_folio(): be sure to *also*
> -- 
> 2.48.1

Thank you, with your patch applied one test VM with a PCI passhtrough
configuration start again.

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

