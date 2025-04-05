Return-Path: <stable+bounces-128404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56413A7CA20
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A253B6DC3
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966214EC62;
	Sat,  5 Apr 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u22BHMrn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A205695
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743869783; cv=none; b=ONqwKhPR0T6Ycq785HhUB/6VYyAD+NAvnSpX7D9v5KnoK3ImJSKoDDXnQea3I6EewcDZtvATZXBT7SC+s+ThE1uivxCYbwXXj1P6IHiyKii/XgGCvtvWf4GeY7Tl0wC2Tdl3PXMbeA1c/8DLDXnOIkrgcoDyeWbqGdJgWSzlPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743869783; c=relaxed/simple;
	bh=f9fwwNv03NbODRWqKK9+JE9Q2mHw9mQ/GAhJTTxPSIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSrRZ0Lr3SWohJQUBiGcCarpUdoNti5Cn28maaZ0N8YdF6rvil1oLA9nZ03qYLwHy3s6izfLKcvq9pQMf2MyrCMT+jwOg1/r9ODfeJpWIplAnUvx0Mp3ZNR8ouYoWE3b2i5StQx4jwOgCAFTjEdrXJCKkp+1Jp83hGN9RRzPYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u22BHMrn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so27700305e9.0
        for <stable@vger.kernel.org>; Sat, 05 Apr 2025 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743869780; x=1744474580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQA4y1FzPmhivnWC1Pgg4oxOyq8Cr4ueMJktDOHR4oo=;
        b=u22BHMrnba6WGRrZkRRO89X1aOUWuFyfznNTg8J/QoFW3mK6pTahHpXX1oBsRZqNWh
         P4+BCR+v40UHS+lPyq+nQjxsYcl/XcDPR8J+4CC1QPwxln1W4T38oZJmljIZhv5Q0cvA
         iXR66EHP7IbkmvBVIzUki72ahB2/iFzafiRCrDrd5b9rtFuJ6gqQcFmq2gXk00FzpvbK
         D0WS1vLUSPiDkYkje9gFLDIEOeCbqK7Ovo4U0hKqv+DeGLnPDLiV7u2E2tL0ZoWPEdCo
         QLYXFERS5lgndpeCRhIvpNsDN9ZmNre1SRd3QrYYaYVfs0hRznxIbrYXWF8j+CmfrMAp
         k9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743869780; x=1744474580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQA4y1FzPmhivnWC1Pgg4oxOyq8Cr4ueMJktDOHR4oo=;
        b=Z6dn6tvuUAUYi8xsYobnprerWQjsM93QbcO/p3J47paSRPhI2LdaJVS/yVRPKXgh+y
         aYhTmpTJ6BZE1sOx2rdavay5dIRG0XbzHVjPdFy51sEg6k0GkfEez1KjfixbAHuudFOh
         GOZAl/mHmfsh/VTJQ5rSAsd7yrwVazw6lSwr4mK55N55jgCZ726DXduzGrl1UcgRA+mT
         Gj3ZR3ermPuo1FOQ2SZdAJa5ZIoKrKnJYKE51tbDeryOBs6zl/H7Bi7TGamUQVmTprey
         q1h3DCVNP8RoQVdeLvFRKsD4qszLBrupE6QUy7bNpu9kgLfxGVg2KcBliVTk5/OcKqGw
         D4/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/CgR+Spw9yfNrTJW0b2Terr3SBDPB/wdF/AhA8cZddKqBlz2bvClkPMIi9xOPE8r3BJYIXvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9getFwRMVjHN4AkDF7dysigbk9WVZZn4839XcbCMuDkECCWaa
	qKKBah0qBcuMzUGW73nda2IpTiqXzH5suD9m8PA20PmM++1Y9mZmi4xX/1c4Cxw=
X-Gm-Gg: ASbGncupj99vXr0Q/FK/HI3iuuGGIK033k78LCoQUzIRz1GemHh9LK40Kowy83kGJrz
	zhrc/aOHB9IJCDZ0/tfelQtiQynDmS4gwCNd1JeT0K5o3hUxRcRfLlDcU8ecHIRC0xfccRbfLQt
	7GRgdezxaRXen1iyWm/+x2n31Jz4Exgtcd8tcJSkKYnUoB4BiVVfmbVfojya/nQ6/oYwGhJyQPx
	ivE6S5zHj8tU2kp46xy3Jj8pPlOAsToMJ64aGB99obZmLE6tMU0UvPTt3bLBT3kUHg3iC2vNFeF
	J96AgXAwstFCjCunfekOInYZ1vWttFVb3W8i54hWyH/ev5wxWwhDAi7tdCLX
X-Google-Smtp-Source: AGHT+IHUbTxn+Ru3ccdmf6QiLK+OvdKs5Vbjv0pWdVZVEKvUSxpiHrDhuhyHXkzdAGYKFCiWEJML5g==
X-Received: by 2002:a05:6000:4282:b0:39a:c9b3:e1d7 with SMTP id ffacd0b85a97d-39cba93ca51mr6004112f8f.29.1743869780109;
        Sat, 05 Apr 2025 09:16:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c301a9da1sm7148016f8f.22.2025.04.05.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 09:16:19 -0700 (PDT)
Date: Sat, 5 Apr 2025 19:16:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <8fd63a84-0fd1-4596-a9da-913e9c8eb110@stanley.mountain>
References: <20250405160546.2639-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405160546.2639-1-vulab@iscas.ac.cn>

On Sun, Apr 06, 2025 at 12:05:46AM +0800, Wentao Liang wrote:
> The sdio_read32() calls sd_read(), but does not handle the error if
> sd_read() fails. This could lead to subsequent operations processing
> invalid data. A proper implementation can be found in sdio_readN().
> 
> Add error handling for the sd_read() to free tmpbuf and return error
> code if sd_read() fails. This ensure that the memcpy() is only performed
> when the read operation is successful.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v4: Add change log and fix error code
> v3: Add Cc flag
> v2: Change code to initialize val
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


