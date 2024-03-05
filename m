Return-Path: <stable+bounces-26712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6B87154E
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7F51F22DDF
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E14CB23;
	Tue,  5 Mar 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpKSGbLW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE87AD5E
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616873; cv=none; b=GAautAX5EPW5it/fgQLENBo4eiTtu4ZZNnZhEYBB2b1FgoqIWyjcKROJGum0q8iz0UgHF3WZJaTG1G2PmAM3xpphRvhuEDqo7BJPQ+pisr/Vpmzb/gLunBk+HLSQqQB0WEoMcpNJ4PmoC9ZwjqEf41iUiYbDv3xS0spmXN/aku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616873; c=relaxed/simple;
	bh=BWyP3ZiJl//c4sCDB62Ke5dXVqc2HOc/4/gYCNh4cxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXEfaOee9hsXBBd//ypJEKEmZ4JHVX2/EalaDOW4i8JJakSCzQSt3cffM8UqNG5/LeZOKTACsSNS/AvW/GCOPOo8YGwXvap96zqLQsKNSCqVIwb5iJNp6BJ3KbEkKQBWrf0cOQvuBPw2rhCwz1O3z+imNwS6mPz+vTj3KV6VZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XpKSGbLW; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so2136599241.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 21:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709616870; x=1710221670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiQO/RxAuC9qRBH2upguRHveqR66bc4QXGr9EN8Ghi0=;
        b=XpKSGbLW0GSpVnTEZ3PoqrdXv1IwtF9txYy+tCGbjnpbao6EEVWD4oubTGVAU0WPrV
         0TjlsO/XpoobMEh36tV+CxxIUUBhM28aSPg6mNsIlC75DpoInRW/lf50V+hlT01m+dOq
         RmjslpECoavTvc/XFTSCl+g45/Hx1vHriBFvCXtJmw+TIu4G/CLEt/OtrbdVAlces/Ah
         BfoCcvvI/AsUZsOuTod3phjDqwqR0P6AqKFbJXh8L1bu0/OGmdvp19r1ik4fk4NK0gqk
         BqXAw4UwGvL7Hh5hhfyTx6Pl+NPBT31OyVuMitM3lO4xCKmoxCZcRIQnSoeNCtEVQNhB
         +yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709616870; x=1710221670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiQO/RxAuC9qRBH2upguRHveqR66bc4QXGr9EN8Ghi0=;
        b=mePQA0E8fAWE9a6hSvIOTXQOSbwDfCJFC/N8zu7BkK4qMrnmMPgZqs29FtRHC/rzmD
         I+gYfGl/4VGVKXNJ5M6ykwctgozxv+0cHtGyzk9XKj8v9agUjSaRV5FFag0x0K3/YmtY
         swndIAzdT9ujNG5SKacrDnN7XB6J82nnq1Rl2WSx4xEcMBlKVqMCXludET66XbzEdVA/
         07eBIWJzAvHmIXDnQ7+a1GN5RxkYZhhoAxqJrAMNlbfdZQqwElSrEPflkGsj6H4O5M7Z
         AyRbMtmt2VX+l5KgBSNqtCMUhyZONt5e9V6P670/uBvNY/69VjE0eDFUPWLkcYwPGhgU
         FUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu+kNS+x1wqr4R0/qx58kc6I2BzuhYPW91v/z0Yfwj3obziv0il+gJoczzAvnLzXD952kVvfCbtk9muqfiQXebUz0aMIo/
X-Gm-Message-State: AOJu0Yy+LDP0uiUhWuA0cDFRw8ptHnunAribuT/TA7rBAo6jxMcODSkT
	pPof3/BrH9OqO/c1OWE82gZVWIuBLEtucHPrNKWu7MHl/wyJHp4DYOHldyht8xs7UR03UmMCOnH
	erQmIZPwBGbm5TPaQwOFaOCf5NtbAibDV2pNvdA==
X-Google-Smtp-Source: AGHT+IG4hbbCymssTEntZQDnPHryRIK17OJT6rKJrg61BKfg6ZtC5P1oebB0sMSPA7+WGr6xZEvXtaLOYgIPG0NubuE=
X-Received: by 2002:a05:6102:cd4:b0:470:5d0a:6b29 with SMTP id
 g20-20020a0561020cd400b004705d0a6b29mr951020vst.5.1709616870285; Mon, 04 Mar
 2024 21:34:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org>
 <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com> <f539dd73-96bd-41e7-8227-fbf1ffba068b@app.fastmail.com>
In-Reply-To: <f539dd73-96bd-41e7-8227-fbf1ffba068b@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 11:04:19 +0530
Message-ID: <CAFA6WYORMkAmoSqxA3NSfTgfdebnVt1VjJp7i23yt8L8OquWGg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, op-tee@lists.trustedfirmware.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, jerome.forissier@linaro.org, 
	linux-kernel@vger.kernel.org, mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 22:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 4, 2024, at 06:45, Sumit Garg wrote:
> > + Arnd
> >
> > On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> The error path while failing to register devices on the TEE bus has a
> >> bug leading to kernel panic as follows:
> >>
> >> [   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
> >> [   15.406913] Mem abort info:
> >> [   15.409722]   ESR = 0x0000000096000005
> >> [   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [   15.418814]   SET = 0, FnV = 0
> >> [   15.421878]   EA = 0, S1PTW = 0
> >> [   15.425031]   FSC = 0x05: level 1 translation fault
> >> [   15.429922] Data abort info:
> >> [   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> >> [   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >> [   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
> >> [   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
> >> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> >>
> >> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> >> lead to the introduction of this bug. So fix it appropriately.
> >>
> >> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
> >> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/tee/optee/device.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >
> > Jens, Arnd,
> >
> > Is there any chance for this fix to make it into v6.8 release?
>
> I merged the pull request into my arm/fixes branch now, will
> send the branch on once it passes CI.

Thanks.

-Sumit

>
>      Arnd

