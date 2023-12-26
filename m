Return-Path: <stable+bounces-8589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6DA81EABB
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7D1C210AD
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCE525E;
	Tue, 26 Dec 2023 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPF7GQSt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11448101C1
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 23:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D45C433C8
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703632334;
	bh=RjeHaiimmMCIXK6vnnTxiMW5EtUbR3YN2yiCuuvjGTA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=vPF7GQSt9KglyIAVSL6+xJRXfRWlxz1xMpbijNDeAeQ/G3VY+wist229HLiyr4pqy
	 ON2aEgTMBtdT1Kkl0Yf/S7ctnzeYtO6oayhrm0GN0Da/7PZhAHgsPFyrUY5YUtHrgj
	 nile9uNYfPcHXRT05xs5Gj5gnp7ZYyN8nvu9t01wDFsoq1cbLVTcVj/U/6KCubWe+6
	 hwJj95khLWtOW77y3v15ged2lurqCuXHte/887v4Pt8M7GzXL/hDRxTo8Ky0ZdNd3O
	 h5rXfMZnsNSpMDDXuBlTe7LpCMSOz3ZBStURloW7ff/ZNmUU0/w0AmStVO6Hzw8NFU
	 62TAicVBScEhw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5940ff752beso2185568eaf.3
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 15:12:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yx9b0aXiOMX6LVuIIkHWJRHD5TlGjn67naRbMkZsPkgaa17Es0M
	rl549GuHoUrXHEqzlkaN503qu33O1ItmB3lg7c4=
X-Google-Smtp-Source: AGHT+IFAKhd+XF2lDX+s/vRmfNo5jzU1fdhcyBtlFAcsaEFFDE+HGrWGDvqkWJt1XV66gIZO9lVSLQaA7DY4/UE7dwE=
X-Received: by 2002:a05:6820:2409:b0:594:182a:29cd with SMTP id
 cp9-20020a056820240900b00594182a29cdmr3767463oob.14.1703632333738; Tue, 26
 Dec 2023 15:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8c:0:b0:511:cb20:18d4 with HTTP; Tue, 26 Dec 2023
 15:12:12 -0800 (PST)
In-Reply-To: <ZYtbLYw2xyQRG8Md@sashalap>
References: <20231226105333.5150-1-linkinjeon@kernel.org> <20231226105333.5150-2-linkinjeon@kernel.org>
 <ZYrqaBw9o9L_WmW7@sashalap> <CAKYAXd-ujQ5-X4T7SeoUUoBVhhtqcdZujkcCoPrXu5245ORY2w@mail.gmail.com>
 <ZYtbLYw2xyQRG8Md@sashalap>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 27 Dec 2023 08:12:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-vO-40w+gqWq_Hobbw9r8M-py1u3dNdVHuPm-9JSHBdw@mail.gmail.com>
Message-ID: <CAKYAXd-vO-40w+gqWq_Hobbw9r8M-py1u3dNdVHuPm-9JSHBdw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 1/8] ksmbd: add support for key exchange
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-27 8:01 GMT+09:00, Sasha Levin <sashal@kernel.org>:
> On Wed, Dec 27, 2023 at 05:05:10AM +0900, Namjae Jeon wrote:
>>2023-12-26 23:59 GMT+09:00, Sasha Levin <sashal@kernel.org>:
>>> On Tue, Dec 26, 2023 at 07:53:26PM +0900, Namjae Jeon wrote:
>>>>[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]
>>>>
>>>>When mounting cifs client, can see the following warning message.
>>>>
>>>>CIFS: decode_ntlmssp_challenge: authentication has been weakened as
>>>> server
>>>>does not support key exchange
>>>>
>>>>To remove this warning message, Add support for key exchange feature to
>>>>ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
>>>>using RC4 with session key. The decrypted value is the recovered
>>>> secondary
>>>>key that will use instead of the session key for signing and sealing.
>>>>
>>>>Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>>>>Signed-off-by: Steve French <stfrench@microsoft.com>
>>>>---
>>>> fs/Kconfig | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/fs/Kconfig b/fs/Kconfig
>>>>index a6313a969bc5..971339ecc1a2 100644
>>>>--- a/fs/Kconfig
>>>>+++ b/fs/Kconfig
>>>>@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
>>>>
>>>> config SMBFS_COMMON
>>>> 	tristate
>>>>-	default y if CIFS=y
>>>>-	default m if CIFS=m
>>>>+	default y if CIFS=y || SMB_SERVER=y
>>>>+	default m if CIFS=m || SMB_SERVER=m
>>>>
>>>> source "fs/coda/Kconfig"
>>>> source "fs/afs/Kconfig"
>>>
>>> This looks really weird: the hunk above is in the original upstream
>>> patch, but what happened to the rest of the upstream code?
>>>
>>> This change doesn't do what the message describing it says it does.
>>There was a problem(omitted some changes) in the previous backport
>>patch, I didn't know what to do, so I just sent a patch like this.
>>Should I add it again after reverting the patch or just updating the
>>patch description?
>
> Given that this was due to an issue with the backport, I'd say just
> write a new commit message explaining what happened, and point the fixes
> tag to c5049d2d73b2 ("ksmbd: add support for key exchange")
Okay, I will do that, Thanks for your answer!
>
> --
> Thanks,
> Sasha
>

