Return-Path: <stable+bounces-83611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1F99B7B3
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57E9B216B6
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ABF1474A4;
	Sat, 12 Oct 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vldu+kBS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2955126C15
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775537; cv=none; b=plL4ZaqhaMjPxCvDjix8ritlQ3DPdyGnUf3pJpBBXn5ClB2IdhPgDf9E7oXHkl6Utfb1AU2WcmTtgslRyhn8nm2Ev6Uc+zEQLyaPNwRbx8IUnEJspqiH60XV8XfB+qnx+ZORGnw0tAdShjlgkn2AZCPP/DFUeNFWaZ9+d20Ryeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775537; c=relaxed/simple;
	bh=Beb2LoaSh9glIra4Yg3S3/npzf0u6bXtYw7crPtOego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmlmfRXz5WYyAnhQCbJYQ4Y3tvMbZ+71qeSro6snoXUDuBcDNoFXfKJn5I+SDR9ORIiN+zUq3nt6dOJSQbD34hfvOUPg1AxnBUuatt2twvYWsEFjClhUfUdrywklLEAC/r7ivFmeXU9yV0KrEe1wOC46NhWDuFffht5EsEBSOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vldu+kBS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso94155ad.1
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775534; x=1729380334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjM5EfvRmGH7Cfw6M7RPzw10H88y3DRi+sDa3xaXdkk=;
        b=Vldu+kBS3PL+PtZ+m4b/IRwiIcy+kCrkgxA1pjW+nsF6bysYROFTylTO+FuH2KV+2e
         DR22e/ggFHfGv/v7NMSjLX45UghFsAcH0K3omUgS8LZXl7R5tByfdSuRFQyGOP07A2hp
         NnyqOrVr7nJWBjt7co3v6fyOrnY50/uDKFxN5+STlM7fkh6ujT69+4Jl4sLQE7hcqXrB
         lJ+9rl1Cfp/V4ZmE7ncAVq63CI7sBAZNsgMTa/SFALau/dL6wFF9YQB0KiZp16EFFLgW
         cXopEkgrtMFRm+C9T3Rt7GwzIaGCGgUoFnpejWYC8XkrHxvf2/untgFMbuL5VRuqHeSr
         sBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775534; x=1729380334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjM5EfvRmGH7Cfw6M7RPzw10H88y3DRi+sDa3xaXdkk=;
        b=Uero3AT/kr66ZBinNhPwwA4p1EEZIwjiKgqpo0fJG23CyIHWU6Elw7sUHkLXRLZXNG
         zgyFfQkxbFI6V9hW+okoOE457BmAogMfHZo3wyZKTgGW1iNY63jXt9tlabtpMMg2bVYX
         6Q8oQ5RzrLTHqjwvHJgiKPs18m/y6jOLaJ+CBa53KjdkvSMHZam97oczAkaAMZaTmnrm
         mCQMSpikTTG/ZWsp3sa9/6+EYv9MXt5OIuUZsa8GlubavGe0zih+EpvJngrWUcKvKJDz
         DPBs1EHOSJaUfP3ZDvTtFhyA81qfsBfK6q+yhPRAbISDHj9IcdtRFmyRTYZ09UqUI0jk
         NL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAuh8bWTyP1ByTSTPVr2CMDJ1ZnNzeL1LGevUc6e/oSvTIEZQOYkXAD09UNLdh6Blb/e+knKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hK/K22sqtAl0lmwSH80Qc3bjVhzHgDKjYS1y0+HaZprDk9Zj
	Q+TqgEAFKdOsxVZyfrOvgia5qQAOFH3gqMxTYr+jLkuBcTLtp9hf4blQwbj3ew==
X-Google-Smtp-Source: AGHT+IFQSJpjwjPuPRFnScQ+rZk1z/9WXYhnAqRSxCh0IUCNYcxFjhSfxFPqJSDZV8RDbJsjObAq4w==
X-Received: by 2002:a17:903:22c6:b0:209:dc6d:76a7 with SMTP id d9443c01a7336-20cbce2f692mr1888465ad.14.1728775533708;
        Sat, 12 Oct 2024 16:25:33 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5712738sm7914268a91.31.2024.10.12.16.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:25:33 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:25:28 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, zhiguo.niu@unisoc.com, boqun.feng@gmail.com,
	bvanassche@acm.org, longman@redhat.com, paulmck@kernel.org,
	xuewen.yan@unisoc.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] lockdep: fix deadlock issue between
 lockdep and rcu" failed to apply to 5.4-stable tree
Message-ID: <ZwsFaPcHsXqxbL8V@google.com>
References: <2024100226-unselfish-triangle-e5eb@gregkh>
 <ZwgdAXfbCDYmc8hd@google.com>
 <Zwrkj6GC2wT11kb3@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwrkj6GC2wT11kb3@sashalap>

On Sat, Oct 12, 2024 at 05:05:19PM -0400, Sasha Levin wrote:
> On Thu, Oct 10, 2024 at 06:29:21PM +0000, Carlos Llamas wrote:
> > On Wed, Oct 02, 2024 at 12:07:26PM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 5.4-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x a6f88ac32c6e63e69c595bfae220d8641704c9b7
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100226-unselfish-triangle-e5eb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > a6f88ac32c6e ("lockdep: fix deadlock issue between lockdep and rcu")
> > > 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
> > > 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
> > > 10476e630422 ("locking/lockdep: Fix bad recursion pattern")
> > > 25016bd7f4ca ("locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()")
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > These 3 commits are the actual dependencies:
> > 
> > [1] 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
> > [2] 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
> > [3] 10476e630422 ("locking/lockdep: Fix bad recursion pattern")
> > 
> > It seems to me that [1] and [3] are fixes we would also want in 5.4.
> > Possibly also [2] just to make the cherry-picks cleaner. If there are no
> > objections I can send a patchset for linux-5.4.y with all 4?
> 
> SGTM!

OK, I've sent the patches here:
https://lore.kernel.org/all/20241012232244.2768048-1-cmllamas@google.com/

Cheers,
Carlos Llamas

