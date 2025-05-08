Return-Path: <stable+bounces-142857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA34AAFB50
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF571C07ADE
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432422CBC0;
	Thu,  8 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pRWh7vZu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764F22B590
	for <stable@vger.kernel.org>; Thu,  8 May 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710908; cv=none; b=bgHRAtuRFJMACCL7jS0lsFikKvcCOZe5i5dkMKWKWT8dDd/ytPYALudE/VRFqFo3zFN4wU/n0ZZwZHWX0EktxB5eLJ56TXd+joJiz4m67uCLZkfUzsW4ix76ALJCXjhTTUlzgmw1Tcydk14vMVFSRypfNk3rJLkD0eOhEMkckA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710908; c=relaxed/simple;
	bh=+L4RShj5f5vWujBc4hl7X7bkL3O1PyKno5T0QURiKrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5nwCp9YJJ8KgJfH4VwLtLnmm6RpJ2VDh4Ge/MvyNoJkU9p1fRSBG4TUiFfAZBGZVqJbAZChDLNpI6OPhkaSan2sXqwYuak3yB1VBkOJyiZq+y0LeklfI0pC1L922Ds23DVaH2qDumR6uaZnSgzWVavX7vNl+S+60zViyEokkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pRWh7vZu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5a88b34a6so106665385a.3
        for <stable@vger.kernel.org>; Thu, 08 May 2025 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1746710904; x=1747315704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6+F7sC4lq7A9uwyyHv0JUmrfUrtoSWQI2+38pjZK+0=;
        b=pRWh7vZuRyAPVq0mf295rzpaLpKDMLH1+ZQ8fyMKVbUA1y2oPiQlBRuob790LXYM2U
         K1ryBNP9xI8VEKxGUaFYoU90Lqs9meCEEwslxwmmArPCrbwS1ujYEkGqI+hLNrJp8Z6U
         rbP21HBX3Y7CQnkzvUT8LjU2TwATdTVPJaVS356UeHuBJAnuhy934Jft2JlhCcF04jF1
         wpusVOMDvk87g9zKMz6LfPqQ/ncuCgXT0et6cVhwsA+JePI/T7oJdcZdwlveMloIyli9
         IU4zsOJsIMt07875q2xGPyDDZRUcPkaz/exVWfLXKSu752n9GPT5Q1n7VXUVjUJJsyqI
         zJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710904; x=1747315704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6+F7sC4lq7A9uwyyHv0JUmrfUrtoSWQI2+38pjZK+0=;
        b=H4a2G0HE3WKrZzUm0fsQE5L5joS9T4J8iZIgDdPP6JFFBPdv9Y2rlt7tGIXtB0YPXX
         KmZD69WwSPjja6q/25KV58gTV+M2MuQv9dMlm7LJ61hK08KNrmJR6KRpkIjqH3qwZa4t
         yFcRreLkik9H3idPL0l+h8UK7ew34oK9XOBBUcS+ofcMhWeX6qKLFFNPPLsxf9TCzCeU
         SQThnndRDj6puofH8AKe2l/6lGb8++sgDN8CEW6u/cNM0XZs06Iy+DssV1mzOmkYkjtB
         Hqp6FglGA81+POCsHNEIlLV823RStfS7f797ZogLS3DPZobVaq6c51rkKBf90iLeWuZV
         GQ5A==
X-Gm-Message-State: AOJu0YwxUR3nr6Cq6JjtOahY1YkDcRW/8q4fWJozh8r7b5jrHQbxDNLL
	NUkHFmffQXreO4iHHrMs7rXUc5hIUCaIwSKgiBq9866NEbptgFyaCX3tdksNdZ5g+d2xbeIESpV
	bWMn/4nJPiuykBAQKH68uEaIr1zsE9vQQ4qvzww==
X-Gm-Gg: ASbGnctZIRp3KQ47tM8+r2sASJernpuFiltpYmoNb0aovM0A+bIN8514EsbFwcOR8a9
	UyCtrIfUcNeRz6aYw4avsq2WY1YpCj/qTyFLGmWOQ3cacEZ3jy8NkWvzLoXf8bfrsbyFqxKKQ3J
	AL5OJgpKz510DDa61go0VNBg==
X-Google-Smtp-Source: AGHT+IFAm5bd005VyseIS1dr9F6a/JBOZzKDKZuZ1gmuo0nUeW1bL4XJmAQifXGpoCCjFyCVBzgF3f33AxU4Tq3X+YE=
X-Received: by 2002:a05:620a:1985:b0:7c7:a554:e2a5 with SMTP id
 af79cd13be357-7caf7405679mr1060715285a.44.1746710904541; Thu, 08 May 2025
 06:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507183820.781599563@linuxfoundation.org>
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 8 May 2025 09:28:13 -0400
X-Gm-Features: ATxdqUGQ979zRBf0y1uOq64HSCY88KmE0OF2th89NGdxTXyo1bgCaZ6VsUDVfCg
Message-ID: <CAOBMUvigbAGXoCSVqCz0nZ+7Y9ausHqV01uY1Z6W1jgGJkQzzQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/164] 6.12.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 3:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.28 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.28-rc1.gz
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

