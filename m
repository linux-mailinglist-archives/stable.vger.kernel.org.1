Return-Path: <stable+bounces-196980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A8C88E88
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1014E2B73
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED72D6619;
	Wed, 26 Nov 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Knpr6ihP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789352C11D5
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148969; cv=none; b=uY5AR0SdbQrW/aZUbLsIfpszrsq4d/T6K4/ji0pBtsn8ZVzPUJUUBwC8VtEaaKfDOWggKjTc/8YubZAZ21QyFJUh0zIut1RweSnMIxlpZ4m2KLbEeux7cixkH2YsIGvMH8MvwWFUyuivV3tCJlvNfeqHKs9j4It7c0TbLOsB7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148969; c=relaxed/simple;
	bh=Vtl7rLBaBEn/KSTLl4Zjd1qS6jKRQUiNL/jJehq1mxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5y8J6gEeLCWimnHKhxeWfzzeoFUJE+ncPStJdJEGVXCt2D/rvZ350USMTe/96MkH1Az2dq+a7m52zQf73YJWcwMzMYvPsxD7G6AKGHBIwqcevQhgRX98N618Coes2QAAY9hXlh1b6pHp5qFzZ9YkCvNxy7v7rhs3RU8wLrNqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Knpr6ihP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso27657135e9.2
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764148966; x=1764753766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGBU0sIrWaYgVSB5vZZqcavGYAZzP+4eqGM3Jm7itOY=;
        b=Knpr6ihPF4jispJcJ+HB8WSQXLA7BF3XLiqQYHXA6q5y92v+aAA+zDmPZClNNTSCnl
         Kj/wSw2GMTTM4dpIlHbnQ1x103BzlFKSDc1G6gMhIr1BX/OkaZVoo1c9LbyXfgIm+1/n
         HqdefPBw2X727e0gslFBCxr3Dt7PInrwYV766joXc4ft7aWpOiDyy8Yhssr8pmDAerCx
         Jsq6i2LQtQm/YnVolSoOTHYol8kxfmGYfDcq6w+ra0AfbaDc2A05OqEFA+rKN7MzEXJq
         nUfjvxCVESC2KaEBwoz1WmK2Z6x+RnZtPhH19Co4mBdvrXHMPx+/9p4hydkgjkKFvKpa
         IOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148966; x=1764753766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGBU0sIrWaYgVSB5vZZqcavGYAZzP+4eqGM3Jm7itOY=;
        b=nEwSsqJsTe/dcNJ0X1ABPB2nR3SkCQedsM/9hqqAVmHKnD/F23PJwPSOjCIauTdbZn
         Za5sZ7sd65MRovBGkju/fGvcXOZyd6MPtul0V/DJM28KiFbNjzkenRy7wdSpB2gX553D
         20gdiBxgm7wHY1LWSaln3OjUyh01p7mQ4xjTAPzsqfWhHXSLdYcrKUvOGn/f2ihdLNc0
         BTWU9KiemX7QOGV000L2pUid8yu0lC0j6erQ29dzgRLRau1tcOLqqA4ed7isrWl048bd
         GUXKb+5Mn2lKcczT5NbBxF5l9u2yPpvPHEd56XVY2gEY9WnyYMmDYhK5Erel1ln6cpCt
         sArg==
X-Forwarded-Encrypted: i=1; AJvYcCVkfHefqLDKVrb0DnhQxf1KdukIzPnqFuvzK6lEe2osN15Qmx8B0WA4gGSZSUL4n6qDqnShLos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqzYmf/UxenIeBMNEOYnzhVBnXvwDXTIDhQRHJdjCr5A7g1It
	u8lr6Z8N13VNsqrguxdlxP5R22FSA7swIi5wF/OJAg/wwgo5r8K/AUtFlH67sdJHgzE=
X-Gm-Gg: ASbGncsCtowobXMuBhgniqfWClh95SuwYQIEvmK38qlp/Q6JNGNdqeYszd3mSuL4mMj
	8mt2wVY+XUTpEQOxa5ujmWUvZgh/urNRE2fCHXNTufy7U3GmwnNffa8/gEQzXu0e2Kr7429y9Ov
	ZxBL4VA/tEkvDQbejKun8+WiaT/fQCHJn1t6ThzaOcsEEBJ94eYafDL5lRewJzsoiMrn8yZRQMm
	FcwZCLgfkzx6geaJlgQTpm7NBpsZKkVxqSxx+v6nZFfq/eAWVTh1x1ALSub3QiLczL10tlwx2HM
	pVzqG9EWFk/O6Ep7S03SdXdK6+768ZwWOp/lX822Kc+nLOHct5Ng1f5JO2PhJxF0i13gQYLrxq6
	SKKmnGbnqj/rXLmi54UVupHD07QRIDfAhT8sZreMiA2OnRyZHcmf70hzbRcOGKKUobvX8yz635J
	uSqk4gjHDx2kifvQ==
X-Google-Smtp-Source: AGHT+IHSYn3JUSnHJS2jB5hsr97OjXCfnxSaHWvWgEUcUiMAMXNUe4oAdYVmIpW3puc1TP4bkxt7xw==
X-Received: by 2002:a05:600c:4f4c:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-477c0184b1emr211669725e9.14.1764148965785;
        Wed, 26 Nov 2025 01:22:45 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ab8bb21sm34249085e9.0.2025.11.26.01.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:22:45 -0800 (PST)
Date: Wed, 26 Nov 2025 10:22:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <aSbG4lo2cFbwytTF@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
 <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
 <874iqxlv4e.fsf@jogness.linutronix.de>
 <jm64hv26zmnlyl6lu2zoodkaz5mxcykwo5kdbvv34kyyvc6ov7@vdtslu4slrux>
 <bcooiesgor2qs6l44xotc6h4f4b5ktoodvuuapgsmpmlxb7sav@5xn5qh5csem2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcooiesgor2qs6l44xotc6h4f4b5ktoodvuuapgsmpmlxb7sav@5xn5qh5csem2>

On Tue 2025-11-25 14:24:55, Derek Barbosa wrote:
> On Thu, Nov 13, 2025 at 02:15:09PM -0500, Derek Barbosa wrote:
> > Hi John,
> > 
> > On Thu, Nov 13, 2025 at 06:12:57PM +0106, John Ogness wrote:
> > > 
> > > I assume the problem you are seeing is with the PREEMPT_RT patches
> > > applied (i.e. with the 8250-NBCON included). If that is the case, note
> > > that recent versions of the 8250 driver introduce its own irq_work that
> > > is also problematic. I am currently reworking the 8250-NBCON series so
> > > that it does not introduce irq_work.
> > > 
> 
> 
> Hi John,
> 
> Apologies for the late reply here. Just now got some results in.

No problem at all.

> Testing this patch series atop of Linus' tree resolves the suspend issue seen on
> these large CPU workstation systems.

Thanks a lot for checking the patches. It is great to know that it
resolved the problem.

> I see this has already landed in the maintainers tree at printk/linux.git.

Yes, I wanted to have it in linux-next in time before the merge window opens
for 6.19 (likely next week).

Best Regards,
Petr

