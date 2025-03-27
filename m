Return-Path: <stable+bounces-126838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AEBA72C93
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E560E1898FB4
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABA120CCC4;
	Thu, 27 Mar 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZmw8cvb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A221CAA85;
	Thu, 27 Mar 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068092; cv=none; b=LKwUqnZ+UDRs8jeKup0H3BNlZ6/lFWHa9ytSkqltaefbf0MpHgelrlYvgjpoFip4uX4Hsxh2zxF46YryDxwEGq0wgRb8vXz+iAK5+Sc8jucB4EGFnZy87yL37UZHtqAPmWGTtFYhc+2xZ1XzWArT9Ly9CBHnkzBogYd6/+s1Gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068092; c=relaxed/simple;
	bh=feahf2RlNjMG7TuzyyRQ7CAEtCk2y5mQ9bTEbE1vmSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQIHt9zDG2qKEPHEeMImNiYYfIDEzFoEZcXYmit+Wu6DbiFTbhoGe/70K39ylr95EOUpMS/Z4Uckid3Z3QNGjkCF26l+L5E71ditO/2MND6iCY+SfoMi4haeK1WCNWFai3mcw2ANRfWVwsN5rRjqgkdeGkE1qRO4kZnZvPWOswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZmw8cvb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so736461e87.1;
        Thu, 27 Mar 2025 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743068089; x=1743672889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwthd6DvDSuYnlEHZsEaCsrecTV0g5QhuogV3nNKmcI=;
        b=cZmw8cvbRWqSHx/74Ffc3gs+P6O/to6eG3xun2W4/JMbm0WyPJr0q+0bOz6uLFj/v9
         nVW5Y3myodnqA4OBGpTj+FivqN8DDqz94LwOmIg4GjWwoDn4wIn5WQuNXT/cf9P6dOJg
         P9GzTKGTMRRdNqL1LbyB8mk9zc6mC88lH++TCOZ0LMkfPMaDsxaKeUyXxqYNDTkcBI6I
         c8Nox71k6pnBmsO22tp+Wog93NePFJirp0KN8iL2u4qDls0jvabxa46zFS8L481UQmi7
         Hrewuv6YyLTpU3ZLY6QZkN06kl2fFDJh9cFyquGSm3eSyFs1rH6ABCpQXCDFqGzwz5fF
         TG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068089; x=1743672889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwthd6DvDSuYnlEHZsEaCsrecTV0g5QhuogV3nNKmcI=;
        b=IF4jO4UnGSYF8zFfmEQ/R6Xu4Inm4uHsZYpjDLnEV7kxGsDxU97rNLnHHcfX7RWRjq
         dUh9DOFgW/kJhSec4nt73xMfC5I+pEkGnrFqRC3j4s1/eC/KMp8l2z4O4H+c4paYwfe7
         XJp0ioMtPPJVeNH66MSwmlSSoIJ547F9vMaKDxfQQVdW4C0KQRiAao25MQyM5P1gaYzg
         5sEsivwsCQjZbE2x0VlsD2k3MCdlrQOm2fg9FQZg4Dn0Hr2+JwOY8wPBmyU6pmqGdbRZ
         eelgVUUQvmUIxVaen4ZzcunVv7kfed7Tg6w3HRZqF28ruccSgTB3iTuAlld2oiiBk16T
         q1qg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7Xq9awTZ8bif5UjzNDog95tKPBJfjV1t68JomRxQqTS4lNGkBc5hU6N3Ve9gUrbX7o/n3NRk5vA9@vger.kernel.org, AJvYcCWq8rrgEzOyakdN34ZpzAIgWRaV0xowl07XUE9Yl71oE8ytc6wFAAIcZOV1HlD4dbfyHrml/IsvciuTFPE=@vger.kernel.org, AJvYcCXFETA2Cuqd0soz/W1x1+wMU3lu2w4UDvaSrvcIkN2qG5Jfxxa8MqyLC3VG2RNBhW29/9IbEcUc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7lBXhnt5RV8bsH2Z2y2t/a5g9NBt0vRCdy0tMCRcqaeVQBGh
	FiWKdNXzZmNeq/woSI3mvmtpg3VCDwjKfJLP/nKuImJtafrbF/nQ
X-Gm-Gg: ASbGncusxeFgLf8DIR0XvV/WSNDISi7eAI5mLlbFsXSa5fvxEEMiSiUK3Wfg5mvQAwd
	RS5DZcHxhUhPf7PU80XSWzkLdqtpKl6DTcNoqGYuP9rmV2QDve0l7HrEiRktJoyYfJE1t6+PUH2
	T7dyuFlr8FscQyMFkoFlf4rStZae0Nww1bBd/qLUMIf4XssWrje25UdsWYCK+LsOlQPiwgPoD1v
	cAiJQLlWa9FWQfA0P1kKHUthjWsqdiVFfS1GZhVBqkTI5VSct8ZzZBNYGjBRrHEO+ioVKl5f5DQ
	OtFmrLGBFOHXbekePHxT2hQo0SwaCeu04M2cCfiscQkXg5YG0UHrfiErDGngFw==
X-Google-Smtp-Source: AGHT+IFwgZ6kYC8A0WndQ549KjcP1lam1V9gB0x42xLQC3LqdXyaaWkYCCa3Vu+K+wV3jCMbpRX8xg==
X-Received: by 2002:a05:6512:15a6:b0:549:8f47:e67d with SMTP id 2adb3069b0e04-54b012435a4mr969722e87.34.1743068088708;
        Thu, 27 Mar 2025 02:34:48 -0700 (PDT)
Received: from foxbook (adtt243.neoplus.adsl.tpnet.pl. [79.185.231.243])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646931esm2034295e87.42.2025.03.27.02.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Mar 2025 02:34:47 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:34:43 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
Message-ID: <20250327103443.682f4cd1@foxbook>
In-Reply-To: <bb78e164-f24f-49d2-b560-24d097cb2827@amd.com>
References: <20250326074736.1a852cbc@foxbook>
	<bb78e164-f24f-49d2-b560-24d097cb2827@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 12:08:53 +0530, Rangoju, Raju wrote:
> > What if there is an ISOC IN endpoint with 64ms ESIT? I haven't yet
> > seen such a slow isoc endpoint, but I think they are allowed by the
> > spec. Your changelog suggests any periodic IN endpoint can trigger
> > this bug. 
> 
> If such an endpoint is implemented, it could theoretically contribute
> to scheduling conflicts similar to those caused by INT endpoints in
> this context. However, our observations and testing on affected
> platforms primarily involved periodic IN endpoints with service
> intervals greater than 32ms interfering with ISOC OUT endpoints.

In such case it would make sense to drop the check for
usb_endpoint_xfer_int(&ep->desc)
and rely on existing (xfer_int || xfer_isoc) in the outer 'if'.

> I'm not completely sure about this corner case if HS OUT endpoints
> can inadvertently get affected when co-existing with long-interval
> LS/FS IN endpoints. Our IP vendor confirmed that LS/FS devices are
> not affected.

There is also a third case of a FS device behind an external HS hub.
The device will look like FS to this code here, but the xHC will need
to schedule HS transactions to service it.

Regards,
Michal

