Return-Path: <stable+bounces-95864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BA9DF03E
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D71161BF1
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2E19307D;
	Sat, 30 Nov 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ic8OSo4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AC43179
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732967157; cv=none; b=HQnkzcjaE18L+1bCe0aBrhYF57HVdszmHsErGXM4wixGMuJmFBBfFEpG+bql7oKmt2FRO88Ahlb8uLNBKj6F961ZgsIM3TcpVh1mDhKhPUoWv4z2B0z+6Da4LOzEmr1cfZTf+WQCdcQTp2UGXmumr7qYANWl6TiCD0tlGGkdSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732967157; c=relaxed/simple;
	bh=r1e0yUCyDDwKPlm63GtdgkD7CHFhpuCqZeRfGb0SRpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeRvND98MU1hml5v0KWy+yfU6zOKMTNwCGGwbSV3f6hxFPZfAHGRElcCS9ENEzsAyWG7XYt9F9w8YIybplP6cuxLWH03mEomz80MRVPT57l1d6qpyhz3yMnTo9ebDajgrBufqz0lR3vkfTwp50C54Sv2hg5qJO/X+zZoRbbVItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ic8OSo4F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso215959a91.1
        for <stable@vger.kernel.org>; Sat, 30 Nov 2024 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732967156; x=1733571956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=Ic8OSo4FVtMrHBIIpLb54zS6gDREUfv3/RYvTZJFfWJQ34LmM5/koQF3XTEiNcGzx6
         sAoxcnv8J7iAh0/USrZICVb+hMfODOR4KZLwQMd3W3qs2d6ZQ39dzCypkMHe/PFGNvnA
         O3bX7fN9/1ytKEtXBcnz0Z2qqHHmwjF/cot5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732967156; x=1733571956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=LRVYTd2EZajIYQJSW9M7LZRXI82o7SUy9xtwcPWXTydgK0K1/CI4i7QMi/w7LA2bG1
         mJAF/YMd+FgshBX+JirLSaQobh70qUrrXZ89XYjER2QFo7wReQIgw0spxeCrKn0BzP4/
         gG2/6Uy+gRz4IiOPMp5RREbuJJrzBesvz5Bjtst/1NDBeoP6+McgvqyWaiOgsn4TkCRb
         puZvzhoO9ouE0RDJ+Aa6kH8qnYM6/9zs6acfsjogY5Sg0RfGAVKNX6UH+hyGalFKhyum
         0GiGh7Iy5YPqr8eXs+tcvYEmtd4waO1hTPZeCwV7nFvycYFvSV8IC7e+SdFFwtru4Mc5
         3ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUkCYRciOMBvy4ju+KVgECJ2oUaYi1An/VmGRU0uh94l2ObrYYgv76zX3lmeRJLmynuSYEU6Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VS1KWwkFRpD6byd7W0ZKtY3vE5MloHrqyXnFH9kIaSf69ts9
	jEvGeIyWXe0c1spZACBdSL6xmEOopwGhvHUjPOwmSFpvlx/w0DtHtegBiREHmQ==
X-Gm-Gg: ASbGncuVIS8G+mt2AqVPZKuou/v2MfFXNzYYerJYUg0VQzcTgzTzlaDfhKd16W29nIr
	53ieLuHeMadTLmk3eLRs8LJtVQQgnPxfQAXiEDF/SqpMmtVHHrTKECTMj4yR1EtZ7/99EARGYdT
	8x9yfAnWe/j6G0Zqt2lhsoj07xsxU8V/k6Z8+7AOHJ52pcu/kLOX70XnBf1R38ZXvcYyB1RXu91
	zz0Zd7au9Za7DAXNjj5lfUrJjHCpZ+9bBpStxQWU30TFoTbGmv7Xg==
X-Google-Smtp-Source: AGHT+IHgAsdwCtIGni0kUusDMWjJYG3oPVjW5T6ZOyx1CHulNmaI/ielGsyBmh1jVqjnM8DFAz+dAg==
X-Received: by 2002:a17:90b:3b87:b0:2ea:83a0:4792 with SMTP id 98e67ed59e1d1-2ee097bdd2emr16602262a91.28.1732967155689;
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:18ff:40bf:9e68:65f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03bcsm6794650a91.33.2024.11.30.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Date: Sat, 30 Nov 2024 20:45:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: 20241015061522.25288-1-rui.zhang@intel.com,
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241130114549.GI10431@google.com>
References: <20241128111844.GE10431@google.com>
 <87o71xvuf3.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o71xvuf3.ffs@tglx>

On (24/11/30 12:21), Thomas Gleixner wrote:
> > WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x447c references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x4480 references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > FATAL: modpost: Section mismatches detected.
> >
> > Specifically because of wrmsrl.
> >
> > I'm aware of the section mismatch errors on linux-5.4 (I know), not
> > aware of any other stable versions (but I haven't checked).  Is this
> > something specific to linux-5.4?
> 
> So it seems the compiler inlines the inner guts of
> sysvec_apic_timer_interrupt() and local_apic_timer_interrupt().
> 
> Can you try the patch below?

That works, as far as I can tell, thank you!

