Return-Path: <stable+bounces-98855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D39E5DA9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5325A1884523
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80408224AEB;
	Thu,  5 Dec 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KXVXFkjI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E4218E98
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421120; cv=none; b=NjV+vkmzWpNhrpYhwm4k2qtGY/a4ClcJlUS6yoEuohlz8Z2uHX/BhYs+Bx3QuR7Z3iotLjxG+B3sqkPV8j1v0H1Nf6x6CLPvXn7X9qI7qGYq4Nni0lU8iAdC1lxtvxHzUJOkvknOKmVRd1O9uD8+skiKgYz/78GZYUDIoeCuGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421120; c=relaxed/simple;
	bh=7MoIFK5OGXq3gDhad/EY4fgDc+nrvflIniaIyfUBSuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txHfKRuW7BLIm4aeLnO8Q798Y0BTlt5k1BSZVsrgqjQD1LRs3XwvJ/YbYTP2gOrLIjV3Wn9uZ24C+5xIBLsulrpZLCdEO0+uVJCsODIku92z0IbAg4R+DDsRlYD5PAyfu/Z6K+1m9fzJU1Xq3RceDUJCQZ7DHGLct/lOs9gCae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KXVXFkjI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e224bbaccso1324314e87.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733421116; x=1734025916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z5eWK/vs7fqhFUwAujMxMk12h0AxsQYVmA9NF533vvU=;
        b=KXVXFkjI0iWCJE0Y84upfas5njYq//+LIRxhbYFiQp+fpNVwjdv7R4C5hIzLEyOmdB
         nSSTmfwHk1B/r98GIwZDA81zqeSwlZaktcxiuwtwQMOA3Y4FBiuJ7PBR10w3gtop3UrI
         vYJ/4xVB4vfSGN1Tc0i6PS9m0AAnvuVanDjGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421116; x=1734025916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5eWK/vs7fqhFUwAujMxMk12h0AxsQYVmA9NF533vvU=;
        b=d+uXtrH3xgpf8w8lzp3Rnklm1qelAVah1PwMoy5o1gs8o81WNagvYcbtv8EQ/VrFOD
         7JjJ5ixT5fcq3MJYKSctO8NqGeQR/PQPLikW8PoYuhnFFfmVqV0UfjFmcQeTLIsJgan1
         6rGR04UDwa9nhWGtyEr/LuFwc7Nx8ZoJvvs84oPecrNw51kUg4ttNlOBWnmzLsegXyun
         Sik/kPDlDGqW8v05JvH2DLx8j0FE81NFWceWEzWDR/QXhAKx7XpYPL3zazVihmujF+ir
         SKiqMuM6t+R9vGqAJPXpoCujwYYdqqkWlksnjSZp9AGdNnOhGnTaEDSxeXKrTtLsHhh4
         dLbw==
X-Forwarded-Encrypted: i=1; AJvYcCVYQT3M0J6ZJQ+wbw307pkjhSntO8LGCtGqJB7ketVIQqOggp8KpJi/HoAI2Tn8mW55bG6QlhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMqrzUe/ke3+tTV9ZQPfpQyLTfi++xGxsId+HVhygB94PU7mk
	Q9s3z8aEA7k8OJlWd+hkHOjzkasO/+jSw+7hdvrB7Ywxu6B/F+54bXVcwzEzNhRj79bEimSCJrk
	7LWE=
X-Gm-Gg: ASbGncuSqW6C9iDc52ze2gR1BzfDkdzkTa9VlpFjCgM5o/49zmrtK4AeMBbXifarTXy
	wdkDIq99eM27NNTj/zWSI3wt7JoSvqFlnU5Lpw0WNThERZVooUqYXRxAscURLmUYs7svQfL3izH
	2noqur0hl+SYE5iQgnCsSBKvFKWymfyknPIYoEDAswui1gsKso1VpAvVFQ0G6nwIUF/sFRQ4k/G
	bWlgg83g2sWc8kclGuS2ajBKX9s40MAV0s9HcIOay6vWWHyI5LOwqsJu3ngmyvWLbYRU8PZKhh4
	DS1yAPEkG29Lfp7nSXZhJ7yp
X-Google-Smtp-Source: AGHT+IHAVFuvbl2nxKeVSUc1Mgj83gupvCfEPfuprd2pFWImnTDvbfLB0C1muUb7MYYF0Ghl48l79Q==
X-Received: by 2002:a05:6512:2203:b0:53e:1c53:b1e3 with SMTP id 2adb3069b0e04-53e1c53b1f2mr4694099e87.34.1733421115835;
        Thu, 05 Dec 2024 09:51:55 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca298sm302377e87.267.2024.12.05.09.51.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:51:54 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e224bbaccso1324272e87.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 09:51:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv2Jd0RJkq08TVjFlSHTIG53gyYjZ1kBu/011o3vlD81zFSjgA9v9PDxWc/Rt81WXQkeUFlNE=@vger.kernel.org
X-Received: by 2002:a05:6512:6c9:b0:53d:e4d2:bb3 with SMTP id
 2adb3069b0e04-53e12a2e4e5mr7858256e87.50.1733421113830; Thu, 05 Dec 2024
 09:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203144743.428732212@linuxfoundation.org> <efbda6ac-9482-4b37-90b7-829f2424f579@cachyos.org>
In-Reply-To: <efbda6ac-9482-4b37-90b7-829f2424f579@cachyos.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 09:51:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com>
Message-ID: <CAHk-=whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Peter Jung <ptr1337@cachyos.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 07:46, Peter Jung <ptr1337@cachyos.org> wrote:
>
> Reverting following commits makes the machine again bootable:
> acf588f9b6fb560e986365c6b175aaf589ef1f2a
> 09162013082267af54bb39091b523a8daaa28955

Hmm. Thet commit

    091620130822 ("sched/ext: Remove sched_fork() hack")

depends on upstream commit b23decf8ac91 ("sched: Initialize idle tasks
only once") and does not work on its own.

         Linus

