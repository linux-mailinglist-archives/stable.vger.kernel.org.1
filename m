Return-Path: <stable+bounces-50214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C6904F21
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5094D2892A6
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391E16D9D8;
	Wed, 12 Jun 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr0/iviL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCA16C875
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184193; cv=none; b=onbRnYIoJjmBRmFldzF7HxShCpMj48dWC+0PqG5GQmBO6Bv7W+Adro54ygnOfPKSmOulFtJ3Kj6D9Te6t3gVmGjGdaTK6EnVosbk5g6VqJx3PeLTjQS7064hKYyfWm3b/+etiFJ9YenJXqXZfuGivxlI6tI0N5Wx4UvgA59oJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184193; c=relaxed/simple;
	bh=L6aQlkYdf1XjFaD3aaJ4kmtrRKD/GnbI/GjZRBMbZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOJkphCLRF8uICcWiV8HRQxgbZan8bb2nyTSGwZ01B9dCQ0WvtxNpktkE+DBpUY2sCU4vgRe0cRxVcai7+xJNZzeWbrWoSHCYQTdYJxpqHGT6CmapS5Q9uxjhPKKi1Mve+zgliGzHhcTzvF8vHX0uBSZA7XO/9JCaTG58SsX6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr0/iviL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f225ac23bso3119521f8f.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718184190; x=1718788990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=px3FWD61KwYUoVLXs51y4wh/lB5F1voz4oJ3Gukra6M=;
        b=yr0/iviLd0x+N6izlpoVwFHchZVFq0+B/C4HXaQcEE9/WbMxy9Wjm21AtJpmPeLL5d
         aO5VI1CC6NBddliXGJS+J2uZjOGlV7ad3uSMWNYb+Fyk8INe0Gw7fbfRqjCZTyl7lOMc
         k23dAlQk+wIyN57fIHhkxtULBXIVVXCCjqIf0kv5SF33rv7nsyjDYr8l44xaHmJMh9/v
         xFm2QtSj8xCGVkTgM2mJhoqj0KlzYfRyf9/locAICanKC8TQPmG1+o8jR+rMF/o+fNiH
         WkrnX8bQkrhPdnawTqnBuMEQTYk/Xy3mMfJy7RRN2z5BU4euqLec+NwN4rBccdkoj+ob
         aPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184190; x=1718788990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px3FWD61KwYUoVLXs51y4wh/lB5F1voz4oJ3Gukra6M=;
        b=re9zJUzVolzEtAsIV8WlRJzDx80zi/BcB7YhUtvr+M/AJy5OFT877nfP27eMMERGJD
         jGTd7c/szl62Pe01rH3uYys4g1YbDb+xW8cmzSTPBcBuJi09gd7UouBqcDQ1B2aSrPeS
         +gMWBh+KljUMqYKEdQNXjNCn3dpzaxlfRvu+Gep7QBCqyQs3ff5JInc1NyyHOqUiBgpR
         JAiQzXj87ayt0mN8DsZdHsamH6N3abtrtkkLejils3cim25l3/EMqsYbUk0C94TuXVaH
         L0zEzEaeRIpfOpFLCX7nvjKdzTx3CQQMPokhpGK0N5DZMbGDbVx446LfE3SYdaBG+wHZ
         DYhw==
X-Forwarded-Encrypted: i=1; AJvYcCXBzf5n929qYD7PC/tFX2Dam3x9TbL1BQqHNHsd/8C2C/DD8qddMhQten0GTRyGCy+MmN3f30Oi4t3FXARkqBoW+EzQlVqT
X-Gm-Message-State: AOJu0YwchfGs3pHqXh/VDBkz2GGnIxeYmDj3sbdLt3SYitpnbfLac5Ia
	mFRxHvQW5AozAVFey8zUXoYSs0mKFRu2qF8rpPxDOxpZwDjydl9eJtVNIWKYQvY=
X-Google-Smtp-Source: AGHT+IFOMCjOwX/KFQg+pTTAbiYMRIrI6LiOBW6EbiPB1eB/0gA7Kzf223cvhK/M1n6QlFI50LRw1w==
X-Received: by 2002:a5d:4f8f:0:b0:35f:1cec:3cf with SMTP id ffacd0b85a97d-35fe89395bcmr1062754f8f.65.1718184190317;
        Wed, 12 Jun 2024 02:23:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2598ac1esm7109636f8f.93.2024.06.12.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:23:09 -0700 (PDT)
Date: Wed, 12 Jun 2024 12:23:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: Fix return value of nvmem callbacks
Message-ID: <f2156a50-0ee0-479d-8d60-3255f3619ae5@moroto.mountain>
References: <20240612083635.1253039-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612083635.1253039-1-joychakr@google.com>

On Wed, Jun 12, 2024 at 08:36:35AM +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> cmos_nvram_read()/cmos_nvram_write() currently return the number of
> bytes read or written, fix to return 0 on success and -EIO incase number
> of bytes requested was not read or written.
> 
> Fixes: 8b5b7958fd1c ("rtc: cmos: use generic nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

After we fix all the these, can we add a warning once message to detect
when people introduce new bugs?  It could either go into
__nvmem_reg_read/write() or bin_attr_nvmem_read/write().  I think
bin_attr_nvmem_read() is the only caller where the buggy functions work
but that's the caller that most people use I guess.

regards,
dan carpenter


