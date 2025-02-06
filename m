Return-Path: <stable+bounces-114119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F0A2AC59
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D268188A1AB
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FC1EDA0E;
	Thu,  6 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hcaK2gJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969CC1EDA13
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855288; cv=none; b=DPDweUvB2y8L1+pgiVhVX0R0pXS3Ff4o19y3u4Ozhk3c+HIWPpyxJXdEzH7Dq1VQbcV/uUzaQmOoElYnpZuw7mJlo2Wl7g+b7IdOvf4U8YUofqixGIFlQ3EF9rTvDuQnPTPJ8gh1MPEmV7jSW6OKWpvFfjRY4zUkOnpzWp+EG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855288; c=relaxed/simple;
	bh=Uppy9qyBqi0c00e5boX7N3UvJj7ICkV753yX5Oco/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCXjDFB0Lz/7Cga3YWvsRGcZdDyTB9fNUKl3XY42Hj9uhSf6nh2E+6xE+Dpkep8J6yO02Jzuqo3ZCF9Z1Owxpmd2sP6eM39VrZ7OkOs/I2anfTXvIlzcrZRvI9j4iycpjG9AHkk2Ezafl836058kryBr1Z8kv6yIrQfuDjL7oC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hcaK2gJf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B7A363F874
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738855283;
	bh=IJ2DYHPP6jpaqqb8sa/25NQW7hOlfXSzeHhsISe58hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=hcaK2gJflZBt5Mhoo5QXKJKdGB0WyEiNXJC7kAgoufdvoSKhyoMDa3e4htE6F6uyi
	 pOFTH3SNtU9NF5ay857GqJGpESCM+d9bIqN3FPTUKbFRRhta3r0Dq8nHEjezvrqJXc
	 tMnk/BIbQDfGFf9lXiMmqkaWcJ1Fc7JDvA5mUCQvK539v4oXu89N7sIEr6v9yNmcGk
	 WnuBoas2YtOtipOtKHnFERCEavIcIaliiJ8HPNTth4VlD3BBfJMJiCVVrHT07iSmD4
	 fIm8ApRlCOPgxBD+7XzPWDcS8/q2/8h74ne3r82eZdNnR0Fjf4N5NwjTPPcs0lt2+S
	 zPBqb0oYBpI+Q==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f49f0bd8fso2595165ad.2
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 07:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855282; x=1739460082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ2DYHPP6jpaqqb8sa/25NQW7hOlfXSzeHhsISe58hY=;
        b=JuagnM4UFv6PACoSrqp45Aex73YRkRuc6A3KaYrnPSrIqBq2S5OTT7VqrOyVqtFsBm
         UK3xL4uw3oIwFjkyMTvAxXTakEmNeSzGWvaTDVYibr6G5EOE6Kr3u4W2suf0ZE6qcEBz
         tDonatk3pIGgyego4UZ2e56tFnwn7dKueLTR7DLmgdnOBjPO74O9EI0lP8yOO1e0E5Uk
         qQTxVMAVDNs4BK3EutMwrKEpVbcpwwFHyKqPhljybjZVP7CElpaVWVbN32+t6PcmG20A
         ZdifbBR/33mhCPQBBLQa8ot85Q5D1uByVfNQIpdm4HBjJ31aRsr3IyUPfPkkW3PVIuex
         ug/w==
X-Gm-Message-State: AOJu0YwwMerKPJt510cfQFfNTEjY8kjFiTz3kVYcr7Zbdd1dypo9BaBt
	c0ooMKBajG0Wvni1pqJe9HhI6X1gq9H1dokXYF42DzRdqIo2SIm//KoFxYGg2C/IKQHtgwBkq5x
	Q/IrV0pf+jRmgv7Q7NsoUJeKTYYvgtnFkA1ShkquR7NTFhoefwQlcFEnE3G9yow5u85seVw==
