Return-Path: <stable+bounces-45227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6918C6CF9
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B11F23A4A
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547E15ADA8;
	Wed, 15 May 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G76BIFjO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F315ADA0;
	Wed, 15 May 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802580; cv=none; b=qpumBLH77eTp7vazhOxsIIKHcO4lIHcezcNib1HqVYCT+xnL3jcFJdRUMfhAabuGdc4CZCX9wbi/VlPi5mjI1GQReiUp0wWHiU3XOtUVFHJ/pfOfnk/4RWDFm+qXKnSQrwORD7hfFBJegPnK9GZerMsyVqD6hH0diJP9vVKgANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802580; c=relaxed/simple;
	bh=kZ6t4klUyIMJn16H55r0wYiMd4UJePBx6iySXQTyR1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skn24XmyXYeCwsM4V4b5l1OhGnnhubZBKyx02Enw93Mr4aE3lv4UMM4kJsJjRWqCiu1/hM9QXQrVY0pXg11494YNF49hqE4nXF8IDD+vSV/iag3uIJXTMHfKQcr8FewKjDM2UOTOiS6i2/zBTTwVWHI70joD3Itl3yuQGDOd5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G76BIFjO; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7f81be2539bso1318310241.3;
        Wed, 15 May 2024 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715802578; x=1716407378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fg7/SnhYZO0IrKL7k9gXi4LAAZywPSttMr41QqUb75E=;
        b=G76BIFjOC9I4609eaxK/hge0vv6c6pu90i3pZqNkyV1TE/tyYrMbfNKSh8xHmTBuLg
         2BCQpysH7HtciGYwaMWUr95rnPi2bon8DnajPu7HYvD8zvym8jDp+TBZ6aXwypdf/NQ9
         2zbkd3c0SqINeQ0WAHyuDFIXakGzZ1sG7EzUhJddD2twoE34B24rzs6I61v72jzBUND/
         Q6OaJlROOI/ylPxnF+MBzaCjdJN+5LRyvdOiUnVcT+WS3BPTOa08PMtCYnS1Jx+ovgNf
         qoSnu/F77gt05QQPDcjqUPTEPqjx/pMCcRe4S8lmEiHdH1fRFhUQ9zBY8JYF2n8lSm3V
         Xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802578; x=1716407378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fg7/SnhYZO0IrKL7k9gXi4LAAZywPSttMr41QqUb75E=;
        b=QXzxgJDwFQ2tUiirCE/kiw8Mm3uKD3xii1pk+skJTh/CWO5eVcQKEtNQ8/Wx9aB9OY
         kvl3uQ8Xdd2pe9oQ3K0U2jOgEKdpbzqOi5p6H8uj+ES6KkzMUWxKYFKBlNDGUs1fL1nR
         XgKLObYohmIbyCsxMWYycENwmnDIE5evNNUqfZkmbJlELblWIJAEszhA+sPKouNzkp9G
         Mw/NW1Nl3lQGhPvk1O7ayAED/JhmjyQ6347+Fy+UgkkJjbw14esBA9gIQf0D/vt2h02e
         h+V7cCB9+pSYKr1dsC3NBB5TpBaDHV+OfS0EfDkEuRnb5niH49zWq7zT8GI4RDv7LuQn
         oFSw==
X-Forwarded-Encrypted: i=1; AJvYcCWPiML30cv4FczzKfmL4X4A0XGSxB5/TU2Kjjfh8c4k/PaQWvo86Ut06rHZR1fuYXpUmM9f439cJKtcTHx2vTMXC/5HDTUym1x2C6kP
X-Gm-Message-State: AOJu0YyK+cBwRmlFd3Eh012tX1I3hMeX0QH46nMwaGr3MDdS5HYDLw+k
	hMEvqNiAIdsLWg62srlWeApUcfX5/YwK5a8ZthUVuEAdrkzLoLyWoeH32G6xWQsg6ynY7mB7ng1
	V64l8dU1JmrG3uGRjwZ+nP5/TdZ44vydT
X-Google-Smtp-Source: AGHT+IGvNTG0pQdAEJXa0r+l3xuPRP51cQc5MvnBhifGmCSoxEELMNC4gvY2X45M+c3yB2dLC39yQM2WlDMqjonStJI=
X-Received: by 2002:a05:6102:304d:b0:47f:17e7:ead3 with SMTP id
 ada2fe7eead31-48077de5466mr15483575137.12.1715802577005; Wed, 15 May 2024
 12:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082414.316080594@linuxfoundation.org>
In-Reply-To: <20240515082414.316080594@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 15 May 2024 12:49:26 -0700
Message-ID: <CAOMdWS+1-Yj+5uYB469K63VU_9-Pi3O2do2S753udPQm8vhOEg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.159 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.159-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

