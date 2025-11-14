Return-Path: <stable+bounces-194800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE84C5DF19
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8EDE502FBC
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808C328638;
	Fri, 14 Nov 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJYfOWMW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FF32AAA0
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132130; cv=none; b=HPOGQJPmGT2UfKakVDpI/pMlIXVqKO9yB18oGcrsQIT1IqQ9BaCDZZjNcwAjtAYGZm3zBxUkDA1TWVvmoCv5khx6zdOdqbxal/cLCfX7gEWZ0tth6TCGuQvQivDnLhYULWx+hhXOY0UPeQbOeP22tRsCLPkJgiKrugPrEBAwVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132130; c=relaxed/simple;
	bh=2Khq+clUZPAnTgX8+cOpXF7s2qoRd84f1QccmectT60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnTvzNZ0dea5saP/ue09xyvqXX5rwMLQmFG7bb7j7IEd6Va6VdZ4i+C8rHYbdYWsZqcazu68HR8h9mT0rQiNN2lXo4QpPz7Ny5FYdkpZ9hJnOAIDWnwopDFY0vs9JUgvZGPsY4KHtrZV7zj1UMo7vGjJKy91gFYXoqkrvuSPAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJYfOWMW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b714b1290aeso311200966b.2
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763132126; x=1763736926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDzBp/INwp+nibTWfFPJwgjZkiTPte/DobTvzSfhc24=;
        b=gJYfOWMW/a2/mvzhAdwixNybVhMDLe8ppWD9QSzWdX2ecxR5sDO652vNNywaVfNuEz
         DmyKdMEna1IbULw+D6Ooo+4mEeSEpeBHi1aaXhm2E/w7IaDY8iBfdQxosMxFdPETd1VE
         C3RjFx4GSX7Afuai8ae7HgliGZhQesFEdGCuCMFB0sdbfdYCME8CAlGGigkzZAiH0bmK
         YQ+sW5SN0+eJ3NwMBKXa053PTj/753LAK0hk9oTpQN23/lSzfkXgGqFXyIRyQYYT3cma
         ovPhvKf4HxKVIk3tZDwF+HADGJZ4flS/n48Z+w4ENrhF+EJVRzSKSaJ03/pWuaDQPY8g
         Yhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132126; x=1763736926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDzBp/INwp+nibTWfFPJwgjZkiTPte/DobTvzSfhc24=;
        b=NfDqc/5aNOkIzBssnefHf8KmX+GENO2VuZXBCtth5NUkC68a9PBa5hZ5sUPJOl0Uqz
         JF/KEl2aUi0XTD7hQtsWnsivLK/hcjMVJ7tlfkHsNCIHaLSDgwzFENEi5MuaJpgkblKc
         LZbDe3fJG5bxB4A984QipmJ5gxHqv/0XlojnAMcRE5InCiIQb8A4vM4hNxY/rEO3tQk6
         lrUaw8e/+i3QMXoIuEwgvsf93vdgQInCJdSzIANkgYnODzPB+YP5KQ9bmMf1xiwAFH2U
         7qx4JrvikOvcMnuuXxNWt5H7YPDFvjfKzDFrGNJlWOH2wJdsVJUJyxMMJUft/7vpgsSF
         r5kw==
X-Forwarded-Encrypted: i=1; AJvYcCWMhjdI01JrdsdfTZKUK4nzaaR2+/LXvzCHYOxKOBOHhS30BZF683nepZxOc3sYu5V1UACsWGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDfv7IL25+0vK3fr2v6BsnBM1TB/fb610c38dLq2ZMUqrO+pU
	WPQDk5drIppd5tEkQIduHWCfxjQFiy5iki2/hJW9M9qQBBwts4+lkoOUmAGr733RpK0=
X-Gm-Gg: ASbGncsO7spfn1vvKc6iRhbfFmFvXlC85+5Ew1Y4QTnJGSkWo2phI7Kv3lS3CLMnZLp
	YzCIdw3D3OrrGpLfGPF8FXoJMoOqSxvItAQvnuoeXM5hrZlzUiWARd/1atGf6XG34A+iJ041CGo
	iAdtIdOj6D4b5OvH/FfoC5yvzgj7JYvQv9PbSejA2VIEPMl/n++ppR434fSeNRwDcWo+O7nsE52
	GkyWpjtc+MR121f7hzgXIh1W2rn1wqz04PCTHvUzsfcrFRmVJJPQaOMPMubelPcAhf7ml+8U51w
	4l28V0tBpQpBD8rcBikXpfDTkZ63UtXEBlJxUBBa0GMqvG1YPDLgEwenn/nt915bVLp6vSdI04i
	H9p+suRqCERppZj9QFnNSpB0NErno415AACDbQ1EMJvcVrCVoyCYLP5tFkH5rcfOo/XT6k483QN
	ihBYA=
X-Google-Smtp-Source: AGHT+IF+i2WhjuFis09P1HmbNsLUwVUwMcIFjOCk5FIhnMXjfFaPahdHVqojAAaz8G1W/NE/AKf0zg==
X-Received: by 2002:a17:906:c10b:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b73677ece6fmr307763166b.8.1763132126316;
        Fri, 14 Nov 2025 06:55:26 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f8767sm3899788a12.9.2025.11.14.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:55:25 -0800 (PST)
Date: Fri, 14 Nov 2025 15:55:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <aRdC3Dd-dfoWopS1@pathway.suse.cz>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-3-john.ogness@linutronix.de>

On Thu 2025-11-13 17:09:48, John Ogness wrote:
> Allowing irq_work to be scheduled while trying to suspend has shown
> to cause problems as some architectures interpret the pending
> interrupts as a reason to not suspend. This became a problem for
> printk() with the introduction of NBCON consoles. With every
> printk() call, NBCON console printing kthreads are woken by queueing
> irq_work. This means that irq_work continues to be queued due to
> printk() calls late in the suspend procedure.
> 
> Avoid this problem by preventing printk() from queueing irq_work
> once console suspending has begun. This applies to triggering NBCON
> and legacy deferred printing as well as klogd waiters.
> 
> Since triggering of NBCON threaded printing relies on irq_work, the
> pr_flush() within console_suspend_all() is used to perform the final
> flushing before suspending consoles and blocking irq_work queueing.
> NBCON consoles that are not suspended (due to the usage of the
> "no_console_suspend" boot argument) transition to atomic flushing.
> 
> Introduce a new global variable @console_irqwork_blocked to flag
> when irq_work queueing is to be avoided. The flag is used by
> printk_get_console_flush_type() to avoid allowing deferred printing
> and switch NBCON consoles to atomic flushing. It is also used by
> vprintk_emit() to avoid klogd waking.
> 
> Add WARN_ON_ONCE(console_irqwork_blocked) to the irq_work queuing
> functions to catch any code that attempts to queue printk irq_work
> during the suspending/resuming procedure.
> 
> Cc: <stable@vger.kernel.org> # 6.13.x because no drivers in 6.12.x
> Fixes: 6b93bb41f6ea ("printk: Add non-BKL (nbcon) console basic infrastructure")
> Closes: https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The changes look goot to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

