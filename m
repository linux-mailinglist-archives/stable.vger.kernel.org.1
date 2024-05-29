Return-Path: <stable+bounces-47669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F38D4179
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 00:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963A028272B
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8F177998;
	Wed, 29 May 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em6ABQO1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347F169ADC;
	Wed, 29 May 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022474; cv=none; b=Bc1Id14hjIobPKATLCWG1oiINIK6Mx2M1G8NUesAZttgb0IMCVs8YK0KKD9HyI6HyiXoYPTbRnb/9ipunfHygAvI+dpBjubHCXo/7oeno/fKt16zjt7Om+sQC26i7sUBt9JN4l9erGuWkYK+ot0ELG5LfKO/ch7uoXt0pbGabS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022474; c=relaxed/simple;
	bh=cJkVtCe9chGJt5IKldUIkSFpB/Ui0QXuhTbAlsCSg+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akwj6zeQzH6DPFoTtG5xnZkhCEMjNzvDt5PzWdCYw4/FOsK44q6pQHWtMm6B4ZwqDsr9sMIxDH8fZd44d+ya19oO1WMpMoEwUvpmTmF7uBTPq7JRhmscxzta7yGI2N2rV1vy1D74DdFwKzQ25G/6yawWswB/J4aez4XZKUqFJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em6ABQO1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bfb6668ad5so204759a91.0;
        Wed, 29 May 2024 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022472; x=1717627272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6d5L0M+O0BYIyZ0V3sCIepJy3/RK+ClQnDqxaIO1wg=;
        b=Em6ABQO1pTsTUbCzBJBD0uKG0/NJR2A0rvYbrK+x8pewnEVphhymnBBYXA2dgDSRlp
         r1b5Tj8byCKPXayqONOD2iIJP9yqfNjxlnodTmiVLcuhpPgcnO8RGPOEIIglKzXVqDbb
         Xdyd/Bz3qr73rnl8uVpRbnqpLoTQ3G+hpz8MTSdxd+HV+ZfzsZv0K9395ZxuWIHW2+Wm
         URWjkP09LomwxHyrMV8Z13s23Jnmf+yM9guf7YEGbUgUoSQ5zTUCzd/aBLI30WSfk4ZN
         s98ddnL1zhmwDbwDfYty2n5zsL7QXvna9biEVo893JX440ebURu/WQu70JPND/qCQAz8
         NQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022472; x=1717627272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6d5L0M+O0BYIyZ0V3sCIepJy3/RK+ClQnDqxaIO1wg=;
        b=Uzpym4mtEPDuRpegePNdKGhsFNS3GD4rqZvq6TzwdoQ1atMRfHTEcZDEYwilxFBWem
         LQnn+oeWZF53nq5nzlYVcdKjSaKIzf1UkwnDBdyixna6EZLI0dooeEo60bb5JdscREjY
         83WbDqQd7BfBgnzNDFqyFzj9w1nQwCSssSY8PmcDw2qYMGrl2ufPFIpIBv7gpwEzgRhY
         cors5SjUlU1bq5BUfHX/q1awgbvuPYSFbW8gX2FYmwYRRCgwJLVwv7H+MqgdR5ta427+
         I78WGLt7GX/T4uuc65wzBDTpuT1rAKkcWBmFpeLLzCaE2UMniVKAXgRxrQbi+HtZi+MK
         mGMA==
X-Forwarded-Encrypted: i=1; AJvYcCUJY15p3HxLL/J9SeY1wOFNtb0LagphnoO4FPcW3dDtEnwYAebzpidBsvFNuS0816A0hq5MYvQ6opyRPdjM8qOXghumzDYr
X-Gm-Message-State: AOJu0YwTeDGNCfx8Lv0wW/0HwxmF+/RJ3G3eF8cAHo15+VF6SJK2Tz9I
	OThzNc2d44Kk1iFaqTVYgtLmEiw84Zx0o7xh0IAc6k/wVnecdiMH
X-Google-Smtp-Source: AGHT+IFtMnIEVN+/40b4FXMJEk1ihUfkLB8uCd4w6gdpI19ZFqz5LkFeHFhgsU65eo8eJE+lQ87EWA==
X-Received: by 2002:a17:90b:1095:b0:2be:b314:c789 with SMTP id 98e67ed59e1d1-2c1ab4b4945mr650207a91.0.1717022472194;
        Wed, 29 May 2024 15:41:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bab23sm339107a91.48.2024.05.29.15.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:41:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:41:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksandr Mezin <mezin.alexander@gmail.com>
Cc: linux-hwmon@vger.kernel.org, stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2] hwmon: (nzxt-smart2) Add support for device 1e71:2020
Message-ID: <9bcc4eb7-2a51-472c-80c3-0e17ecc43382@roeck-us.net>
References: <cd58922f-711e-4125-8214-57e1f83f6777@roeck-us.net>
 <20240524004040.121044-1-mezin.alexander@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524004040.121044-1-mezin.alexander@gmail.com>

On Fri, May 24, 2024 at 03:39:58AM +0300, Aleksandr Mezin wrote:
> Add support for device with USB ID 1e71:2020.
> 
> Fan speed control reported to be working with existing userspace (hidraw)
> software, so I assume it's compatible. Fan channel count is the same.
> No known differences from already supported devices, at least regarding
> fan speed control and initialization.
> 
> Discovered in liquidctl project:
> 
> https://github.com/liquidctl/liquidctl/pull/702
> 
> Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
> Cc: stable@vger.kernel.org  # v6.1+

Applied, after adjusting subject and desacription a bit.

Guenter

