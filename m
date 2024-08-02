Return-Path: <stable+bounces-65288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBC945950
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70086281E8F
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1E1BF31F;
	Fri,  2 Aug 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxOO8Z4Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FB335C0
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585323; cv=none; b=dDMROK5WavK0IAUG/ao0Ca3cq1aWMbutgs4iW8Ei2TNCjFfJQPP/UEuDhPCNDlfOd35UwQ2JI6TP7w7rRm43K6QourhSOMuCEjgnhVTB/QdcxL2yFD7Mo9EXtuIznJT0b68N4s0t4mwyLh1QoqlL6Yq5zEreDNN1J+kgPd6VHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585323; c=relaxed/simple;
	bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/nD9VcZFtJflmdhbz+5sj8OuSsMtSiWh3Dgu8FaFnobiy5usigANAqiIPaG/WkMfMwPFXPZ6019iMkaHTkFOrTbsWR8fQ029qf0MiRIsljMirWafsBm0kCjdeoo1HUI76qEQKqmqP7E2DoMWRZkUwC5N1O7+K75fbIH+QjlUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxOO8Z4Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so47405a12.1
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722585320; x=1723190120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
        b=IxOO8Z4QN7j6f930eC7rpOTxLDaqkdVAKGkbNMGmDTdwCBviQO4h2yo/5b94jMdSEz
         fs2fVZ2kHhmKub5KhXgFtrw3TtoR/YVxMTrt0iBY3TFkmFzFoKxYR6oVJBgGBsAtqqq/
         /1L0ba9BeC3SJ+nyFZg2THJzGJ8PWjBKspDq+Ig0zRbihFnQPIG1qNd8z9CxSqcrl5n6
         c0Vy1Fg0TSEIqUpGQ5b8dr+IfOWGCQ3eQOtP+V3vxqEg2nbkYUC1fAOK+GSaY/s0B11c
         8SkUVIboTGltSXoCP29A/3ZL+CpaL1UxalXiqSUrrxvN2aDYQX86D0TvUycH1spMAfcJ
         E4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585320; x=1723190120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
        b=GdjG7wQ3A1iRa98NqImdjSoHWw3aA81yIXDsI6urxrU39ny3K4sOml3/JXHKhFNYUz
         Ofqng3sgPjsiSJHcixUd8sL3E3ImapBTx5LLGAPY9+/hQpb81BOz8x4PhMuylgPdF6TD
         KMRNTJh45KwBTm4MZEc6vyKlL/vNxlhMO3VOvVY0iHmq+ZG2YkAusAN+sW44Muw47zp5
         /ImiTe14TjMq6WcKDkio5E/Tnr4mx896MHt7LYIxY3/Ybb8lYss95o/Ci0opM5JjeqnH
         nUXLkT5DatyfinZ/OC9MezFqZUGCYzLaQEPc1LgK2PGaayZWOkWZbb4zjuDY8s6iJkG2
         jWaA==
X-Forwarded-Encrypted: i=1; AJvYcCUDCHFLpth+4Ivhwmr7A6S0iUVLnMWN0APogEsxe34Bh9sVHNBOqFjCuIMa9E+StmVljlls02DzQ0iaHpMT6F1keEfK9OpP
X-Gm-Message-State: AOJu0YxLDGOVBOSIS+RdX4zKmVw+mpjXQ7tyKyPS3akMQlnDvB/Id0LI
	9kB4L4Aw/S/4dxwWK7ofnc7U/526o6GXVSk4bzJDbMm3ZQIdowK9Q+SkGa+0AYuQT/6y2MK5uqj
	Ow34UWItitLz61wjyQVuuf+ZY6CO1vOjXwNpY
X-Google-Smtp-Source: AGHT+IEGTXiHBDLKYnZL05d2aE7knTVbal5f5V1FrC96v7hLWqCF0MxevZVGa4yTDO6PcXVZPZ7GWMxPH/x+DmFJ8pg=
X-Received: by 2002:a05:6402:51cf:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5b86752ec46mr107321a12.0.1722585320222; Fri, 02 Aug 2024
 00:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726122814.729082-1-kyletso@google.com>
In-Reply-To: <20240726122814.729082-1-kyletso@google.com>
From: Kyle Tso <kyletso@google.com>
Date: Fri, 2 Aug 2024 15:55:03 +0800
Message-ID: <CAGZ6i=165A5k59MKqZxH4DvB8XNsZJ+26_0SuMZ+hidam2qRLA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Runtime get and put usb power_supply handle
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	royluo@google.com, bvanassche@acm.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:28=E2=80=AFPM Kyle Tso <kyletso@google.com> wrote=
:
>
> It is possible that the usb power_supply is registered after the probe
> of dwc3. In this case, trying to get the usb power_supply during the
> probe will fail and there is no chance to try again. Also the usb
> power_supply might be unregistered at anytime so that the handle of it
> in dwc3 would become invalid. To fix this, get the handle right before
> calling to power_supply functions and put it afterward.
>
> Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v1 -> v2:
> - move power_supply_put out of interrupt context
>

Hi maintainers,

It seems that there are some problems in version 2. I will send out
version 3 later.

Kyle

