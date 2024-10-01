Return-Path: <stable+bounces-78348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9698B7EF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07630286859
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6219B587;
	Tue,  1 Oct 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3kQRqU3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1819D082;
	Tue,  1 Oct 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773647; cv=none; b=kYs5MK+QIed+WW1XXwetz5KVQ2AxnbzCApTv/8hbLGizO8PltE4tZ3Eg3GEMv1QuQHqWTVbqjhSDgdgagVJVi3Tp/rUuBpaEE+2JiF0Kaz2emlVWTg88qVsv5J63/Tj9VmhCSTjWWwTxBL7+3I5GaDWCrjo/7Cukkpmkx7hLqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773647; c=relaxed/simple;
	bh=t0QjQYuYY+0WPl2rM9b833pgOlO4jJJb/lVE+1yxW+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9o8kWOkhYortePGvZXFFVWv5cAHDhZdGjRkt+d2PwjRG6u8u7ggFstR0GNlFOmEEQ4QIXn0S3CIZFJf8/DgnMg2ONx9KdzZFZtPKawz+4x8AVv99Zzf2ZDoM1yulifQlcHzFOSZjp/VYzHfcskzl5NbbyzbzO/TEKNatcqMluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3kQRqU3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d6ad6050so4422595b3a.0;
        Tue, 01 Oct 2024 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727773645; x=1728378445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywPE5AaZtgDQQHnYbM9mXQQedD2d2ZGmzizHSTVSQq4=;
        b=A3kQRqU3ctI9MBDzenlgihcD8rqjF1DEYIK15dWvWmqNy+uGztYIhnwKMHXgvmlSz/
         x2vCx/fcbuPmrmHyJo//X+fwP4aRgbqpl4DglGxavQUAmh+F9CMaCxRB+wgRWHA5esWw
         1MZCdqHIf5Sptz3vAvviKxjbfXL+pF2eDKZuRPoBirTKG6YlLNpuQzvEbrjCBJBAQC5R
         koHCF19lWVP/ZttBNZ9jowjMQAOr7xkGEsvR6oTnjLn1oMIr+jf8V+gnfYeFappTLZRC
         XGGAIQEi8ti4xrGBTtdbTDv95C4V4aQJk8KT9HtOTC0EDvizTRzSe+ZMIRSHB/uyyYF0
         7zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773645; x=1728378445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywPE5AaZtgDQQHnYbM9mXQQedD2d2ZGmzizHSTVSQq4=;
        b=oMhQSKHj+LvY9Z97WHAiyDxoO134eWZwECCrf0moyV+fMwlhkrNmK7Ycts3yYKff0n
         rD+rkfIyvOcmt/F1kvcWkMP4mo4xtI5DzBDBGcbKaWMfARz7F1A2EmMQmzRJ8xJiVWU9
         DV++KY9XkXs4jSJTIWrNVinP9a333niSMyu4eCa2RvLqk/vq+Y61dQf2sH6kkqDgTDMp
         5Zw2W3DxHMQaeBc9Fld8ubgniezGDlaq3b2H0Xf5842VGISoqYP4nRxjCqHvNADQqtgL
         5mbOKNt2RrRsGSeUodeqZJpM3UTxycqEJ2LqRQfXOU5PMsh0jhZSa5DCr2KMwyW8oE5K
         RQ2A==
X-Gm-Message-State: AOJu0Yx39RZIIn87bGblZfFPkD6Nepg6CDJVW8jMnThhikXf6dGIDHCi
	45JiDhv3+IrWjQOJqvmDaQfXC1DJDSokg+EHPitPxJYK6GPgIElvNWRDRDw1fIw=
X-Google-Smtp-Source: AGHT+IGgiYXhGsh0grqiaIRf+G5AmhO0EjlvWLjs3tq97HTv+qtSELgnWzRvm9q1RgLX+hGh3vqzBw==
X-Received: by 2002:a05:6a00:1304:b0:714:228d:e9f5 with SMTP id d2e1a72fcca58-71b25f008d5mr22021736b3a.2.1727773644558;
        Tue, 01 Oct 2024 02:07:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649bed5sm7572786b3a.24.2024.10.01.02.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:07:23 -0700 (PDT)
Date: Tue, 1 Oct 2024 02:07:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, dlechner@baylibre.com
Subject: Re: Patch "Input: ims-pcu - fix calling interruptible mutex" has
 been added to the 6.11-stable tree
Message-ID: <Zvu7yZx5XW2nXmxU@google.com>
References: <20240930232429.2569091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930232429.2569091-1-sashal@kernel.org>

On Mon, Sep 30, 2024 at 07:24:28PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Input: ims-pcu - fix calling interruptible mutex
> 
> to the 6.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      input-ims-pcu-fix-calling-interruptible-mutex.patch
> and it can be found in the queue-6.11 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Did you manage to pick up 703f12672e1f ("Input: ims-pcu - switch to
using cleanup functions") for stable? I would love to see the
justification for that... 

> 
> 
> commit c137195362a652adfbc6a538b78a40b043de6eb0
> Author: David Lechner <dlechner@baylibre.com>
> Date:   Tue Sep 10 16:58:47 2024 -0500
> 
>     Input: ims-pcu - fix calling interruptible mutex
>     
>     [ Upstream commit 82abef590eb31d373e632743262ee7c42f49c289 ]
>     
>     Fix calling scoped_cond_guard() with mutex instead of mutex_intr.
>     
>     scoped_cond_guard(mutex, ...) will call mutex_lock() instead of
>     mutex_lock_interruptible().
>     
>     Fixes: 703f12672e1f ("Input: ims-pcu - switch to using cleanup functions")
>     Signed-off-by: David Lechner <dlechner@baylibre.com>
>     Link: https://lore.kernel.org/r/20240910-input-misc-ims-pcu-fix-mutex-intr-v1-1-bdd983685c43@baylibre.com
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index c086dadb45e3a..058f3470b7ae2 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1067,7 +1067,7 @@ static ssize_t ims_pcu_attribute_store(struct device *dev,
>  	if (data_len > attr->field_length)
>  		return -EINVAL;
>  
> -	scoped_cond_guard(mutex, return -EINTR, &pcu->cmd_mutex) {
> +	scoped_cond_guard(mutex_intr, return -EINTR, &pcu->cmd_mutex) {
>  		memset(field, 0, attr->field_length);
>  		memcpy(field, buf, data_len);
>  

-- 
Dmitry

