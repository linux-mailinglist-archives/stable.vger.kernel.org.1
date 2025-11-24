Return-Path: <stable+bounces-196756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC9C81346
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC6C9347A0A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439E3128CB;
	Mon, 24 Nov 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6ZmUclK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531D28000F
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996408; cv=none; b=K2Eo84TnIg2CmtPKJYQGgO78JAouQMvMUPki/+3c9So9bfSGdsTpTj+Y8OfD/o++D5QFh0EDC6EtReY7+rXo6QVMcw8n47Z+A2voksRH5YeG/BSg6HwnHoneTVSQeoc3jlQExtpfqARz2GErtPSln2dWayuBuo/Mmqxw11MXbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996408; c=relaxed/simple;
	bh=Zv6sZZVH5Tg4MU1n4DAASvy4CJN2qOGUIe+LdrAYHCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTOSU3TZuRs99X6Fn4oe+CiRGruDTxG/PtR3Er6qDoTWRZFKDdcrfgcIiqwUF2RObSHe6lQRTNHVKfRFgEJhKo2YhzBKpq87aig8iDO1Jf90jQg8H53c7J1udwcYHFLUYqhVi3815K9brr3N7z3wS2lkmWMtTXmeCjDz1/cwv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6ZmUclK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso104015e9.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763996405; x=1764601205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpSrGiwlZ+0hOk9rap7cArtCHHFycXoPfn0OkIXK2uo=;
        b=z6ZmUclKxd/7Jxb10gjD28/bByzs4VavHOcj6sQYpWUcgom92UiNpOP2bRBYJvIHLQ
         P86Dwxo8Tac1v9PoCFFv2LH+D5MU/aYS9IyIHEAFLEPexMiWeu+2UpaDl6NVw4AhkQMP
         lHePkodNRmUQlS3Gou+Lml6deKq/vr9TpJ4NLSiSk6XdPJh3YBnBIlz1newT7yCVq9eD
         alGqZ9Ykt1/PFJc/eeeHwWkkQYJDJdZKwvxI/1uKY1tH+Jz6ng6To86pE3QmuixCahU6
         +R565UcjJ10+qjmwBVYcP3Z//Q70DfXqMRI6buI63UCTZcAOmpRQMJLF70A0+go3GTbx
         L1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996405; x=1764601205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpSrGiwlZ+0hOk9rap7cArtCHHFycXoPfn0OkIXK2uo=;
        b=RNjzRugqPo6j6qoGEAktkcOvJfE5PqkjGQPOYRw6ILVBP3VeOqAzyyl9NAZQvPzuWW
         rsQCVBcvFMGrgZ+BYx5gObsDPxmNeHQysQorP0Z4Qe9OVzDfy4KWn8gVqQZYfZwldKOL
         YIWEvNo6mbYyeawz3Xg7EcibpYtR4WcVqMTEf25qJfkSzppcqGdMVh+wIwTgfTdMyPyt
         vWyARmb8eI6nDAx/sx9xJbCmI7y8VqLj7UiKJKm+GST8xAuyPzHxwykBJVSudR7GiJFM
         xek8fVr5LC3pi7LQFZQIwZJ4NUSlMV2OOD76sEoMFQYW8SG8tBnDztAZ+e5ukoDIlaR5
         J6wA==
X-Forwarded-Encrypted: i=1; AJvYcCW4+vHLe34r3Mny2CVJBBfUrFwNBlfXxDqKI5xzv/ystLdeAXR+3D0rySfZKPkJs/GYPOksNEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3wApK5m2PQ17HYBxtUYHRfrQFPxMgkCAPrRnKp2tfj5p6WPU
	jEF2/T7Glhj3xta5aIIs/+rGEEVsQF9k6a2b0Xxyw9+1lOG6+MHLuutg/du/1iFPzA==
X-Gm-Gg: ASbGnctPq2y9cKcHdnhdHqMe6lBzFyOaeC7zyFm9oLegJU2GjejRqOYnouRlnsrzQkE
	+DvLz77JKvJ3HDQsB4ldyeW28h4PHGXatzSyBqOZW3J9VDnGa62MKqjgffsDivk5RgjSeE3LSvD
	Awbw0+cBgdXIZYHro2zNhmvrRJQ+3vsRSK5yp3vi6XLsr4yht4a/J8q+jSryS6YPpP+WRWNbBpZ
	ReZRVmeOKq7yYKHaoZPp6MTSowVHuNRbwr+85YPyarwQMOqL103lXFvc4qIqA1LXxY+yTvuaUX5
	Fn2K+D5pfzGWqJ6dTrPxP+Hl0F6zyFfyZUWMo7CwECnE6rUHmV88El4gmnPJn0DdlmJkBC5+cQw
	ukbyvaEecHZfGezbNjR/LtgyKSEQMf+vitxagEoAWXTp3pHpsIud4AqF1zlv28waReCdREnAZBW
	p7rt+JamfSreUyVY2cZ6t1xnjkRMFA2N715mpoXlDp8CgxdW0QYNd1
X-Google-Smtp-Source: AGHT+IEowmPkwaXSngBNWXI9uD0Sb2K0kOKk+Bb6hjf5hTeLo7Q1tIsM4KprZntxj4zH6Ac+aAy0PQ==
X-Received: by 2002:a05:600c:c114:b0:477:86fd:fb18 with SMTP id 5b1f17b1804b1-477c5e09081mr1897855e9.8.1763996404899;
        Mon, 24 Nov 2025 07:00:04 -0800 (PST)
Received: from google.com (153.28.78.34.bc.googleusercontent.com. [34.78.28.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e86b3sm236223395e9.6.2025.11.24.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:00:04 -0800 (PST)
Date: Mon, 24 Nov 2025 15:00:00 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A
 memory share
Message-ID: <aSRy8LqAopE82ZPs@google.com>
References: <2025112429-pasture-geometry-591b@gregkh>
 <20251124141134.4098048-1-sashal@kernel.org>
 <2025112405-campus-flatworm-25a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112405-campus-flatworm-25a5@gregkh>

On Mon, Nov 24, 2025 at 03:50:45PM +0100, Greg KH wrote:
> On Mon, Nov 24, 2025 at 09:11:34AM -0500, Sasha Levin wrote:
> > From: Sebastian Ene <sebastianene@google.com>
> > 
> > [ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]
> > 
> > Verify the offset to prevent OOB access in the hypervisor
> > FF-A buffer in case an untrusted large enough value
> > [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> > is set from the host kernel.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 8d21ab904f1a9..eacf4ba1d88e9 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> >  	struct ffa_composite_mem_region *reg;
> >  	struct ffa_mem_region *buf;
> > -	u32 offset, nr_ranges;
> > +	u32 offset, nr_ranges, checked_offset;
> >  	int ret = 0;
> >  
> >  	if (addr_mbz || npages_mbz || fraglen > len ||
> > @@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  		goto out_unlock;
> >  	}
> >  
> > -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> > +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> > +		ret = FFA_RET_INVALID_PARAMETERS;
> > +		goto out_unlock;
> > +	}

hello Greg,

> 
> I was told that a "straight" backport like this was not correct, so we
> need a "better" one :(
> 
> Sebastian, can you provide the correct backport for 6.6.y please?
> 

I think Sasha's patch is doing the right thing. Sasha thanks for
posting it so fast.

I looked up the other faild patches on stable and the reason why the patch doesn't
apply is because we don't have the FF-A proxy inthe following versions:
 - 5.4, 5.10, 5.15, 6.1

> thanks,
> 
> greg k-h

thanks,
Sebastian

