Return-Path: <stable+bounces-6682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4378122D9
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE51C21280
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CCF77B3C;
	Wed, 13 Dec 2023 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRvgVJ5s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659D77B21
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 23:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0C3C433C8
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 23:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510306;
	bh=C5g6Th+Ny4w1vQZnWbhsibKBCvXox3vPycaVRsRgcB4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=CRvgVJ5sVzQp2IdLthXcwVqP338Wglob/oOCUYF7VP9E8dmzMT2ULEfAPZLmhx/Mr
	 43uhuqfNAF6i8DJRmiKwBelcSLMLchdhLxVRlHFgAiLvMPSh5LSswYaV+xsxz/+ejd
	 UlB7rmewhCcNYjsllikfeMiNdUyMmTOtuYijTe9pnsiWx1S1NdyYYp8hfIYKidHe28
	 zHjODJJ1QpnIYp8DVM8XBpXQSAH78wIJ2Eq+SBjOUbb+Qd6TYKyZ5e4WZkv7WA8BTL
	 lLnV2StN6rpdKRu0pfW8nZF3cVXArSb52zsdjMq9RC0mZ09zifeVJtsH6z8OOf9rM6
	 oE1jtlV4cC5xQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9fdbcec6eso3917396a34.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 15:31:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+1AbfFPx+t1o1mqkb6kDFq+RmKAfWi5eMQvT+AxWFxsc9yqpg
	0S57s4E00rQOM6JdzVXMFdPBlxjEmhv4V5cyOek=
X-Google-Smtp-Source: AGHT+IFn0++CBz9JcihGnVjcnDn+6fWZc37a7SnNVKJ5kdX0ZKy01dFTYXNJmUeq/+E6m+OWdIGyWN1hajMQMpEhCjM=
X-Received: by 2002:a05:6870:9f07:b0:1fb:75a:c43f with SMTP id
 xl7-20020a0568709f0700b001fb075ac43fmr8465792oab.104.1702510305282; Wed, 13
 Dec 2023 15:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Wed, 13 Dec 2023
 15:31:44 -0800 (PST)
In-Reply-To: <2023121350-spearmint-manned-b7b1@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh> <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <2023121350-spearmint-manned-b7b1@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 Dec 2023 08:31:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
Message-ID: <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven French <Steven.French@microsoft.com>, 
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-13 23:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
>> Out of curiosity, has there been an alternative approach for some
>> backports, where someone backports most fixes and features (and safe
>> cleanup) but does not backport any of the changesets which have
>> dependencies outside the module (e.g. VFS changes, netfs or mm changes
>> etc.)  to reduce patch dependency risk (ie 70-80% backport instead of
>> the typical 10-20% that are picked up by stable)?
>>
>> For example, we (on the client) ran into issues with 5.15 kernel (for
>> the client) missing so many important fixes and features (and
>> sometimes hard to distinguish when a new feature is also a 'fix') that
>> I did a "full backport" for cifs.ko again a few months ago for 5.15
>> (leaving out about 10% of the patches, those with dependencies or that
>> would be risky).
>
> We did take a "big backport/sync" for io_uring in 5.15.y a while ago, so
> there is precident for this.
>
> But really, is anyone even using this feature in 5.15.y anyway?  I don't
> know of any major distro using 5.15.y any more, and Android systems
> based on 5.15.y don't use this specific filesystem, so what is left?
> Can we just mark it broken and be done with it?
As I know, ksmbd is enable in 5.15 kernel of some distros(opensuse,
ubuntu, etc) except redhat. And users can use this feature. I will
make the time for ksmbd backporting job. To facilitate backport, Can I
submit clean-up patches for ksmbd of 5.15 kernel or only bug fixes are
allowed?

Thanks.
>
> thanks,
>
> greg k-h
>

