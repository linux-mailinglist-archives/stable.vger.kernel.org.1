Return-Path: <stable+bounces-200115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DFCA6138
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A4631DCD61
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C828750A;
	Fri,  5 Dec 2025 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFhuR+86"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436F275861
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907410; cv=none; b=qqNcKxRoXNF2HCvCwlepC8k+viu0wZSXGEC1DzHoHbgt/UOT3nN+tQl69iM8L+WGF+gHkrzz/1sSvvtfui9L77CLlzXncvblM65P02g/WMMlEQEKfKAdccwggjesT1kLxY9C54w6yxRD9AcRzfI8d+Mp7ZaAGENXvGf4pFdkNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907410; c=relaxed/simple;
	bh=L0mlTgPckn3fQYXFq8WyzPQM8CoQwb3Bh5roMJ5U4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJMOfYWkjC/yZcXF3SlPA/nVLLbo4uO+UEZbP9IN8LoHlMCx1koG+XaS+r3AUjJpb1Mepqvi023IV9GufcK5lv0PdKun3bWWVVvvkgq+T2iLllodJZ8yO9ipaCZ23BBfyiWNS0iqCGux2Tl6zwiaXn9eBEkXI7Gm8B411afEg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFhuR+86; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso2661497b3a.2
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 20:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764907408; x=1765512208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOUA7xF3xg1jso4H3Aqc/OZDv+es3ngBZ3OiY/JHB08=;
        b=XFhuR+86eJdRTkb02xw9Xs9QXCprn9xkt+/gw5uTdwwGNQTf03mI7SdYH/Bk2DpP1i
         hy12YSphQzynfD2401f3KWGdnUPbwxXfmLLHLKhgfKquDgIEfECZ3r503+M8lYtjFSyw
         yDbEq3ej7R0Hj8DL3UgIRkAvHRs/j8IkWk7ylagmha3v9TRP8C//LmO4BA5nJZIsw9nZ
         LFfCj/tXp476yD/oPNYbmnrDJKnpwUzDla9VszE7bd2bDOOZHG2+ZHpOPzGXBeoc7LG5
         /b4kcfZWw7Cn1YsowFui54iOz5zpRCMr4FcSzRuSQK2aNSqkbDfrjJQv8Cx9A8taO2Mr
         dK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764907408; x=1765512208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOUA7xF3xg1jso4H3Aqc/OZDv+es3ngBZ3OiY/JHB08=;
        b=SpB8B7eHL4O14Wd9bwCP3Rv4XNt95Qu+SVXtR6OwmApVV1IeOoS/Ul3QF4Ab/Fq3QF
         ATwBUobwAIoGQo4yOQKNwTJ5n4/wS9GkDjNuSn/fyzVjnZPRcvOYVgV+tDXMC8V9iPV6
         htamGY6zgKv2vLXmPOmy4DZqmbrScw1dwCgzT5oBBelddE26V/z8kJuwuD/lP5AFP6DH
         i3Ne16Pnzib6EzFYE2p3VX1glbkQ+s3Z6TPDCbvO1bsrdfS4l/DZgjgnyF52/tH1xkrU
         0p7arbp/88sKi/DzJpLbDecLe4XnXPzrpquPpxTIeLkMUTZpo3F7jxdn8VrjvW/GJ5wz
         2dfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf3K43Mb9bJfuZOl4UPEzu87KGWfKdIPZ/K/UDudKx9VBc+UXHRlnbNAMAHOsgMm5LNY9Vfo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgwutMDoTDtJYRDFW1Og3Xj7dvT+wgRTs6tQtLBxWr+uDC3XA
	koWptVrq3XHCqtw7jO15qo24GJRXrfviA8QLhTyrOIXa5epG8CLeqcsz
X-Gm-Gg: ASbGncuDX8X8QpXJDci80ilbN/mxTuVDzvBp3U0I5fxTE9jtKWwaCI+O4OzKuslistJ
	j1kbEKJ1ZdOz6oaNDTVu8vjRGCXze52aHEN0FsWcBlaw8RMo9dE7+EoqF9uFMqnxcRCkvK+Ne5C
	3I/piPUs40o6cny/4bv/Mkm73FuJu2EUFPfDRwL2BBSd82ERZF/n3bi6mBOBlC4temwwZoh+Tie
	1BHC4JweeLNKCaHjbY4/CDbz7ZKHD5P3wCtrFYPFT668OhOEDJcq+IgehVftguWaz+VgYZLbl1f
	RlbFCT+rX/uONEZmMseBGRTDV2L07POMfRgNwy5f94g/OJt+Hf9Jef4T4h+2nvzpAE1dajL2Ebs
	qxuFwOcYawAexF+izFswUbUlDzOTWs0Yser0TqZK0CiPMEAtZJD/iTMSf/J/vusQy6be4Gw9Ksy
	ag25VmjWTaSNqSdqO7CC/07WzFmgGeXhsKhw==
X-Google-Smtp-Source: AGHT+IElj+T8To+QwxQszhtxmAxzccQSixmMWqGp1fLQk66p2l2O7RhgSvCI5BRzteSapGww+7XBgw==
X-Received: by 2002:a05:6a20:7f9b:b0:35b:d15f:8fc1 with SMTP id adf61e73a8af0-36403763911mr6867611637.1.1764907407764;
        Thu, 04 Dec 2025 20:03:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed331sm3659847b3a.4.2025.12.04.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 20:03:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 20:03:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm): Fix off-by-one error in
 dell_smm_is_visible()
Message-ID: <dd389a71-dce9-4142-b546-78c04d4d1346@roeck-us.net>
References: <20251203202109.331528-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203202109.331528-1-W_Armin@gmx.de>

On Wed, Dec 03, 2025 at 09:21:09PM +0100, Armin Wolf wrote:
> The documentation states that on machines supporting only global
> fan mode control, the pwmX_enable attributes should only be created
> for the first fan channel (pwm1_enable, aka channel 0).
> 
> Fix the off-by-one error caused by the fact that fan channels have
> a zero-based index.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1c1658058c99 ("hwmon: (dell-smm) Add support for automatic fan mode")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

