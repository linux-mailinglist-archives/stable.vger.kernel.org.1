Return-Path: <stable+bounces-16044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1183E8BC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F568285E6D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7891FAF;
	Sat, 27 Jan 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg7+KDav"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51C4680
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316533; cv=none; b=VcfRoJbQyZCkFw+jotkbYHiACVebzp0fuXiDiypW8OZRD1KsLj/ZS4R1mE3T3pFcZk8ytk8X4izN1fCR6Cw2R329GEJ338AU+Mj+guaYbbJTDbSWhq5pqA1GuuUQC3ZpHg7Rk2eHOy1aYHiH9iGmb9kf/1vpbtvqY67cmT2LIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316533; c=relaxed/simple;
	bh=gL85G7oQIrBOLuAHXySmv8gTdUx/orvDuAGHOivXeRA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oH9AYg4X8wTdDgmPNp05QqZeP1cnb1vQAZGEUlBWifPy5L9Rdw6F+ACowQuZgEZ4duLFT50TjPUUSkhpUXVnH4gGXk0LNdfcp4oZQRHDrzqgtuUx4u81I8TZKevPyFATJBmEUHq5lagM7sBtoxFn4uKYhBPd4yta9jUdgfdFjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg7+KDav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD36BC433C7
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706316532;
	bh=gL85G7oQIrBOLuAHXySmv8gTdUx/orvDuAGHOivXeRA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Pg7+KDav8ZniQ4LzeRQ+SCv7GpjGWg+TPPQxGOyBY8uY/sg8L5P2SKr2ZgoL1n3LK
	 d3O1V8fnDa+0lB5MfUf6p9M1ECgWe3AIot5mJjkAuIsVtoNAw6gZ66CUQD+g2TX2Fn
	 SnmWQ4EXNleh0gN6Z2ZW9TAhorsMH0ROcE4UHiptpU7K+7enNklvQ7mXvhbtgf5f57
	 /ExSQ/FoN4wl+6bHuW15F5Zq/qryOv5hOF/IaFW1FkrNZRXFy92gzJhPGoMFCqakoc
	 y0zbg2rZp1AXz7UZXp+2kPaPq3F+PjcX/ce974b47N30jtahokcwEVemD82NRmJxxr
	 z7UEBlBpK7sdw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a181a46b6so251915eaf.0
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 16:48:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxvzOhp8Wl4i/hiZw60lG6XdvOemg8wqUaI1em8Ij2IPlM+7Rly
	hc3qlN1/6YA8aDQROuNO7rV2xZr1UWG9lXRVtF50OFU7LVCq+FtXfIgUvFHbYgpbskhNMzBKRZP
	A3UYgIYCXsLtzF+zMpUaJ1CZH2+0=
X-Google-Smtp-Source: AGHT+IEoR0od/GI+jl501lR6W6THDbw+KgK0UE66nSqE5SQLdB8B4UrNrMd54/8p5VjIg/LUSRJx5WsnJN8ZH1HZRlI=
X-Received: by 2002:a4a:e60f:0:b0:59a:f1e:9b3d with SMTP id
 f15-20020a4ae60f000000b0059a0f1e9b3dmr529602oot.2.1706316532211; Fri, 26 Jan
 2024 16:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5984:0:b0:514:c0b3:431 with HTTP; Fri, 26 Jan 2024
 16:48:51 -0800 (PST)
In-Reply-To: <2024012614-gave-liking-6c12@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org> <2024012246-rematch-magnify-ec8b@gregkh>
 <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
 <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>
 <2024012537-pastime-bobble-8a7d@gregkh> <CAKYAXd8TKpJVD85rU--oCsO8Z=2iUnu_2e+mmjaTU8xTc1X6sQ@mail.gmail.com>
 <2024012614-gave-liking-6c12@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 27 Jan 2024 09:48:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9GCuT=oZpkxbdqaGZXq8LtfFbtMG3e8u5ZJzs=D+vrkw@mail.gmail.com>
Message-ID: <CAKYAXd9GCuT=oZpkxbdqaGZXq8LtfFbtMG3e8u5ZJzs=D+vrkw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-27 9:43 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Fri, Jan 26, 2024 at 10:59:17AM +0900, Namjae Jeon wrote:
>> 2024-01-26 10:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> > On Fri, Jan 26, 2024 at 10:25:36AM +0900, Namjae Jeon wrote:
>> >> 2024-01-23 8:28 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
>> >> > 2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> >> >> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
>> >> >>> This patchset is backport patches from 6.8-rc1.
>> >> >>
>> >> >> Nice, but we obviously can not take patches only to 5.15.y as that
>> >> >> would
>> >> >> be a regression when people upgrade to a newer kernel.  Can you
>> >> >> also
>> >> >> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
>> >> > Sure, I will do that.
>> >> > Thanks!
>> >> I have sent ksmbd backport patches for 5.15, 6.1, 6.6, 6.7 kernel.
>> >> Could you please check them ?
>> >
>> > Give us a chance, we just released kernels a few hours ago and couldn't
>> > do anything until that happened...
>> Okay, I would really appreciate it if you could apply them into the
>> next version!
>
> All now queued up, thanks.
Thanks a lot!
>
> greg k-h
>

