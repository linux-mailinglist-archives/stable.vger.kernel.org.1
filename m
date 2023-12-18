Return-Path: <stable+bounces-7833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C920B817BFA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CCC282D64
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3273465;
	Mon, 18 Dec 2023 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufFakPar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73C1E507
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 20:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B28C433CA
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931518;
	bh=llIy83nuaRKNo8XA4BbLRkLf5mEAOa2o7Q29zCSzUVM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=ufFakPar+jwgY7hqExxaVPDHuzRtW+nkKHVOPLn5YXLQw2VvAQpRjvRFhTBIGAtZT
	 XeuL7ar2ZtgBBv+HPzmjklweGUOMwrZU+BuHKirwbo4rgfKxXPkKkWj9oVs8PCK6Q8
	 n+g4M+ticgqa0c0eGtMvNovNe+JbLLw8aXU7+EBnnJTCj6YDYGskSpr1JhhFVPCZvz
	 P70Sar9jLi7Qp5e+xFa/MoCQW2TyvEj0aIRDJAelTl9wlKoUZQ2FOJe2Y9Tnc6cJla
	 an/ROoAhDb6fnc5/gYvbueKoWngsofYQvWXUzQ1Fnr9Jv5udL7A66x7Ia0085Q54N/
	 2ronNvV+BBixA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-203c0c5f1caso956556fac.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 12:31:58 -0800 (PST)
X-Gm-Message-State: AOJu0YwMpS1iEELuw6IRbBDqYKJeofIq/N70eMMK0WMuKpASDpkxZ8LA
	lN2vrckKawh2CEXiWs9DMPk1GQ+xtYOGYDVgIdU=
X-Google-Smtp-Source: AGHT+IG6TSYFWMuoMYKU7GvSUH/ZmZcbOHiQ+JJjeSnjeXFBo2el630BcEfBPdAIZWhXwlS/GGLMFsIgcyZnNyrE4mE=
X-Received: by 2002:a05:6871:b1e:b0:203:9d59:2a4d with SMTP id
 fq30-20020a0568710b1e00b002039d592a4dmr4495494oab.40.1702931517688; Mon, 18
 Dec 2023 12:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Mon, 18 Dec 2023
 12:31:56 -0800 (PST)
In-Reply-To: <4fb8f26e-cf8d-4ad8-bd44-ecd4198f8072@wanadoo.fr>
References: <20231218153454.8090-1-linkinjeon@kernel.org> <20231218153454.8090-4-linkinjeon@kernel.org>
 <4fb8f26e-cf8d-4ad8-bd44-ecd4198f8072@wanadoo.fr>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 Dec 2023 05:31:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9+gtn6EMKTCH96onyakhfihG2mry62AU_a6=LMfRK9JA@mail.gmail.com>
Message-ID: <CAKYAXd9+gtn6EMKTCH96onyakhfihG2mry62AU_a6=LMfRK9JA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 003/154] ksmbd: Remove redundant
 'flush_workqueue()' calls
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2023-12-19 2:56 GMT+09:00, Christophe JAILLET <christophe.jaillet@wanadoo.f=
r>:
> Hi,
Hi Christophe,
>
> unless explicitly needed because of other patches that rely on it,
> patches 03, 28 and 42 / 154 don't look as good candidate for backport.
Even if there is no problem now, a hunk failure may occur later when
the new change near these patches is applied. So I decided to apply
clean-up patches as well.

Thanks.
>
> CJ
>
>
> Le 18/12/2023 =C3=A0 16:32, Namjae Jeon a =C3=A9crit :
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> [ Upstream commit e8d585b2f68c0b10c966ee55146de043429085a3 ]
>>
>> 'destroy_workqueue()' already drains the queue before destroying it, so
>> there is no need to flush it explicitly.
>>
>> Remove the redundant 'flush_workqueue()' calls.
>>
>> This was generated with coccinelle:
>>
>> @@
>> expression E;
>> @@
>> - 	flush_workqueue(E);
>> 	destroy_workqueue(E);
>>
>> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Signed-off-by: Steve French <stfrench@microsoft.com>
>> ---
>>   fs/ksmbd/ksmbd_work.c     | 1 -
>>   fs/ksmbd/transport_rdma.c | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
>> index fd58eb4809f6..14b9caebf7a4 100644
>> --- a/fs/ksmbd/ksmbd_work.c
>> +++ b/fs/ksmbd/ksmbd_work.c
>> @@ -69,7 +69,6 @@ int ksmbd_workqueue_init(void)
>>
>>   void ksmbd_workqueue_destroy(void)
>>   {
>> -	flush_workqueue(ksmbd_wq);
>>   	destroy_workqueue(ksmbd_wq);
>>   	ksmbd_wq =3D NULL;
>>   }
>> diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
>> index 9ca29cdb7898..86446742f4ad 100644
>> --- a/fs/ksmbd/transport_rdma.c
>> +++ b/fs/ksmbd/transport_rdma.c
>> @@ -2049,7 +2049,6 @@ int ksmbd_rdma_destroy(void)
>>   	smb_direct_listener.cm_id =3D NULL;
>>
>>   	if (smb_direct_wq) {
>> -		flush_workqueue(smb_direct_wq);
>>   		destroy_workqueue(smb_direct_wq);
>>   		smb_direct_wq =3D NULL;
>>   	}
>

