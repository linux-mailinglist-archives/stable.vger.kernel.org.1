Return-Path: <stable+bounces-114278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B25A2C9D6
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30EF16E116
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0B19342E;
	Fri,  7 Feb 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jR3B2Uf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0019597F
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948022; cv=none; b=eCgV1ybDFP3cN4EDJvHcmHF+81BdC7v6/d6aNUijz3azt645GND5qhIw4Mrrgi9HMU5lHXSM3Hn8grNtZagdM+V9QiY3xzyFxBAuHSCFDzT9Otlu95dT3YDyfLJCp0pUAxkoZrA2+nsgbnWKrpY0aA/MOBpL6tE8WfHfyfFNdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948022; c=relaxed/simple;
	bh=WnxzVfiBDOWKlPrs8uy9gGAmG83nu7iJWuRjeGWbCNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdI9cblkyZAWh3uZ1+tTUEWq6Z1CnpI+Z7PFYtCYa2d40jlzhOCt75C7zeE4wDJQmSri5zCWxEqLEPMdkeUSq4OXIo+0sZSv1yYzAUpDl9vF7L334F0naA6sS0DanOW/p2QPoohbFubRJOPcrWN5vgQJOId8O3uP1tCQ6MkgCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jR3B2Uf/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C6943F220
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738948016;
	bh=LpR99Ye14Bl3z61OmVYY2qgP2w3XFhQFmphCUyct0cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jR3B2Uf/5ZKIHOMLEi5Kwl1WL8YZTnFcpOBdO/IRTDmv3AB87MUNsUgEcSOEDAnSL
	 cTnhs+VnFT7UC8UrKBA9eIGi7y5TpBIENrzapTiX5LObkvoPCoctWRd25tQgv24KwG
	 GzsthQ/QJMmYNvsZ26OlWps+weysHVXkA4tqckewuL7riPzq6Mo7cOrwVaEcMNysLa
	 FJff4FW9S6UO6O5QPfDKdA0er82sT2MHdTLck1mcoJ5gPFzfkRnnbuf+acdH84sZZz
	 laRoZg483ezPhhvi8RYadKXN4nsdSR2iKxM7lrUn9PbRZUqxkgwQU9WrNbq3wSmWKD
	 5kSy+wd9at/sw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa3fd30d61so244377a91.0
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948014; x=1739552814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpR99Ye14Bl3z61OmVYY2qgP2w3XFhQFmphCUyct0cQ=;
        b=g1jtbZK6rXtNkiadTQdKonze0AWjNvdoBDhHBybnxAxn+OuSvYr0newknuNeGbXt7O
         8QRG4QMFQf6DglkU45aQ2ZpP9Bq9GnG5udpNkidydP6eO2Y9Y681q7uTrRt1y5e9Bol1
         /zNx7jLZa47Ai73LqzLz1zwO6jmA0PoGOlm2Yrd9537ddsLyMlTdklrhfrC2bRPuWLXb
         f3Eflt7Vu6C74DTyUuTjxLnpP5JaE87DZMukW25j/otG416FU3I7dQrM2u/MlXXa+lsv
         uVGUDBnYG6KbG7zduBLi6lP5XGQndz+jjmGDce0CaqFsILKl1C4QcLYSNVLtlTEJxLYX
         1E+g==
X-Forwarded-Encrypted: i=1; AJvYcCUBYzEyGZ4UbwzzzkOKew9dhY2sUh6Xwc9ePUH6JMmgQPMvhmrNE+Imhw3ZikpG1Rr/0wRP0bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2NoL04f3FJQO0e4oAaUkdfSCk3PJ5pe5HjVx3bA579ZWxHb6
	P9dOW5pmivGKWV1zZ8KoGCS7csz4X4M2rtT8oh5/nCw3L2AOa3cxvoUzwmYuPbFzE8xK2c92h+V
	jNDRkS3i9nqnP4mn0NQMWPUtf3PhpPS0RyP0kgS5I0Sbe7lp9xofMP4Nyp0aRttvJxkG2BA==
X-Gm-Gg: ASbGnctDMpS7ZK3tV5MJJNZusqj+a3nzdWirqMlT1haZpfVhqvigSIc7NAesXGCQdRo
	1QbJeAwi+5x6419c4ubCqUX5JrBvhT+rxfrfM2S3pnCEcYfmqBqykWblaq3PotKZPaYs2t01w2n
	Eh0PdqgHsRy6pUYtaKfg2ero9GaVTu6qqG5+qDZIO9Z/6nzi3TjEdLFK8qx47Jg81bQIQ89IWc/
	4RYOtlHbebqTWL3+SYq/GQ3x464eDsE58lQZoduIwaiG/iivRqKcCt3RjFU7Y/8TYK/+xxq9cIj
	2Vg61O4=
X-Received: by 2002:a05:6a21:3406:b0:1e0:ce11:b0ce with SMTP id adf61e73a8af0-1ee03b6d257mr8098789637.35.1738948014645;
        Fri, 07 Feb 2025 09:06:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJBQDafFYhVotNsoO822rUdYxAjMfjIT6w0V06a6wSD3JLplbq4at3BA1ruD3EaS3VB7vGhA==
X-Received: by 2002:a05:6a21:3406:b0:1e0:ce11:b0ce with SMTP id adf61e73a8af0-1ee03b6d257mr8098734637.35.1738948014219;
        Fri, 07 Feb 2025 09:06:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:bf00:4534:dd5d:8dd0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf14b1sm3334500b3a.91.2025.02.07.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:06:53 -0800 (PST)
