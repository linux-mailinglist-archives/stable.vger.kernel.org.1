Return-Path: <stable+bounces-144501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92DAB8306
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2A51BA74EE
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF46298268;
	Thu, 15 May 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="n5JDdPqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476F297B66
	for <stable@vger.kernel.org>; Thu, 15 May 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301811; cv=none; b=Il6aGb4zsFcsT69asd8XJZhIxIQFAaUguSn4RFtudRyUtGL4SAT3mZimcy9reWu+Nhp3NK6f72vX6tVRqETHXjPpt3FWMKoiPPygZg1kyCqPhHtalFmAHxrw/glgX6hYz61yp4KuHw98L4kOotWEdfJd08E94TJdiy2bjLHi7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301811; c=relaxed/simple;
	bh=djpDvvX/7HFh8gDgjiZXIm9sq02IazDn9C1NLqrTLqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieUu+CWCV1HfP1O0n9lL2+7ZukAQ0ZAbXuy9JCA8yJW7pTqIVaQSLOAoLRI7lzCmVO6xyNQ91xPuo5FBuKqgszHUEqyGki4HAl0YJG1l+FopEGZhPF40vmzzBsAylBdRfuWVMW2QehPxvu7n9h9d+R7kfJrLkWtAy0MPJOsl2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=n5JDdPqi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fcf9cf3c2so6550995ad.0
        for <stable@vger.kernel.org>; Thu, 15 May 2025 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1747301807; x=1747906607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsn3tSS0YIiAYkn/3PtEEaMquElK/Qt1xrI8n22o3uE=;
        b=n5JDdPqiTuLhrMVcEJ5HpUOH8uneWrOv1ryIlOMNylRJKjXLv0Ix4XHHgsza0Pwxhp
         U2ej+SEWw/ErMlkISpP0uWr13ux47iEOtsVqAOAGgkfwe2PQy8Z9pp6IMGFHLT/kANz5
         1p6nNwTIxzrlbZ4DW3ViOSlRutY5n4gGP08Af2dGbCbgJ2Wrim2TmWScTHZG5MgnL+g4
         FBAlNWUCDKeaaiQOHzbg3+9KksceckBuilPSV+muPc0haBJ2LlDh7CVH1krr36i07CQN
         hvMIozMExgk9z2FkwRsH9QvsbYHRatYtmCQ8LYbzT4B4kttTCtW9f2DUiQy6h7VBRl7A
         losA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747301807; x=1747906607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsn3tSS0YIiAYkn/3PtEEaMquElK/Qt1xrI8n22o3uE=;
        b=XlOqJxTXBan5HTuXJ5R1hF0flJDFUIL5aY/sbAKxtfUYX7DtuA7tlKQsBDXiHv7BRV
         ubGHlsj2wruCBdGV6j28GpT/Nf+SucGJcUWq+OgsTuRPpd6klsiBp6J09TGjr3EZNFom
         RyZr6g7u1flYNHsP3AXjzru/j78yCZfAXxB1Sp7IXc7x7f8arqAf1MkYjVLdjg3umNIn
         p9h1ZOsm56cXJOTfBoqGA1r7lntBjj3WmQZiWQNDgmUWzPGWpf0btlB1Y5mAIGdvarRV
         Gkx7ujANRyQiGJk7nAssZWmA1VrJvz17FknPrruqTnThYuSXTvelEvB3OC+1wYb9jrjG
         W1Xg==
X-Gm-Message-State: AOJu0YwGpel3WRxHErqtDcYWYVGad1Qa6CfagbJICTQB1Y+zG74dLOkH
	WzRCwQdI8wkqk19ld0MwMxIK+2zXC68JvDHDJiqVpiyJZvJdX9SCqdNaZF3kiz1cqN1iUmGzn4q
	X/b45TEMTbbJTuQoZK4SuPnOGEP8VURWioZaIHKvixZ9VXat7xk0=
X-Gm-Gg: ASbGncuEGiEBptxxB+1pcyOf6FmxJt9XZVPhCLsV0khkYLmIaWsIXkJXityPksISCD6
	p8dlJuQmWvaAKHeym2xi7zZZ1z9jFX3GGY8K2PAgP9mnDfzfF+EXa6C1g1zl9g15i+Ic4XfEsLO
	ubKfERQ58xkKCunpAX15ZFJp99zMHnLrzet1bS6vi6feg=
X-Google-Smtp-Source: AGHT+IHjX0X5C3EUWrGSjnnmKk8PWbWMvSh1PDfyYwywMuB1EdID9s2hTSa4xV5KaOkCcMVL9ob0s0DSTPTzbHdCtvA=
X-Received: by 2002:a17:902:da8b:b0:224:2717:7993 with SMTP id
 d9443c01a7336-231981c916emr92027985ad.45.1747301807523; Thu, 15 May 2025
 02:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514125625.496402993@linuxfoundation.org>
In-Reply-To: <20250514125625.496402993@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 15 May 2025 18:36:31 +0900
X-Gm-Features: AX0GCFv7LM6xHGOMDQ0YP04y9Es-FYO33imw6SrXtOdgeyWmqPX2PDvxohw74N0
Message-ID: <CAKL4bV5fxuXaCcfB+omQEj=XuK40VO2XdUj3Gwu=EwuSLn0j=g@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc2 review
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

Hi Greg

On Wed, May 14, 2025 at 10:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.14.7-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.7-rc2rv-g6f7a299729d3
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Thu May 15 12:03:02 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

