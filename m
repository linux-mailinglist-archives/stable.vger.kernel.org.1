Return-Path: <stable+bounces-208062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83911D1193C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11E95308F746
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DD34A3BC;
	Mon, 12 Jan 2026 09:42:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C6347BB5
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210971; cv=none; b=Mq7F3ktpmOg0CE00EG9SupTmCZijDb3iR3T7PuxRq+CeDD2CBR860WZCRETU6GNk3SFIFMXlFvAugLlcABJcUHvjZXtZLPszlDE4KRTG3QMDLBwV0CHJqu1LFy18WQAD7BzvwkHN5pyiTj37OfertzLO6CRLY5Veiq+GIdvC28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210971; c=relaxed/simple;
	bh=gBBnGeBm/IqQmJFIlkwqG+/6/hwshNzPubwtwxHJlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+rSuv4zrhkzKZBbvTPqiWxtVwMi/HpEraeUzL0UlzfPHRMAqziAbCYqgUQRRqPvv+otsnaGhJI3hz1BaSYeu1Z8+tgjvMs9h6SMQebTv58yzHUtLhe2IYNNK2wCXQBBmUeuvoBj/7uaHIZuz5B4bfs2W/BzDDVX6lIx/tvbc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cdf7529bb2so4568291a34.2
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 01:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210969; x=1768815769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37jw5nLaZWVZ6yrJck1zZSSpLqHqkC9MlKG8jIO3uBA=;
        b=s9CWNOpM8mYGglDALGIAtOt0AVG1iz0lQ513dBsnIvCBGq4tIcBRds0KJiy6JGW5q/
         u802YixE7dy+R3rlWJ4Ywjgt/diTwB1/nfVTpxyOSBhkgH7XBip3QymsfDttCMo5XfBu
         4kpClg77JbNMT3a43TnYwXKi6TZ/9k2e3dfrpX/vwhB8wHtCJW8R8ZolFCmyXTGsKLYs
         vSgzKETLSI1xP/P48Qwkc1ZaDvZq19hcr7ElaqxBrX7QB9CTba4WIl+JECpnJnZyVjQA
         Dbl/B1DYpR2PQc9iF6L5xGXJJgmLbRN0kdgS19VBGwf6IM3obG9xOWG3RP7DV1dbyd8O
         TEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTLks4FsTD29sR8300O5C3SAfWTqSwEB05a412yfEPoR7plfqM9VwoNztkicOdrdp0H5kzem8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rwQ1/AdOTIMWMPenZ1tXQ1fGd8QMnI5HpWmjkuMBsDxfhcla
	u6LlNq1pE5iDv2wZRWAFerbOKhJwSpjhh6an7ml6GSRIU+a6n5v01HO0
X-Gm-Gg: AY/fxX4fTy7dwHg9igM7wOXTumCsKzK21UUdF9h2SW6qlVtN31J/S31U7unseWK0Lv+
	N7xfyfibQFi1UYhG+ORWKXD8MoyQPbsaGLCeVxWssAbp3xNaXA+8Wxg+nmTSuTpP9BoGbvksTMi
	MD6/1HCiH1MP1MSQw+RONQeoIAYZuOMm9URe8NKCTv9/9i79TEec54y5CAuEODIkHKlNMkm++qC
	TjHwsbdbi8kO0cTAdJ7bumIXPTLVb8V+BIyZ8rCr5xTGG8JoSWTfGtIMoL/Wn4tbKI7b9aFP07n
	T6cFNRCkpT/1bjtIhexAhRyRy3CIVhq/yUpqFkpg9bmP3crKRaOe7QEBCDZpfqZ4H2WeGe3oIUE
	Vz4b883uDPcxiefJIWWPNIcODwgvJvIoJ7xEp3f4VkB17puib1+IwFuh0HEdim5UbyI0Hoju9Ll
	XmJQ==
X-Google-Smtp-Source: AGHT+IF0hJgzX75ZcIowtNhUjlPnKr/1ZMKF6Ic3Py2DL3yFdhUTF0b1MKvrSAqEbri5ZvRTLM8gzQ==
X-Received: by 2002:a05:6820:16a5:b0:65f:1038:1317 with SMTP id 006d021491bc7-65f54f76ed2mr9334798eaf.70.1768210969330;
        Mon, 12 Jan 2026 01:42:49 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ced969sm6764615eaf.17.2026.01.12.01.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:42:49 -0800 (PST)
Date: Mon, 12 Jan 2026 01:42:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org, usamaarif642@gmail.com, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <74f52o5tq2nodc3otsvknrsf2rpzphtaba7lxia5u3i7322vni@giqfw3ofnnyk>
References: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
 <aVwp_BJx84gXHPlD@willie-the-truck>
 <20260109145022.35da01a3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109145022.35da01a3@gandalf.local.home>

Hello Steven,

On Fri, Jan 09, 2026 at 02:50:22PM -0500, Steven Rostedt wrote:
> [ Resending with my kernel.org email, as I received a bunch of messages from gmail saying it's blocking me :-p ]
> 
> On Mon, 5 Jan 2026 21:15:40 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > > Another approach is to disable profiling on all arch/arm64 code, similarly to
> > > x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
> > > commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
> > > code").  
> > 
> > Yes, let's start with arch/arm64/. We know that's safe and then if
> > somebody wants to make it finer-grained, it's on them to figure out a
> > way to do it without playing whack-a-mole.
> 
> OK, so by adding -DDISABLE_BRANCH_PROFILING to the Makefile configs and for
> the files that were audited, could be opt-in?

How to do the audit in this case? I suppose we want to disable branch
profiling for files that have any function that would eventually call
noinstr functions, right?

