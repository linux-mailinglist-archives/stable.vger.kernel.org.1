Return-Path: <stable+bounces-128443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA65A7D360
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249C37A433F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 05:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD412222B4;
	Mon,  7 Apr 2025 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="LOWI6xHg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FF221F3C
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002906; cv=none; b=qOEhEe0YirpznCGhgJz7NdAQYn60kiGjLX6zwe0JEEVzqW3FXC5Ts9qL65/WgyMDMW9I7LujcmKSu/ewSRAoaBxk+1d15In6vtDUqGe/Z03ez8TZmhSaHCiI9Samo2Ekp5iB3jYsIVttGRas+ZUy+Vk4lRy4uQoWqcZBtnUIaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002906; c=relaxed/simple;
	bh=ZXqXd0MmLMI0riqS8u9RqcWyfJDPqI+oGhc85RczZVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPuPMHcs2Y6Q3uQ3HJbvk0eUxipNo95GOGmfohPw1OFZVMxXZ1lQZCgq7glZlotstr1+sIMjYkrVGbyuD39/aSOA538Waz6vK+Pj7mhrwG6OYLKhi9t5FsIg8ZE148AdHlPI1c+cHGEWvdd1Mr8IhZNwyqk2rx2TpuZjqfYzJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=LOWI6xHg; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b8e2606a58so2214878fac.0
        for <stable@vger.kernel.org>; Sun, 06 Apr 2025 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744002904; x=1744607704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEEmoqINK7WIXpxYhOtUxFVJ9mT6bhXNq+L2ySzPZWQ=;
        b=LOWI6xHgb30YWC3dS/h5rKVm6ldgMYQ49547rx2iC48BzG6f+VnD75Y8h6kb2ogO6s
         43DAKfZ9AK+oixp9SQAXMTdDOu1bDnIYjtfcCFw2rGy4VqSfT78MEfOB69vRBlj6cRtz
         1B08cehHth3NJjVMXGU3eRO751+qxW35VNdFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002904; x=1744607704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEEmoqINK7WIXpxYhOtUxFVJ9mT6bhXNq+L2ySzPZWQ=;
        b=st/f5b6jgNDOzd7prknG+onbWRKAxE/0jqmOB9CE5hegLh2sORUXqJ14vMMYXkRzEW
         u8+ZD+9BpRFaiClAgHY7xMltXYjQHMqdduG/bs3rgSirNNUU7ccI9jNAIDiGEKZr7btS
         0odIQaDPnP4Tpcdb76HnvU/rF7TPXbLELUCYzZrXk4NcZsr3Mucegqb3x5olkDlFC5gc
         78+9XJkmpP275z1wZPJWUFiSGFnT5jXbCAiqzue2dAzIGrqbDnCZ3RKUg+nlo8MA6b/A
         Ae6DH/zGFbtTIevNmP1ddUyAnHIGE3jUNKPXOTx7dX3lzfP4ZovuJxPO2fUWlMEPPfRH
         CkzA==
X-Gm-Message-State: AOJu0YyPTlSg/lWlEHypNEAsiYuDENuFlzADhRaC7JhtI0xbJ0jVrWK/
	pxgkU03n+mk5XOqBcd7mH6unJZllBpOtxXcRNPLMzhsbysd+sgH7xIX1BnI6o7mvqp5zO9opasT
	akopXgNtOFOkfQah/VaVY8a8wJYx8pplpqvC27H22Jd7nyyq8lbg=
X-Gm-Gg: ASbGncvqY8siLwpZ8kbDfDMqxq//D5OI6XLy75DvMzCsT8N4FoYoymKWY707EmuCjEy
	KAYUUpV5xuVke7pJhL3ozI6dUy9ZCHCTlfbWK9FfxYU4XZE3qUdBzEZw240HAI1LRCRWSLCk4yX
	HH4lubuarDvcyYnoDKqmw9ENfWsDAuiIX8Cbnp377QV0WYqsPfFov3NrktUYcDcxR+xXRo
X-Google-Smtp-Source: AGHT+IFevmckQxonljA/suLBbBJS4//iIwwtfDo8gUL/OaDJQXDR7wjASQhs81Li1yLcQYQC99aam1v5SiPrlqvmJgc=
X-Received: by 2002:a05:6870:b9c3:b0:2bc:7797:aa95 with SMTP id
 586e51a60fabf-2cc9e65116bmr6511016fac.20.1744002904114; Sun, 06 Apr 2025
 22:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH+zgeGNArHoJw4rfd+Q-WQhv_rk+5wke7kYz_LaXNjXNocQew@mail.gmail.com>
 <2025040350-rink-overcoat-4696@gregkh> <CAH+zgeE=rLJ0U1hq264tXwQri-hngdt0NsFa50WyRGt4FD3gfA@mail.gmail.com>
In-Reply-To: <CAH+zgeE=rLJ0U1hq264tXwQri-hngdt0NsFa50WyRGt4FD3gfA@mail.gmail.com>
From: Hardik Gohil <hgohil@mvista.com>
Date: Mon, 7 Apr 2025 10:44:52 +0530
X-Gm-Features: ATxdqUHKrADcrE6Nt2_Wp-m42t2Jgd7VffsZFfUX_0PLXH50j726Cpdgy9IK-Zo
Message-ID: <CAH+zgeGRpPJ4yEAheYfs6VaEbDgiZvy6Qk6AFxi-8yYGPs-gQw@mail.gmail.com>
Subject: Re: Request to back-port this patch to v5.4 stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

My apologies!  I'll test-build it before submitting again.  Thanks for
pointing out my mistake.

build is failing and there is a need for a dependent patch.

Hardik


On Mon, Apr 7, 2025 at 10:43=E2=80=AFAM Hardik Gohil <hgohil@mvista.com> wr=
ote:
>
> Hi Greg,
>
> My apologies!  I'll test-build it before submitting again.  Thanks for po=
inting out my mistake.
>
> build is failing and there is a need for a dependent patch.
>
> Hardik
>
>
> On Thu, Apr 3, 2025 at 7:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>>
>> On Thu, Apr 03, 2025 at 03:36:05PM +0530, Hardik Gohil wrote:
>> > Hello Greg,
>> >
>> > This patch applies cleanly to the v5.4 kernel.
>> >
>> > dmaengine: ti: edma: Add some null pointer checks to the edma_probe
>> >
>> > [upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369]
>> >
>>
>> You obviously did not test-build this change :(
>>
>> Please always do so when asking for patches to be backported, otherwise
>> we get grumpy as it breaks our workflow...
>>
>> thanks,
>>
>> greg k-h

