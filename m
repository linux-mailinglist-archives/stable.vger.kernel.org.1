Return-Path: <stable+bounces-192869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE32C44A1E
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DD03A3F46
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C6261573;
	Sun,  9 Nov 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="athyOGDd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D61CAA79
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730585; cv=none; b=sxgzSAgaoASx7oI5+l0AOkkRShq717JHGNKOIDbMbzO+2wTJBTTK+voAaiqpzb42pW8Iq2V1cTXFCWOsj/Tw2c/xHNmrb/TvObktxpESVk9/xLvCTzKL/JuoNwz+fW1/WfZUn3d/nhE2xv9Vq4PUraYVw5ucdvSSxyhs6Bnypk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730585; c=relaxed/simple;
	bh=yGq8Y0gkoqQHLwZS2dePvCYMobIl4geCER7EzHWgRlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkAF6MJkGDMHkzdeoOAT7b13q/aHrTtWlIlrbCxS6ibFn364jNHJn5n+4Kc9YMW8wH5VoMVUwF7HICD+qnkB7YWeEQKIfSO6TO9Ml8y7n05gQPZ+AcECRISdBj9zOH0YtTpQ+aR46pgrCGMFQcwJPYQJXm99tMPqvzwNWystI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=athyOGDd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710022571cso24101195e9.3
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762730582; x=1763335382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpRf4SnsIYUEbCuKm8TbCRzkaA9WFZ2/wnfNgOLDP4Y=;
        b=athyOGDdMGznR+7N5FqawKiLI+2NrioU1Cgra8p6YT5G7HdpTV3SG8/UD/E+yjzuPo
         KGt24rZ7bzs9zJ7Z3zdExoPY3cRM5dW6sUc8smxzB9evDTIuVBSSqSYi6PPuhWrzKe8+
         ERf67CcAwJrraQqvBR7H3kS19mYgn1JDb6KYgD0rtQb5/cifpRn+h22O69huDV2ci16N
         lgLyZTbsr1bEnZG3yjhYm4Nl7Uck8woDTJ0QznDLHJu89RBWWrEE3dtzAziwFscezUZd
         4uXoz+efYAsBM503HCTUSyU7YYl8i6l5VrFt2XhpIzVpmwZJN5zJP+9PbwONfn7+ANFH
         vSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730582; x=1763335382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpRf4SnsIYUEbCuKm8TbCRzkaA9WFZ2/wnfNgOLDP4Y=;
        b=P2xQF03Q4sFruTWw0iFL9/e8NAgtZNlDuSfd8l1bQDv+90XPS2Sc2Tz5uB51xQdM5V
         hXLvfXJBBqObaBV9GrHBqaFQw0o++B6UnMXtjjEWMFi5J7oGStCyI5Gmfo9q01c1gqYK
         GSBjI/KsPaRFZ4hLGHN3aVz2g6ZXyoFjM2/yzrVdAvjtgDtLeB9YP3XOtbmo4UQescrY
         Cqbe+XASKD4/xveQLWU0n5JjwhRvHxtluvbqdTKmZX3m/jvSSssgf9isoaTubTPhg7dM
         1KJuOmZhliHgRlZrjjUvxUthC3aGsorkNd7lnvBray7O64wa2Q3QEJ9drLnu47y+IH2h
         uMCw==
X-Forwarded-Encrypted: i=1; AJvYcCUoe2PqrJUUOqdwgfa0Xfau3hSIN6HDG1gMFJ4TInvcgZi1fxIxucs+Z7d4cUaigU/CLEefCRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0uOepTrE88TpvctRkY+h3KElhhh1Ld/xu/iEyYZm2hfLI+sxu
	YEu/nJIFz6uLM5fTaLfsuloYOfzNbjufLzNH+C72ZTIoeFdXXK5poMAe
