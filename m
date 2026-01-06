Return-Path: <stable+bounces-205118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07226CF92D7
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D393043217
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E734C98C;
	Tue,  6 Jan 2026 15:46:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DBD34C81B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714371; cv=none; b=QxkUKFLKWVh4+TUUSRC6XTWb7SbDq0nfldqQcD6qLbpf7S//GzIFz4zBgEEpwdu7JBZZVvD/btTFo4fV1XoHauBFItPRSk13iVnRZbRZqBxG716zYQXWUmzVbj/RMGva8eBLWSGkGG4zy8b6pizzz6k23Kg0SqYyvfi7zudFdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714371; c=relaxed/simple;
	bh=dAi7RBBhF1hgxKa+hRL7HHi1/MQQPDt6gkhve2rSQW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKpMK3wZzFC6AyIi5ABFaIiYqt1FRT+I2KNKYVf5NE173NdGIsCkuBMXyxRt11jqanV4z2zctRZAwmmhNaJZbbNqXOM0a7m+v/8gYHRogv99dpiPdKnG0sqhxaO/1s/jDbK7q4N7W/aE9XXUSiqefdVJFFYXtdJ1RNrpESA8aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ce229972f1so898161a34.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714368; x=1768319168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQTUy1kZhVd6QFKYgDUasG/BXOAj1nBI7IAdTwgQh4k=;
        b=kfcpjl/1yj/fctFNCZYCUPacnGjCfR/sDKIAjioKv5wpV+FLrZlTJOQIp3i4m5UBgu
         AYadyv8bRCXFaG6da56desACOgh0RK8zcDodxP7SWSrKCavKCAXmJXpdC5H6oKB9RzK4
         kSLqSGmsO7zMaFazpP7YFwDl0YF5Rzh7Sl7IQlF0ZlQsA653HQff/Xy8+kBIYePAqJJb
         DscKb9Fiij2jOYrsu/mvalJBBXRVThHRs+CYOfZbCan4pZr9fzCZu/5qWYCWTSabRwcp
         fjdQTYZg07BEx3ZVWdccQqHRLJa2qFs+j6GnthrCre2LE4RxW4HF2lz3p6qjYRjgUTV6
         dvlA==
X-Forwarded-Encrypted: i=1; AJvYcCV7LNta2HuoQ82zGnDmZO6gOkwOAEkachyEr7LTofQoHjr/ZoTLKMoBAb+iElO/Hia8Zwh8QqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUcVUSe+b9DzcB1Asy9OY4443KYor6rNHXln9KIVJbmgHVJYS
	SjrKwweRSMPe7+7nnxKPtx3BgUkITzk16MmTktH0wLY69i2hT5taBiQTvZKSHQ==
X-Gm-Gg: AY/fxX5an91XUaMVEDRQR1JfqWvoBjRht6DIf1sDI0ODhwG+voyzROrP4j4kFd4L94p
	/rR8jbzRnmmmtSyAdnByFzQSCorvRzpSbsK1W0eHN66ZBxAKlipumaFj2jWOr+ISQqrdT1/zMb8
	/dIagTJGjd5wxiQ5m5+LvlibO1hIAkF0nplDFMjW49l1nBUOb99YXdsMo2UkzE2enIRs9Ghw33U
	BUIDqfqwmX9DlascbUrDcMDIRFdR9BSKXS0kT35n9YSAgHRV9E9bP18+yNx8R1ZCI8D/MErDE0p
	Pt1fERWLRxIV1lCDZFgb1pYiVFN7wlJgOpebU6lttpLRjkFMKFwcayDfJiz863A0s5ySdIfyweV
	yrtgHhD3rkrwm+fhr9gY3MUT2U2/a8ihVPVKq1P+RsQs3jZ9+5l4OYC43SU0daOKaBqlPcAJmRt
	hX4pvFeZfpZZahCYLQ1WXW
X-Google-Smtp-Source: AGHT+IEDVtPF+jdII9GyQUl1ZSSEpCxWJpHOx5hPHx7PAH7getQJEBbENhpATdFTeDD/D3J2rXVxsQ==
X-Received: by 2002:a05:6830:668c:b0:7c7:1e8a:c9d8 with SMTP id 46e09a7af769-7ce46745fcamr2517821a34.36.1767714368554;
        Tue, 06 Jan 2026 07:46:08 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478029a6sm1603103a34.3.2026.01.06.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:46:08 -0800 (PST)
Date: Tue, 6 Jan 2026 07:46:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <cllfyxsg4gkyg65j3bko2fncibwmr2wqzzs2255qp6l3vupev7@2ke5cv6iqpow>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
 <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>
 <aV0qxGioAXxkh6QD@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0qxGioAXxkh6QD@J2N7QTR9R3>

On Tue, Jan 06, 2026 at 03:31:16PM +0000, Mark Rutland wrote:
> On Tue, Jan 06, 2026 at 06:05:37AM -0800, Breno Leitao wrote:
> > On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> > > On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > > > The arm64 kernel doesn't boot with annotated branches
> > > > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > > > 
> > > > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > > > solved the problem. Narrowing down a bit further, I found that
> > > > physaddr.c is the file that needs to have branch profiling disabled to
> > > > get the machine to boot.
> > > > 
> > > > I suspect that it might invoke some ftrace helper very early in the boot
> > > > process and ftrace is still not enabled(!?).
> > > > 
> > > > Rather than playing whack-a-mole with individual files, disable branch
> > > > profiling for the entire arch/arm64 tree, similar to what x86 already
> > > > does in arch/x86/Kbuild.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > 
> > > I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> > > is unsound in a number of places, so I'd prefer to remove that Fixes tag
> > > and backport this for all stable trees.
> > 
> > That is fair, thanks for the review.
> > 
> > Should I submit a new version without the fixes tag, or, do you guys do
> > it while merging the patch?
> 
> I assume that Catalin or Will can handle that when applying (if they
> agree with me); no need to respin.

Thanks Mark.

