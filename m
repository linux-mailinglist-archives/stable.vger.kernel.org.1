Return-Path: <stable+bounces-83757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E20699C5B8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6228CBFA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0F156879;
	Mon, 14 Oct 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMXcXS8l"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C514A4EB
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898268; cv=none; b=WRXdH/35z5K2SlLPKNTsJWYFTjzSnE6DPcP+nH9ggfBv7iYtmx7TytdDnmiCcaJAvEztvr4OBGQsFxtAyaEPdzTM+rptpYtkPWY6nE3XdBody6Qqg65XIgr4KHGzdIjZ8bVtUAEu2aRHvyIlITnpklUNfirBOdTxISc6qQfai7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898268; c=relaxed/simple;
	bh=10Vh/KXdRgda34P24+FCpQSF7tDiI5LjonUGB1ERa3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1gEQElV98x6E0Jz4+4xPxtWr6udZNdmgVXby8bo0KtQKL7tb5YnvzVA937KeW/MZN4lX9wXzg/BsuIavvVy2aYi0IjwhHqSTrWY16FCSUEBBckCG09eflAoG4z9zEkkSeIIEtdVnm5pdYH6AD5hAvwkV/4RrPfY7XzcgHSsvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMXcXS8l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43120f65540so18681595e9.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728898265; x=1729503065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPxfM3/+LHt+EmVnzhLr9Fip6ZGfwtZ5p/tUW2SXXpI=;
        b=eMXcXS8lzTnM02rJIVw2/WdsdmSh/mnx/ivOmhWN8ViLT9NNERxB4W7xliedmLhH1U
         P9q9MwDQYYfBQsWQh9os4zZXfDzbuJoBjp4xOR3RinoOc278D5Z0IR8mzybKbwwu2W21
         lPfZSq6fesf0cRiLuObl92IuvJtrj6XMCWZ9LxrGUiQGkUfMSNHTmQ23XoIFl/WAnOZo
         +o4oAsVOmxj1tqMfannFrZT7oA837YZ/Gue1RpkIBGKiFF0nAzNRmLO5obvM3zQtvXTO
         7uUeBTJGye+HNYoKNhZRhPA/qsYUPs248r2BcyQ4o5VJMoKT6NoSuHr5G/aps62cVkjD
         3z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898265; x=1729503065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPxfM3/+LHt+EmVnzhLr9Fip6ZGfwtZ5p/tUW2SXXpI=;
        b=kTiJjqwKjfOQj/5VzTnzjqoXmFEEDbQGB/9CC72TxfQWUKKlVcbdQBkk1hkorsGZlm
         hvws5pfTH7vX0YDvJs4lgoFei7YPeniqhL14ORhx9TGkG+AnBHfOtP5j4wZvTxDNtLG/
         5W1uwG3r9yzGgmWrl/MEqsA9PElL4gk/OAMmqUUilWZAqesXJ9eoLzkSUVJOSaym74+L
         OtjgICouj8LdD/unnWmEGakp1DvKmKicN7cH1TzAHI61DWVsNg37GnqqIJszd43DYSOL
         DimxvDqVX3FBkjOoKiyFqFM3c84GmBMHjUm9UnoVD1rqv3ZquiB3XssMIaluIrIDR6G8
         SHVg==
X-Forwarded-Encrypted: i=1; AJvYcCUDxRM5BvnG0yNUqI19cxAUlX753I6yDHkpi3Pti7kZr5q9IvqDgwMiZreMcGSM+F5qXe8XeTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyjqTrhNZ8CFa5XmsMmcaxf63g5cDDcstN9JpKLI5FnyV6F15
	npJpzBLXSlGsz7PGOEM4GcxOy7d40XcFzJgoXWw38gGLi9LZ4NqWhiXMdQue/b0=
X-Google-Smtp-Source: AGHT+IGJAZ2abLY3A+ePxucwhIPOIPVNEZwYUtaSndGiYueX+Z9ySXWSN9wDAthowcyl1n/MoONv3w==
X-Received: by 2002:a05:600c:190f:b0:430:53f8:38bc with SMTP id 5b1f17b1804b1-431255dcb76mr61160315e9.12.1728898264921;
        Mon, 14 Oct 2024 02:31:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43127a6ae71sm63892235e9.47.2024.10.14.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:31:04 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:31:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: vchiq_arm: Fix missing refcount
 decrement in error path for fw_node
Message-ID: <e9ccca49-c609-4d65-8609-a5ca3264ede7@stanley.mountain>
References: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>

On Mon, Oct 14, 2024 at 10:56:35AM +0200, Javier Carrasco wrote:
> This series refactors some useless goto instructions as a preparation
> for the fix of a missing of_node_put() by means of the cleanup
> attribute.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - Refactor vchiq_probe() to remove goto instructions.
> - Declare and initialize the node right before its first usage.
> - Link to v1: https://lore.kernel.org/r/20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


