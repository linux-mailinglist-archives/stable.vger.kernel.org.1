Return-Path: <stable+bounces-6743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5FF813253
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDAB1C21A97
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597F5811E;
	Thu, 14 Dec 2023 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyccBsBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE258101
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 13:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF76C433CC
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702562315;
	bh=wpEb4YwzF0OG1Kt2GsjU2fc3rJTU/2D9j0oUU41n070=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=EyccBsBuWIijgUrRa3uob6O+nbgcTK1rnFqhkxsY95RvvSl84ycZYLaYnvDOSS8ll
	 KswxSi5hvdg9OtKHt/TjHEPSEYYgSyg5DCebpHLYtl0KJ6TJq3vklvXccygTXI6GRF
	 mu0OCJAC7cFP0aCDbH+f53SVoAnwdpoLogONiAxgF/G2Tk2umBEbP/BqVlxvepVjFC
	 g8kfEk7K3a5TFdHtd0QkwMHEzx83SjI4b6dtIpgH4S1AVGyLKpiTsj3lLltvzHmqzw
	 6SGmMjzK4+pw/rY8k+tbXKbYdrFWUDKthNkVfuGaNWe1Ruz9e9eV+Cpzw8jpXD8Rh3
	 nICOQ9Zo8RaIw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-20308664c13so2027608fac.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 05:58:35 -0800 (PST)
X-Gm-Message-State: AOJu0YwNReOpTmWk5sL130IoVdNFpU/1FNTQMc+mMJZB2oPwTdXkYxGZ
	cUEmoiy/4gwl6btpxuQznRPu/X5jwvJMmYYktiI=
X-Google-Smtp-Source: AGHT+IGIlDGxEHhsN1ZDdBxHbu1UXUM7Lbu0+qKx43MB/zzsJi/v937p07QhIR1DUNnManoJ8pMWLavvercpz9N2S64=
X-Received: by 2002:a05:6870:4e01:b0:1fa:25de:2f6b with SMTP id
 pl1-20020a0568704e0100b001fa25de2f6bmr12691784oab.23.1702562314656; Thu, 14
 Dec 2023 05:58:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Thu, 14 Dec 2023
 05:58:33 -0800 (PST)
In-Reply-To: <2023121439-landowner-glamour-f7ad@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh> <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <2023121350-spearmint-manned-b7b1@gregkh> <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
 <2023121434-universal-lively-3efa@gregkh> <CAKYAXd_CU9qRt8Y2n5n-=tUKPPHBUpiu2sLOp7=bF4=MzPMz4w@mail.gmail.com>
 <2023121439-landowner-glamour-f7ad@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 Dec 2023 22:58:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8qBOvUrgcguv9DW+OBiu5Muh+9QsA5PR8ESWeVU2D+vQ@mail.gmail.com>
Message-ID: <CAKYAXd8qBOvUrgcguv9DW+OBiu5Muh+9QsA5PR8ESWeVU2D+vQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven French <Steven.French@microsoft.com>, 
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-14 20:58 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Thu, Dec 14, 2023 at 08:33:48PM +0900, Namjae Jeon wrote:
>> 2023-12-14 17:05 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> > On Thu, Dec 14, 2023 at 08:31:44AM +0900, Namjae Jeon wrote:
>> >> 2023-12-13 23:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
>> >> > On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
>> >> >> Out of curiosity, has there been an alternative approach for some
>> >> >> backports, where someone backports most fixes and features (and
>> >> >> safe
>> >> >> cleanup) but does not backport any of the changesets which have
>> >> >> dependencies outside the module (e.g. VFS changes, netfs or mm
>> >> >> changes
>> >> >> etc.)  to reduce patch dependency risk (ie 70-80% backport instead
>> >> >> of
>> >> >> the typical 10-20% that are picked up by stable)?
>> >> >>
>> >> >> For example, we (on the client) ran into issues with 5.15 kernel
>> >> >> (for
>> >> >> the client) missing so many important fixes and features (and
>> >> >> sometimes hard to distinguish when a new feature is also a 'fix')
>> >> >> that
>> >> >> I did a "full backport" for cifs.ko again a few months ago for 5.15
>> >> >> (leaving out about 10% of the patches, those with dependencies or
>> >> >> that
>> >> >> would be risky).
>> >> >
>> >> > We did take a "big backport/sync" for io_uring in 5.15.y a while
>> >> > ago,
>> >> > so
>> >> > there is precident for this.
>> >> >
>> >> > But really, is anyone even using this feature in 5.15.y anyway?  I
>> >> > don't
>> >> > know of any major distro using 5.15.y any more, and Android systems
>> >> > based on 5.15.y don't use this specific filesystem, so what is left?
>> >> > Can we just mark it broken and be done with it?
>> >> As I know, ksmbd is enable in 5.15 kernel of some distros(opensuse,
>> >> ubuntu, etc) except redhat.
>> >
>> > But do any of them actually use the 5.15.y kernel tree and take updates
>> > from there?  That's the key thing here.
>> Yes, openWRT guy said that openWRT use ksmbd module of stable 5.15.y
>> kernel for their NAS function.
>> The most recent major release, 23.05.x, uses the 5.15 kernel, and the
>> kernel version is updated in minor releases.
>> https://github.com/openwrt/openwrt/commit/95ebd609ae7bdcdb48c74ad93d747f24c94d4a07
>>
>> https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/
>>
>> https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/kmod-fs-ksmbd_5.15.137-1_x86_64.ipk
>>
>> https://github.com/openwrt/openwrt/blob/fcf08d9db6a50a3ca6f0b64d105d975ab896cc35/package/kernel/linux/modules/fs.mk#L349
>
> Ok, thanks, that's good to know.  Also you might want to warn them that
> it's missing loads of security fixes at this point in time and that they
> might want to move to a newer kernel release :)
Okay, I will.
And I will check ksmbd in 6.1 LTS kernel as well as 5.15.
Thanks!
>
> thanks,
>
> greg k-h
>

