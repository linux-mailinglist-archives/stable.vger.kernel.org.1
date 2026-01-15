Return-Path: <stable+bounces-208412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76318D2218C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 03:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BA3E30486A2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABDB274B35;
	Thu, 15 Jan 2026 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmS0Affo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DB26560B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443092; cv=pass; b=uC0pqDYzpWtoML4oOtaAghOYYMDiNXHZZqwLwe541ko96eay7qdKdOOcM4cb3D6XJCyWEq9kR8E5N0xOyfdunAPoQS/L1FcWxOiQXIBwJ1f3dKRcs/nuTAj1d5G/iOKx3iqJmx4lKfhQSQXEyOXzYET78VjTllZ3hT0zcLLPqmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443092; c=relaxed/simple;
	bh=GU9gFbsEQKP3YK7yys92528/fDnsy2Fkse95G/VoLxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F80En5idMAIrDBLIyHHInbHaMYZ9adGmQ/4Rca1wJX9YooQOk0XfB4qzOAVrbrP6VlFOeG7Z76idh+i2o/tzrHksl+Umj9oLlLwEXsRoychQB7mFb7/gS1P7D+UOmy/1cWvEptoV0RlMH1/kh2wr3XeE27cJ9Lxjd1P17DH4S7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmS0Affo; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a95a96d42so17975e9.1
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 18:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768443089; cv=none;
        d=google.com; s=arc-20240605;
        b=Dq1vVyyXwRIw46LzrrEU5fzEDXqRqr5ngGwvwQZTr+4xwlWUVD72r2gKeVkQbWP/RV
         R6rmFfgEqqrr7MUNL3ZhIJdRnCBG6VKb/4+DsPj8o5Eh/4jC74oZPj6k9uesDtbQryEp
         Fz25pKZEqB1QtYlcJqCgVWhrgjiq/ldqAUA5MVoNP0ryyoQwjpP+4v0gTmVlwrKuDmNj
         liWJIhmu4bFrqvxbfiBbBqnlhR3T5SrHU7ZPAPX3F+QNn59BZhBWPTy5ywl2drwSvtL3
         c45wbwW9Z8UnhsPRF4htZDV1aNehOKU6IISFsTCuy4WajUTVs77C1iIKUobwJWZjejLB
         3DVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZB2Tkb2iBFUCMnkjohKuozepoklzEsrHClEgCnaxUK8=;
        fh=lOLwJgdfDQCkuP7Ir581ZAbtVZaWG6GVouRBhcYmeQk=;
        b=NaR/uLUnOeIP+hK1fR3Tvgpb0ntvMx+irMlmN6UCeaZVQytmLX1jtm7UDIZKaRf3+X
         wTzjNDpwXCjSH3sHS42bTU6CbppW8eCCDitkHyrNQGyvV+wZyOiFWCHjaKFFJj7I/j3g
         7+uM7vQ7NEldTbQeqm7zk55/usjXuuqC0h86x/MKKio82jktGr298IuqlkwFTES/OAJF
         /xRrvSgnMg+J/imBp39kwvTSet+K38nYc/N8k3cxRWGbUihTuvqBm5DbSrToUgDNc9Sx
         ExTaoKvWUZkQkYOURXuAFiixm1vWv5gLuPwVLi7Yz8Jt6IVj+G8Lfprpnk1SkYRoupZL
         pAUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768443089; x=1769047889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB2Tkb2iBFUCMnkjohKuozepoklzEsrHClEgCnaxUK8=;
        b=LmS0AffoT/V7muaWPbErujyQ9EZhZwsVdqJezhlprALRNlWGEGnblSid/8PNZs3ovp
         Tu4Yt59SIvCL5mxa+enNHB7sJcPlQyfeLfKeLJVYmDuwhMeQRnm5Cf+Z0m2m9zA+0y35
         8rNAjRkzHv0f1P2ZLSUGdi5WLY2vl8ClruB+Tvy2JX09/QlxobkliRqCmJ0k7WiKh4lx
         FsXzBEPj+PhFQf3biVL1zwuRc02mqlke3KTWs8IytnKFzZp1CjJ7TfAmjmO0wqzPfmAl
         rbBsHYc19c7G8TYXwuWoKbDXwApIbmcITOOEQT5mdPfign0qZgEZy3WjkxUGmYk5XvfC
         e6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768443089; x=1769047889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB2Tkb2iBFUCMnkjohKuozepoklzEsrHClEgCnaxUK8=;
        b=P97UHPvJ0+n1uz4g3FCK0ZZpNbWZwQlanluwfjXeBxdoHjwvRXsV3n080f/p8Z18z5
         aUyE0q1kabiZ5Z+OvyNqb84CqsvfhuVUg/sVY9XYQmYZ7SlO0ozO49sJnhuUY2N2rJTA
         +9W+d35fRnaAk2699TlLw/YVIJvDnhMZXklbouGd02SPNeqIFqekRMBWgRoeuHadkT1N
         JxNRmmmxLNbmMBX6RQrdHM51YA4/E8ViscrdpYbYabhHXN3+ggNf9D89ANXkAdmGbKsF
         eEcfJtwuplpSFeDP73qIDm7uoChE8WMZXkdTY0iaoyQBjbHD9YZN7QLJM3zkSmZP2XNi
         SBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCnu+jS1k6iXj2Z48XtnWuHuYepjeZLBd9a5x+XdXPTZJ2U6JOVV2zrvPu+FI0VKvTH4nnCbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Un0nz8SHyzrorMC6iY8xNK5KFE0vcMQJjRlBGWFZSXt61PnB
	iIuVKKl1KkKDb8dzmgJmJSjXSKUfKLJTx8AFzJRNjYSwsIy+79QrTbv+YTVU8GN6t0Q6L0hvaNX
	Mc8YD1mQi5Dr1Ic+hjU5QrPkXb4692XaL+hFF7NT/
