Return-Path: <stable+bounces-195187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A1C6FB1C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D12A380DDC
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FE2DCBFA;
	Wed, 19 Nov 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bp8alCq/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9218A956
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566241; cv=none; b=e7XQh8P5NkZGHTTFu/MvSaWtz+uP4l/FqIUnDm4QdmUF3XEE2N5jiSudCVtfT+1h8j5h7paRlaV9nfCZFzAgHODJvMhPQINit+cONgbCeO06F3SJAn3k+WpbSSNPUDkzHsFxT9aiDNXXeQJnfJjaPONZvMZB1RqTvLaWT2H5bDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566241; c=relaxed/simple;
	bh=gBAPjo8ugyvHmrVtrmxOJ2a0rCcEYfOjyZ36VdDd+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jighWlIoKB5nwng/+1tzn3sRa/Y2bAPho+7jd3x3eBQDLFJF7Y2ul8+KgIrksV7ByE6dsV5w6YbBC7hLYJC6NdrqC7cNWeE+Z+d2FERauGG4tembVD9r0OzUo7buYfJ2C/zEfISbYaBaFCodTLM4lMjIB7K+WpYrkMfsPk4JIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bp8alCq/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b73161849e1so1280471666b.2
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 07:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763566237; x=1764171037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cR91zrIOJSKyh2Hyhj1xDMc7fJKXJHnNsh4M5UGYklM=;
        b=bp8alCq/2JEXWopyzs7Y0oyXpBboUgXkqTmTIqdI9PawLHumOSJjoviiZ81RvuwyT8
         Mr+rVXMiefGh98gy+yEqxTI92kAfzJQdzQ7KKChznsOXUDmnysAz2bEi/6DkhwnklAm1
         22ycVCi7M/YsCPC5QPq8+swz6/fjFkJPynqoFeKbSkS/Jb03yqUT+Z5quQ90iP4zQmQ7
         2UrLRYaGxeG2yJZATDa3YLYrT4pbfG242YlJ0e68suiA610GhR5M4o8sZSeXkQSjivVF
         6jEMES7Bwte3niNqsuElOPiKzpqzF43eInDoFoDpW20ph1K+jeguL9rhghEPJ6XlD99N
         eqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566237; x=1764171037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR91zrIOJSKyh2Hyhj1xDMc7fJKXJHnNsh4M5UGYklM=;
        b=Rxrcam16EpqpAJjeB+Fa1c6J0vzjJFkOnFtBnJLZ+xfYBmj2148AWVulvVn+QUaISU
         gyYtNVfoBHys5p3RnLgj2bvr/auN82MatJ4y+SMlCTSl1kJLqiewGySK6w0Wgl1CCGRj
         mXd5jPidNYQTP8EwHu/DyNihmnwXOX5EftDshbGOKNFLqmuswqAlU8mDaQ3B17LnZ8w9
         KVePI2ti5KGe2ROjdMlbb2TwEcY3RiTllY45M+z8yHx56qS7wkLcW9v1us2/BZbWGU0O
         RglPZjGw5hWsjIY/fUrM23HK9CLlPqFHnpHXC2lvitr6ikZS0tUCMAFSmyZfN33tHcyv
         mBTg==
X-Forwarded-Encrypted: i=1; AJvYcCXXi3TUBMht/3/U31rhKD4Yt42Wrr69rs0JRNLiPmbjJJ7pZ0sdVeoJcQIRGUqNl4apey8SqAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnHJ6DShdUosJDfwrus5TM70fa9WKfap8TQZziG00PCK5jawI
	y/FDiZixiQIBlg5qPyy2KSqTfAikixJ3QYpFDNJqQoEL6eZ5GZ3X6RSz8vw077oNIQs=
X-Gm-Gg: ASbGncusTFmME1ubt4xrt6YW9WcXTG03qz6azCuynifWZtoVP61fFCmbTLK2q3uIlqF
	20eFNYi190NEjlssHhQObQjjLTeb5mJJMNABJWR09qyruywsmUAQvtvmq70PNiRfBsUGGTiHX3K
	/PnBI/bwdRubPdqtYPyHsy9wCjH7otLkUeF8arE5eavnwGy3jID/7UKqVopmhpKLr6fFp4K3AFr
	5K+2xJwOFqzdhcNgUiQVck9oh4SxSaCSh5OqNKso9fjGp+bmsRrpKM6ZlTSkb8IpifNqpQrW15t
	vSVJ1dY9NkH39HQZ8YRILAB2enFnhwHN8uAyAY/J2wfp9abuorTwzscn00X0ha/ZgV3fiDp183Z
	tBGgnqvpxQAULuPVs5grMO+s/p2mpoF5Nis6TLpmqqB+N0BaVAAch+Jp7VOuLfIqRbN9Npx9VgG
	RQTbMOcCR0aXtVfQ==
X-Google-Smtp-Source: AGHT+IHoB/qu/86GOU5ftmQshmg+mif3CnNL4qbLOXTn62JkkK8VdGUvRDWsx4F8y8maSQwvqqMWaQ==
X-Received: by 2002:a17:907:7e86:b0:b72:aaae:1b22 with SMTP id a640c23a62f3a-b7637827c2cmr321869266b.12.1763566237187;
        Wed, 19 Nov 2025 07:30:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d82cfsm15313831a12.2.2025.11.19.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:30:36 -0800 (PST)
Date: Wed, 19 Nov 2025 16:30:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v2 0/2] Fix reported suspend failures
Message-ID: <aR3imvWPagv1pwcK@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-1-john.ogness@linutronix.de>

On Thu 2025-11-13 17:09:46, John Ogness wrote:
> This is v2 of a series to address multiple reports [0][1]
> (+ 2 offlist) of suspend failing when NBCON console drivers are
> in use. With the help of NXP and NVIDIA we were able to isolate
> the problem and verify the fix.
> 
> The first NBCON drivers appeared in 6.13, so currently there is
> no LTS kernel that requires this series. But it should go into
> 6.17.x and 6.18.
> 
> John Ogness (2):
>   printk: Allow printk_trigger_flush() to flush all types
>   printk: Avoid scheduling irq_work on suspend
> 
>  kernel/printk/internal.h |  8 ++--
>  kernel/printk/nbcon.c    |  9 ++++-
>  kernel/printk/printk.c   | 81 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 78 insertions(+), 20 deletions(-)

JFYI, the patchset has been committed into printk/linux.git,
branch rework/suspend-fixes.

Best Regards,
Petr

