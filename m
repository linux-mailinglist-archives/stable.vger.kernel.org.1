Return-Path: <stable+bounces-240330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHCWBC/Q6GklQQIAu9opvQ
	(envelope-from <stable+bounces-240330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:42:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8136E446DDB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EBF3058653
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF5241690;
	Wed, 22 Apr 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qS2pjH9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD62367DF
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864963; cv=none; b=MVF05R1x5mmMtgX3zHDrjmQdLYXNb7kPuD8sPnBrK+lrWbnumYWXEs3HTrlopwcnRIbYRSnbBVKLNSyuIBsf8h3mDRMxmU5KxlOUaE99gnFy1GSdALMaAMFheFrP5as6GeI1gU0swR1pXBm7zwzXRRVPRpAblbwCdJo4LqoxWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864963; c=relaxed/simple;
	bh=hY79lEU6UkHfJzfkcXHpxlKi2jbwTblFNPx1u51s9zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hShllZQckzcsDaH7/wVHxCRSecpxO9VRdxxUY2+aUoezRsfJ9JbbYxs3pW24gNCa/+u/y7T4S3H/u+ByHYn2nR2nV7tkJp10bjV02NNH6SFheQ2H24N+4hTNs7WNlr3YhuSm1g/R5TVHhmSa36ODgh5WmpYhDLp4GVRsFJnFG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qS2pjH9Q; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so42785a12.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776864960; x=1777469760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxHtXNRYtwufGHW1ufeXFPBW1zoNUni80T80czPie2g=;
        b=qS2pjH9QQNweSrR8TKy1l3h5D5ksAj9a/INrVgJ0aVYYUeWIIc02mzUfAG1XoJETi2
         smy/fOFYJxGwRvTP2mYktQ/XbzYtq7vc7nufAYXklKLVRxefKZz1Dcoe3sOdat6CGGoK
         /0gsXUhLiqq/yt4kLW2feMgPtIsGlBVvRHIpvdheA2nx5DMsXbyqj1M0bsvleH3K45ii
         evJ1TnPAAHugeg/HgMiAPACQPSWXa6SPQOzDkL6c0ybQanI+zhgItfWzmMIPARVcTz9P
         /G36U/Oyd/MNDclWFG2KK3G55YCtb5biu345RHv9a1rWn7yTT3uMbErB89NCElX10n0U
         CPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864960; x=1777469760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxHtXNRYtwufGHW1ufeXFPBW1zoNUni80T80czPie2g=;
        b=QHOEcna3JUjG8qW1WyhiKSI0zUuiLknJtwm1V3BfWI6SONOQ9wnV9C+VHTknWfWY1I
         nU1VWXhjOdfDSCPpaHs3XhTloc8RbnQdboa6aHUe2+4ZwlVcEy0OVgGgE2JJfvRsDrQL
         rWkU6RY48GChaOPE43iyHPjpyh98MU+7Fgg7W2RQHADMYeW0vYrB2+nMZGylQTUg2Ll3
         ESuKZ7y5lWFm6aMqgAHXr/slVodx2AqAmkOioAWwC3u8CaEEMABBJWvxZzv2v2RomLjx
         GNk6EYwteThORMUDYSgf1yViob9lwGxS2yOmwLIGugVFiFeiHkOu3o2SRqRujjcP9H8M
         IzJg==
X-Forwarded-Encrypted: i=1; AFNElJ/9wspasvdBSiYYRq35HknsqAel4eq1NuVU5Z4qhwZwwnesI8MRyhIiuNSe059B2rmCQTz5QG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkMEz85MxlZxBloo2otVgbcNfIPehcetFo+65DLtFc6ZmI9dS
	tD/0VYd/QvaLeYvn8e719Tlcee6WCtTe0sUFgdHtV7GtfaLVVyeJ5GKl6Ci23ea2TQ==
X-Gm-Gg: AeBDieu4VNblYhToEq0DNUZci1cW/QRa0rJNREItqmG+RCm7HcZGF0gmIhZW6CUvoH4
	2bKSWx0qs3KMRHVNhFRgOr8yh6yblUsVEwc7cpQcq9aMQ6d+u85z/0ODmnAt2Ckkzx7yadIkNGh
	7CAFbbxkyx8Jo/oQnfGzKyqYjS1EISzj0mheQLxpD5qFTsQOZbxtqULm1quI27kWgjJHUaS0u9S
	/vwn+77Mjb47ZAJTg0Xb9ihVJ847aRpnMDEM6liEGN7axsz6RJBp6B5d0/NoQmhRQ1W2QYan14A
	HgFHWeFgrDFcIUYlqFwYNK2kKe6DQx0mwr6c1QiW7x/831oGjxkoC3sGEUf/B5tl/ZOXUZW++1n
	nzXAm1Hp3LPOe957NOW96qtNBjiuKcr9FbPwpBCYkZI3E+L4Vt7ZTC6yGYXlIfdB5DCol7HV5vJ
	Mgu2OJO9uVfPm+Ui8xYK9ylBKwZPbxCRjcTow1oJbmAXkz2Wz1I1V8brPkB/dmNqLc4/KE7TEtg
	d/CJd93V6Sgf3EXloo=
X-Received: by 2002:a05:6402:3489:b0:66f:d653:92c0 with SMTP id 4fb4d7f45d1cf-6744d7128e9mr261268a12.1.1776864959480;
        Wed, 22 Apr 2026 06:35:59 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e3dsm550252066b.2.2026.04.22.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:35:58 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:35:55 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, will@kernel.org, ayrton@google.com,
	catalin.marinas@arm.com, joey.gouly@arm.com, korneld@google.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, android-kvm@google.com,
	mrigendra.chaubey@gmail.com, perlarsen@google.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Validate the FF-A memory access descriptor
 placement
Message-ID: <aejOu98q1lEZoFfW@google.com>
References: <20260422102540.1433704-1-sebastianene@google.com>
 <86bjfb18v1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjfb18v1.wl-maz@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-240330-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 8136E446DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 01:24:02PM +0100, Marc Zyngier wrote:
> On Wed, 22 Apr 2026 11:25:40 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > Prevent the pKVM hypervisor from making assumptions that the
> > endpoint memory access descriptor (EMAD) comes right after the
> > FF-A memory region header and enforce a strict placement for it
> > when validating an FF-A memory lend/share transaction.

Hello Marc,

> 
> As I read this, you want to remove a bad assumption...
> 
> > 
> > Prior to FF-A version 1.1 the header of the memory region
> > didn't contain an offset to the endpoint memory access descriptor.
> > The layout of a memory transaction looks like this:
> > 
> >   Field name				| Offset
> > 					 -- 0
> > [ Header (ffa_mem_region)               |__ ep_mem_offset
> >   EMAD 1 (ffa_mem_region_attributes)	|
> > ]
> > 
> > Reject the host from specifying a memory access descriptor offset
> > that is different than the size of the memory region header.
> 
> And yet you decide that you want to enforce this assumption. I don't
> understand how you arrive to this conclusion.
> 
> Looking at the spec, it appears that the offset is *designed* to allow
> a gap between the header and the EMAD. Refusing to handle a it seems to be a
> violation of the spec.
> 
> What am I missing?

While the spec allows the gap to be variable (since version 1.1), the
arm ff-a driver places it at a fixed position in:
ffa_mem_region_additional_setup() 
https://elixir.bootlin.com/linux/v7.0/source/drivers/firmware/arm_ffa/driver.c#L671

and makes use of the same assumption in: ffa_mem_desc_offset().
https://elixir.bootlin.com/linux/v7.0/source/include/linux/arm_ffa.h#L448
The later one seems wrong IMO. because we should compute the offset
based on the value stored in ep_mem_offset and not adding it up with
sizeof(struct ffa_mem_region).

Maybe this should be the fix instead and not the one in pKVM ? What do
you think ?

The current implementation in pKVM makes use of the
ffa_mem_desc_offset() to validate the first EMAD. If a compromised host
places an EMAD at a different offset than sizeof(struct ffa_mem_region),
then pKVM will not validate that EMAD.

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Sebastian