X-Gm-Gg: AY/fxX7qVEZoyDW6PlCCsUXfqwr9pok2/VkrAMsrvQUo+eugFNTwMp+rynNBAJCtBWo
	Bga/P40/GrNrDeChqirf7XzPFgZjFT3zi/7J9ZbLKrHiklE/ShknnxMUzQHOfqFd57IPv/cWk/G
	EEq8q1nbvJRv0aDuSByYNhNCqVAujzvUfn4Yja0QSYGPi5eaCZf7jEunAtQP7n3aKce6Kak8j7O
	Ft4UuVmA0vysmAskV2BOVhTlFNy/R3TqZj0D7AcPlfu3IMcJbtx4eTV0A4IvOBWeJGxhMuFcKIS
	IL3iFTPEAhiFS80v60EKQuo=
X-Received: by 2002:a05:600c:19ce:b0:47d:6b82:d954 with SMTP id
 5b1f17b1804b1-47ff94e9861mr213485e9.5.1768443089055; Wed, 14 Jan 2026
 18:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114145243.3458315-1-lucaswei@google.com> <d10116ae-fc21-42e3-8ee0-a68d3bb72425@infradead.org>
In-Reply-To: <d10116ae-fc21-42e3-8ee0-a68d3bb72425@infradead.org>
From: Lucas Wei <lucaswei@google.com>
Date: Thu, 15 Jan 2026 10:11:12 +0800
X-Gm-Features: AZwV_QjxHuOYFBK_XIX3hZH91ksqeZtJ2lgVboIBtf45I2RCXUJSUGcAgkAQ8Vg
Message-ID: <CAPTxkvRXmVB9MbPX2vkyhAnLDyJX7YviekOH=y3EcS_1e796Zg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: errata: Workaround for SI L1 downstream
 coherency issue
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com, stable@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	maz@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 8cb3b575a031..5c0ab6bfd44a 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -141,6 +141,30 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
> >       return (ctr_real != sys) && (ctr_raw != sys);
> >  }
> >
> > +#ifdef CONFIG_ARM64_ERRATUM_4311569
> > +static DEFINE_STATIC_KEY_FALSE(arm_si_l1_workaround_4311569);
> > +static int __init early_arm_si_l1_workaround_4311569_cfg(char *arg)
> > +{
> > +     static_branch_enable(&arm_si_l1_workaround_4311569);
> > +     pr_info("Enabling cache maintenance workaround for ARM SI-L1 erratum 4311569\n");
> > +
> > +     return 0;
> > +}
> > +early_param("arm_si_l1_workaround_4311569", early_arm_si_l1_workaround_4311569_cfg);
> > +
>
> It looks like all other errata don't use early_param() -- are they auto-detected?
> Could this one be auto-detected?

Sadly, this can't be auto-detected...

In my v2 patches, thanks Marc and Will for pointing this question out
and we don't have a reliable way to detect
errata in runtime because Linux generally doesn't need to worry about the SLC.

Robin also proposes a few feasible ways(SMCCC, top-level SoC/platform
compatible or kernel cmdline) to
enable this workaround. But, I think it would be more straightforward
to let the admin to enable this workaround via cmdline.

> > +/*
> > + * We have some earlier use cases to call cache maintenance operation functions, for example,
> > + * dcache_inval_poc() and dcache_clean_poc() in head.S, before making decision to turn on this
> > + * workaround. Since the scope of this workaround is limited to non-coherent DMA agents, its
> > + * safe to have the workaround off by default.
>
> But it's not off by default...

I think it's off by default.
Would you point me to where the workaround was enabled without cmdline?

Thanks.

 - Lucas

