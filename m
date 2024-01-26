Return-Path: <stable+bounces-15855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B001083D207
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D771C23434
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575EF64C;
	Fri, 26 Jan 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxHKiUCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18770387
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232339; cv=none; b=JjGa59kHtisaNDxbXJwFg+p7p4RyqxgUB9xze6fC5F64zEci38yvlwdlBUDuDG8AlsyNb01iAQB5G9doz7J8EKooBdh4HQ4Z7y8cpfwlVs6fIeeOG/F0MsoUok2ac3F5HT58AJNTCJ7Ga8nXE/eeL2gabEOCC6PWkHIXyiNuGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232339; c=relaxed/simple;
	bh=TFoAQsFJNDG4zjawbmhRmZZ6FKGRxULtj3mVnE4u6ss=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKroUIFyPZAW2NJaqidts8Y+kHiIah0bIwlTzSr7dIlzdfnrufRDAc5XkDzfavL/NNjRMtTbUhhT6dZ0EauAZg8g4WPiZL01CZBwV2Dev/qmYQKSbDh5a8EiwV+O3y4QwyFa9a0SkYSzAjsDcp8fmgc61vhb1CB+durhq1zIdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxHKiUCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038BC43390
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232338;
	bh=TFoAQsFJNDG4zjawbmhRmZZ6FKGRxULtj3mVnE4u6ss=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=bxHKiUCZyrC15gzMR14BZa7BrwdzJzqxP/oJCHaejMqTm/hAug89BwW0bDA7fISog
	 NXHVjP8zXZzlwxt0njLht2NzO179Uymz+yBARHU8ZclTavs1oeLPhXvfl+cI0Rfile
	 nsXkv9b2FdpnDhAkkIYxyT4uaphJy9oD31DxI9z3Cdyi+lgUq7lrr0Uqhyj05Eo3wV
	 QQlEUn7S2nWB3Mg57abuoPVy4ntRYJASgdDti8Sb+jGF3su3elKRxDROF9gLb1ZX+9
	 nPB496K3KdCr52LZo12fEY/4S+w70cB+S4MsKq8xEbuenE/Zt+DLwJmw48Issqx20Y
	 0EMtpXTuJm0kw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21533959f03so42560fac.0
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 17:25:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyEDrv0oHzeXv+vnD8yb2SnN64rJJhJfxIybjYyj5LmCPJkg45g
	8bMtPa/9geUcPBT+YvzPPXWyE4XsGFE39RV1aTduIw8uWQEAZi4ijQ/94ZbWTyEsgFSyuc20UPE
	Q7onoJ8HJjsgvGnjae1TBWoZO6tA=
X-Google-Smtp-Source: AGHT+IH3qxnpD3Nq5DHRK1RKU4+djPbg5wo3FwwiWQKFlo7LIF5q1Gw5/NUMluw6qt+DM2oUVOA8AwXNsutLLm7vxp4=
X-Received: by 2002:a05:6870:d38c:b0:214:876a:a517 with SMTP id
 k12-20020a056870d38c00b00214876aa517mr580047oag.35.1706232337811; Thu, 25 Jan
 2024 17:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5984:0:b0:514:c0b3:431 with HTTP; Thu, 25 Jan 2024
 17:25:36 -0800 (PST)
In-Reply-To: <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
References: <20240121143038.10589-1-linkinjeon@kernel.org> <2024012246-rematch-magnify-ec8b@gregkh>
 <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 26 Jan 2024 10:25:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>
Message-ID: <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-23 8:28 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> 2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
>>> This patchset is backport patches from 6.8-rc1.
>>
>> Nice, but we obviously can not take patches only to 5.15.y as that would
>> be a regression when people upgrade to a newer kernel.  Can you also
>> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
> Sure, I will do that.
> Thanks!
I have sent ksmbd backport patches for 5.15, 6.1, 6.6, 6.7 kernel.
Could you please check them ?

Thanks!
>>
>> thanks,
>>
>> greg k-h
>>
>

