Return-Path: <stable+bounces-35920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEA898610
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B7288AFD
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF982D6C;
	Thu,  4 Apr 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="EpgpKt68"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5982C63
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230254; cv=none; b=gUsMY/urF4N3jnh3CO5Uywx7kXtswWBSjfpb7BW6TXYTxfsy7dMFjuvKm77mmyiGJcuQ506Zw7smDxB9CLy1rsNRA456yMSEjuLnwbv0nY7cATarD+CxcIA5YcqTDcF/vWDA1naH/BQgkt+L41z/TX0tYoFGVDnO1nAXneAzNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230254; c=relaxed/simple;
	bh=hbUkkTO/U4EMpnbOF6FBCVXqVCPGG6PylWE9C7brf+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGrbzLffjN3e/Rrwvdzt4vUx+8Talx44qNDV8ISMFkLjjbVGvZduwC7AHJqgIDenWkEbzGSBMw7rGcc58/f7lZ9XSo+eAPKjbFhH8ljma4v9WYZtW50vUNNjZvAoyoMfz4LcroqAqN80h4OAZG/Zh50ldzmMh+T0e/dXERpqmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=EpgpKt68; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ece8991654so572139b3a.3
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712230252; x=1712835052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5mGpLNN+a7Au2G/EYQDoNReDpzvoncflKDPE5zOJmE=;
        b=EpgpKt68ukmgDyfXX6S2hYiYe9O4jbkLxLnzdLC9Y+QXbes34iCwOFWr/vs2i1zHDr
         HY4h7N9ky6CZfrBS8qPvpLTXW0jJlErbMEjm5d1s+OZxYNZx1MQyBD7xu1lZkU/+Nu86
         8YIoxKC3PKrtZyHf+JknGUZ2jKav7dwuFEVGlLhjCgXTAiw22HGEnkdbxRQXNZaxyj+1
         AQvfWh7lbRlTp/312CSAOK+U08beLDQKaJjYgdYJd5dq3ec5E+W+QnLA4KbsZh8c0kU+
         eUcD/R1SwEWXcweY1KDFkjjYJ3jXmlqou7FrlMs+GAFyHrN3/Q1Rw3e/P/ATdZpkQXCo
         T44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230252; x=1712835052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5mGpLNN+a7Au2G/EYQDoNReDpzvoncflKDPE5zOJmE=;
        b=EWI8B4wNAtnuJFAZ3FR23mHL2ZOIpmNYKBssoGTttpgqaUVZQmtXEp3R1ZIE5Bl8FH
         qjJo2wkjXrCoNWEZCACTy9RZu/nyY6emO7fzodcmCBjANZS5YSox7ozgVh84cC502h6X
         vURtN6YeESSk6MInLjz0mhVxYdtEHu9n/BFcGeUlT1R62a6z5RhFVZ/cFAPPZqJLnFow
         81AWtM1eta5QnvQvkg/iT90m0QTjtBRfJrReVW6remlcJJsl4hD2vG5Rl5Xqk1dHEhvu
         PaIjgzKGn3flBKYcqN8Ubo2/6Aa8QOfZN+W55t3aGDIW2iVovbqifoWKJKxFd+UsXEsI
         JkwA==
X-Gm-Message-State: AOJu0YxpYpRvtsslZYYRg6fd0g4Regyk6SQitcGDA/xVHThAUR5iPiVw
	+bzDKweEejpGjvTf8m5GFKwZLLHYDjb6k474VJW3+eZSscrh8OVzAsxAeYGknfa1+LHwPqBoTaN
	cWfjnml3ZuP/q566JURbRtsxwyEAYqY0uNbmIKw==
X-Google-Smtp-Source: AGHT+IFN6dZWmAgrAkglzr4sW4NjlCbAfdN8/hIeao7f5iZTSqTUjUYfMiqUfdOryXKK78X9Ck6xcqvzBuTpgIOCMWg=
X-Received: by 2002:a05:6a20:dca0:b0:1a3:aaea:a45b with SMTP id
 ky32-20020a056a20dca000b001a3aaeaa45bmr2091520pzb.39.1712230252503; Thu, 04
 Apr 2024 04:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175126.839589571@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 4 Apr 2024 20:30:41 +0900
Message-ID: <CAKL4bV4EuV2AHv8g6HoRVmQXtS_ATE6oHE40gvUQd43bUqTGjw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Apr 4, 2024 at 2:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.25-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.25-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.25-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Apr  4 18:22:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

