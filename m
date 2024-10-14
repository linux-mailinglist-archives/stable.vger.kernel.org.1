Return-Path: <stable+bounces-83746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F899C394
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B57BB2572C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26914B07A;
	Mon, 14 Oct 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn6rA8L3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813114B086
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895191; cv=none; b=bgjx9RBsZVU0XW9we10LbvUefJ5rw6eT/cU7HaPtJzEsURj+iEF96FzdTftP3yPn/4U/WDUkWfD6l6grjLc2q2wGj8tRohX9C0S4fanMOegoZ1opzZoQERRSg3J8w1UKeSsJ9vGK11ynydwA9CU0H3PLyVwmkfRzf5RNlP+9rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895191; c=relaxed/simple;
	bh=j5KMbLgM/cSlGqVgmYOvM8MYfFCjZQKVkWvHc4WNE28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJgo5n4a1faDc3oBb38R+hVjQbhzHOP3o0WFeJBf5Vo/ZZZdo1zVVIw313chx9Urg6wON4PZUG+L0AJPSRLQ4c3BhZMvIdJVXJU1TBzawgnitTsPiq1/zGUs1RQ2IO2tn9R07rfIKRveuAWGGOO2bRPibfB1mASOwNIPNApcofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xn6rA8L3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0474e70eso165261066b.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895188; x=1729499988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRVP8PnREQKgMzWy1TiJYpVDO1N8UeyJCGoiVpxt1nM=;
        b=Xn6rA8L3gSSWJbDc/53AjH8PYuU5tlpmy2JPWbbBNVDeccx8WLLzc/Decr1dFoCkk6
         yT+OXUIOO6jwK+962d80mU/krg/SGJj0z8P3gzjY6tekNx+z2I6jTk1lBykcKqqi0b3z
         W5kL9qFdmTl4gP2JRtIveywYdP7bWPI6eFzaDcukCb+QANmuUGv3vsybU6GAHzmrdwDJ
         Ig3/feIsBxgavjwGDOn/n2rB6cfVgW9QY3/mpWmeZ6ZAhbB+wDKbTEL26JC9lx6HVQo6
         GdLiNO0MTkODxmD7ryGsExPcbp6+Rwtdf7SqazGMrSJ6qs9Tmc3mmUMUWMS+Xzgo65wb
         zLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895188; x=1729499988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRVP8PnREQKgMzWy1TiJYpVDO1N8UeyJCGoiVpxt1nM=;
        b=W3VUHJNab3c70o0pBKwgvS2RVfSqzM3IaUdhHoFMlORA2WLlqpaPHw6WR44GSNuIAU
         qyFVQgBy8SaV0/yMxbK8h7LFo8P5DEAJjOK+UUrR7JP4ZLzdqH8G+0Dj4YS4hO81ujBH
         bswcmlXxcYnQOJaPqtMv0l/l3Zyu96GvODNYKCemIrIvrAS5lC/GZpfRPr6gun90pSrI
         uBL8cV265TlB10umyqoEZ9e3gJoJLIQUWaZ6j96ed5oU5xNxHUuRLmPRa5G+ZrzJwQAy
         pCvCNZhVw4rtWaXs5xb9jNz7SoldQiPtPAMmSnXml5NmVz69aGJOOHAZ/fZdgxF9jMqj
         ws6A==
X-Forwarded-Encrypted: i=1; AJvYcCUzE3z0j+3XmswneMh4u9+3DAshdBOk9uspN4+50X4zFYG6WgHJp9iuD8c78iPhVoWD2FiZaUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKxH86lzSkIb/up1Cq3xxcv3wueAojAaSMSE/gFS8LnPelpo/
	XtJLB0zj055WPPXQ4Ryzjst1WgpfmvYMXHn87dZvjT2OI37dzOoiCYCx20gFe4Q=
X-Google-Smtp-Source: AGHT+IF/zFtsig2aX112+izRkjqLmgdoEyL1+SlRLxD7y4x/PjYyilPPAsZa/YaFD38CdWCPTvN9dw==
X-Received: by 2002:a17:907:d17:b0:a99:ee42:1f38 with SMTP id a640c23a62f3a-a99ee421fdamr662474666b.31.1728895188121;
        Mon, 14 Oct 2024 01:39:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0e1913a0sm121377066b.75.2024.10.14.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:39:47 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:39:44 +0300
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
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Message-ID: <20d12a96-c06b-4204-9a57-69a4bac02867@stanley.mountain>
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
 <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
 <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>

On Mon, Oct 14, 2024 at 10:15:25AM +0200, Javier Carrasco wrote:
> On 14/10/2024 10:12, Dan Carpenter wrote:
> > On Mon, Oct 14, 2024 at 09:59:49AM +0200, Javier Carrasco wrote:
> >> This approach is great as long as the maintainer accepts mid-scope
> >> variable declaration and the goto instructions get refactored, as stated
> >> in cleanup.h.
> >>
> >> The first point is not being that problematic so far, but the second one
> >> is trickier, and we all have to take special care to avoid such issues,
> >> even if they don't look dangerous in the current code, because adding a
> >> goto where there cleanup attribute is already used can be overlooked as
> >> well.
> >>
> > 
> > To be honest, I don't really understand this paragraph.  I think maybe you're
> > talking about if we declare the variable at the top and forget to initialize it
> > to NULL?  It leads to an uninitialized variable if we exit the function before
> > it is initialized.
> > 
> 
> No, I am talking about declaring the variable mid-scope, and later on
> adding a goto before that declaration in a different patch, let's say
> far above the variable declaration. As soon as a goto is added, care
> must be taken to make sure that we don't have variables with the cleanup
> attribute in the scope. Just something to take into account.
> 

Huh.  That's an interesting point.  If you have:

	if (ret)
		goto done;

	struct device_node *fw_node __free(device_node) = something;

Then fw_node isn't initialized when we get to done.  However, in my simple test
this triggered a build failure with Clang so I believe we would catch this sort
of bug pretty quickly.

regards,
dan carpenter


