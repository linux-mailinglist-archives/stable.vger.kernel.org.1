Return-Path: <stable+bounces-6559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD181094B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 05:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1F1C209E2
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A5C2CC;
	Wed, 13 Dec 2023 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGOAHwAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BBBA28
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 04:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B68C433CB
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 04:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702443574;
	bh=u6sIbSs4MW7r2nKNpHdg3ICb7rwvaqUS1cn+mvA+hwY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=HGOAHwAiSzXwl2zomxWOqFm+cic7u/xn4pz4LqQcfcRsPXMT50yyWOB4pUeu2+dzp
	 5QRh8xTSZI6IXGxqwnnSTSbcbF8REaCQwXXtmQYm/9vJTQpgxticUysst810ZcCTYC
	 dBRTutUSu8/QBv4Wjbp6sCLZX1TH5A5zklLLHjPncJ8Evme70gMF1TlXlwPybeZ7uf
	 GBlfBxcACtEesi8vXrPaeHYkuAE3syLWP0KM1Z1IyJUC0Cc24FTcwDtM88mWd+VPoz
	 04aVN3Ap6WdM2VEkyq9HX+RVf45vIPelo5AAiCOqXdyU5uKgIc7775JuK3fjlhTyU/
	 9fLmCQYaNaj4A==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77f380d8f6aso381534585a.2
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 20:59:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yx1rW5nFCwBzvtt8AjbAXQbFcRuiu/Zq6T6OI9fhYnHjoS5IidX
	53sUco9C8cvYzZ5VE/t/QOmti+YJ97MpS7zYbGI=
X-Google-Smtp-Source: AGHT+IGufCscbgrmR2FbukbXkzaTT9lUmqMQCxV/dRdubTlhwhPFF6gvv2UQmT1wmALLUwhk2oMQ673FYK3YSFsQW8A=
X-Received: by 2002:a05:620a:80d:b0:77d:a51c:dd52 with SMTP id
 s13-20020a05620a080d00b0077da51cdd52mr8501059qks.78.1702443573145; Tue, 12
 Dec 2023 20:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Tue, 12 Dec 2023
 20:59:32 -0800 (PST)
In-Reply-To: <20231212184745.2245187-2-paul.gortmaker@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com> <20231212184745.2245187-2-paul.gortmaker@windriver.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Dec 2023 13:59:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8zubqA+eViBvz=FBe4Lvvoc1Nr4LH6FmzvP6YPSZHUow@mail.gmail.com>
Message-ID: <CAKYAXd8zubqA+eViBvz=FBe4Lvvoc1Nr4LH6FmzvP6YPSZHUow@mail.gmail.com>
Subject: Re: [PATCH 1/1] ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
To: paul.gortmaker@windriver.com
Cc: Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-13 3:47 GMT+09:00, paul.gortmaker@windriver.com
<paul.gortmaker@windriver.com>:
> From: Namjae Jeon <linkinjeon@kernel.org>
>
> commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 upstream.
>
> The length field of netbios header must be greater than the SMB header
> sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.
>
> If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
> In the function `get_smb2_cmd_val` ksmbd will read cmd from
> `rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
> detector to print the following error message:
>
> [    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
> [    7.205423] Read of size 2 at addr ffff8880062d8b50 by task
> ksmbd:42632/248
> ...
> [    7.207125]  <TASK>
> [    7.209191]  get_smb2_cmd_val+0x45/0x60
> [    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
> [    7.209712]  ksmbd_server_process_request+0x72/0x160
> [    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
> [    7.212280]  kthread+0x160/0x190
> [    7.212762]  ret_from_fork+0x1f/0x30
> [    7.212981]  </TASK>
>
> Cc: stable@vger.kernel.org
> Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> [PG: fs/smb/server/connection.c --> fs/ksmbd/connection.c for v5.15.
>  Also no smb2_get_msg() as no +4 from cb4517201b8a in v5.15 baseline.]
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Looks good to me:)
Thanks for your work!

