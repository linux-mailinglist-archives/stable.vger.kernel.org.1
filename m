Return-Path: <stable+bounces-210121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE885D3890A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD92030060C8
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644FE30C603;
	Fri, 16 Jan 2026 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="DBNnH6nu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8712F3618
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600705; cv=pass; b=dDLORvaEnu7LEM8Bu5rRIs5CKpFIJh2uHCzkyAxBW9hV1+hFyCYfke7U0tS1Y3h6uAcRCxWfj4qIRXtXiZaIH9+arXjDRBacR25mj1oZZcAiWEtABKNdQQM5kQ0+CnUjMvJQY1tWnO8ULn9Ejn7e3IbTGD/O1gMA04BFDtP0lH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600705; c=relaxed/simple;
	bh=bPaRwJS1RrJBMlnVDNPm7dxe49RmumTjqinBhkL9jf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvl6BjPo0lMvPNTKjtfEznLiEuZmBWfBfSClwKG9Q8925a9zr7TzrFrs7QwiXDQWl88neeZrUXRFoNagoxRWxX52biXSu1ZCl+OJRAedyMaoRipCSkizeFinjOQHDzRVid1uMd4Dj2U4Ny/OJ97rxobbzwSzDUnYFODJnWXGHKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=DBNnH6nu; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888a1c50e8so30597096d6.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 13:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768600702; cv=none;
        d=google.com; s=arc-20240605;
        b=EVJez+tOlpr8EInuAvo+ZyW3+mdKPwgHku5RiuQMlze/tKV74vaFh3BJEP9F70siNB
         a7QGVnrH6clbVxplIlSjhGNmQNGeCh4+R1qVqKrkj5QQ60joc1krWcPPcfdBoXljisTO
         EzinXdUH2amSfNbPSeFEN2DrZOYLBO0BvpPXPY7YdOuaOUpAMt63kUBLnC/znjHIYtiu
         MjKB7EehOeLUoitfAJzG/MahkpF/XrH+uYJWZDu4DumdrADcHIiV61xqHYVYtmLskq8E
         8cfTsgIXKNN3AU1pk+FhOQnebKcWyU2fuqXSeq0JUgRqse99ndRELrJX70vW+S0i96yH
         BKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ci3VzwquJj/225WD6QeakQESZUt5GcqZi1oxdxkAGbA=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=Fm+a33pdEkXKy7PQF+t0zEVyHY2MYYE5qYlTyp+f2cQhgrGmvbRaImS2YtVxkyVfpS
         VXA/ilAKc/UtLFg47FGoYrM9Un1uhWi/HeCFOnjFk3CM6VztrtugXeKxBp78N6pH2VCQ
         703LpkIrUuWtRYTpbcArkuL6hQJOsKkfBYd+b9JU4ZX1oGMvOh9PFnlpu9NASZOs4l+Z
         0r6lvYzFVe4f7h/BuEU1DfDNh8VQZqbaVQC9zZEj4fMKnH9fsBfQZCyLTeFPe0E4lzux
         VBsRnxoEB6FNhDIX2z3aAu01jDQI/tfGSA2Lm/2cuYeYYaGiGD7lOet0OLzFkC5GiH9h
         oi1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1768600702; x=1769205502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci3VzwquJj/225WD6QeakQESZUt5GcqZi1oxdxkAGbA=;
        b=DBNnH6nuWyly5Dk7tQ4h+6pGTF0GZ/cKlDat4Jo0MRKshf6ugRVP1zF2pA5byt/2RM
         mk3lscumiDFGOzWfPZeH9i/V+SMRZ347kuY+7zl8h5PILjhr9Ve8XKcihgoOJJHa1LBM
         7uUQTOI9TCh5kFmjkq33uJbMdb8TEw26u2p7bhhDPdkBYvrZiIqKnkwEo/bEDatS94zf
         k+n2LCXD73XJyKVUsjnB6HF3agqQBKpLngU+gFmP28MVxG25UGSvTzDo1uLiYX3gNgkR
         HgQn3KuYoTKpm3SJvcbMXiWtDURegDl1VENw6S8uI6VjEHcJm0YU7/Fq6YFBiBg0ZnFA
         ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768600702; x=1769205502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ci3VzwquJj/225WD6QeakQESZUt5GcqZi1oxdxkAGbA=;
        b=kOyvxiBGfXgdTdZS277ZXckLQaXhFJGnDvPe126qcV7CHgk2qCWROY+PjlBEM5FPrw
         iKqnTOERhiAwyrNtFoONRmm/0TdSk1/X8WT/pNBTOvaprUWOq9lG8ZFA1E5P6LZJ2rNf
         KsEbV7dkaTzUn/rgK0pNshPQh8sm3GPv/7JAaRdfhGKYMUhrrHxBRkdhCHyUHzccLBm/
         fKVY1QFJuF31h6lqExo6nmW7GprBQw+Uuk9KTb46TPcSiv448bNAeiQrGeTTX8zp174q
         +qsAOr9DmnmBtma3suH0knisg0ulYrTS/HAnXaQhVVq/KIfkDKsfKHxDIrwahCqzQML3
         PNsQ==
X-Gm-Message-State: AOJu0YwrnlE59OMJi3+TqSwSZoNEl5q/J/cv0O4qFtPykUMiuNwLMJd4
	ZzHIcIUC1+3UhQPbPq9dpe2sMXzl2MzT7FJZjo8aLWsa+Nqo6fxv+FtjAzHzycjvlT15Ke/1zWY
	stN63fKYZphn72oiEcAG2PcFG9w8G+inIBA75GiYYqQ==
X-Gm-Gg: AY/fxX4yCeN+1PRfyf7/MK1EzwO86EfSO+fXX+DuohpuKg3pUVhpho6z1A/raEyOlVY
	AF2tYZbHhLDRZrWaLXSNS98yB+Q+FqS+BJcZQAzdb7oe+qCCMYStdFD8IFNowO0+uXO7e3Oc0Tg
	F08xJlGaGNsil4hndN5ZPAhn38bOv8n67dbITBnpIABGO31hhx5Ywg/yX257uo5b5yP9jXL33Hb
	7Zwai/wsM5rKYi26Nc6utHEF6tYuL+lIVjX8oszDP6dusV+W5imJhwzdNnTwiqmOysoFVtR
X-Received: by 2002:a05:6214:1d22:b0:888:57f3:ac07 with SMTP id
 6a1803df08f44-8942dd9d671mr63198166d6.54.1768600702129; Fri, 16 Jan 2026
 13:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164151.948839306@linuxfoundation.org>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 16 Jan 2026 16:58:11 -0500
X-Gm-Features: AZwV_QgX9Dh_WA66C1bE9X16GWaQKsScdv4wLDbHYHjFqcvYSeDOuQ1DXsIvl9A
Message-ID: <CAOBMUvgaE4fiZw=d9jWNxvcYQuFtifR5AqL-nCDDR=aS4bXTNg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.66-rc1.gz
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

