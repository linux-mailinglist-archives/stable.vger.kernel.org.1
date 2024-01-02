Return-Path: <stable+bounces-9224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D8822567
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 00:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C11F2348B
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628421772F;
	Tue,  2 Jan 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naqQ0d6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40517999
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E47C433CA
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704237033;
	bh=MquSI2fdVKSuxNcUfuZIzvUeJHlxhlQhjbr5hxXbJf4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=naqQ0d6NYm5Gk+DGR/uqu5Nhtm/PrFh39AtEc59RvN6V3zl9Rvlc2m3ewNe6bk8ev
	 iynb5BU/aIw8XeZsiPnuKAayl+fUnc30EbTF98kdpa0gY+6GErUWnU+CUajtSwANpt
	 qnCCc0zvorMpRdMSfsVE0JyA/AM4ISPEK0WCg2JWuPN+pB4BNZB9JNJK2FBNFPAxDC
	 bFSMgA1c+rLHLU2F9fUcpTDn7NhBXosN08gWHdwV4V+uEm7i/gg3sYtkJwp63s+4io
	 nspSMEQvR7+8Y4H6syIrbwgM6KpyOFzeUvo4NFHlsDj0ZCOdsluZScv2ZM30mL801A
	 3XBWGz5sZK5sw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59502aa878aso2231975eaf.1
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 15:10:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxkxcAWiWWmwEyRifdcHM9HFq+Ex69ZOapgS6JkT4dTA2mGGrd+
	PsEQx7XFO4pwuZw07QLhBqGAVJLhl4fd8kLHpOc=
X-Google-Smtp-Source: AGHT+IE/YbmDkQTHmHXeFYGD/5go7LXKRrOzR6dR7mu2x92zp8d3tPSUoDuKNc4dLD9ixL1TTGmXss+thAsaM/sKy0A=
X-Received: by 2002:a05:6820:160b:b0:590:2b6d:a862 with SMTP id
 bb11-20020a056820160b00b005902b6da862mr10553582oob.15.1704237032931; Tue, 02
 Jan 2024 15:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:d42:0:b0:511:f2c1:11ee with HTTP; Tue, 2 Jan 2024
 15:10:32 -0800 (PST)
In-Reply-To: <2024010241-define-gangly-9bf9@gregkh>
References: <2024010241-define-gangly-9bf9@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 3 Jan 2024 08:10:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8t1VYq-DC9tH-Fh41qR9wJt=MSbYjLxtGX4uBK4CDNTg@mail.gmail.com>
Message-ID: <CAKYAXd8t1VYq-DC9tH-Fh41qR9wJt=MSbYjLxtGX4uBK4CDNTg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ksmbd: fix slab-out-of-bounds in
 smb_strndup_from_utf16()" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: lometsj@live.com, stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-02 23:28 GMT+09:00, gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org>:
>
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I will send a backport patch for this today.
Thank you!
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x d10c77873ba1e9e6b91905018e29e196fd5f863d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2024010241-define-gangly-9bf9@gregkh' --subject-prefix 'PATCH 5.15.y'
> HEAD^..
>
> Possible dependencies:
>
> d10c77873ba1 ("ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From d10c77873ba1e9e6b91905018e29e196fd5f863d Mon Sep 17 00:00:00 2001
> From: Namjae Jeon <linkinjeon@kernel.org>
> Date: Wed, 20 Dec 2023 15:52:11 +0900
> Subject: [PATCH] ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
>
> If ->NameOffset/Length is bigger than ->CreateContextsOffset/Length,
> ksmbd_check_message doesn't validate request buffer it correctly.
> So slab-out-of-bounds warning from calling smb_strndup_from_utf16()
> in smb2_open() could happen. If ->NameLength is non-zero, Set the larger
> of the two sums (Name and CreateContext size) as the offset and length of
> the data area.
>
> Reported-by: Yang Chaoming <lometsj@live.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
>
> diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
> index 23bd3d1209df..03dded29a980 100644
> --- a/fs/smb/server/smb2misc.c
> +++ b/fs/smb/server/smb2misc.c
> @@ -106,16 +106,25 @@ static int smb2_get_data_area_len(unsigned int *off,
> unsigned int *len,
>  		break;
>  	case SMB2_CREATE:
>  	{
> +		unsigned short int name_off =
> +			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
> +		unsigned short int name_len =
> +			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
> +
>  		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
>  			*off = le32_to_cpu(((struct smb2_create_req *)
>  				hdr)->CreateContextsOffset);
>  			*len = le32_to_cpu(((struct smb2_create_req *)
>  				hdr)->CreateContextsLength);
> -			break;
> +			if (!name_len)
> +				break;
> +
> +			if (name_off + name_len < (u64)*off + *len)
> +				break;
>  		}
>
> -		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
> -		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
> +		*off = name_off;
> +		*len = name_len;
>  		break;
>  	}
>  	case SMB2_QUERY_INFO:
>
>

