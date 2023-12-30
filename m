Return-Path: <stable+bounces-9014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B378206A7
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28402820B6
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793AD8BEB;
	Sat, 30 Dec 2023 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nALUnKPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103DF9DF
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 13:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED88C433C8
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944406;
	bh=7qKQh2GAnrqSpii8ha87A7vx/Vnh8kqS/kDgw0juLMs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=nALUnKPsOz6EDSCrekfw0UR4R/KFZqezIxkPEi7VdBpyF8kQo8dl9fYzq0Wm6Pv+m
	 MH4dGGEA7uEXR24BNUEgMthd5XKg8T09tXBUKjWQop3T5kD1SbFaYF7KMBO1l26KAp
	 4yxsb6+MDYZiqVHJk2nFDfx7nkJ8hQA6ox/Cr3jmTMJMqplRWfgxNffDA8GECEj9EF
	 bStKH3jlGfuOQd3Tnk56OdUEf1CLIUilidPdJ2MoH9Qti4EzzmpKRG9zelQTMwfvgq
	 ItuitDLUGXg6fmNZ7mHHF5nK8CAkfhYjXvJYrohsknQ/PZocG6dG4zOjnFaeAdc3cy
	 pr+zMj+vA3Swg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbc649c275so1645701b6e.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 05:53:26 -0800 (PST)
X-Gm-Message-State: AOJu0Ywwfji5m75fEZUZuz+KXysreqd/N4RrELo5lkOsa2h5C4L/1VT7
	HhdDEYFzzzKFZ+cFrRaAkbi8s5M5390rigP7hx0=
X-Google-Smtp-Source: AGHT+IFBL1dY3HRIkvwxMoCm/xD1XK7QajAcn8P+3wU8aD4KEgi36kiT/KGEIUNuxDyl8t5G1TVi5qEkIvinzlMn4tg=
X-Received: by 2002:a05:6358:7213:b0:170:b89a:fe18 with SMTP id
 h19-20020a056358721300b00170b89afe18mr3748480rwa.16.1703944405933; Sat, 30
 Dec 2023 05:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:d42:0:b0:511:f2c1:11ee with HTTP; Sat, 30 Dec 2023
 05:53:24 -0800 (PST)
In-Reply-To: <2023123044-creamer-connected-32d8@gregkh>
References: <20231227102605.4766-1-linkinjeon@kernel.org> <2023123044-creamer-connected-32d8@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 30 Dec 2023 22:53:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-qaL_DKiVNRsgQJafYnEsQGH5sR9ptbziAkoyruGeW8A@mail.gmail.com>
Message-ID: <CAKYAXd-qaL_DKiVNRsgQJafYnEsQGH5sR9ptbziAkoyruGeW8A@mail.gmail.com>
Subject: Re: [PATCH v2 5.15.y 0/8] Additional ksmbd backport patches for linux-5.15.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, smfrench@gmail.com
Content-Type: text/plain; charset="UTF-8"

2023-12-30 20:04 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Wed, Dec 27, 2023 at 07:25:57PM +0900, Namjae Jeon wrote:
>> These patches are backport patches to support directory(v2) lease and
>> additional bug fixes for linux-5.15.y.
>> note that 0001 patch add a dependency on cifs ARC4 omitted from
>> backporting commit f9929ef6a2a5("ksmbd: add support for key exchange").
>>
>> Namjae Jeon (8):
>>   ksmbd: have a dependency on cifs ARC4
>>   ksmbd: set epoch in create context v2 lease
>>   ksmbd: set v2 lease capability
>>   ksmbd: downgrade RWH lease caching state to RH for directory
>>   ksmbd: send v2 lease break notification for directory
>>   ksmbd: lazy v2 lease break on smb2_write()
>>   ksmbd: avoid duplicate opinfo_put() call on error of
>>     smb21_lease_break_ack()
>>   ksmbd: fix wrong allocation size update in smb2_open()a
>
> We can't just take these for 5.15.y, they also need to be in the newer
> stable releases as well, right?  Please send patch series for them also
> and then we can take these.
Okay, I will send the patches for stable 6.1 and 6.6 kernel to the list and you.
BTW, Could you please apply "ksmbd: have a dependency on cifs ARC4"
patch for 5.15.y now. because It will fix my mistake on previous
backporting patch for 5.15.y.

Thanks!
>
> thanks,
>
> greg k-h
>

