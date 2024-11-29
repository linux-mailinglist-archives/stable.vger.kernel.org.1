Return-Path: <stable+bounces-95839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB779DECD8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7D01638A3
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B9189BAD;
	Fri, 29 Nov 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQJe0Nft"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286915AF6;
	Fri, 29 Nov 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915119; cv=none; b=a7BQjFEBmEVh4v08PejP8WyKnrqEzBZU4mpuZYAReq3ZrHESbe/CohQ3VuhOWjZ0it+5CV6rPNoFwn9pDQwXs9EDj6svNXa5FUZMXyvj8tjb/jW6PmTfURIm4kVGuuys3WDKWcqrnCbhOQZiZSv7sXU/0JXRCrsZNcdDONi61bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915119; c=relaxed/simple;
	bh=9onmvIaJLISG67vwgchmVef7Mm+BpVYqrZJhuC2/nSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnhCxhOzTfCzgXu5tSzquaY4kKwO9jYHLruF9oAjx4Br/i6OUMMkJTJfaAGti2lNzrU059MrB5dh2sI2oWKQfhya40oF+Vpb8hMcMmm6Vkh15W7iwjHzmtNLn6sgUkJ2Rqp3UuEzKqtitAWjEaCZQzjVb+uvdkvK9mAOQ0s/xyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQJe0Nft; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b66d5f6ec8so153649285a.0;
        Fri, 29 Nov 2024 13:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732915117; x=1733519917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9onmvIaJLISG67vwgchmVef7Mm+BpVYqrZJhuC2/nSA=;
        b=NQJe0NftObYCyitn6dHM6W73QUmkgRy6c6l5A3K95dGtytvBhRfeovS7QYGxm5dDaA
         Bu963OucFXfpyiGLluPo41R/H/rOiCkrVh0e5j3qHPjJggw0PyDo/LbMr+eynkqJcy/L
         xHjrorpnTup4QMUv900wQpchmZRY4MkfIHu1rkoOkxDJKWY09kOYcFSWUigmxUKZe1tI
         LTwXAU8KYJjCpOz8ftmzdofynjhiuZg3iVMZDi2GJTrsHRWs0PbTyBAQPwj8mzo2nXYu
         0eLAWmbxjK7AmgIXRocu4P53RkcV4nBfyMf1URcqDLYcEgXIKl1LqVLziLOJ+LqVXUrF
         sMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915117; x=1733519917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9onmvIaJLISG67vwgchmVef7Mm+BpVYqrZJhuC2/nSA=;
        b=w4vkDHDw/90rhfV9z5oZpCgADoWaa0zH1EtZ8vDdNk+oWq0wg8iDScKIxZvYw4R4AR
         GIM3IGlJF/2IM2UASd4UU4tL5NB3bjlRxpmb9MJP2UF1MpVWOfHFKhSy2KFWb31VFATx
         wicmPb2Hrp1zDS1W/qd9cYlRjEKySKtBOu7qCwx10RC0hL25vn5nMTYqpVDZMqjxuZz8
         7ccqdmQfGd2oy4CCGZJDm3E/Gnr5M+AWSWaDfnCP04chq5HJiAZsxakUZYw+BvpfBQLl
         65pcPf1fqeby50wThm8V2Bb24Ltdl8gOVx+xl3tBkuxMqBCpPZK5JiY823CTSgR1bN/r
         bVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUFmbjJpvNbSGuNbBfgyh7kgtudySNcYtcoY37fHjF7yLOfzeuUD8g56TDoW6vTO2dOIxK7GDomFV0rmoc=@vger.kernel.org, AJvYcCVJDYfulta4SfAfIRN3JUoExwJsfM7iMehuaSldn1wUu9Nqti6vAPR1SeYUEZidB9PCgfJnxdAu@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRylA9N/X37HthOzcKKfOyxY+i7mmSG76xydkh3qCYBFtOExt
	e8TARDeWOv9so8PiX/ZeZMYXI3H7gySVPb7XMPHz5u/MnA0G5Y+NptlyY1maSakGuPK+1oBebMd
	AqXIeeR85FXhsre2nL6gWTsv+wik=
X-Gm-Gg: ASbGncthoHVj1SwYtCFty1aEUtjB6jiwTiPRWmErrp4HlTDyNezu1nrBbeJy3/R3hr9
	lEfStLju4er+57WsrEfr4ajiG1eHCTZWakLt7Fm6DbVeIYcSMqhGwWE96
X-Google-Smtp-Source: AGHT+IEkWpCGrfP+Fw8sEVM7ooU4K9gi3GzorgaZIVsmnsijPL3UKcok7+Lxti1KIwLzS+qUu0AIzifd42VpEKhIF5A=
X-Received: by 2002:a05:620a:2715:b0:7a4:d685:caa9 with SMTP id
 af79cd13be357-7b67c46384emr2348891085a.48.1732915117107; Fri, 29 Nov 2024
 13:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115232718.209642-1-sashal@kernel.org> <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local> <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local> <Z0kJHvesUl6xJkS7@sashalap>
 <CAL2Jzuxygf+kp0b9y5c+SY7xQEp7j24zNuKqaTAOUGHZrmWROw@mail.gmail.com>
 <20241129133310.GDZ0nClg7mDbFaqxft@fat_crate.local> <Z0nfomc6TKd-17S9@sashalap>
In-Reply-To: <Z0nfomc6TKd-17S9@sashalap>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Fri, 29 Nov 2024 22:18:26 +0100
Message-ID: <CAL2Jzux9JrS95dTAOgH6+FFa8suHZ2SLcDwF4+dXNg4xxYG8Wg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
To: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com, kim.phillips@amd.com, 
	jmattson@google.com, babu.moger@amd.com, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com, 
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com, aik@amd.com, 
	vegard.nossum@oracle.com, daniel.sneddon@linux.intel.com, acdunlap@google.com, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"

> Or LPC? I don't usually end up attending KR but Greg is always there :)
<innocent tone>
You should come once, it's such a nice conference!
</innocent>

