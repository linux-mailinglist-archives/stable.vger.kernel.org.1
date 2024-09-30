Return-Path: <stable+bounces-78242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A0989F85
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2FB1F209AB
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F34188006;
	Mon, 30 Sep 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcXRJzPq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F1189B98
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692622; cv=none; b=oRiLW2Q3Uuq7JJF7mEsAVRpetB0j+bcNLtYtKxl/JxzN4a+HGt1IsfkRL03LpsjZHJ2VaJEMdtFejme2C0IG2HNwO0HUZiQNkh7ITS2VdMlZBIgQbeKoawLgYXGiwxpqFbyt2oOA84akEs07q2drUC2SAQB4kMUGj2HwufGTKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692622; c=relaxed/simple;
	bh=VGRUhIz4Vn1P2La+6gVKCXPca/yCRduCeFQ5hZhM0SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a05cdqzjoREFhl0COUxCK87guGonolb6G8m530K6HR3BuGn2Oyves8mcNRWNdXcsy9wf+OMcw9uRmDJWZYHZzg+l7pacvaI4N6/Z4yWkXHAcOPi8MgTJKuKWSaZVr1FTPIW/2E6w+qJgR3doeOGVP+POdI8PP1kW8S34lSd4tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcXRJzPq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8ce5db8668so747466266b.1
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727692619; x=1728297419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMdMSE9py3RjyD6QCh1eR0VuWp5bQ3RLbcnII21K+jM=;
        b=DcXRJzPqhXzXMzO7iKfCyTwPxpfo5JFaWANfJIe2ANGUAnUKewf8tCNa2ej3rieLFv
         l1L7DzWbUSfoGCorWoK5K5K2nr7OivrKYncTYxVWzuB6J3sGqR1rL0WhkfI3MnBwBJdi
         1N974zioBFgOUPqdTLSHIMI8fDz6DHQxJuRyxRt4dP3FrdKFM2xyuflTxQ6zrDm5IN/O
         vKUpKXjVA8FD3dUXaG23Ger1e9ejvbBBRzu/bNsZgHN+Z1n4T5hmVX/e58mqMQa1u2/1
         /PdnuzCR1BvEENZJ13FfcnAuEIx+fohobQpWEYUum79QtfWcSxZSf5+S7lmivZ3l0NOk
         FpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692619; x=1728297419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMdMSE9py3RjyD6QCh1eR0VuWp5bQ3RLbcnII21K+jM=;
        b=ujjixQWNMpCP73KZevVqGLpe4AIeREGkR32oddMUSSXgmjmvkcwj7mpGo3Lfzhi/5d
         cXbVCwhmxcRgsJF1DsVz6slGft05vj1V0seekai+thD4PgVmSsH5VzTvKO1agRmwCDZ/
         3RkRqS6zOcUuDeOSjDTfvEaRIPpxWCrVf0GcvlngptC0BGLCv/fnomc4cV2yLw6YaIjW
         weEzyEn55yt+urt/N219tDmnD7fMc35T0C63TsW/o8d3lEPHmynBpcwIlreREzJqWw08
         WT5n/aWQEv3cyfRzOd5pDf4rs61lI0U7nj6yYThQ8Tib2NBxeFU1FqAz+Wq3cutQiOWT
         f1pA==
X-Forwarded-Encrypted: i=1; AJvYcCUh5LPh1NcNSRsVr/iNQtMAQx0EohGhpeGYKtwTUbwB9rIZCOXrI7cXF3iCnDzJVk/+ciYshHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0ecGd1eGH3erOPorUCM4poI6Mjyqf/N1Kur1nUzB8htVKwih
	a3XepzmXR05oH95w3qPlZOTFyAAIq1bRynu3NMiRM/Ma9AV73OQfKnmo6s0V7Zo=
X-Google-Smtp-Source: AGHT+IHQ1cmTo4UbLbfQql8P7BUCjSn6i5rykafHKyXfrRh0KuZAMOMWuZyLvKaN1xkt7Fee6L9LCQ==
X-Received: by 2002:a17:907:781:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a93c48e80c8mr1302865466b.9.1727692618860;
        Mon, 30 Sep 2024 03:36:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777bc4sm522635966b.14.2024.09.30.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:36:58 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:36:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] staging: Fix atomicity violation in get_serial_info()
Message-ID: <bddd479b-8fa3-4e39-8ca5-f7f133a8b298@stanley.mountain>
References: <20240930101403.24131-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930101403.24131-1-chenqiuji666@gmail.com>

On Mon, Sep 30, 2024 at 06:14:03PM +0800, Qiu-ji Chen wrote:
> Atomicity violation occurs during consecutive reads of the members of 
> gb_tty. Consider a scenario where, because the consecutive reads of gb_tty
> members are not protected by a lock, the value of gb_tty may still be 
> changing during the read process. 
> 
> gb_tty->port.close_delay and gb_tty->port.closing_wait are updated
> together, such as in the set_serial_info() function. If during the
> read process, gb_tty->port.close_delay and gb_tty->port.closing_wait
> are still being updated, it is possible that gb_tty->port.close_delay
> is updated while gb_tty->port.closing_wait is not. In this case,
> the code first reads gb_tty->port.close_delay and then
> gb_tty->port.closing_wait. A new gb_tty->port.close_delay and an
> old gb_tty->port.closing_wait could be read. Such values, whether
> before or after the update, should not coexist as they represent an
> intermediate state.
> 
> This could result in a mismatch of the values read for gb_tty->minor, 
> gb_tty->port.close_delay, and gb_tty->port.closing_wait, which in turn 
> could cause ss->close_delay and ss->closing_wait to be mismatched.
> 
> To address this issue, we have enclosed all sequential read operations of 
> the gb_tty variable within a lock. This ensures that the value of gb_tty 
> remains unchanged throughout the process, guaranteeing its validity.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations.
> 

Ideally a commit message should say what the bug looks like to the user.
Obviously when you're doing static analysis and not using the code, it's more
difficult to tell the impact.

I would say that this commit message is confusing and makes it seem like a
bigger deal than it is.  The "ss" struct is information that we're going to send
to the user.  It's not used again in the kernel.

Could you re-write the commit message to say something like, "Our static checker
found a bug where set serial takes a mutex and get serial doesn't.  Fortunately,
the impact of this is relatively minor.  It doesn't cause a crash or anything.
If the user races set serial and get serial there is a chance that the get
serial information will be garbage."

regards,
dan carpenter



