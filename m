Return-Path: <stable+bounces-83388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD7999167
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7EEB2B23A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202E1CF2A3;
	Thu, 10 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpUX0ozK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE551CEEB1
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584971; cv=none; b=uEYPzEY7rx5MKv4dtmMxVqlHyX096dP1U50JKzh/dM9T+mAA2ah/1Xnptu1Ea2vsgGGvuRavZMEJQtC8AwtPx+i3MRI8IUSiC/A7stoszgkv0CUmOMZpM6BsTUsT2vQgdYTq9MLmVARrahpU9+f43jEzkzw/iIfWRnZZr14mbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584971; c=relaxed/simple;
	bh=KRfmh0WHrI7FtdoIWOsXAyvWfe6pjfpG1SgCAo6iEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmudlWczLp03ZZNQW4ENjvmIBxgl3qqt+BLFJtCtLXq97+XN0EcJXgdgtBB5dVDQM4SFCPX7CuN6dPuAXNXiVFHUDd2BDcrPjunzYfRY6K+uQLdR4Vq5F4C0G435ckGw6URuk5Ie+aw2FHT0PtASivk8GhtVVjVAUDGMpGuMxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpUX0ozK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so29861cf.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584968; x=1729189768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xv+6blBozM2tJRwlZos+lMwBmiKQ20KM1gSqpAhTd4s=;
        b=dpUX0ozKJloDLXyLAXIRMIrOhIS3NIQYEZIGETtVFQjuavi2CMBINeiC+w2vXv6bd1
         RJ6iAReezOcZxVwBhU1SQczNiI3NOz97in6fVMbyT9N756U8nvmsZ1UzqqSnqrZmTHo9
         GmbHMWxRiZyeuuraQsCzZIQc+XOQVzoy/+W8X0F3kioWmlCCqD6Nug3FkjUA1jKOvzsS
         mAnrDVlphTCe07xUv66Y0VJBRAvzTBl3qSPiPDSE2+VeTEE2Erjkfup7vXJk1+QITmPm
         nH4TgwE+Emu7J77oynbdwXDIKGkNrwEFhm8XlV1SAujpwyaPyT6/86pPe6oWlToI30lV
         gI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584968; x=1729189768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv+6blBozM2tJRwlZos+lMwBmiKQ20KM1gSqpAhTd4s=;
        b=Xw2UL3lkg0QOyGbdeFgLXKtURzZC8sf7yoSyAaznEnWhn7lSyWIvQbIbHGxC5waZov
         HCW5OuRERA76yM7j7RSZeN0hw3fWnN8rlwVE+Xk/Izfywuh+3gHSp0OaibaAX9u2emwn
         B+P1o0hXSGz3gOvYDSiKg+kMzodx/l27ZbPPsNPFGjPxkjNndofprIrPBfokIC9Lal1b
         DxGHB9/VcEn2qoHkbT0aOGRdPrkB1qzjXAyJMTelDe42siSS2ZRKPd68yHpNlyx4Nt4J
         SXnPHAwvhDPBKZAo7gHvy+u1OhqzDalZsiTPpUi+oZA7xO6bm9eQmC437SjdpZzzk36w
         IK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9/4x5XiAGpqTVZNpq+cmvWj6PKoENeDItqqehY1CkQm9nI3hQWzU8nZdEV++ONWDmm5EnLeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1TtoRFNHQjj/gK7qe6z3/EQp4oUieIizvGF7yBFfPkNF3UR+
	UUC0yFOlM1EjK/VipbWpKGO2GIti1Rzx0L6mAtsSj4wjA5CapldMjn0JioHEvg==
X-Google-Smtp-Source: AGHT+IHV+5t5+Pa/8tpQ1guAZ+KwXSYIgwWjTWheVLG3xcLJD9Q+wlDOoff0ox795cO9eHIEx6CUfw==
X-Received: by 2002:a05:622a:2998:b0:460:4841:8eb5 with SMTP id d75a77b69052e-4604b1650a1mr61751cf.19.1728584968131;
        Thu, 10 Oct 2024 11:29:28 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8badc9c3sm12199115ad.36.2024.10.10.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:29:26 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:29:21 +0000
From: Carlos Llamas <cmllamas@google.com>
To: gregkh@linuxfoundation.org
Cc: zhiguo.niu@unisoc.com, boqun.feng@gmail.com, bvanassche@acm.org,
	longman@redhat.com, paulmck@kernel.org, xuewen.yan@unisoc.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] lockdep: fix deadlock issue between
 lockdep and rcu" failed to apply to 5.4-stable tree
Message-ID: <ZwgdAXfbCDYmc8hd@google.com>
References: <2024100226-unselfish-triangle-e5eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100226-unselfish-triangle-e5eb@gregkh>

On Wed, Oct 02, 2024 at 12:07:26PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x a6f88ac32c6e63e69c595bfae220d8641704c9b7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100226-unselfish-triangle-e5eb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Possible dependencies:
> 
> a6f88ac32c6e ("lockdep: fix deadlock issue between lockdep and rcu")
> 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
> 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
> 10476e630422 ("locking/lockdep: Fix bad recursion pattern")
> 25016bd7f4ca ("locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()")
> 
> thanks,
> 
> greg k-h

These 3 commits are the actual dependencies:

[1] 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
[2] 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
[3] 10476e630422 ("locking/lockdep: Fix bad recursion pattern")

It seems to me that [1] and [3] are fixes we would also want in 5.4.
Possibly also [2] just to make the cherry-picks cleaner. If there are no
objections I can send a patchset for linux-5.4.y with all 4?

Regards,
Carlos Llamas

