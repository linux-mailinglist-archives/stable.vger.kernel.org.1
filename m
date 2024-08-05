Return-Path: <stable+bounces-65376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF3947B2F
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE013281EE6
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2889156F3C;
	Mon,  5 Aug 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZYgCsyN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E838DCF;
	Mon,  5 Aug 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861923; cv=none; b=emMhdWnPiBY1VWsxSqx2BQi4DnXwr7gtl0TkNm6Q6Tv9tPhjQLjWk2O8FynmY/9oIIbMbACbtdO3dbH8ml+LQU1VvEZmFNDdhoRTRQsvpwAS/G9QUcZCuJCz+7N7E7srddecL1hiiu0XE0/o3LZh16T+MdOUEyiIAk+B6AHuMq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861923; c=relaxed/simple;
	bh=BEn+I+gciu0ebkc79/DNxsbZZq27qQyC9sL4IRvi4iA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JIhNUbKMHMgkfewiWDiU4Q4Tk9gPIs1jkc/yRlZd4WD5s1lsjy+iDTBXHfeX9toCssTeGOtWkNxINgd586uu+SqGWzY7DCUnkWP1MHzDBl4VLe2c2v8EVAZj/lcV/NpNM2YSFk8QSDu8bDWICNLQhExxasqyQ7HbME+Gd4DM9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZYgCsyN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d18666so31138395e9.3;
        Mon, 05 Aug 2024 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722861920; x=1723466720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq+a8Y8J7LSOmGovatkbCSe+K+SAGbPs9LTgvAV1mho=;
        b=dZYgCsyNnffFW4a7268QtzLzj8tMYMnqhdTjMIbmP/KZ+e7K4663SGrg1jor3aU4BO
         kfSutyRz1neCwWOgqeC8QMFkWASYmRCJ/6eJO1hlIPseSW1vZAJQsBUJ08xBFbQ9wBck
         /bQYExr1LcofmziEQyGMvjR7BMS9qIyxXf+TE5rSBLBIFXL/OcHwbBsesn2uG6s7d5TU
         IUgvTYuCSPZ2gIzca7zW+Hc8mJ9wgkDsmOQs3L7Blrg1rw+bA67aeIJs7qAwzPQLDulS
         NXBL3/AS6oXaax6S0VQHzk2Y98yVam7hanttwzwzoNmxEY02j+tywsxkJ61dDwVwvsF5
         A70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722861920; x=1723466720;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq+a8Y8J7LSOmGovatkbCSe+K+SAGbPs9LTgvAV1mho=;
        b=f7SWoJbcCQykniQC0xGjb4ZnQybB79zWxYO0csGkUqhLsLCatZlxlNyqzZSmfBP9Ir
         NgABiSpaKcfEtxxQA+oeUohbySfJIaxGX/GZwnpLmnf8WMqRR64Ey5seZBiqNnPAkG5i
         2nH0pCZ64sEC1hFdvrMx259qE4Sjj4C9+HnJabh15e+WnYw3+R+KXo8de8462DvBG3yI
         DeAbc+rzEVSD4AQe8ifO8WU6N7skX11+1mk6KMAHDmHwB286d3lGzLMmpbPPYTjGTNFK
         G+0RSGcNTsn0zaBn2PiTySVUDk2seM9gty09qUNgUKlWOi5lmM4EZ8UrjrUQX+1ikx8R
         FO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVAIdiw15zXqcn6Rs3qqcy0nhbl9y7QeSsDaraSE0Mz97sgdMcvIZYBlBWp/SDwTcSxMLGNiOradRqlWtlEmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDP53Cq1c6IuH6uoXHudAeyBdCce0s98mJ8qk8JPXYC/niMKMY
	vMAkdrZxv0JYHjY1JDAhNSuvizq08AcW1sPnWmpEo25zkzOBRE4/
X-Google-Smtp-Source: AGHT+IEV3hOwO3flNf7fxsxAPilr7sqD/koHb1mByKca1pnfbvKtJymRAz0CkKPZmocsbBaWGTzXVA==
X-Received: by 2002:a05:600c:4449:b0:426:6618:146a with SMTP id 5b1f17b1804b1-428e6af1afcmr81173025e9.2.1722861920088;
        Mon, 05 Aug 2024 05:45:20 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb63f21sm196787135e9.29.2024.08.05.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:45:19 -0700 (PDT)
Subject: Re: Patch "net: move ethtool-related netdev state into its own
 struct" has been added to the 6.10-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Sasha Levin <sashal@kernel.org>
References: <20240805121930.2475956-1-sashal@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <65f0f054-2de7-572e-d6aa-926a0f3598f4@gmail.com>
Date: Mon, 5 Aug 2024 13:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805121930.2475956-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 05/08/2024 13:19, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: move ethtool-related netdev state into its own struct
> 
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-move-ethtool-related-netdev-state-into-its-own-s.patch
> and it can be found in the queue-6.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This, and the series it's from, are absolutely not -stable material.
The commits do not fix any existing bugs, they are in support of new
 features (netlink dumping of RSS contexts), and are a fairly large
 and complex set of changes, which have not even stabilised yet — we
 have already found issues both within the set and exposed by it in
 other code, which are being fixed for 6.11.

> commit e331e73ff4c5c89a7f51a465ae40a7ad9fcd7a28
> Author: Edward Cree <ecree.xilinx@gmail.com>
> Date:   Thu Jun 27 16:33:46 2024 +0100
> 
>     net: move ethtool-related netdev state into its own struct
>     
>     [ Upstream commit 3ebbd9f6de7ec6d538639ebb657246f629ace81e ]
>     
>     net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
>      currently contains only the wol_enabled field.
>     
>     Suggested-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
>     Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>     Link: https://patch.msgid.link/293a562278371de7534ed1eb17531838ca090633.1719502239.git.ecree.xilinx@gmail.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Stable-dep-of: 7195f0ef7f5b ("ethtool: fix setting key and resetting indir at once")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

As far as I can tell, 7195f0ef7f5b should backport fairly cleanly
 to 6.10 with only simple textual fuzz.
It should not be necessary to backport the "ethtool: track custom
 RSS contexts in the core" series to support this.

The above NAK also applies to the backports of:
     net-ethtool-attach-an-xarray-of-custom-rss-contexts-.patch
     net-ethtool-record-custom-rss-contexts-in-the-xarray.patch
     net-ethtool-add-a-mutex-protecting-rss-contexts.patch
 which were notified at the same time.

-ed

