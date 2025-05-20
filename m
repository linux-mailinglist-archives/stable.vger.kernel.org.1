Return-Path: <stable+bounces-145064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774EABD6C1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB917AC02
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903527815B;
	Tue, 20 May 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkZ2ttKg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EB276054
	for <stable@vger.kernel.org>; Tue, 20 May 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740455; cv=none; b=GjvZzyuvtQD1uMBFxnGYY2lAcbEAbGJetWcVNahbIyNj5YF6devKHxDhsKcAsx8hvkLwtZs4SW1qQt+o+Jqz4A+iV9AyeNqh8YsPuY4MDl6odai7JaaRvmg0vgvfA6YU+EWBRx+SObysYjP5ol7H3o+iSy9Id6mb6vstFrI9m6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740455; c=relaxed/simple;
	bh=wtBTWGaBa9I+LI3WqMdGv1C8FdK1+C0nlmC5RwWtcFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYb963ck3QNX8bTjHJtAMIavjqW81wmI1USROvWCortVqGDsAPgKttq5mUPnwh2VSTIJpHFueE6EuDXpR0p2Urt08bYO0BrQFmE0XnHa4MvPoGdHEWODyJvJR54LDN3/HFADoHUxsaVpJ0Ffy6pWN8kRe5h95Ns+fF2QPdofHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkZ2ttKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6747C4CEE9;
	Tue, 20 May 2025 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747740454;
	bh=wtBTWGaBa9I+LI3WqMdGv1C8FdK1+C0nlmC5RwWtcFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkZ2ttKgNuC7unuxyUSCKVnzRkle/30ek4+HRxl7C8G7BT0VgnAJ/qvCiT0ITUboF
	 +xS4DgH97F/yx1NunZ+QgZs/6I0CTItMC9FEdpeQwf8ppREZdQc83GjKdbUYhsne5O
	 13qYCdLYbeUVP7W0Rdx8NvVTozfgH5ZWZZiRHO6U=
Date: Tue, 20 May 2025 13:27:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: dan.carpenter@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.12.y] dm: add missing unlock on in dm_keyslot_evict()
Message-ID: <2025052010-figment-nail-2d3e@gregkh>
References: <2025050954-excretion-yonder-4e95@gregkh>
 <c9d4dfc7-2300-e271-0308-056633142226@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d4dfc7-2300-e271-0308-056633142226@redhat.com>

On Mon, May 12, 2025 at 02:36:16PM +0200, Mikulas Patocka wrote:
> Hi
> 
> Here I'm submitting updated patch.
> 
> Mikulas
> 
> 
> On Fri, 9 May 2025, gregkh@linuxfoundation.org wrote:
> 
> > 
> > The patch below does not apply to the 5.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 650266ac4c7230c89bcd1307acf5c9c92cfa85e2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050954-excretion-yonder-4e95@gregkh' --subject-prefix 'PATCH 5.12.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > >From 650266ac4c7230c89bcd1307acf5c9c92cfa85e2 Mon Sep 17 00:00:00 2001
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Date: Wed, 30 Apr 2025 11:05:54 +0300
> > Subject: [PATCH] dm: add missing unlock on in dm_keyslot_evict()
> > 
> > We need to call dm_put_live_table() even if dm_get_live_table() returns
> > NULL.
> > 
> > Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
> > Cc: stable@vger.kernel.org	# v5.12+
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 9e175c5e0634..31d67a1a91dd 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1173,7 +1173,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
> >  
> >  	t = dm_get_live_table(md, &srcu_idx);
> >  	if (!t)
> > -		return 0;
> > +		goto put_live_table;
> >  
> >  	for (unsigned int i = 0; i < t->num_targets; i++) {
> >  		struct dm_target *ti = dm_table_get_target(t, i);
> > @@ -1184,6 +1184,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
> >  					  (void *)key);
> >  	}
> >  
> > +put_live_table:
> >  	dm_put_live_table(md, srcu_idx);
> >  	return 0;
> >  }
> > 
> 
> We need to call dm_put_live_table() even if dm_get_live_table() returns
> NULL.
> 
> Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
> Cc: stable@vger.kernel.org    # v5.12+
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  drivers/md/dm-table.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-stable/drivers/md/dm-table.c
> ===================================================================
> --- linux-stable.orig/drivers/md/dm-table.c
> +++ linux-stable/drivers/md/dm-table.c
> @@ -1251,13 +1251,14 @@ static int dm_keyslot_evict(struct blk_k
>  
>  	t = dm_get_live_table(md, &srcu_idx);
>  	if (!t)
> -		return 0;
> +		goto put_live_table;
>  	for (i = 0; i < dm_table_get_num_targets(t); i++) {
>  		ti = dm_table_get_target(t, i);
>  		if (!ti->type->iterate_devices)
>  			continue;
>  		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
>  	}
> +put_live_table:
>  	dm_put_live_table(md, srcu_idx);
>  	return args.err;
>  }

Sorry, I don't know why I said 5.12, this should be for 5.15, can you
fix it up and send a version for that tree?

thanks,

greg k-h

