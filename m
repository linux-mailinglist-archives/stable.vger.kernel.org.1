Return-Path: <stable+bounces-206109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6ACFD119
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 11:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 014763070AAE
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2659330AD15;
	Wed,  7 Jan 2026 09:37:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE681309DDB
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778662; cv=none; b=YPoSPVOlz35hbNVRL6b1mvRAGTosoWReMRj72YRH9Z0cROqJe1tR+yTId70eF4cI7eVqUS+NyQOoIGiHbiaHw79DfHLIldGA1EnKavaLQeCUy5icf85XqqFw0A5LSZMc7VwZa62a1CJP6Yv2RCs8PoVVs2eGutqzMiHtZ3sbz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778662; c=relaxed/simple;
	bh=P3bmIaKbj4dlQJDQsd4YExNB4f0vddu/W5Umr6N15ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOg+JV4p0Y3N3sIYMG3xJO1t5a8lqrZdLlfbiYFoDrY4c02qkp8zknrJu3MFByWNMwXq+NMs6wqoWA/hkrabgHqXrwEDSUnYSkoZrVp5iDhXxIBUaC1K38nK0v5kq99U9SUxJHPiFiHNazoV4PLY3aAcFFu7VTcjeRbk4nhXhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4557e6303a5so623767b6e.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 01:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778659; x=1768383459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSOFVzjnYNB1d5rrdzoosTOvprcgQBQWb0G+083URhQ=;
        b=rp/zD0kdBbi829IDRvHTPhsS7JsjjPocEYcS8NLtKzDpSofOMz3Tuf2UocAA3FQX98
         YmBxxaeJXUmFPVV4iCQt1bhut4V60AK2KwluSRUHdzAkasEikT7lYWdpfY8LqwxRBbbO
         xvEqpoWO68++fmt5ZpK18JdQlNG0KWuZgpV00HvU0KEnVBHOuNOLMXh32iGWqsoKTFE0
         Cp4J9HdZFlthXS1xXtnwr/M8ifl0ZSC2G59Eu3jhbvPcbPWQtNiQebUxIlEd+52/q7BW
         risNzLMXkKuMAcgpPknv2BeDKqjJaTJhnAug1xqoc7pXLgWyB7HH8W8nzLzUvrMemVb6
         lY+A==
X-Forwarded-Encrypted: i=1; AJvYcCXmpfIEoLbWG2JuWPJqZLux3FGiCo+0BKuowg0ZL+bErftzH+C0IaB79wZcyLeYnpL2aHcqcrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb4PcZSF3EzELerEPdTpyvA3/IM72stqpA5D6vVeOltOGeSVh
	6Ew5xsgffh65YI2wvWyTseui2WFpyEdcYxExKCAL75bCBSyAC5oZKIQ8
X-Gm-Gg: AY/fxX41FYBoXPLFIMp28wBim770E99WbTT9QicK37X9ueGu3/DhZQwLrQJB/YaTCkp
	doEozPERF1inhpRuAICAxA1XkuNGEqe4tSR4Kqw+iKt/TcGMvZH6LqFZlSPnqxHFfbixeQ4UdPW
	JF6BreimP/A769Zv8yNoB1n7A5q5H+sNXzv70GZKIfJTMNn8Qzu9gYWriAgIXBNYqdKJObRKfMq
	GuiocV0c6JjD8VO/RvmUfEBWQnqJEStjHMmFYjINBVTYoSBEldG6pERKRAZpst9LqACZ4PI9NHU
	jdUqG7o0WJDmvpKoSeZATloKRiT3SDopW/1etMEYG01R8AbGDFnIJwEmvLe4GhRYpapL5rQObSz
	w2oYzkOsPKdB+IhDOqSIhjGnoRoEvr5dypbL4lQIKTdBMTi78AELUswX4YToIeqECDE+KuB5En8
	lWtujUNZ0rOxL52g==
X-Google-Smtp-Source: AGHT+IE6mzfvESbk566yQV8NURTCe+ARwpNwZIV2RSmTygG0udCgbDFLYujQwW54LSoVrkMmFxWFbA==
X-Received: by 2002:a05:6808:120a:b0:455:d817:513f with SMTP id 5614622812f47-45a6bcc87f7mr802717b6e.14.1767778658722;
        Wed, 07 Jan 2026 01:37:38 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288d5fsm2230196b6e.14.2026.01.07.01.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:37:38 -0800 (PST)
Date: Wed, 7 Jan 2026 01:37:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, puranjay@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <frfmxk2ifpf5shcws42q3eeykb3xyflxocbic6junm7mzvmqik@vktwefe2zmw7>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
 <aVz-6WozGIxGiTUR@J2N7QTR9R3>
 <20260106111142.1c123f12@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106111142.1c123f12@gandalf.local.home>

Hello Steven,

On Tue, Jan 06, 2026 at 11:11:42AM -0500, Steven Rostedt wrote:
> On Tue, 6 Jan 2026 12:24:09 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> 
> > Whoops; s/CONFIG_DEBUG_VIRTUAL/PROFILE_ANNOTATED_BRANCHES/ in both
> > places in my reply.
> 
> Note, it could still be useful ;-) 
> 
> I've been running my yearly branch profiling build on both my main
> workstation and my server. I post the results from my server publicly (this
> is updated every night):
> 
>    https://rostedt.org/branches/current
> 
> If you check out the branch_annotated file, you can see there's still quite
> a bit that gets it wrong. Some of these is because of bad assumptions by
> the developer, others is because the code moved around causing new branches
> to make later annotated branches go the opposite way.

I am starting to look and remove some of these likely/unlikely hint that
are 100% wrong on some very sane configuration (arm64 baremetal hosts
running a webserver).

So far, these are the fixes I have in flight now.

 * https://lore.kernel.org/all/20260105-dcache-v1-1-f0d904b4a7c2@debian.org/
 * https://lore.kernel.org/all/20260106-blk_unlikely-v1-1-90fb556a6776@debian.org/
 * https://lore.kernel.org/all/20260105-annotated_idle-v1-1-10ddf0771b58@debian.org/

