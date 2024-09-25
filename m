Return-Path: <stable+bounces-77692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95F9860BD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE96EB2822D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB415C12F;
	Wed, 25 Sep 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZJHGiHAF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9E13DBBC
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269311; cv=none; b=O02NxoniPONR69UfIxF/RduH+SXm9PMKl02ctQ2TXe3pyU8PSK40Fh4m4jeoMFWKTywnv4664chnScsTx9gUBXOkgwiMwul3wcDHXph8CSJ/AOkQ7Vj2jRJ7581U4diAYJ0pm3889tHAfV2KdAcNq36zzSw7LJNRypvNaBF5yVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269311; c=relaxed/simple;
	bh=/I2QyuALtHqcZ4GKUEhdX0jON2I0ZTnTM6uixWW961A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5zZSe0uzCl/5jaDVCH6Xt2iOO7/Glz7Ns1nf/piAuxcAyfYlOgbXD4HZlT6H4VFm970/AV7plydmGfp7IXipEQXh0skM/2fFS0lkvFsFIfX/wZn5LUUe8IDswDi9MIBWajjTl0p5pSHvQ4U9AYTpd8KAAJS8uuxSFFtzodgzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZJHGiHAF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7178df70f28so5134296b3a.2
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727269310; x=1727874110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hs7Rj+geVPl0+wE/2Riapln7P4i8+opp+f+HJRO79M=;
        b=ZJHGiHAFS2AgScucvvWX3NCYCxcshW9W19k3I9uqzfr2w399/a/heKllDE6r+cbK9Q
         qOnyEIEsCNxa6x2kjeAufWFV8+88lbP/ElRRRHj23uxgUmdPBdw1ETd1aOhvh5bkvyvB
         yqzaxM5Y3J9BxcYmTF5Fo4xducN9rUSoS8gOtzBAqX8B1KvWvumrFPOtnSxkfQGKpJNW
         f6iSuDRv5k+8jWlJtUyU2JtSEEwIq4PEUPGwHO0fPnxdMgNs9e13MXt9mRK9W27/h5RN
         VJCO4ZaZYB2YisTYoEdelYlbWoSoTvi0yQz8jLL0yRNL8u8nG0CF4tCasEPck2/kGeyu
         SA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269310; x=1727874110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hs7Rj+geVPl0+wE/2Riapln7P4i8+opp+f+HJRO79M=;
        b=Ud6z1GEhYV5TjwRfEUHPacDYEA1FPgHwVsa0K1OtZp4OSeQK8K50CdcrJL4vlJSMBy
         239UAaV9V1fyJYClF+K2nIRBu7wsSiYeHch2mkmd+P1wTaMmhCS1rnKWUdHZX2RmQ1/j
         CcQPvpgbpFuCY2t6s0wmRy5JUbYhv//podAlY5nQA+LQVr2npDwzIQQnIOZPBBuBmFAj
         IVEwmPEcC9qEq7dgaqyBagAKvq98yrogUUf0HMGQa07OsJRTD2fxSpH5tsK4qUCa9f0J
         5wXPoj7I/Amu/rDqSEWmXeBlSDxZOd70l7u4AsVnPbjpiaz4xun80nuGg4ZbD2bQqtwb
         MqGA==
X-Forwarded-Encrypted: i=1; AJvYcCVXlHCnI27iX3p2+2yqjG5urdM5Lz6PUsf6gCoLrXckpSnqYbArb82GNdQi0T/qDbNgkY7ngDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0h4XMqvW8oqUuqDIOSvsxnmss8FoKrBhnLBtDZgiUXJYvLnSu
	WDMDUuLQcYZC/uepZV8msRfq4AxfhgAdNJ9YZseCku8ZO3NifU3xxTNjLjcz9d0=
X-Google-Smtp-Source: AGHT+IGhVDXpQmSdOuPcFz0YHbnVT7KRb9mz7wJNr05mOpzbhnXZwabgK4/OENvrYl39bd7adJnW7A==
X-Received: by 2002:a05:6a21:3997:b0:1cf:e5e5:263d with SMTP id adf61e73a8af0-1d4e0bf0da3mr4193230637.35.1727269309727;
        Wed, 25 Sep 2024 06:01:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c7326dsm2566998a12.66.2024.09.25.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:01:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stReM-009sBT-2S;
	Wed, 25 Sep 2024 23:01:46 +1000
Date: Wed, 25 Sep 2024 23:01:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 237/244] iomap: fix iomap_dio_zero() for fs
 bs > system page size
Message-ID: <ZvQJuuGxixcPgTUG@dread.disaster.area>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-237-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925113641.1297102-237-sashal@kernel.org>

On Wed, Sep 25, 2024 at 07:27:38AM -0400, Sasha Levin wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> [ Upstream commit 10553a91652d995274da63fc317470f703765081 ]
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.

Please drop this. It is for support of new functionality that was
just merged and has no relevance to older kernels. It is not a bug
fix.

And ....

> +
> +	set_memory_ro((unsigned long)page_address(zero_page),
> +		      1U << IOMAP_ZERO_PAGE_ORDER);

.... this will cause stable kernel regressions.

It was removed later in the merge because it is unnecessary and
causes boot failures on (at least) some Power architectures.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

