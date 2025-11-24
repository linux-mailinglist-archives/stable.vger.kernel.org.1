Return-Path: <stable+bounces-196794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD20C8259E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 601CE34A015
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399E932BF5B;
	Mon, 24 Nov 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVr5wzB9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295792D94A1
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013991; cv=none; b=gioljY8HXPZy97zTnds6dBIXSd4pZJde5zzjGYvJ6Ln4xXnOBRZF2HNL2nai+K4TvxwJGmGB4BbBnP0hiJEGO3fqXT3w5NNDoWs/unsMXkFIdrXPt+78693LeIIm3btqd8PYLL7FksuMxMUwe3CKqdi/zg3x4toOvwtr+GRu55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013991; c=relaxed/simple;
	bh=SzdvRNzW3vHKkF+5/fGqZL4B3U+idnGWYEDKpg9pPtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo6PGMfXrl9Dh035+iMbfeBCnp3vQpQtQkV+NoylwhmsOsqmPM4VVpuLzH2zg1TSd3tygH4dtjSdB532Qvc3eqwbARJ1kvYLj5nJGTAvWnMyZv4qbaXKiXZ84dkE2y4UfWEEPzgh05H8y66QYdzu7102Cqo3ypOT/YjcH/jPVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVr5wzB9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso10285e9.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764013987; x=1764618787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COjrg2B51aEIH/fSxrkNXyyS5UriWByaQSUDGrOa14o=;
        b=xVr5wzB9hC5IACSXulFpdR2LbQOnBCIoO/x3EV2jlXv7WC4Kjs5vonTc4OSBAUpb2E
         fGGGVHf6f/I7lHQz9+1/SzQNrp7Yi77DIW+uJbGbhEtkdQzwAwPGFaOO6Bc1gMHxW4Sj
         nQeVPEcAuZ/j/5pYSCC+QX4fgDQZu9Dh5MRIZRnN7aToRDW3xF6ENCpAyZS2l4zulj7m
         FZTR9n4tLMPhKAxevRKWTg2OKwna8s3Px9X0SluiIZU8hsb92K8lw4QmkjFz+vm5CUcZ
         z4+tf/TYGdUK9LZu7Lwxivb2FhNYyhFyTz2u1oD6XqSSHAaRGKIfSr0kR2jYxa1ngLZ3
         RHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013987; x=1764618787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COjrg2B51aEIH/fSxrkNXyyS5UriWByaQSUDGrOa14o=;
        b=rU912cWttiX1DBgofCM38h0R/IhrJKw4IiU+c7sAw/OweWd6cMCjTR9EWufwtAa6/o
         8PbIGwS/tLXNgr9DCquVRqYs+AB999p8Irb1yXpT96t+AAq/aFalN/VGGPbwgtltb/6U
         TjELsB0BgnmZmKv7rvo7BGppbIsSzC97daKPTQjtxxd37r7PaRF6WMAxYYATWyobDlDj
         Pp3yXBftP2+0PLiNifCtytHGq1uQCy2GnZ0i535oflPvpOqd+nj0J+eyaiGYsoT96BnO
         E7mzF+55uNyjSDAtU+NY7Q8IHyJv7ZYT8LkJkfU/4CW63o6hOLLUW8VGh4cjaS/BRKDM
         kTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtENSWK0R2b/8kXdbIHdaqLYoM5WtUc73BsInRIL3LvDHzN1lgYsRbPrqzyhcw7dC+duUeFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgEfZcd3mKtpC5nLmxX/FkpGvXvExkL7nM4ggu9TchmbdW22p
	vAZ/hpIl58AmZUQiK+6Tc1dMGg41N8L11PocZ/mephwWTzcwe2GBfE8JQhVd1dRiRw==
