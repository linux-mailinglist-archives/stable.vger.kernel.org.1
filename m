Return-Path: <stable+bounces-66343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C294DF65
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2259B20B5D
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F04C79;
	Sun, 11 Aug 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDGanktD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48C360;
	Sun, 11 Aug 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723336231; cv=none; b=md5tbQxyFZVWOPd9Az5P1Aqs+VxOga++uc9l4V6KhOc1dMcChutkuDLQ7Qmapwq/QuP+SRkWW4Rxs02Ltoa6Qg0REAytmJQNygaxF3b2Uj4FdbE1/ecNv7j3h9bRAnWlxTctP+PuzFt5ul5d4JOqzCQKZqfqPZSvOlz289E6vhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723336231; c=relaxed/simple;
	bh=vaUddXrjASxrFU7ujZ90h3PNCsSdvh8bEciES9HDY5w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7K+Q6NnV/Ft1rg+2Fvjufu4uooYIVGpwIojJzJiXCAoxdOTm5n3zt+9oqturitb9EldcxwVnrYtRzK2hsVgIrLljRi78p5Gz7En2RxN7QFM7wf8vaYlg5HujpSGXi771VhetgrEjq+KhdNCadOsAe+CX1VJCpPEj3aPw6IeMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDGanktD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso2434460b3a.1;
        Sat, 10 Aug 2024 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723336229; x=1723941029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RTU5KagBlB4zAmSVjdZRQ8PvXJgJUde7W6biB3B8HIU=;
        b=PDGanktDT6sCdu8YITX9U/RDW+QLuH4ER8rT3mHeqjob5JBeEmUPCc+Tkpa1FFNoOy
         340ww0fBwpbAy3lcDORxgDCi20misjdwnDgRfFzHWqmwkSfkn/DZfdb07Ie/F5DetfWo
         JQrZ8B1rmN8+47fR8xiA6wj0Sbqq3lOeehyWejA/9ldNToz4u84svqX0uGPxc7SF609d
         tLGL2RRUPZc9AGCjmdHWgQ7wfJGgoQBsoIKdOZd5OJAAxmWw8TyPSJldNOpzwOasfyTy
         Fs7A29RuJfOwLmjzbvWUAOfqKF4xb8hld7gl8hju9T9xLKF4q3mD+mhlPftdbmBX+0UU
         Rz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723336229; x=1723941029;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTU5KagBlB4zAmSVjdZRQ8PvXJgJUde7W6biB3B8HIU=;
        b=WZGH9oE6vRn95vxPc/vo9UhHa7z8ud3uXwqBcLOGI5smgTkCmo1yAU8XllVDWURNK6
         csC44v/HJ7eOAbnphz6wYO/TPKSM3x40p0LHX3VKJbxgX3jnMnAffeiFBGieesOCVR73
         nmHYv5vhsmu9Oot/KWwNa5LQTovvsI3UPg6n3ivrLdFaoUEhGBKxJziVGePtWeK4ADjU
         Rs64yN8PJqlteSgI5I29oB/864nz6+mgfGUz4dCjSK5DHlDkcffDJ4SxKwaoQvfEi/it
         reKUn7I1DsDmlDYbymc3bW85TquvFqtkdbcbVZarv5rojR3UOgHCul3OSQCVxsud/QW0
         9ohg==
X-Forwarded-Encrypted: i=1; AJvYcCVp12g21QJvqL0g2AFzZ+ESZgf8paLiz/s65Oahn0sjF1iTR77xbXRshI1FgArN0sq592MNEx9X5/FrXNA1T4OmqAb4fC0f98j6bOnR9aie1GZDrCNF6CoapPYa5712VwFHWlh9
X-Gm-Message-State: AOJu0Yxwi4dUJOcTGqPf0oao9c+YuwLOz7XfNtKtQNQQpNzY4Pm2+npX
	63ayW7P9LdUUBCqn9hL01t2Kg2ui8fbVKFcl2cbEr9H6wClj08R4
X-Google-Smtp-Source: AGHT+IHmJtGI/0vlKenALImUzngCP/eRiB6LzA0ka4Y6QAeUFBN2+br1D17hsZWcPi8WeKtYzvaJRg==
X-Received: by 2002:a05:6a00:a2a:b0:70d:1d48:a7d9 with SMTP id d2e1a72fcca58-710dc768d0dmr5741709b3a.15.1723336229256;
        Sat, 10 Aug 2024 17:30:29 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43cc2sm1713303b3a.104.2024.08.10.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 17:30:28 -0700 (PDT)
Message-ID: <66b80624.050a0220.39b486.4736@mx.google.com>
X-Google-Original-Message-ID: <ZrgGI/4lVVJuN+uE@Cyndaquil.>
Date: Sat, 10 Aug 2024 17:30:27 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
References: <20240809-xsave-lbr-fix-v2-1-04296b387380@gmail.com>
 <87ttfsrn6l.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttfsrn6l.ffs@tglx>

On Sun, Aug 11, 2024 at 01:08:18AM +0200, Thomas Gleixner wrote:
> On Fri, Aug 09 2024 at 13:53, Mitchell Levy via wrote:
> > From: Mitchell Levy <levymitchell0@gmail.com>
> 
> ...
> 
> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> > ---
> > Changes in v2:
> > - Corrected Fixes tag (thanks tglx)
> > - Properly check for XSAVES support of LBR (thanks tglx)
> 
> IOW. I provided you the proper fix and now you are reposting it and
> claiming authorship for it?
Apologies, I did not consider authorship implications when resubmitting,
as I haven't encountered the situation where a patch is essentially
rewritten during the review process before. I will be much more mindful
of issues of authorship in future, and I appreciate you pointing this
out to me.

> May I ask you to read Documentation/process/ ?
Yes, I have now more thoroughly covered these docs. On second look, it
appears there's no Signed-off-by in your reply to my v1. I can send the
patch with you properly listed as the author and the proper
Signed-off-by lines if I have your permission to add your signoff.
Alternatively, feel free to reuse part/all of my commit message if you'd
rather submit the patch directly; it's quite understandable if you feel
unenthusiastic about me being involved with code you've authored.

> Thanks,
> 
>         tglx

