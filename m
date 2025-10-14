Return-Path: <stable+bounces-185625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA276BD8B21
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA643A9F4D
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A02F9DAE;
	Tue, 14 Oct 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTLg9y4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443282ED15F
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436733; cv=none; b=Lqh9qsxiTQRlFTgauZh35CcEAZ/ULgNrhX4c9RNc4UvM4mI7mfbnlBudPlPpwdFKOW3dY38Ec21fjNcNVMlN6kzTbQaTDCh/Zgm2/i5bGdQ9iKoE71ufu/iE3h3h+KpOaZNAFTPpB+wgC6g4Y38J571+KpL6KM6Z13ybh55sV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436733; c=relaxed/simple;
	bh=tDZJGyjyFwsEnGU/+BhSU4pXv/ZOaODbT4E16jUaFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD6CNtBfSv9sYtmnCz+cia0yZRNSaf5mFRohWRaynCqnU7QAcdtAWUthWNK/N9d34afNlF7kZM/IYc2NJS6yDYSqrffqnjUW1fKGfyczvR//pOuzOgzFtzl7C1NXJG7zqSm4vLpFq1tlWFEe+zNACf14DxHlpV6nVPc7GgRXeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTLg9y4E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so43372795e9.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760436729; x=1761041529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmcOUYE96CwkIuciWDdS0GQ43f2j/gyLBNOKfTnV8UA=;
        b=LTLg9y4EVZoqTgyp1AaPC9AqwrucU1M63waRZYt3HGKu2WtfChtCRhtH4uemKEypHI
         HnNynq4uI3hRdXxdJDFhYvotEZ1hNkN6AsmNLmZeb8YpXAsYs3k+D+mixG88kB/BK+UB
         IwzV7JqTS3vmSOJc6cYrnopyF9093sj6rG7FXryweAEJ88ua1PprSEFnFLDolL5cBv0e
         r0Oq8Rw8kGU6yB8oLavQ6pD+zcqlkNZJyrlOlTbrwlQOkurDD8fkSyjJa/ncXLWpvVnL
         l1qGVN5TAV+z5RA/MUAegQUG8f20DEgs86NZrDZzjyUb0fFT6bvIS3A9hdELUWpTnjvn
         1lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436729; x=1761041529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmcOUYE96CwkIuciWDdS0GQ43f2j/gyLBNOKfTnV8UA=;
        b=ZvtdLiTvAoZzBYF+IQ3C2y4nr+Obqp73A+NAqGiVaqwScduM788YGaW9O2r0AGa4dv
         k7onKRzuv7qFOvh4ymt1JXyDxg53O1P6vbv6zKRDpuApDu8Qp75Sce4eRRlR5VE4Ckgz
         dqn+qVqw4Ft+PINZLhSZKjdQBY26IFazh0eJ5HuNLspO+0iwhTQN35tZhzwwGKjIK5dc
         MtBcTG68iEyaXfmxtW7K38blRRrOC7veqywu9j/gBP21+lHQmksiFdG79tXOkEi2Em10
         LdyNwYTJlkmxPTbjMR6x/bIqeiXSrNHGf/GsH+n3P6PoH4ICSTtlUv9/gd015b4wbA98
         TNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCwP0EnT9Y6M/2rPyATorDyIne3eQfTYdGBqmYc58/Bi3BUA6c86mZMqB7k5EfoHIBVCiF2yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXypSlgOKtVtRDTya/JzTHO/eGWSYRAcpjM1uRw3hHO3vjSvHD
	dbwSo3L/xldXl1/ZxvqBODnk48pTk4IXaFbtTeLQjx9cPSSdTML2MYLW
X-Gm-Gg: ASbGncvg00gKJoipfpbGMdbT1dy8IsYbNrr2DdA2NR4vRizJKWR5Osg/bglvQ0OD6qK
	I8GJnL/BIccwdkvJakXw0Go6k+rFgxRlDHsVsEqt6Bq0L2N1Wr9C25sqPaLf7NodA4vEjBm3mUK
	ltbtjOb+U1ete7+8E62OoGwDFmscgHLf5NyR3Dt8rfCndUC9Zd1AaIKzPBnhcLHmSejc/8VotFK
	Qmc/XmkcNYKZl/Ysv0ZpO6zkjfTA7aPtb6vBT3K3Iy4J9WCzx0FY6j/vZbo8ZWpbpOOmvAioMVJ
	X8Lk0hANfcylia47IZbKlCz17taaLegL7LZHdOD1j3XgKnTlPDbkzMmml26XaX2dWLpRrys3l8s
	tywiQIv35E5ndmDUIXJULr0Jpm/i1QVQustWiiniYYNkqWLt30RFbLdygY0vheYw4csMG63jcBy
	q/pxK7ZPE=
X-Google-Smtp-Source: AGHT+IF6ne/xuQ/Yzz4Zzb7wpstPRXQSA86ePFiRmshMRn4gI9s18XitfechdzacRqFT+6sY8lXeJg==
X-Received: by 2002:a05:600c:3b1f:b0:46e:4340:adf7 with SMTP id 5b1f17b1804b1-46fa9a8b3c0mr176129525e9.8.1760436729180;
        Tue, 14 Oct 2025 03:12:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b30sm230224825e9.6.2025.10.14.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:12:08 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:11:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, Kent Overstreet
 <kent.overstreet@linux.dev>, amaindex@outlook.com,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com,
 joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com,
 mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, Finn Thain
 <fthain@linux-m68k.org>, senozhatsky@chromium.org, tfiga@chromium.org,
 will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-ID: <20251014111125.731ab016@pumpkin>
In-Reply-To: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	<CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
	<inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
	<20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
	<b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
	<56784853-b653-4587-b850-b03359306366@linux.dev>
	<693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
	<23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
	<2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
	<ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
	<3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
	<ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
	<3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev>
	<20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
	<CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 09:11:06 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andrew,
> 
> On Thu, 9 Oct 2025 at 06:04, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 9 Oct 2025 10:01:18 +0800 Lance Yang <lance.yang@linux.dev> wrote:  
> > > I think we fundamentally disagree on whether this fix for known
> > > false-positive warnings is needed for -stable.  
> >
> > Having the kernel send scary warnings to our users is really bad
> > behavior.  And if we don't fix it, people will keep reporting it.  
> 
> As the issue is present in v6.16 and v6.17, I think that warrants -stable.
> 
> > And removing a WARN_ON is a perfectly good way of fixing it.  The
> > kernel has 19,000 WARNs, probably seven of which are useful :(  
> 
> Right. And there is panic_on_warn...

Which, like panic_on_oops, panics before syslogd has a chance to write
the error message to /var/log/kernel.
Both are set in some environments.

Tracking down those crashes is a right PITA.

	David

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


