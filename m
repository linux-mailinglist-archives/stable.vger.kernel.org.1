Return-Path: <stable+bounces-132312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB20A86AF4
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 06:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A9E1B85ADE
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6B188A0C;
	Sat, 12 Apr 2025 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEpzgaz+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D984037
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744433030; cv=none; b=iN6d4FNb+eXv7K5DHsxo1bB00bMGktaqlyuF+dHfy1vVNRNK0lOtFPnRsZIVdh5w6D54jVN89oHBJnmWuOOMyzzLnXscP66E0OrGeGn8JNNowT7sR5xCjdclClvskZAItwX/6VNshcGVQqVa8kZgyA4GReoyhDiLCEn1PZ9zMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744433030; c=relaxed/simple;
	bh=EylllJImv3qhzLeg7Hz3ocN2fi83rwMC9jhdkJm3RDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGvk0wb+btzAptxVsW2TNHNz27mOe/1cBce9S5L4qs7+o+5924GiBJ/+sbYhCSzVFbhmu2djjehLlUQxS6lVAzUTqbTJtoM0y0m4TMwbQjXXSXCx+xrJ+NlEH+3vP8603UMk2Cb3B3CgU6YxUo7DjP6/Mwz6qE+UDtJkmQu70+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEpzgaz+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b0e9f2948so3597e87.0
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744433026; x=1745037826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnTCsDVWU5J4Xw4ABLK6h0NzKq/dBZzCAzPAZFSnhMY=;
        b=SEpzgaz+3DEDWH3RUZ0cxdmerJuDZzGejGEcdGDo1PWNdM48Hy15Tn6Wy2dA0AGzdI
         Ht/NzzfAvawgMF71ST+ak/PozYgQ8PaZ6SP8pOUJcLdcDwbvzKamGpjs5LyKiPssPiVz
         ZWIWj8uIOQEY1GUVmLKqxlv1he+/SJi4RjpLoHaT2YT/AmrJInH3NpbnP5vUZfOs/DaC
         ht80H1KWevkt3mu45tQ0RjKv5abpFpJeWWK/OA4tSPYKJ0x9nL8SHjTIXS8CC3QfGydZ
         j3AMg/RyLknEeuofucC3kV54uLzNYacqPAW5PwM4RF4PNaoWHHGTYUfDm44ZVQ820cYQ
         hjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744433026; x=1745037826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnTCsDVWU5J4Xw4ABLK6h0NzKq/dBZzCAzPAZFSnhMY=;
        b=j7x4tHsrpYwevIO/lcb0xiMNbmmS8EB8poikaesSlj+pU9ZjZOsqAyphVREMLmhA7X
         KF8qLiZE6mBc72gdsK1C2wY5zFyHmgKW2S19xp/gOSVqiv9zRcydBqQNiFwxFGiIXjPP
         zg+1E8M79lZITV4HxhXCEeR8AgJQckOw24h9M1QzXTYIO1BMoX16q+PEFx0SJVR7cCUL
         COkD+oYCWUJ4fakBbnzwEqLGbjw7pISdDa2OG2NB2iZ+z1yhKciyHMh788o+M6Ktwqwp
         0DmfG+Bz9nd8fCEcKtBJjjElFd181GQK6ufsUECSrHNWIcRwnnVx6PJrvOEFZhDFBIHy
         Saiw==
X-Forwarded-Encrypted: i=1; AJvYcCVwccTKo2riLvEBTJvrNhusIWVDo6hEwEA0JEp+H+bP30HWIbXBez3hhfxworcuShrHt/Az/eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEdsncyoTAgOlm9iCQ7ZD8gx3f9htIfZ9ux1gJ+3Sm/JT0l11
	QpgqHovpTJahAU+K1WIsXh6vkGBEYOmKzuMcraTkBAUD+Qodci4ZgrfLAcH+hUVK437MLbtGEXp
	XhM0D96CNlFN+cbBIpJDBfNZ69UbBplMpuCGm
X-Gm-Gg: ASbGncvqff1o/bjeBpkRbvLVWEjGI/iOMUuGUNvQqAOsoB3TT9Ut0AfiwkzPJnT84dR
	hoc0Cw12YJs1lUEGvhQuldFPu2Ia1ryDgOM5/lFJD1NS1yez6Ma4gSIu8vOve1zyq65qQFqBpxO
	lLHnH5o5BM/Ds83gDOeZbwCMmj
X-Google-Smtp-Source: AGHT+IHnstA8OniMve4EXZITU1zVCY4y154h9HimNAz/Uo0RrhTicjqylKIFQodk/tjVtUv8odT9lNWzhaGFZHXckDA=
X-Received: by 2002:a19:4307:0:b0:543:e3c3:5a5e with SMTP id
 2adb3069b0e04-54d4b942080mr108384e87.4.1744433025987; Fri, 11 Apr 2025
 21:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327133233.2566528-1-khtsai@google.com> <2025041149-krypton-rejoice-bced@gregkh>
In-Reply-To: <2025041149-krypton-rejoice-bced@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Sat, 12 Apr 2025 12:43:19 +0800
X-Gm-Features: ATxdqUGbABxzaqNR9ApS36LdZlULbILlznZJz9K8NT1T8kLwQpJDLD7xl2RobSU
Message-ID: <CAKzKK0rDnEzeV0CuQdki3Gzh7yCvx_roHo4axfTYpN0V1Sv7-Q@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Mar 27, 2025 at 09:32:16PM +0800, Kuen-Han Tsai wrote:
> > When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> > going with the suspend, resulting in a period where the power domain is
> > off, but the gadget driver remains connected.  Within this time frame,
> > invoking vbus_event_work() will cause an error as it attempts to access
> > DWC3 registers for endpoint disabling after the power domain has been
> > completely shut down.
> >
> > Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> > controller and proceeds with a soft connect.
> >
> > Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
>
> Always test your patches before submitting them so you don't get emails
> from grumpy maintainers telling you to test your patches so that they
> don't break the build :(
>

Hi Greg,

My apologies for submitting patches that broke the build. I'll be
careful to make sure this won't happen again.

Regards,
Kuen-Han

