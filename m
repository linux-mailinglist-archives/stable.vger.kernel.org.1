Return-Path: <stable+bounces-6733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED0812E9C
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E96B20BC6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A893FE3C;
	Thu, 14 Dec 2023 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBptTax3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C43C473
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 11:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F368C433C7
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702553630;
	bh=vjNBT8wTLC5VPpxx0FjDawHmbm3bpYIkZ6tsa+5BeyE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=ZBptTax3qeyYN/51VnJB1JU8Fo9OUeOC9d0pcHFJRF5Nu87lsqNZ8hKFrqOHn0+Hm
	 WyJVznDT1kZuoCsew64qFAMy50uBTSsHk9YvZku1HfKMDY2siNRnpZflCvm44vIYAa
	 7wz5DRv9pHlMxUNjqBZU7dqJ0yFhEaSfrB/9ArBF6a3V9LmTLzfd3I3hlHKGp/CD2S
	 KGkpvAkXai5HYjOjI5w4+1e049wyFCygCJhHtip3hZP15zJEPIBd6ZtLQzGuERHTm+
	 eWVG7qzBJFb6IfY8qe2SHW7EVSeSaY1LXow36NMmPSsKfH4ClwJs8l7qyaiDh1i84M
	 SyF5xRkZEx2Tg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59052ab970eso223261eaf.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 03:33:50 -0800 (PST)
X-Gm-Message-State: AOJu0YzyDXVT5ssGVShOatsOLVhH9akbGDoCT0NYmz4Hu0622ThgGNWS
	i6f6wzQxYsOCP0pzwUQcgypwXGNnSeNdd2sBkBw=
X-Google-Smtp-Source: AGHT+IEZOYQwipo55dG+iVJHZHqRQup1dSSPuInG+v3cXmrGvDZ8R7NRLRTF/PxXGqYDtFQZ1lNcOMtXqpgyQj4JoOU=
X-Received: by 2002:a05:6870:bb0a:b0:1fb:75a:6782 with SMTP id
 nw10-20020a056870bb0a00b001fb075a6782mr4417423oab.41.1702553629357; Thu, 14
 Dec 2023 03:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Thu, 14 Dec 2023
 03:33:48 -0800 (PST)
In-Reply-To: <2023121434-universal-lively-3efa@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh> <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <2023121350-spearmint-manned-b7b1@gregkh> <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
 <2023121434-universal-lively-3efa@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 Dec 2023 20:33:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CU9qRt8Y2n5n-=tUKPPHBUpiu2sLOp7=bF4=MzPMz4w@mail.gmail.com>
Message-ID: <CAKYAXd_CU9qRt8Y2n5n-=tUKPPHBUpiu2sLOp7=bF4=MzPMz4w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven French <Steven.French@microsoft.com>, 
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-14 17:05 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Thu, Dec 14, 2023 at 08:31:44AM +0900, Namjae Jeon wrote:
>> 2023-12-13 23:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> > On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
>> >> Out of curiosity, has there been an alternative approach for some
>> >> backports, where someone backports most fixes and features (and safe
>> >> cleanup) but does not backport any of the changesets which have
>> >> dependencies outside the module (e.g. VFS changes, netfs or mm changes
>> >> etc.)  to reduce patch dependency risk (ie 70-80% backport instead of
>> >> the typical 10-20% that are picked up by stable)?
>> >>
>> >> For example, we (on the client) ran into issues with 5.15 kernel (for
>> >> the client) missing so many important fixes and features (and
>> >> sometimes hard to distinguish when a new feature is also a 'fix') that
>> >> I did a "full backport" for cifs.ko again a few months ago for 5.15
>> >> (leaving out about 10% of the patches, those with dependencies or that
>> >> would be risky).
>> >
>> > We did take a "big backport/sync" for io_uring in 5.15.y a while ago,
>> > so
>> > there is precident for this.
>> >
>> > But really, is anyone even using this feature in 5.15.y anyway?  I
>> > don't
>> > know of any major distro using 5.15.y any more, and Android systems
>> > based on 5.15.y don't use this specific filesystem, so what is left?
>> > Can we just mark it broken and be done with it?
>> As I know, ksmbd is enable in 5.15 kernel of some distros(opensuse,
>> ubuntu, etc) except redhat.
>
> But do any of them actually use the 5.15.y kernel tree and take updates
> from there?  That's the key thing here.
Yes, openWRT guy said that openWRT use ksmbd module of stable 5.15.y
kernel for their NAS function.
The most recent major release, 23.05.x, uses the 5.15 kernel, and the
kernel version is updated in minor releases.
https://github.com/openwrt/openwrt/commit/95ebd609ae7bdcdb48c74ad93d747f24c94d4a07

https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/

https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/kmod-fs-ksmbd_5.15.137-1_x86_64.ipk

https://github.com/openwrt/openwrt/blob/fcf08d9db6a50a3ca6f0b64d105d975ab896cc35/package/kernel/linux/modules/fs.mk#L349

>
>> And users can use this feature. I will
>> make the time for ksmbd backporting job. To facilitate backport, Can I
>> submit clean-up patches for ksmbd of 5.15 kernel or only bug fixes are
>> allowed?
>
> If a fix relies on an upstream cleanup, that's fine to take.
>
> But first, find out if anyone is actually using this before you take the
> time here.
Okay:) Thanks for your answer.

>
> thanks,
>
> greg k-h
>

