Return-Path: <stable+bounces-114076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B731EA2A7C7
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0A71887B23
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBE22C325;
	Thu,  6 Feb 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rBU684MG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9F22A4D3
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842104; cv=none; b=PHCzEAKMdYuaBYhYFM9b2w80YiTTdS30cq2ir9auOeRuwX+otlcDQOll94a9+fsQYaJKm8wuampoAqmJ1h0cOd6xB4cTqqU8P+dl4rWBSwNuC7BssIKXxtx76ZZFiCc2tklAFuTIpqJN9ys37zOeqHnHzNpLAKSFu1VuYRPkyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842104; c=relaxed/simple;
	bh=uPd/seLc0R/OCTGhswhENSfy993FEKKvyB0nCxN2bzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRnNRA4rTUfZL61rAqSfI/Y4jOj4j9og0VYBK3QPRFasIvOvN/Npqo4NvnS/Yo7dM/TAu8dZTVUoNkJ8LIgTTMjNMdQeIbFpEVLoqRUrh2iPOfXljEzEVSv30Z1bl5lth1EkSAlpgw4SA40nuuZYHRkBVHAnrvQ+2F21MT5JdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rBU684MG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 344893F291
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738842098;
	bh=pxRegLnQ2ckk9B0H5x44QGdXpNaEQZAvL/r+edA76Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=rBU684MG/1ZmpVOkmC2DqkiIsuD4SP1Xh2F3tfwFM9joxQhOBBmzDm45TH1UhVq+L
	 yKzNmGXWeSHXf5iGB1CTLFIh/+Dzrsp3un2UUqa9WEs5c5c93y0mB//tmEXCsDgH1r
	 yXR6A0uRi7qyFLQ+dK9J8lgczaWsev/o38H4sikAnJwSfhPDIuNjGogQbm+HX8iPy6
	 w2iuA1U9/vWW9gWZWqJhcl/RWeBe06Ih1LMtgHgdnsaZ0JQgzQGGl8ZknpiTcRbUMc
	 L7h0sPKipW5AIEbcFWuurXcn3f0CdRieYYRmaUUztryRlppJzqoZXVKgW55VhQkHpE
	 //GDAdnNSVXWQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso2497320a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 03:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738842096; x=1739446896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxRegLnQ2ckk9B0H5x44QGdXpNaEQZAvL/r+edA76Vc=;
        b=qhaxWGMW/09E6NTdzdKVX/pXRq3bdgRpIhZVUn+SmtMUlBL4IMv0FEkXfnYQ22q1C3
         +m2auHZkfd3/o1IOYOSgNC/RGmQQZMyCf42LitnbpgnZeZE4WtwXiI2+YYwtaEAw11Uy
         nqszb3NxbaM7I2i/wv6/4R4eYUVmN4++Q9VOFDnwH3cUYntImO7PiZUMTl0V4JHTmFcY
         FSLYF0B9GXiti5NVrJX1hauXzAo5rfUfHjQh6utk8oIpTnpBrihor751ihQmEUhnfLR5
         F98O7DO6GS4aS3da5knGaIdUvMi4hDOOWZNT+FHjj6PGOnxUABcF4xkMLm1IxK4n7hEc
         fWUQ==
X-Gm-Message-State: AOJu0YwugqAYaQT7Jmyc745MrNXMZbQ+6l7ZmujXQYOEs/xoNL+ATUpg
	DhJcuuUx44DGS5qbTsO838VXPHqqv3N1iaWRZgg6J/ffetUWeo6uQRxwt0gw6UwotihzBbB2XMB
	Nd40V0qMainE8yZt3xKORmx7Q5A4d2nOH5+DKPr9nkFUttBYRQlwmlik/+SIW4FOKUU7ATi6AKJ
	lPIw==
X-Gm-Gg: ASbGncthd2Y+MIOmZM2668YAK6OLnHGsR4SApYwz+/S3+f5sv+Ih4gbiXKV9C05iCtp
	n5mKl9o1PJSutz9u0ONtMWfYVqE7++Cs60Jm50xn8oD8VxOUaD1BDDFD3Hv3jMsUrO6io6TOiD6
	fhP8yaU5HttagPJDQB9MWkTzMszeVEJNWjTlQD2TGc5hyDHUZQh0Pt/+4Anx564b4yqIme0YOSz
	BSmw/Y9IuxVfo+UjFh/C8Pv9jI6PnCJfqaOzH/buS5j0+2t75zGHchYp9bOxWEAl8pktLtNA9n7
	viX1IoQ=
X-Received: by 2002:a05:6a00:3a01:b0:726:54f1:d133 with SMTP id d2e1a72fcca58-7303513960bmr10558142b3a.12.1738842096298;
        Thu, 06 Feb 2025 03:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgWFlboY9bVv95oILpdZGtSBQdmygikI9ZzimmOUBKZ9x2HbGcBkcS+B2DV7qPOnVt92hGlw==
X-Received: by 2002:a05:6a00:3a01:b0:726:54f1:d133 with SMTP id d2e1a72fcca58-7303513960bmr10558106b3a.12.1738842095895;
        Thu, 06 Feb 2025 03:41:35 -0800 (PST)
Received: from localhost ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1375sm1075175b3a.119.2025.02.06.03.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:41:35 -0800 (PST)
Date: Thu, 6 Feb 2025 20:41:33 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12 102/114] btrfs: avoid monopolizing a core when
 activating a swap file
Message-ID: <q6zj7uvssfaqkz5sshi7i6oooschrwlyapb7o47y36ylz4ylf7@dkopww2lfuko>
References: <20241230154218.044787220@linuxfoundation.org>
 <20241230154222.045141330@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230154222.045141330@linuxfoundation.org>

On Mon, Dec 30, 2024 at 04:43:39PM GMT, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.
> 
> During swap activation we iterate over the extents of a file and we can
> have many thousands of them, so we can end up in a busy loop monopolizing
> a core. Avoid this by doing a voluntary reschedule after processing each
> extent.
> 
> CC: stable@vger.kernel.org # 5.4+
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/btrfs/inode.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7117,6 +7117,8 @@ noinline int can_nocow_extent(struct ino
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> +
> +		cond_resched();
>  	}
>  
>  	if (file_extent)
> 
> 

Hi, please let me confirm; is this backport really ok? I mean, should the
cond_resched() be added to btrfs_swap_activate() loop? I was able to
reproduce the same situation:

    $ git rev-parse HEAD
    319addc2ad901dac4d6cc931d77ef35073e0942f
    $ b4 mbox --single-message  c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com
    1 messages in the thread
    Saved ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
    $ patch -p1 < ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
    patching file fs/btrfs/inode.c
    Hunk #1 succeeded at 7117 with fuzz 1 (offset -2961 lines).
    $ git diff
    diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
    index 58ffe78132d9..6fe2ac620464 100644
    --- a/fs/btrfs/inode.c
    +++ b/fs/btrfs/inode.c
    @@ -7117,6 +7117,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
                            ret = -EAGAIN;
                            goto out;
                    }
    +
    +               cond_resched();
            }
    
            if (file_extent)

The same goes for all the other stable branches applied. Sorry if I'm
missing something.

Thanks,

-Koichiro

