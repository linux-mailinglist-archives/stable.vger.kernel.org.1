Return-Path: <stable+bounces-6990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE8816C27
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B957D284359
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209D199B2;
	Mon, 18 Dec 2023 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijIhSvOQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FF1947A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 11:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F0C433CB
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702898899;
	bh=a5QCKu0p5TFbLqzmhsr4nWE9+TEPieatl5v1eS6h9Rg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=ijIhSvOQsBrZS5nqNf0jjyPw87P0qfT764wTyFTrCMC87jaOSQH6FS+eZNjYjBpbs
	 Nco16MBuA+MnYdYSjXIz6ELdoOaZmjUQZq/tHbj4wlN25MxwU9DkZ2G6bbXyx6bR3/
	 nE8FMdPxm/p4QYr4e5qWGq7spTVs/9jkhAdup7jLVf/wylABWKkkNKo1R8Xx7124nt
	 FqZielYn80Geok+XJWmuwNJUEbW349s/9AOLTCkJSbVaRtAA7vnJvSULR4evXyt32W
	 5ELcSX0MF0s8rCEglHm+Eg5yqZuD10ScG1r4XpshXmOz3CGZxuFvS7D0+AgEc3R6yA
	 ibkOYETlIc+Zw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d18c224c7so1871600eaf.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 03:28:19 -0800 (PST)
X-Gm-Message-State: AOJu0Yw0k/qKfPm8lcnTaOC9rSGuClbZrS/7GYSRuA4L2eOT2XTQSERM
	yAas9ZLOD6cECQYyl2186/clAy5mozLFX7jttmI=
X-Google-Smtp-Source: AGHT+IEDbDznjUXrA9DEwD7sBeaWJZuFN6z7sZVCJn20CmFIbDrmQ+pRMGD1qUl2hfsVsH4ZTMDDnYma9OhTs+nNJjo=
X-Received: by 2002:a4a:e821:0:b0:591:6970:2cd8 with SMTP id
 d1-20020a4ae821000000b0059169702cd8mr4473666ood.14.1702898898363; Mon, 18 Dec
 2023 03:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Mon, 18 Dec 2023
 03:28:17 -0800 (PST)
In-Reply-To: <2023121813-compactor-lettuce-4ced@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <20231212184745.2245187-2-paul.gortmaker@windriver.com> <2023121813-compactor-lettuce-4ced@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 Dec 2023 20:28:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9mNgB_HyiZVFDP0rXaPukqtzYsdtTyLLO77SHmW_YuKQ@mail.gmail.com>
Message-ID: <CAKYAXd9mNgB_HyiZVFDP0rXaPukqtzYsdtTyLLO77SHmW_YuKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
To: Greg KH <gregkh@linuxfoundation.org>
Cc: paul.gortmaker@windriver.com, Steve French <stfrench@microsoft.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-18 19:38 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Dec 12, 2023 at 01:47:45PM -0500, paul.gortmaker@windriver.com
> wrote:
>> From: Namjae Jeon <linkinjeon@kernel.org>
>>
>> commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 upstream.
>>
>> The length field of netbios header must be greater than the SMB header
>> sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB
>> packet.
>>
>> If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to
>> `conn->request_buf`.
>> In the function `get_smb2_cmd_val` ksmbd will read cmd from
>> `rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
>> detector to print the following error message:
>>
>> [    7.205018] BUG: KASAN: slab-out-of-bounds in
>> get_smb2_cmd_val+0x45/0x60
>> [    7.205423] Read of size 2 at addr ffff8880062d8b50 by task
>> ksmbd:42632/248
>> ...
>> [    7.207125]  <TASK>
>> [    7.209191]  get_smb2_cmd_val+0x45/0x60
>> [    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
>> [    7.209712]  ksmbd_server_process_request+0x72/0x160
>> [    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
>> [    7.212280]  kthread+0x160/0x190
>> [    7.212762]  ret_from_fork+0x1f/0x30
>> [    7.212981]  </TASK>
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> Signed-off-by: Steve French <stfrench@microsoft.com>
>> [PG: fs/smb/server/connection.c --> fs/ksmbd/connection.c for v5.15.
>>  Also no smb2_get_msg() as no +4 from cb4517201b8a in v5.15 baseline.]
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  fs/ksmbd/connection.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>
> Now queued up, thanks.
Could you please remove this patch in your queue ?
This patches in my ksmbd backport queue and Since I have backported
all patches(between 5.16 ~ 6.7-rc1), I included original patch that do
not need to be changed unlike this patch.

https://github.com/namjaejeon/stable-linux-5.15-ksmbd

I am testing them before sending it. I plan to send all patches within
this week.

Thanks.
>
> greg k-h
>