X-Gm-Gg: ASbGnctydr1C3YIbhp5/KSAwaKEl9aoiLMl1S06v0y6XgVQIcrEtm2mgDO+dlLMYcFx
	43SJGLU9sVzudP2WVckdZvtfahOf4YFcezTEaB+Wap/5nyRlA0MVPQ9sXBPeFDoqqrnBr59z29U
	CWBRGUA7aVvFzWXsYOBAPAxkaRISop0UIXH+B+pcFnBehVCrtzsqeNQ4bxzdU+kKRSUtCymEXl1
	2ZNef8zHtsdu/2PcuSrcoftFnKUsBL1XE94aAWrHzK1niGcGP4wFi4nAUBYwWFKDCmsQm64J/hK
	NgL2iubYx/HEUcW4nFzCj3N0z9GAKZPgspd/MXeMSGtIZ52r8NXHX49mycQH9laGgl44Qpo6mBY
	GgIHzobS1oPKmOGMuYe6Pjm6NOv5dwVN0Lh8qbbd72DZs9ghj6SCdppQnU031UEyxpnqWsgh8CT
	oXLRmPvyKdXd6E+ZMDNa8o+RYZ0AjjbK4ZB9A+uoAOkA==
X-Google-Smtp-Source: AGHT+IFoXhEVWqJyVDZ9zwYm2ygEdPkRnSFCeDmrZnNxSFKzA//nNy4j1tgrOfL9AQTwFGE/KNUbsg==
X-Received: by 2002:a05:600c:4448:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47773228c21mr56390845e9.7.1762730582162;
        Sun, 09 Nov 2025 15:23:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm98802145e9.6.2025.11.09.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 15:23:01 -0800 (PST)
Date: Sun, 9 Nov 2025 23:23:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, stable@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Laight <David.Laight@ACULAB.COM>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Message-ID: <20251109232300.42618f06@pumpkin>
In-Reply-To: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 08:45:35 +1100
NeilBrown <neilb@ownmail.net> wrote:

> From: NeilBrown <neil@brown.name>
> 
> A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> to compile with gcc-9.
> 
> The code was written with the assumption that when "max < min",
>    clamp(val, min, max)
> would return max.  This assumption is not documented as an API promise
> and the change cause a compile failure if it could be statically
> determined that "max < min".
> 
> The relevant code was no longer present upstream when the clamp() change
> landed there, so there is no upstream change to backport.
> 
> As there is no clear case that the code is functioning incorrectly, the
> patch aims to restore the behaviour to exactly that before the clamp
> change, and to match what compilers other than gcc-9 produce.
> 
> clamp_t(type,v,min,max) is replaced with
>   __clamp((type)v, (type)min, (type)max)
> 
> Some of those type casts are unnecessary but they are included to make
> the code obviously correct.

I beg to differ.
If the values are all positive the casts aren't needed.
If and one the values are ever negative the code is broken.
(I think that is a bug in the old version without the initial check
that sets 'total_avail' to zero.)

> (__clamp() is the same as clamp(), but without the static API usage
> test).

And it is really an internal define that shouldn't be used outside
on minmax.h itself.

Replace the clamp() with the actual comparisons you want:
The code should always have been:
	if (avail < slotsize)
		avail = slotsize;
	else if (avail > total_avail/scale_factor)
		avail = total_avail/scale_factor;
(The compiler will CSE to two divides.)
I think that actually works best if both 'avail' and 'slotsize' are signed.
Then it doesn't matter if 'avail' is negative - and lots of tests above it
can be deleted (as well as the max() later then ensures it isn't zero).

But for bug compatibility swap the order of the tests over:
	if (avail > total_avail/scale_factor)
		avail = total_avail/scale_factor;
	else if (avail < slotsize)
		avail = slotsize;

    David

> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> Fixes: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 08bfc2b29b65..d485a140d36d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1822,8 +1822,9 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>  	 */
>  	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> +	avail = __clamp((unsigned long)avail,
> +			(unsigned long)slotsize,
> +			(unsigned long)(total_avail/scale_factor));
>  	num = min_t(int, num, avail / slotsize);
>  	num = max_t(int, num, 1);
>  	nfsd_drc_mem_used += num * slotsize;


