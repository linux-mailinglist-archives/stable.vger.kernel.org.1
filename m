Return-Path: <stable+bounces-196564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996AC7B695
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2ADA4E5684
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5882DC350;
	Fri, 21 Nov 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="1dZKlwsN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BF2DA779
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751539; cv=none; b=TIX/H8QLFTPwPHisimeCJWdrVidhtCiQQNtDf0hG2Mnn+w+WNEEp6V6bvJhDTO/4k1ItdziQraNTueyLUUQZ36agrlqDEn/Gv1eqZWiE0tzD0tHtT0R3OOP2BiAmFgsZfmaNOeqmLRWQDT2rH4dYW3S3Jsd9qRtyGKc/XtwHtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751539; c=relaxed/simple;
	bh=OD2BPBJ+WpYdSJqGl29PTyCpt5wg8lF186uyL6ulPYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny5FmaJJdkVIClzJm2NNzLicdTz1cCQhDwMEb9gKve2OoMnY1BUaiMK4U8jZvVBZe+TNyF5UrvNeZixCPiXJAOrOLcIoIlW92ay2HEwBil6EBm8FT7A2RXWQjBu9d2zcGWYxLa5JqFP6GEsXp0k1L7LNuZLL4ostG1AtKVAHgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=1dZKlwsN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735b89501fso269175566b.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1763751535; x=1764356335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fFzITl85/n2wxKTQjOLP5oK8q+GJ7Cr55qPMQ6tPpzE=;
        b=1dZKlwsNNlyAhJAFPRvujeih1QlB8fnHgMwlhwB0gu1MpeyVE3bF+xZcBELGzLFlyw
         SpeiRs0VFVNQN1Xg7PeYB/eRjG3A+L/ghnaXU87lDgCkn5RS/RdhMR2dA4xu6uaW+vrA
         XwMZ+RboNbwEzMKHGcLUtm+pfHPRX2NTh/Vo/6XOcxTX6TjROkBfWMyYTmJwtf0Wugsq
         ptRtNTCoSib6wrEz9SJ9i/FWxCADxQR4z49rcBjzvEjhtYYpc7wNvbfABrUP9HGLd+Bt
         w/XMhLqMxrhyLHs8o2qxVEI13ywwrzbKswDKuVzzF7oumqfupWUdeL92nzJqa9S48B5d
         rqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751535; x=1764356335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFzITl85/n2wxKTQjOLP5oK8q+GJ7Cr55qPMQ6tPpzE=;
        b=sU5rnaonbX0KfJTDl8PYDHnUrvilsAPKLTdTxhFyTbC+uDmCzLt+Bk0gMk8GlQEl7G
         VDTYIbPGgaFnEVmGlsk9wty+wqU/3M5/MHXjFTgmoT7g/iGswglLD9QevRaQRSXTOpkQ
         Bx0KNAeLQsvuz1Lc/2SsCLc4SpRV6pyUaHm4ikb/7aKwXS6P/Y7Z8CY+20Hd5Mp6BJyr
         hRthCP/7HQaFQ/2Hd+nyWWuHOQUt/kp1G1azvkcQtF0mtz6DQbPsE18s5lUXCJUp3MNa
         9/yf0Zy7N1oqIxG+2cGuKldfzHk0YBtNMvfQB5+QSp50ZYByDjEm4rSH8ibPnlQQaxnp
         iOrg==
X-Gm-Message-State: AOJu0Yyu5DDWRTw4jAnBBW7xh6qXhWQx4TxnEtHCqZjkwc60963wkfg0
	I8lL08hoJ107hDOyeVEdRkJ7cj5OnD+YaqEab3g9a5XVabCLOky14ZiNwBz9NK7yN8OfvFaZd4b
	5TroNBJ2eD2ul36hHZF6HM7dSPLdcNIhHSXjF/UDlzw==
X-Gm-Gg: ASbGncsWwDNxeDMSgkWMbPKgAEK8YWViaKFJDvWl/3T0BwU1+qfoqvNwOberNV0yJX4
	tiHrg7fLIcLcoE5TQyKOsjjrzXQRz4pPG6x7yB1FeTEc+2X4iaUTjnXlR6V2P/piZQ8NegeaveK
	bpFqqDHgN/OjpjCwyXeYPULGgdsJwAmZdUcnHzEN7bD5qEg6eASEYsc936bM639Bm79ldDRSqgS
	+gdBO/UjkmGUmgiYRJsNTRoJOSFaKPRfq0ASORo16LnFaO76m+ibeiFyG+tdTqfAt+SfUyKJWCg
	Mu6VSQ==
X-Google-Smtp-Source: AGHT+IG76ktUz04yjmfFAFe+FBW8iYZfGik4rFERzzHnYuCkGxcwG0i1C2FkLzqA9pN8F/lFTANRSliwzFOY1jzUYsQ=
X-Received: by 2002:a17:906:c14a:b0:b6d:3a00:983a with SMTP id
 a640c23a62f3a-b7671709c17mr368806266b.38.1763751535510; Fri, 21 Nov 2025
 10:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160640.254872094@linuxfoundation.org>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 22 Nov 2025 00:28:18 +0530
X-Gm-Features: AWmQ_bmv5hZsmWYOBkRJLiSLXVbu9rpn7KMv-kwMFVHeSRgi59ua3hkQmuXQ4_o
Message-ID: <CAG=yYwkt+GD=FHtSq+7w=-Q3jEQS-qnaG+-KS87qkVebUa+ozw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello

Compiled and booted  6.17.9-rc2+

// sudo dmesg -l err shows error

// [   21.490792] ee1004 3-0051: probe with driver ee1004 failed with error -5

The error above got fixed NOW.
THANKS

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