Date: Sat, 8 Feb 2025 02:06:51 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: David Sterba <dsterba@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>, 
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12 102/114] btrfs: avoid monopolizing a core when
 activating a swap file
Message-ID: <obtsofvu7o6mrgmf6u32hvly7zkgwxdqicorol4o64jqvyqe4n@kxz4jlgztzps>
References: <20241230154218.044787220@linuxfoundation.org>
 <20241230154222.045141330@linuxfoundation.org>
 <q6zj7uvssfaqkz5sshi7i6oooschrwlyapb7o47y36ylz4ylf7@dkopww2lfuko>
 <2025020634-grid-goldfish-c9ef@gregkh>
 <20250206174542.GM5777@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206174542.GM5777@suse.cz>

On Thu, Feb 06, 2025 at 06:45:42PM GMT, David Sterba wrote:
> On Thu, Feb 06, 2025 at 03:31:02PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 06, 2025 at 08:41:33PM +0900, Koichiro Den wrote:
> > > On Mon, Dec 30, 2024 at 04:43:39PM GMT, Greg Kroah-Hartman wrote:
> > > > 
> > > 
> > > Hi, please let me confirm; is this backport really ok? I mean, should the
> > > cond_resched() be added to btrfs_swap_activate() loop? I was able to
> > > reproduce the same situation:
> > > 
> > >     $ git rev-parse HEAD
> > >     319addc2ad901dac4d6cc931d77ef35073e0942f
> > >     $ b4 mbox --single-message  c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com
> > >     1 messages in the thread
> > >     Saved ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
> > >     $ patch -p1 < ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
> > >     patching file fs/btrfs/inode.c
> > >     Hunk #1 succeeded at 7117 with fuzz 1 (offset -2961 lines).
> > >     $ git diff
> > >     diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > >     index 58ffe78132d9..6fe2ac620464 100644
> > >     --- a/fs/btrfs/inode.c
> > >     +++ b/fs/btrfs/inode.c
> > >     @@ -7117,6 +7117,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> > >                             ret = -EAGAIN;
> > >                             goto out;
> > >                     }
> > >     +
> > >     +               cond_resched();
> > >             }
> > >     
> > >             if (file_extent)
> > > 
> > > The same goes for all the other stable branches applied. Sorry if I'm
> > > missing something.
> > 
> > Hm, looks like patch messed this up :(
> 
> The fix is part of 4 patch series. The stable tree 6.12 has only 3 and
> in different order, so this one fails to apply due to missing context
> and got applied to the wrong function.
> 
> Applying all 4 in order to 6.12.y (same base commit f6279a98db132da0cff)
> works without conflicts.
> 
> $ git cherry-pick 0525064bb82e50d59543b62b9d41a606198a4a44
> Auto-merging fs/btrfs/inode.c
> [detached HEAD 0466e0dbbb99] btrfs: fix race with memory mapped writes when activating swap file
>  Author: Filipe Manana <fdmanana@suse.com>
>  Date: Fri Nov 29 12:25:30 2024 +0000
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> $ git cherry-pick 03018e5d8508254534511d40fb57bc150e6a87f2
> Auto-merging fs/btrfs/inode.c
> [detached HEAD 1715e6abcf46] btrfs: fix swap file activation failure due to extents that used to be shared
>  Author: Filipe Manana <fdmanana@suse.com>
>  Date: Mon Dec 9 12:54:14 2024 +0000
>  1 file changed, 69 insertions(+), 27 deletions(-)
> 
> $ git cherry-pick 9a45022a0efadd99bcc58f7f1cc2b6fb3b808c40
> Auto-merging fs/btrfs/inode.c
> [detached HEAD 78d50f8c8827] btrfs: allow swap activation to be interruptible
>  Author: Filipe Manana <fdmanana@suse.com>
>  Date: Mon Dec 9 16:31:41 2024 +0000
>  1 file changed, 5 insertions(+)
> 
> $ git cherry-pick 2c8507c63f5498d4ee4af404a8e44ceae4345056
> Auto-merging fs/btrfs/inode.c
> [detached HEAD a162d2371965] btrfs: avoid monopolizing a core when activating a swap file
>  Author: Filipe Manana <fdmanana@suse.com>
>  Date: Mon Dec 9 16:43:44 2024 +0000
>  1 file changed, 2 insertions(+)
> 
> I have more trust in git patch logic than 'patch', this can happen in the
> future again.

As a side node, I just recently observed a quite similar pattern elsewhere.
Unfortunately, by the time I discovered it, the 6.11.y had already reached
EOL, so I didn't have an opportunity to report it for fixing.

The following upstream commits landed in the stable queue and were applied to 6.11.y
in reverse order (i.e. applied as #2 then #1):
#1. f3fe8c52c580 ("iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig")
#2. a985576af824 ("iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig")

that appears to have resulted in the backport for #2 being broken.
(see https://lore.kernel.org/stable/20241021102302.767569469@linuxfoundation.org/)
Since there seems no "FAILED to apply" announcement, I assume this was
handled by normal patch(1) usage. Just as an extra side note, #2 seems to
have been applied twice on the branch.

So, even though the patch reordering and patch application strategy are
essentially seperate issues, I tend to agree that when the latter causes
problems, it sometimes indicates that an issue with the former is lurking.

Thanks,
Koichiro

