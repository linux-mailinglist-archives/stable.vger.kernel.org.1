Return-Path: <stable+bounces-194801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A2C5DD15
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0804F7F38
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD732E73E;
	Fri, 14 Nov 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DQd+0y+7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EA32E734
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132227; cv=none; b=Mw5toSrJVFcSdaPFT+FLio3Jf9BkqlGrDgWoar2Sh/HShySvh82ImZNH8NAZV3si5wehqAod5Uz58lqSkn9jt2duBtd6+NRvcwMwUIr0lyGso1ILaX1EKMDgqrSK2w9yoqaqtCLsKYcJ2hZON7AWC3k2A6Bs2TUHrNKzMI0XbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132227; c=relaxed/simple;
	bh=gciHlXxYLdlQzs+wz9fWszVt4GV+k4O7swYAQmw88xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5TZX0X5oCP7tRpG/O5W2mrbYx3iJjkcZXQbzAn9piZ5h4UkQ0NWEp0WsxH/ef8tGEBq+whBHqdSc0cX3cUMe9ti9ml6APeb9WcRTw/ksNNR0yNTIJ7WqZXlFhH2PJOE77UiNVuhAYadOJKC7dVwG+r/2rhrNBTp0mFT/7gGs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DQd+0y+7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b725ead5800so258642366b.1
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763132223; x=1763737023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x48AYDZ6c8REpkpum5TA6RkDPVy+wpYnc495RC66pG0=;
        b=DQd+0y+7+BUAEc0dk/W2CLqAeB/ccIvpLLH1OY9EqMS70RjqnIufkMq46A90oJoKBH
         ntccNGcE3dfFtMmFVcr2zzUzXbFrdu/Zpt+dRbXFR9sJhTSMHB/MfVq2vfGE1VvR+Nsm
         pAPTaA7gTZKNJ9pzIv4+toRysiuZ3Z1LXPmpxuv+2FoqO/txN3c2wCdwYncRL+7Jqy2H
         vuz5u5c9iiowzVmeQUQRi3iUCBlx0vK90eTjttKfMU9V3arxgKXR6PYKpVuhWtj+tYJz
         en1rx+JZZnTG7x7VdBH2Z/oUYEW7XsAaJVtPMNFarwZUqI2MDp6C6+IUlzZAwutgH6gb
         HDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132223; x=1763737023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x48AYDZ6c8REpkpum5TA6RkDPVy+wpYnc495RC66pG0=;
        b=c2qqQ4wl+jVGR0X30eu5igKPjqYNAgqUoG4jY471tG+d/FYegK93jUKFGxTCcK6VcO
         XlqQeJt7baolWdOYlL5VUfpt8RYg+Y/j2rbkWtM0xUFN1ioPIZNSpz6afDHoG/0VZYNe
         n2fuXfZqegy04wh6IDPgr6uGiv4rPTROXrKWc9X9r6q8GSJUpT9K9HRQpKu7oykCB2nc
         kiVU72W1HZExXQDXGRIydHRnWvhuApRSkkd3hOf4nGEokw4f2+nii6E6oFyNjhv7Oh1f
         gdxfTNJM2biHMN0YXk1cREt/a1jTOJnK+nFS0/K49iwexiNaiKE+DMlcxuzMeohJ9n4l
         dsuw==
X-Forwarded-Encrypted: i=1; AJvYcCXbsNGySaYS8BqovrVP1iEE7udy86xdXt+D+uVQ9kGaPWl92cX18eZmvFkbffMu+M4B14tRSYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVZXxo6Kr6WTo3doryEXqTEd8RJ2QLIHY2zC7seqvbCN6AV/T
	I7o89Y1dW8ZLwOlcisZk/2Lb4sr4WxLph6WOQo1xs7xZReRL6PPwXlc+qtQp1KRiDV8=
X-Gm-Gg: ASbGncuP6FdmC3Ii4zrnkskZbmHuPpwnPDw4KUcuIzQ4XtPitu8Pg3RV6B1gIlypk4m
	hibQYRRWApuH6jVCoAFOL1Y3ExmEteXutTORJQYp9RlX/lBOlgnRM8mf5XAR8wx6YwPtnlUOt7w
	nyanmpGQ9tOpnyR8azt4LWS47OLoHYJxXJ1cCKsIO8weuA06mPeMM52XOAqHGYO+qh4YbnVDke5
	OluX9NtWpq2EobF1X+zWR4ki9suVzaabIXLf6tW0F0dX1j5rvjmz1XCczTjdz/vAqC2GzKfEgVG
	yHg3VtgZdvMUDALoSVO9vx+vs891g46n6XGtCQ2QNs1Ed8KHWOWXLsowhrq0Fk7pcFnVFMEh3/I
	YujixELSy8tBNAOjOT8FXr6mjRM9gPFy4/KgDAbJpzbsts7Pzm+crt3jiTsomasOsTBQYd9S2pT
	d0dO0=
X-Google-Smtp-Source: AGHT+IGmgo/ueKtcknmnIWfzWxJ6fDWEdRR0mk9D2czttZy+48P6Hx0ftDkWhgjzFkqNL+MGjNP5jg==
X-Received: by 2002:a17:906:9f89:b0:b73:42df:27a with SMTP id a640c23a62f3a-b7367808697mr315784566b.1.1763132222635;
        Fri, 14 Nov 2025 06:57:02 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdaf6dasm400448466b.63.2025.11.14.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:57:02 -0800 (PST)
Date: Fri, 14 Nov 2025 15:57:00 +0100
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
Message-ID: <aRdDPB73FQ4eMomh@pathway.suse.cz>
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
> v1 is here [2].
> 
> The first NBCON drivers appeared in 6.13, so currently there is
> no LTS kernel that requires this series. But it should go into
> 6.17.x and 6.18.
> 
> The changes since v1:
> 
> - For printk_trigger_flush() add support for all flush types
>   that are available. This will prevent printk_trigger_flush()
>   from trying to inappropriately queue irq_work after this
>   series is applied.
> 
> - Add WARN_ON_ONCE() to the printk irq_work queueing functions
>   in case they are called when irq_work is blocked. There
>   should never be (and currently are no) such callers, but
>   these functions are externally available.
> 
> John Ogness
> 
> [0] https://lore.kernel.org/lkml/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com
> [1] https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com
> [2] https://lore.kernel.org/lkml/20251111144328.887159-1-john.ogness@linutronix.de
> 
> John Ogness (2):
>   printk: Allow printk_trigger_flush() to flush all types
>   printk: Avoid scheduling irq_work on suspend
> 
>  kernel/printk/internal.h |  8 ++--
>  kernel/printk/nbcon.c    |  9 ++++-
>  kernel/printk/printk.c   | 81 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 78 insertions(+), 20 deletions(-)

The patchset seems to be ready for linux-next from my POV. I am going
to wait few more days for potential feedback. I'll push it later the
following week unless anyone complains.

Best Regards,
Petr

