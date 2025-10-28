Return-Path: <stable+bounces-191390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0CC12E51
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3524F27FB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EE26E6E1;
	Tue, 28 Oct 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+WJOpOy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2FEAE7
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627681; cv=none; b=cwLrs/demrJnnodVTJ9Q/YHydPT+a02ZFVrfVg/LYr0/M1yq1tUF2w6nWgkfcgXD02mpxwwprwKtX+ooiKD4l9/2YJmjYX4bIKqSknzdFc1vEbQFP98P4TKIhCny2CRrRC/axYytWiTeukymCMQHFDUKWFfWULilt4yGlCc413w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627681; c=relaxed/simple;
	bh=eXt+qTwvJszO8Hou+806wGDbl19YgC8YGTf1MQAwWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq3cV+uJgxoY+Xgocfb2n3nijrY5/iYTKZqwGujQQTR601DCz9JA/vZwSCYbl2APAny6r5sIbnAgra78kYFXV9tkwWCD3MViUKe39600bib7aUJESKRZj2WQWuakx0J32EFS6dF5wnEzB8gZoYg4ghNI20ac8GMAnzj3WToxGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+WJOpOy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so5384255a12.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761627678; x=1762232478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=u+WJOpOy4SoPnd6RXj3kAOT+B6BIXZ2j3QrRX8qogv9tck7i88pMIMtQPGtUAm7fJd
         qRtNr+6X2JAiPOzWRhu1hbUNEqg4mBfpAzL+//8FMSKouyXhmpPbKLFqe5J6UW4FmNhV
         GaO6H/ZwtQxrQVExPVpEKBQnnj15nWpgRol9Rbcsfh2INdASamgTqolNagNAlip4my2h
         39B168kF7MOYR5CO2PoIqBhnKgBwBGgBnmvkCA5IZfwu1EE6F4cqRg8pOn02OTbDQiug
         khjqSI9RGYdHieihoCfCvG8bkOKo8GK00QVY/V3y9KcL+q9LVDAMVXr5Abccgr/w/V2F
         BOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761627678; x=1762232478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=YkJ95b3yvE65hvmxKhyNemcGcxoFFa7pdpU5izO4aB+s0gq0gINVSV5iDbUgO6VhQ1
         qJa46J6nELeElQm/7EHsoVFO057KCZdj9y3S0MMK+t2jAIrg7v4za5XwDzdceq1R9G3S
         wP7LZTsx/hcCjIjWlnzv+GSw1w9lAQnVCef5D5yFPHeRiFyyyirJv3y5/gka7SJes9UA
         ra+5ICAS8zD0AmoOOYqySqj1bdwTL+0G8DU3mEkqMOfVyWBsV92Az0UQBBBvY8EdkhDQ
         T56tuyDe2kOf7dXrG9RlLVQQJSFuS8eH6ASvQV2YJ6hPix2D8/PXE/34ihZ9gFr2eoSu
         l3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX+BOH776VswDdXxhYUkuQTCvkjm6eJyIutSDwkcnYnqxhiMiTgrrr2kfus2feibTMan1JP39c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMgAmyW1VuMUB9sMlRolGq5F+VIpRkigwXJjX0oy8b2iT2DgO
	ZI1GPGxzF9cd8ukWHzN9QXsb96lKcBylZ8It5UpIEeqhcSNeohzRLo0Ki81w9yyOWYQ=
X-Gm-Gg: ASbGncvKg6zGTRrgc+ol6oj5bC+cNIF77Y1aWH4O4XlgmFrLwQjiOzkdA4SZKmcKrcE
	/L31tn8DR+IV9uZ6F4uz4e9fy2mxssqXGh7NGIG11U/QKgmiUL74dQKE9nLzO5ywWtKAx/kfnGY
	YoA4tYevH9D0jYvfro9fVcL1pq58R0htrKS/3FJj0zNA7mQYQw9tm1zW8n9WtGbFe1tnEzJVbSa
	J3M+oqJDuZNDIYocjv6ITRp92jNRN1R2ASCwAB9oBTn/Lxh6UvBcpMKwJzDsj/58ZWZrC/TFX2Y
	SYRFCi2Zfs+Mlh0oHM8D+0I6U5UFFDraTzAibXVhtjS7BENKIzjnIuW+IbNLb4G00Jx3ELG4nvE
	MIQR+rlnXW2cKiV1yEyXDTxQSj9ZJ23O2+zsYs2EKUgT8+VNyOEDusJC5Epdl1FUsbfz0ywE1zg
	CObw==
X-Google-Smtp-Source: AGHT+IEbFKSVcApo2b31IgKzoejiPT54f2Ug4CUN+na1QFDYVgo35NsLKOeM5ffDDNEZ2+JecClhPA==
X-Received: by 2002:a17:903:2443:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294cc69eeefmr20200985ad.7.1761627678039;
        Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm99649655ad.12.2025.10.27.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:01:17 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:31:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Message-ID: <v4lyy4fexh7erlokxhkm7ha3x5lqdb3fo4csuw5ltqgortapwr@dhtgpppyrwfv>
References: <20251027150447.58433-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150447.58433-1-linmq006@gmail.com>

On 27-10-25, 23:04, Miaoqian Lin wrote:
> There are two reference count leaks in this driver:
> 
> 1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
>    of the PCI device, but pci_dev_put() is never called to release it,
>    thus leaking the reference.
> 
> 2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
>    nforce2_dev which is stored in a global variable, but the reference
>    is never released when the module is unloaded.
> 
> Fix both by:
> - Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
>   the configuration.
> - Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
>   global device reference.
> 
> Found via static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh

