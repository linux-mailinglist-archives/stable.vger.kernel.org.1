Return-Path: <stable+bounces-8587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A481E9D4
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 21:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C3C1C220DA
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE32103;
	Tue, 26 Dec 2023 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmg5BmtN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21848257D
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 20:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53F6C433C9
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703621112;
	bh=01fsm2tgquOtXoA4nkJg8Naszk62aEH2BYTayn2baOg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Pmg5BmtN8ATXsiZlhM4lhPTJfLdQH8PtSFr+vSEIvTc6NEBQVsS1Ha7MKuM1PJl3f
	 8R+QC2GZwdhfUcq/SAnsVhZ1Ak+KmMwK1jvSex8afIT1TQb+iWf0F36vQSgzBNFSiu
	 LOGkjJSkE6aw/frDJBpLQjLVlltZVPtT1GGQQ5HgMxuqlL6jxNDRyIxos5TVVD/yc8
	 0wd/zAD1TcLVnsNS/vCRKL4O/Y0Qj+vmknsRAJMmpnSL/jLrPhSdQRh6hRlslHYjKF
	 z0hE9Tf7o6ovolYasd5Rm8nNMOpQZ26OIX2LF1o6MVqwotCLH43Apd0nIULHTzytAL
	 ReXzpdJ2Y0Ajw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-594bea92494so381050eaf.2
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 12:05:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yxwv35l1MFwWsC3Hgj7biZ4nNFuBtzY9UUxuLgHVB5vtbTNYarH
	SAjphwIM0+/SAq5mCZ5pnjTj6abSO0wSc5ZbVRE=
X-Google-Smtp-Source: AGHT+IEpNBhTma6oBCCv1YVYdEpa+s4hxuS/p6tTdmTl9wS47mTSYHkn8LVAognU19jOCfI8AxRC5EOv6e83qHbr+zI=
X-Received: by 2002:a4a:9885:0:b0:590:79fd:1629 with SMTP id
 a5-20020a4a9885000000b0059079fd1629mr3134086ooj.10.1703621111911; Tue, 26 Dec
 2023 12:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8c:0:b0:511:cb20:18d4 with HTTP; Tue, 26 Dec 2023
 12:05:10 -0800 (PST)
In-Reply-To: <ZYrqaBw9o9L_WmW7@sashalap>
References: <20231226105333.5150-1-linkinjeon@kernel.org> <20231226105333.5150-2-linkinjeon@kernel.org>
 <ZYrqaBw9o9L_WmW7@sashalap>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 27 Dec 2023 05:05:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ujQ5-X4T7SeoUUoBVhhtqcdZujkcCoPrXu5245ORY2w@mail.gmail.com>
Message-ID: <CAKYAXd-ujQ5-X4T7SeoUUoBVhhtqcdZujkcCoPrXu5245ORY2w@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 1/8] ksmbd: add support for key exchange
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-26 23:59 GMT+09:00, Sasha Levin <sashal@kernel.org>:
> On Tue, Dec 26, 2023 at 07:53:26PM +0900, Namjae Jeon wrote:
>>[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]
>>
>>When mounting cifs client, can see the following warning message.
>>
>>CIFS: decode_ntlmssp_challenge: authentication has been weakened as server
>>does not support key exchange
>>
>>To remove this warning message, Add support for key exchange feature to
>>ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
>>using RC4 with session key. The decrypted value is the recovered secondary
>>key that will use instead of the session key for signing and sealing.
>>
>>Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>>Signed-off-by: Steve French <stfrench@microsoft.com>
>>---
>> fs/Kconfig | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/fs/Kconfig b/fs/Kconfig
>>index a6313a969bc5..971339ecc1a2 100644
>>--- a/fs/Kconfig
>>+++ b/fs/Kconfig
>>@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
>>
>> config SMBFS_COMMON
>> 	tristate
>>-	default y if CIFS=y
>>-	default m if CIFS=m
>>+	default y if CIFS=y || SMB_SERVER=y
>>+	default m if CIFS=m || SMB_SERVER=m
>>
>> source "fs/coda/Kconfig"
>> source "fs/afs/Kconfig"
>
> This looks really weird: the hunk above is in the original upstream
> patch, but what happened to the rest of the upstream code?
>
> This change doesn't do what the message describing it says it does.
There was a problem(omitted some changes) in the previous backport
patch, I didn't know what to do, so I just sent a patch like this.
Should I add it again after reverting the patch or just updating the
patch description?
>
> --
> Thanks,
> Sasha
>

