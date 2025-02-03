Return-Path: <stable+bounces-112042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C3A25F93
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E67C1885E03
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377120A5F5;
	Mon,  3 Feb 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AwjQ66gC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7B205E0B
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599314; cv=none; b=tcKIFF8XHVIYerj8o6hZ2TxVLm11FqudFI07CQE1nvkTo7ZK6ckQAqmXRGTh2BFptRLEpebp76ksJagD4/I4ThfiX2LvY9pyd2s6cOui1K6yqU41O9rDW0MdHLla2VcmhRZb25CgIMkQ+dep31dFnaVOajnWnNlmmulXBxiN40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599314; c=relaxed/simple;
	bh=zDVsGVRJipMVFnd7EMQBF3dnIplT6UT0+jGAW0VZjmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjwn7vcFBkooxlaUPHHpgL353zFO+aclvDSqO8ZdnSESr+HkjHv0g0pbL+BOSUuCfdBduodREZFAJrR/iM6yo+MOJ+zRwuEbAoaElLP2JOgWsrp8FvJ0s/jHYQ3QAnt0XkYrvZ1tHP8QN8tLY6Pa9hvyQvSutul2cOmY1s40/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AwjQ66gC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e1a41935c3so63066246d6.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738599311; x=1739204111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPasqTS0flnHE5VF++CqhxrbQnr9GQuOM0i0z93o3tA=;
        b=AwjQ66gCXkFkol+eUMjbsM/c/a3SYR4iYCtV7u1tjbS+yXOePRvLKbLmdFlYUe2aQQ
         TgO5EPttdVzuILmLbsXZhoO/C7VL+54owXnWgwJW8yoYG1snJcPRnRsNHOp57UEQ+TqT
         AAmSWZgZUCYO2Ek4qbuw3c7XZJeykpU15pURs2ZSfCxaqC6r+Da6o4quG/h/F6cqdH5S
         gbTwILb97BDKlbPCxB+NBnUvu0r2OrEvIrraXxiH6lxx5J7TCn4WIQBWhe28ZeHIk0ms
         OgXg1ESR/dZ4roh4tL1DFpJlb0OnlfxXD6RRkD3Da6P/8qtvmmETTYa6501aF7AxBeqS
         vEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599311; x=1739204111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPasqTS0flnHE5VF++CqhxrbQnr9GQuOM0i0z93o3tA=;
        b=bGl5676vhA5MTaJMkLx6mbcv2lq1P/UYDTBnDQP0nfFKa/habqWFlT3LH8d7iJnb+l
         IWwMUynYfYr7bgKKFPZsSizGycJoaPbPz9OHRvW4sp9haikjfp74M230hYwDiDfB0A1l
         z+uDWVOuDkzq228ngVm7I/nlZ0tZwx526vmAI34cfbYZBOphqwfatGoiuQuBPIOzy4+x
         IUAiOI0z+DQIYYaH24/FI1SV3pLESXGa2BIjAmfbYqOsaV/FGVJz/QL/of57lcOLk98S
         A8o55xNfNCEQDYV4sxcLsjbNbB4WTZP897xOG6LcyH5qiKzV53Cu4+WDbUZ/u1aWvDeo
         0BSg==
X-Forwarded-Encrypted: i=1; AJvYcCWvTzjqOmnEBUINxng+aGSaZBYLcXcQ1k9UPXspgpDMRqcLBRQN/+cRADPj9OcK2NByGRTTsKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3fI2xOiYSq1A/5NHHM7GqrRvRTZz6VlxqDPTS29Xu7hz0Spf
	o4y0jNAA9g994xU7HAO+ANqDKDxZXFDjHEwnunWh9ke9qsqfNRGB+CElRte4dg==
X-Gm-Gg: ASbGncv/xjKHepBo6bNRtC4BeugIBTYwzBnyJgz/hYWroDdkE+AaWuLnlB2+/9U3hZ2
	PuD+PfEODqdhu13GhGh86PThUzIG8g7wZjzH1Evw05KzDeSVDdBhKqktmcn4gse+4bezGThVWEF
	WulR3VA2F1MkQfgP0KZAfjEUWtj+sqjfRVcyIoh6KUWV8XMXiy69ReiTzhcBxBI3cuumZbjBMpx
	jAGKEFcvsRvz6no641gsbukY936LlkI6rGxkBszCiWKNocbApABsWSrm8J7EhwSmlI8RcdFYWtT
	HWw8ZouYzr2tgykwxQcWGwaGr3/HH79O3g==
X-Google-Smtp-Source: AGHT+IGwPouMQe5+kqUqm04OghExTDFTU7rKqXnjTVa9WJRHHomAQ9IalFm3FMWHWpAOMj/baL4wEQ==
X-Received: by 2002:a05:6214:dcb:b0:6e0:f451:2e22 with SMTP id 6a1803df08f44-6e243c7fa66mr379958426d6.38.1738599311210;
        Mon, 03 Feb 2025 08:15:11 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f0e5asm51736096d6.7.2025.02.03.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:15:10 -0800 (PST)
Date: Mon, 3 Feb 2025 11:15:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
 <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>

On Tue, Feb 04, 2025 at 12:01:37AM +0800, Mingcong Bai wrote:
> Hi Alan, Huacai,
> 
> <snip>
> 
> > I just tried running the experiment on my system.  I enabled wakeup for
> > the mouse device, made sure it was disabled for the intermediate hub and
> > the root hub, and made sure it was enabled for the host controller.
> > (Those last three are the default settings.)  Then I put the system in
> > S3 suspend by writing "mem" to /sys/power/state, and when the system was
> > asleep I pressed one of the mouse buttons -- and the system woke up.
> > This was done under a 6.12.10 kernel, with an EHCI host controller, not
> > xHCI.
> > 
> > So it seems like something is wrong with your system in particular, not
> > the core USB code in general.  What type of host controller is your
> > mouse attached to?  Have you tested whether the mouse is able to wake up
> > from runtime suspend, as opposed to S3 suspend?
> > 
> 
> Just to chime in with my own test results. I was looking at this with Huacai
> a few days back and we suspected that this had something to do with
> particular systems, as you have found; we also suspected that if a keyboard
> was connected to a non-xHCI controller, it would fail to wake up the system.
> 
> I conducted a simple experiment on my Lenovo ThinkPad X200s, which does not
> come with any USB 3.0 port. Here are my findings:

What sort of USB controller does the X200s have?  Is the controller 
enabled for wakeup?

What happens with runtime suspend rather than S3 suspend?

> 1. With upstream code, the system would not wake up with neither the
> internal nor the external keyboards. One exception being the Fn key on the
> internal keyboard, which would wake up the system (but I suspect that this
> is EC behaviour). This behaviour is consistent across any USB port on the
> laptop and, regardless if the external keyboard was connected to the laptop
> itself or via a hub.
> 
> 2. With Huacai's code, I was able to wake up the laptop with an external
> keyboard in all the scenarios listed in (1). The internal keyboard still
> failed to wake up the system unless I strike the Fn key.
> 
> I should note, however, that the internal keyboard is not connected via USB
> so it's probably irrelevant information anyway.
> 
> As for mice, it seems that the kernel disables wake-up via USB mice and
> enables wake-up via USB keyboards. This is also consistent with your
> findings.

Yes, and of course you can manually change the default wakeup settings 
whenever you want.

Alan Stern