X-Gm-Gg: ASbGncuC5qA0dNDx7NqGL2CfXgQLNybQS75V8fR/FMgSvdv9bQINDPf4az2wzQibOD9
	vyPGOleBSfynbLERFf2vdJ2kjzjl3nHZICAW6jQ4Vwp23Ox4FS2qVliGYurdDQ7Woly/wubwWF7
	fw+nRi2CrIOEbD2xvnKtw3UNMwyn98xRaJA7lyU6zXYZpscxwlNAsV06qespEoopA/0i71UlwSz
	eCVZlgWVVRvg+TvodnROqQK1F1ytymuhjKalJaV3e+a3EIQA9XJfXLsOH4rz+CZuKWHmt3VQBhb
	9aFQCPw=
X-Received: by 2002:a17:902:f64f:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21f17df5966mr125508075ad.5.1738855282208;
        Thu, 06 Feb 2025 07:21:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJV5YqdYsGVtUNsDjajCr0DNrDaLu6SH18R3fm2GAtrJXfmqW2UbO06XYN69xdS2FelhSVzw==
X-Received: by 2002:a17:902:f64f:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21f17df5966mr125507795ad.5.1738855281926;
        Thu, 06 Feb 2025 07:21:21 -0800 (PST)
Received: from localhost ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c79esm14077785ad.175.2025.02.06.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:21:21 -0800 (PST)
Date: Fri, 7 Feb 2025 00:21:19 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12 102/114] btrfs: avoid monopolizing a core when
 activating a swap file
Message-ID: <ltg2od752bpeknqtb7slhhdpqmey7nt4xpiygm6lpykgpeyi6a@mftshvw7ldqm>
References: <20241230154218.044787220@linuxfoundation.org>
 <20241230154222.045141330@linuxfoundation.org>
 <q6zj7uvssfaqkz5sshi7i6oooschrwlyapb7o47y36ylz4ylf7@dkopww2lfuko>
 <2025020634-grid-goldfish-c9ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025020634-grid-goldfish-c9ef@gregkh>

On Thu, Feb 06, 2025 at 03:31:02PM GMT, Greg Kroah-Hartman wrote:
> On Thu, Feb 06, 2025 at 08:41:33PM +0900, Koichiro Den wrote:
> > On Mon, Dec 30, 2024 at 04:43:39PM GMT, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.
> > > 
> > > During swap activation we iterate over the extents of a file and we can
> > > have many thousands of them, so we can end up in a busy loop monopolizing
> > > a core. Avoid this by doing a voluntary reschedule after processing each
> > > extent.
> > > 
> > > CC: stable@vger.kernel.org # 5.4+
> > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  fs/btrfs/inode.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -7117,6 +7117,8 @@ noinline int can_nocow_extent(struct ino
> > >  			ret = -EAGAIN;
> > >  			goto out;
> > >  		}
> > > +
> > > +		cond_resched();
> > >  	}
> > >  
> > >  	if (file_extent)
> > > 
> > > 
> > 
> > Hi, please let me confirm; is this backport really ok? I mean, should the
> > cond_resched() be added to btrfs_swap_activate() loop? I was able to
> > reproduce the same situation:
> > 
> >     $ git rev-parse HEAD
> >     319addc2ad901dac4d6cc931d77ef35073e0942f
> >     $ b4 mbox --single-message  c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com
> >     1 messages in the thread
> >     Saved ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
> >     $ patch -p1 < ./c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com.mbx
> >     patching file fs/btrfs/inode.c
> >     Hunk #1 succeeded at 7117 with fuzz 1 (offset -2961 lines).
> >     $ git diff
> >     diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >     index 58ffe78132d9..6fe2ac620464 100644
> >     --- a/fs/btrfs/inode.c
> >     +++ b/fs/btrfs/inode.c
> >     @@ -7117,6 +7117,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> >                             ret = -EAGAIN;
> >                             goto out;
> >                     }
> >     +
> >     +               cond_resched();
> >             }
> >     
> >             if (file_extent)
> > 
> > The same goes for all the other stable branches applied. Sorry if I'm
> > missing something.
> 
> Hm, looks like patch messed this up :(
> 
> Can you send a revert for the branches that this was wrong on, and then
> the correct fix, and I'll be glad to queue them all up.

Sure, I'll send them later.
Thanks for the quick response!

-Koichiro

> 
> thanks,
> 
> greg k-h

