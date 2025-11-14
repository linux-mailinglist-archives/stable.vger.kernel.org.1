Return-Path: <stable+bounces-194790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E2C5D0F8
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E8C3AA11E
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448CD14EC73;
	Fri, 14 Nov 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pYNbCe5i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A57136358
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122624; cv=none; b=J7IzToS/DIoeFmFttZFvSv+ZXlcrCxN/DqmFDqHEvewOmXqhsiGvDtjsDRo6PYkssb1M3uo4KIcARgvFbkiGtcHWCBfT5ORhngnF7ogAA26hCA8zrdYrXpS0lKHo09AbwM4/5L60E2Sv8dzKa38jNjVuMt0ZoFxR8w62JT8RYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122624; c=relaxed/simple;
	bh=ytKFf6tWTEMRKa/hmjUCZSln+A+apd2o8gMHpQNNkCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE4RPk6wZQa948tp6Cdr5zn6Ka/sL93c4HyfQdo1hLlnv6zz1wiJ6NhAbp2+NoY6r+j73cHIBCBV3kjWNJOqbxTOrfaDssnKXID+symN2mHUl07XoM9ZYS6TsFCvas56MqOdMF2Y4NHX46EMQYDC3Ui9gUsChfIwfQQXjA8ViL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pYNbCe5i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632d45c9so14566465e9.2
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763122620; x=1763727420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+4VXmKc8GdqsVqjC4o+a1rY7ncy6Vgm0Q7gfsgW7BY=;
        b=pYNbCe5iJqULV5YLcO9oJs6hK3X0Hybhdam5PDwLJN96+bYi3p7mX7Hc54zIhRzxtk
         bjyTzTOQS+mYh2dWoujR54GwoTI/QCPUH8/icsiS4uuZxKiosCz/p6PGrs/B5++K7pcm
         Hx0lcIUlfoJZYtTkUsQOyuiylwmxgF+Q8KokqlrbZmDNiqxRLJrro33fzLEhJuw0mh4N
         0WhH5Khul7vA7ZI0a+JHJNJGmxGWH8MgLheahs+yRcxHOQVE/W2nw6ILZoB6vItFVCAs
         WUrJRaJ0ba4SrzGu0eGiq/mUtQNmqdn/+iM3Rc+W+MI7SPcQ5IYl/Isg9JHs9dnB8DUA
         5AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122620; x=1763727420;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+4VXmKc8GdqsVqjC4o+a1rY7ncy6Vgm0Q7gfsgW7BY=;
        b=e07OaqpC8ezgPYMhn590GvzjSsGH4cj8nFU9xN74IGS7xjwNw6IbX/9LS9gY1fmMDf
         ysCif2gGB7w53gz4cMuMkbq4CdHMlGY5IwOpJkG+1WiN3zGVMiSiCeIsRRGyVRhc5gBm
         6OPdtcamyIykQ5eGP90xYhBW5dadGit0odYBW7Vep+JKL9YhJOu8kHcVQyF9oi6y/yiC
         O1T2uLjDBx9WBmCYOYvr5Tacew86/QFOrdEPFAO13mmWhOmusxueB0bwBr+DeBL5Ktiq
         L7hx27VIxbJD18Iv3r5p7ASAFeqLAJPoDWe7ZZWPZbd8uMuk3gpWuhCgdoq2hZAl2ZGN
         +KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsMkGTE4JmtKFFUvcJcpypfZhjxW935phW1ECcqHNac/2mzGAOY6bbA7Sfs1fdwgXVB37ttek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tGbHm2GdENMY2aD7ayLdb3uxdzi0pZC1ElC78TODwllY5gcD
	hJ2dKIbU25ShCB6rBOYE0/yC5UMppu1Fb9mOEkPKbdyhAwx2vDpNqNPIpyfVZvIT4vjCATr+Ndh
	GsDJJVYM=
X-Gm-Gg: ASbGncvcqVL+h3QK6PQKYMieJFm7e299/dKqe6V7ljTI+1155FJsdsDnrpbKwOQ8CUa
	MAFRgLIraRTN/1kPZDe1/Lll/PwYzOygwxFLSADIgJmB9uSvSR18xWlgVJLdzaXVhVROZ5ey/Xf
	OQjhnvX00BxyhalbceB5H5M94TWdUUvje81m7svq7SIr0RVXXC5hI6xvWOx+sDiM3PJKhqbIxPK
	vpf/lpI56nH6zlVFyrKjhuksO0y+KZOpe+gL4WAiIEar05yf9SwSS5HV8C0XEkZjVe31jHH1GQL
	75jJXMbG8KhuXY27nAn3wWegAiEw15Bm/9bCBfMqXfa6DS3h1JbmutgmH17gDd/4sEcoXkyfvrE
	cDP8aQAChHgx03OxdOyWUyc0yxyTN/ss5yAVScENoEGII7wMvHy0mJlAgnI2JsS6avWf2xyZ+fC
	908y6JCrOA/8g9NUJvewk=
X-Google-Smtp-Source: AGHT+IG7ua9Hd9WJN68PNypvCmNCiC8BHy/cDb9A4Sd0TasdV61HLLe0O8GuCtGCcmhOWbH2k/1f5Q==
X-Received: by 2002:a05:600c:6289:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4778fe8cae9mr29819225e9.34.1763122620367;
        Fri, 14 Nov 2025 04:17:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm138949845e9.12.2025.11.14.04.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 04:16:59 -0800 (PST)
Message-ID: <5d2826ee-ab27-402e-93b9-f0fde31907bc@tuxon.dev>
Date: Fri, 14 Nov 2025 14:16:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: microchip: sama7d65: fix uart fifo size to
 32
To: nicolas.ferre@microchip.com,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Cristian Birsan <cristian.birsan@microchip.com>, stable@vger.kernel.org
References: <20251114103313.20220-1-nicolas.ferre@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251114103313.20220-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 12:33, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> On some flexcom nodes related to uart, the fifo sizes were wrong: fix
> them to 32 data.  Note that product datasheet is being reviewed to fix
> inconsistency, but this value is validated by product's designers.
> 
> Fixes: 261dcfad1b59 ("ARM: dts: microchip: add sama7d65 SoC DT")
> Fixes: b51e4aea3ecf ("ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC")
> Cc: <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to at91-dt, thanks!

