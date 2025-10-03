Return-Path: <stable+bounces-183329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE38BB825C
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EADB4EEDDF
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE7253B73;
	Fri,  3 Oct 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="k2M/ReJg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54412561AE
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524690; cv=none; b=Rg4uOXfTE76xFBwOvElb5wbuk19HewHAAR+j5nOq3sqjsBOOpC6esUPc9T9ptonvgweLUb4yJiPH+9Hw+Qc7AMgu4FHFuXwDfzacGY3HXmVLE/wLkwVUKZtpcWhZx6kSeXrs2ZcxEvG/GRLyBLcjlIkB/SCYnZH9PHSV811epVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524690; c=relaxed/simple;
	bh=bGf/fVMq7D81Q5YNB5Z+ahF/or+jbs9kwSx5EKrooY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFBKVUHXvl6qq28xaCGRpgYIoePJ6Xf/KUf/Yl5i2h4jwYt+FwNmGQL1B498B/kVFWa8ARLiLs9OAX9Yhvb/EEaFrPj44dMoQ2rq8LlKiRp8UIitY36TIH/+hJ/8KhlFAHyQfFuuZWGAUEqbEBVtDRAhHfcW+xggUhQCFmGtS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=k2M/ReJg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e2d2d764a3so21352601cf.1
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1759524687; x=1760129487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z9OJHsg9AnDgBWFYYVznso9JgY1ikRBT350Nr1kqdA=;
        b=k2M/ReJgV/PIPf4/m4x1RqbifFPwBk5bqmg8At//lqk6DpVBhDAm6KT4/g2mVY1DEA
         2X0Ac4C23kFdj2Mos7g7JXG9+pZHCBLeYaaw+h/iGbMT+0fHaviuoapGj038Ccl8Zat2
         eRzWm1Q3dwSHgL0go0/W5FG09tfDkyG4uULYxOF+puBvARO9pvQTt32yEAMg92oXnql9
         IUErb7yQeBzFm6BnuB6SeVU4K3fiM+g50n9rCflqYg7cQhXK70ta5OxRHeXHv+rAb6Ox
         b/dlWauTsRnEdQV09tGwWa6Q1NspN4PMi0eCIyQakckYXOZZcoK8vtk84LT9Yh9l2Cm2
         tFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524687; x=1760129487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z9OJHsg9AnDgBWFYYVznso9JgY1ikRBT350Nr1kqdA=;
        b=coC6bPKcAMAi9p49WU9Hz7ys+PwI0EKFiiNTt3OblhFHb1xKycSwXPgEpjCSgb3hKc
         Xf1noKGScn2CZPldlSXvSYTLzswM1xFgQT7E05T3KlqAUcg1t631BvjKwwak50kmvOZv
         98TZeRP0chK0Z7chKjRH8D2kCJ2xXg+0+oEv1ejH0jZ00UQ8HjiX8hDAktMuIxvqHkEP
         ClaRqxayhDvwzmFRCq+6hyzMvQgRzyVC3ZGFOMNZs5YQhNx2zfKep4gZjDH8nJCq9cO9
         sJPJu5OWtrTT/iMi7UoT1sL1k8ou1uonMEr97+jPzyQDWaFftavhIJaJiSik2iRKwdrm
         K9zg==
X-Gm-Message-State: AOJu0YwnLBMFNIqxMWi0WDyRI9f5z67THU6O1VYpVRHuQKs6SfUw2S06
	l4HGcLnksQxEY97yRH2Ap+jYSp8A+zrIRQ4V8+L18SCMT5F5cWv2tIo+5/kBHykvjFifx0V4ZMX
	Ja9uvdjsloCQYiTPK5js5+N8VDGV6p0cU8grWfXdQsw==
X-Gm-Gg: ASbGncvExbknkpigWyLUAosIQ/7WtgsGcL0I4tN0RALT3vL0a5aNfrAI5EFfvdCHouE
	EXDtkY10bu1FrGFP1L9elHEM5HHnrJ+gMhuBIAGYZLDDxv3rnGFCU/Xgn9YtVR5xeJbfi0kb0t3
	oMfi2/0vnfClsdtD7juAA347jvElEdj8g5qjYbckCI7QfwGtOa03UdOEbxEuBSFZrwCLBtrvPy0
	2p3jEXhoIgzDfsZIvCbIvEhMcnKl4A0lUUKrlBVXG4=
X-Google-Smtp-Source: AGHT+IGOFuK5QKXUa0EoyQNwTfrrar3OCp+dKAGP3fEaEJ9VnSeYg1Yk+ezWQ9N6bxp2R87Mtx6d9Bh25m/9JjggpuQ=
X-Received: by 2002:a05:622a:303:b0:4b7:9add:76cd with SMTP id
 d75a77b69052e-4e576ae6ba4mr64596521cf.42.1759524687516; Fri, 03 Oct 2025
 13:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160338.463688162@linuxfoundation.org>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 3 Oct 2025 16:51:16 -0400
X-Gm-Features: AS18NWCwKeFKfMLlMvvr2cSuujlh1BUpd9drr1fldSku7mQZdxTUWOKjj9ta5Is
Message-ID: <CAOBMUvjBZLErkgx=VK06QHFBJZ3rLiJ+NdXitrT7PUnd452Jmg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.51-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