X-Gm-Gg: ASbGncsQxkMf81MVZAPbRBYf4PIJWgmLuSc4CLywEY2IocwOmeTjle9+/NJZgcS7+GZ
	TBUzudVOjhewLRlVrEipMswJMS3tptAp4mWFzunz0xS810+s0ClbOviYsSseeUDyireRNUCKEl6
	0e9UlzJVzdWo43njs4vZFmvbw3joPcXqM3zXCNwDQV0AE/uneIf2mGaW0QxadkBdgYhEM2d8dja
	epebTTHEiZchc4e74k4YZxpnrorcfhCu5YIA8s7zsXMMbCHZXM+0ydkbhTkx6v9H0TjlgGX0g5t
	8m2TIsyS0u6rmZgneegG39cX6jrQnJ4EpWXcfngGhZmGOv8kuLtbsxeFaRyiP7+YapN1fT4Sy78
	GH9tyeFPcbfGTUAe7lWyX++wfGCW17htcMyX9u2EBiV/W/hRqkj0vRdnqlSz+owlHR5fnRfT342
	uaEtHyj707tBVkdfK/d26W8XaXvEOvIW/5f6g1mNVyADFQl61hGyv7njHhs/VwItU=
X-Google-Smtp-Source: AGHT+IFU7zOS1S7U3oECu4vnythRdO5EjO0BZ41fQE/Gx03WRuwwdcHoZF7833UXam0Hi+PD9VbH7A==
X-Received: by 2002:a05:600c:8883:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-477c5e092damr2230645e9.4.1764013987388;
        Mon, 24 Nov 2025 11:53:07 -0800 (PST)
Received: from google.com (153.28.78.34.bc.googleusercontent.com. [34.78.28.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ff3sm30762507f8f.16.2025.11.24.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 11:53:06 -0800 (PST)
Date: Mon, 24 Nov 2025 19:53:03 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A
 memory share
Message-ID: <aSS3n-ONygPXRkii@google.com>
References: <2025112429-pasture-geometry-591b@gregkh>
 <20251124141134.4098048-1-sashal@kernel.org>
 <2025112405-campus-flatworm-25a5@gregkh>
 <aSRy8LqAopE82ZPs@google.com>
 <2025112450-dinghy-trousers-e398@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112450-dinghy-trousers-e398@gregkh>

On Mon, Nov 24, 2025 at 04:56:17PM +0100, Greg KH wrote:
> On Mon, Nov 24, 2025 at 03:00:00PM +0000, Sebastian Ene wrote:
> > On Mon, Nov 24, 2025 at 03:50:45PM +0100, Greg KH wrote:
> > > On Mon, Nov 24, 2025 at 09:11:34AM -0500, Sasha Levin wrote:
> > > > From: Sebastian Ene <sebastianene@google.com>
> > > > 
> > > > [ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]
> > > > 
> > > > Verify the offset to prevent OOB access in the hypervisor
> > > > FF-A buffer in case an untrusted large enough value
> > > > [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> > > > is set from the host kernel.
> > > > 
> > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > Acked-by: Will Deacon <will@kernel.org>
> > > > Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
> > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > > index 8d21ab904f1a9..eacf4ba1d88e9 100644
> > > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > > @@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > > >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> > > >  	struct ffa_composite_mem_region *reg;
> > > >  	struct ffa_mem_region *buf;
> > > > -	u32 offset, nr_ranges;
> > > > +	u32 offset, nr_ranges, checked_offset;
> > > >  	int ret = 0;
> > > >  
> > > >  	if (addr_mbz || npages_mbz || fraglen > len ||
> > > > @@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > > >  		goto out_unlock;
> > > >  	}
> > > >  
> > > > -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> > > > +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> > > > +		ret = FFA_RET_INVALID_PARAMETERS;
> > > > +		goto out_unlock;
> > > > +	}
> > 
> > hello Greg,
> > 
> > > 
> > > I was told that a "straight" backport like this was not correct, so we
> > > need a "better" one :(
> > > 
> > > Sebastian, can you provide the correct backport for 6.6.y please?
> > > 
> > 
> > I think Sasha's patch is doing the right thing. Sasha thanks for
> > posting it so fast.
> 
> Then why is the backport that is in the android 6.6.y kernel branches
> different from this one?  Which one is "correct"?
> 

Right, there is a slighly difference between the two which doesn't
affect the correctness in any way. The one from the android 6.6 branch
uses ffa_to_smccc_error call to post the return code instead of simply
setting the ret code an returning. The correct one is the one from
Sasha.
The one from the android 6.6 tree is labeled incorrectly FROMGIT, it
should be BACKPORT: FROMGIT: because it has this small difference.
I hope this clarifies it.

> thanks,
> 
> greg k-h

Thanks,
Sebastian

