Return-Path: <stable+bounces-208387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98FD21A1A
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A38305744C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E853B8BB0;
	Wed, 14 Jan 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eMXZ2HAb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A653B5313
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430102; cv=none; b=utuLplBh1xm2qTZpSmTwfDJJbRcKrj46z7KwD307FlBlhI8a6zoagIK+dZLaDLYBtVSx021I1PwTEkYH6z0Fa8elgZifyaa1+WY2BINU48YuqWqajZhYE0bOc5gcW8p7h3ZuAFaJJsFRWNGcmA8fnNEQz5Pdr3emray7KSYOZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430102; c=relaxed/simple;
	bh=EYJQkC3et4NWoDLKxXE9/Y3cP8J+4A1mfoi2Yh3t7Ao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rZaymlbWYZj7QRqhPdKVXFl67sdZdKgYHLlU6fdR1urJ87FwWH2ksc35VMdIxDtCrW4sj4StNrTV/ykO4Wrk93nNAHy7UHXYj5CgCEUdr0J8Q3Uwpkt5iMBhMxcpN92oAonf14jfx8z7tuZkfO2Kgi0X3ILJt5cSgkKQSds5xiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eMXZ2HAb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so726222b3a.0
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768430090; x=1769034890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F13Qm7TgxMiPviQmHt+xP5v+NAbLWrPExXjm23CEPGM=;
        b=eMXZ2HAbGDCWRtaSIFj+oHEoLe0dLjMadbchS19jmafxlj79Ju/HKkLpPcHQJHciI0
         R9LrDaNmtYx/Asi8RIUBDZDefGRLdnjVzSvH1vJZJuYSQXg49GSunCyKd58oer1WBR4E
         dsAdK3pUCot/k385lMU4tkx4a1zBN+bIr+oeAoqSctD/k4+pjUrh8OJS2mLl1nc1IK6Q
         9+T3x3ikFfAxQcVqXjX4+E349bZnvtoaW+zGnMhhd3IPdlNpK61oqpqCJcmb0WLvTr8j
         FYUmoxBvG3nh8zqvsb1AHXDqYvN9qnf2SQ0ltVbTEC/i3IhOE1G4fO9DN0W8JICSY1/U
         u5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768430090; x=1769034890;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F13Qm7TgxMiPviQmHt+xP5v+NAbLWrPExXjm23CEPGM=;
        b=gOj2vd8jRGTgRz9+BACnBGagosvXa5HFOXBQ1NzjG8FQpFCa9QIs8ALHVbU5L85AkL
         AxgAvU3G9dGUKfuN5noGHtLYfoEyG97U8+AleedgQ7f/CyPzuXS0aTAIUoKbeQT0dSU3
         pipeBL3SFh0Kkr1bMSjrBvUum6kuCwBrtQpnUX4w1RjP2aKipbgNjtqYMayK7UnSqtf3
         THvK92VG7Kw5q9pJSTyUavOW5qs1YU1FB/WaKF14+TRKaN/o+rQoU1D1NZoHUyn5oemT
         aLjN4kxLXHfvHWLg/6VF+jRUnpmHGzNOIKUwV3Pm5gJD3CdsjaCAobioGaiPp/adOMAz
         tCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qkStG8+9nXmHsG9H4w7z5TvoKmtza9ofU9qA7gahejUZfdEOTFRHzRQw5RIARitMMNdGoR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLzWIqYYXNBPmywxqKSMEMuEJPGs9R08bjH+GkL2wXXF4MIXS
	0riaxisz2HgbgkI7Tvdn5DV5x17GEqPUEdwAgiqMZV2yp5SPO7+3MwT8yYc/HCHC6h0=
X-Gm-Gg: AY/fxX5nhc/zPzLuJoRfb0y1FzOOAqmAAzyNAMqu9d2soim/flXshu2slw3bfgKgIs9
	0Cv2xAPLIUwhE6XQv615ovWY7r2ZEkOeENzwQqdvxFNeOnIKO+7CUSt6mIRs3ZKdKk5vRxVndzJ
	6svQqplilieCwYwtl8/FDhkoiva+3NavxzOEq9yiCFfVhQ4ysAl8g3xh3Nzjk7cEu3LZaRvcVpS
	17wtB5uHswkWeLNIi1C2u8AHRLzQLucmnU7UvBXWwqBHwn7NKKNmNcELGG56yLVDQCSTT8WpRq3
	KNeKex+heTuvGrpc3MtAJlLLFLhsi3MZ4/QTYQdjbeXeXczL+bNHK17cqgPZ/+iGoXMKrYDu8wm
	U+twgFa/liurpQQLgNXwcz2kX2R1v5DlrVDx0NaWcXiqOuWTI1Dowu5XmhHKMKHq+oJytDeB0jb
	Z6Egav4IFCshngvkON/mg=
X-Received: by 2002:a05:6a00:810:b0:7e8:3fcb:bc4a with SMTP id d2e1a72fcca58-81f8f10b08fmr867741b3a.31.1768430090366;
        Wed, 14 Jan 2026 14:34:50 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e64b7b8sm529270b3a.33.2026.01.14.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:34:49 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251219110119.23507-1-johan@kernel.org>
References: <20251219110119.23507-1-johan@kernel.org>
Subject: Re: [PATCH] bus: omap-ocp2scp: fix OF populate on driver rebind
Message-Id: <176843008938.3580410.12257045683463470692.b4-ty@baylibre.com>
Date: Wed, 14 Jan 2026 14:34:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 19 Dec 2025 12:01:19 +0100, Johan Hovold wrote:
> Since commit c6e126de43e7 ("of: Keep track of populated platform
> devices") child devices will not be created by of_platform_populate()
> if the devices had previously been deregistered individually so that the
> OF_POPULATED flag is still set in the corresponding OF nodes.
> 
> Switch to using of_platform_depopulate() instead of open coding so that
> the child devices are created if the driver is rebound.
> 
> [...]

Applied, thanks!

[1/1] bus: omap-ocp2scp: fix OF populate on driver rebind
      commit: 5eb63e9bb65d88abde647ced50fe6ad40c11de1a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


