Return-Path: <stable+bounces-110289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874AA1A66B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F221E188603C
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813921148D;
	Thu, 23 Jan 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL2GqzKR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F261F92A;
	Thu, 23 Jan 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644442; cv=none; b=ujMswwJrFn1MOeJf2TVHWbNfh/Zd5ira3Kk5QkCNdd8H1kLNwwgE294S861+QBCObz0+NX7GjTYFE+qQ/PZLQat6Yf6x26pMSj8NNCSy9YRX2Gi0XIp0lIVdRQLu6FQ7KRpmTcthJ7Fe5rprM+3qv+lxYePR+su4+jVOiTkMEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644442; c=relaxed/simple;
	bh=nep8o727NYLPHGiNUvsKSNAPB5PPeZ44AYRcjffQ3wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grX3ibWmhToT480414n8CHZjc5rfd9zV9lW0dm9c3RQoN1XeX3WicDqCbLigJmQ/cgD7i2yuXPEblGlseIG3nzLEllPO8SxKRA/3a8/nGAH3mQkiWs0ppufPvLaHCWzVcBBVjM+edAXRNki9OxsNoZ2CHPky+O7gwLkpMPwgSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL2GqzKR; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e287897ceso788083a34.0;
        Thu, 23 Jan 2025 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644440; x=1738249240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJj+EuMubqF2vrBF+xHjci3i0q6FGL1f+96Tt7g3asU=;
        b=XL2GqzKRLlAyNe1gusM9YfkdcFJI/VauotgyoXi5D9zQx7E4eP6mNNIbvfqUNyWR6a
         c9HwU7xJDoiTsjzZ6EtyLAK6CO6T9FxEWTexyrbStncNsr3NdJtlZvdzRQbng+wIkNTR
         upa2grxjbcyfn/htVKFmPJ+BMMptovLr7X+r8QhoIS5EXPji130OrDZdjzGJ8R8Ecciz
         7BSU/DkTMcvQyZ4ZQ0g+1vCPpAInTEd74ur7QLgPDcehHPAnH+vz1QE8pmjGF8NcbKnR
         0s/vldX45KFeKFf9LIuDRhyeJ3v3oRpR+wRH9k+hoo6kDq8vJNldZdY1sMfL3zICba2P
         JvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644440; x=1738249240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJj+EuMubqF2vrBF+xHjci3i0q6FGL1f+96Tt7g3asU=;
        b=rXJ+nSNXEkkaLLFi0xehWghWcUJMDuPf8FfDQrWWILsDOikvutC7STPIIPavnGZQDW
         FB8h7beb0PNson67IPBBKWapVqt6tJP4cgiOQy6CMs8pHGXd909j2//rLd832//T1EVr
         nl8zQJjrjGoZzHf48jouEIbxbM1ILwED88avqy4X+4s9k7ETFo0e+3bAmbq0NSGRAr5l
         F0lanNcq4AwDnXuaXxIPEsneguY8NDjcYBtihOqGvoefxYvO92NP1GbbKS4D3ZUCkTxh
         Ntuud74xkaAvGwRRCWcgQ8WgWYx69PNmxuaxtfn3ir7iBtw1QkqKRlbrX6K3QI5Y3sMH
         151g==
X-Forwarded-Encrypted: i=1; AJvYcCUvaNFtneEnzPF6oFtq8XPeg76VzDJsoMiN8uHPylA3UQ+QItHtMeHOPudqh8dP0/vC4VFvLgak@vger.kernel.org, AJvYcCWJkFqjR4Thqvt75WoiC0fsQ5QPEpxciF9IIG/etKO3xIa2v1qlSleXQO4+J2hgl7QmWs4U1Cwx@vger.kernel.org, AJvYcCXX8QcEVO7rn5d7rvpwBHrrMPDKzGhOQDV8r/1VLuyqw9xmBsl9xUerzxE8w1SsrL6cLTSWycv7m0qx738=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvnUhyIGZqj4yPTmSPy0+R0FKpVW6WzQJdz0UYZJ1KXgdHcOqY
	2I56XgoMu/eSqXJifMwR4OeUtLxpAkGNzXKMIvvi5L36LDOtZvGR
X-Gm-Gg: ASbGncsfzhMFDCi7gYPAG/JxyFj9tmYhNXVbI733Yj8i3jVdE70LdjtSlg7wr4Umev9
	kNpbfDIbXwGjDgXsq34HXsIM1rKqFgSeOKYnOKXS0tRMUZKgKWJziYb1WxKrgI7l6cRXwk321YN
	z+/L7qukMQ1Xhz/+7luWCSIQh9uA6JjyXcIhxkT/mA/4DwVri51iuYqHdGosv5ivuuF9/2UcKmz
	8M8Qf/SJdpdEoHn5RL81+rpVfAewphVdsvBZRpleTg51FUrao1IlS9d0Nd2ILd0cmaJTZcSoYP0
	hy+aLbii4qXq7a1rThjHh04C
X-Google-Smtp-Source: AGHT+IHmpMquru32roxz3Z7NNyEEFwQU/w7Nn53+St1S5VkFGEPbii/Q21qE9yik6ePRspxYNnCbxQ==
X-Received: by 2002:a05:6830:670d:b0:713:7e24:6151 with SMTP id 46e09a7af769-7249dafaa3amr15509680a34.25.1737644440027;
        Thu, 23 Jan 2025 07:00:40 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7249b485eb3sm4425705a34.47.2025.01.23.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:00:39 -0800 (PST)
Date: Thu, 23 Jan 2025 07:00:37 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ptp: Ensure info->enable callback is always set
Message-ID: <Z5JZlU-MPc01eDnU@hoboy.vegasvil.org>
References: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>

On Wed, Jan 22, 2025 at 07:39:31PM +0100, Thomas Weiﬂschuh wrote:
> The ioctl and sysfs handlers unconditionally call the ->enable callback.
> Not all drivers implement that callback, leading to NULL dereferences.
> Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.
> 
> Instead use a dummy callback if no better was specified by the driver.
> 
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Richard Cochran <richardcochran@gmail.com>

