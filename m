Return-Path: <stable+bounces-15857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631D83D24E
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 02:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5B31F235EF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0B10F7;
	Fri, 26 Jan 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Y262r+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D028F77
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234360; cv=none; b=bfNA0DyvfAzjHPmmtXeiY0kOwRbyheuXLvD6A0CCkuiv+FQcjnjbAeLU51l6z6NELKuM4sw/zSbn9QiicZevl6D+psB1Rvi0fkn6hog8GJCR8eTdGljfPY7Pcv6ExD3+C1DnYSZ5FhaGujvJVW+1SjZ1d+aNU2igESutR2r3Hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234360; c=relaxed/simple;
	bh=qXZfh05rbTscxTbFEM6t8UOtJydLtV6MRaLH04htwqA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxhOX6Vx5rM/f752PjWnlhTMogiPiUaSyLNajiN4LkjlZHEJ8PwJlTmx9D2flL2EboSUDAmCywIgF6W+YFUn4R4OoJbLoQb09gOg+92ygUBvAvpv+mY63zuIMy3B7w14MgJ7YU9ynso4h1bCP2FCTPdfgUp8ziTrM04koQmenzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9Y262r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF7BC433F1
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706234359;
	bh=qXZfh05rbTscxTbFEM6t8UOtJydLtV6MRaLH04htwqA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=S9Y262r+QZgRNuGwypL1kQGtGQasRb4i01rqDswCIqhkHztyWXiNnPNwBaZA8dbUQ
	 9qptYT/9d8Qxnd79hfu5v0kNpXoCBO8WwpV9s3yq8plTWE9AZGF8zxdebhP8KoV+3b
	 UHBWdN4gW3kB2towe0Gg6MtpYUNx66TQmZDltlHdaeL3VS4VkWGm9nWPgNsLYss4u2
	 XuZEU3sFzObwArq94maB1bGxessHua0DVqi0yKV6Ekjjc8MRgJWg+Y+2KiX7gb2D1k
	 bmF9YmJ8C9HFPqkRRa+lzzv7uygusyuSJsz9HGB6UjvnhRMMRHAeTT6WDRx4wL0NDd
	 TWV+hLEUSRAtQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-206689895bfso3948693fac.1
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 17:59:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwSAyLPeBscabAJdoOO5rDsaoQCrGYYOT2Q4sUJzX0/24iWvEtn
	Tbe6nND79y4LQnrLps4cbutSSKGdo/YxNutfBQ5GuY1eoIo37SEHU66Zj0WjI70KzoHWHxvlvhj
	I6yFLH2RWqjDPNIC6jq9OWrlDKb4=
X-Google-Smtp-Source: AGHT+IH+4r405S3b3B/LtNuAED0IJ6TjzgSral2dv2Vhi6vE1scgHenkgIhJMyjIGLErJv0FDdLaGIypI38fPnJSoxs=
X-Received: by 2002:a05:6871:70d:b0:214:d132:a5f3 with SMTP id
 f13-20020a056871070d00b00214d132a5f3mr524907oap.100.1706234359081; Thu, 25
 Jan 2024 17:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5984:0:b0:514:c0b3:431 with HTTP; Thu, 25 Jan 2024
 17:59:17 -0800 (PST)
In-Reply-To: <2024012537-pastime-bobble-8a7d@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org> <2024012246-rematch-magnify-ec8b@gregkh>
 <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
 <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com> <2024012537-pastime-bobble-8a7d@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 26 Jan 2024 10:59:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8TKpJVD85rU--oCsO8Z=2iUnu_2e+mmjaTU8xTc1X6sQ@mail.gmail.com>
Message-ID: <CAKYAXd8TKpJVD85rU--oCsO8Z=2iUnu_2e+mmjaTU8xTc1X6sQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-26 10:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Fri, Jan 26, 2024 at 10:25:36AM +0900, Namjae Jeon wrote:
>> 2024-01-23 8:28 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
>> > 2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> >> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
>> >>> This patchset is backport patches from 6.8-rc1.
>> >>
>> >> Nice, but we obviously can not take patches only to 5.15.y as that
>> >> would
>> >> be a regression when people upgrade to a newer kernel.  Can you also
>> >> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
>> > Sure, I will do that.
>> > Thanks!
>> I have sent ksmbd backport patches for 5.15, 6.1, 6.6, 6.7 kernel.
>> Could you please check them ?
>
> Give us a chance, we just released kernels a few hours ago and couldn't
> do anything until that happened...
Okay, I would really appreciate it if you could apply them into the
next version!

Thanks!
>
> greg k-h
>

