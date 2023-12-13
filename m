Return-Path: <stable+bounces-6560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1081095A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 06:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241F51F218AB
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 05:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743FC2DA;
	Wed, 13 Dec 2023 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxt9RIvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B6126
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 05:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777FAC433C9
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702444440;
	bh=VOo4lw7P/AeYJORZqLpnw4ethh+22T70cQKqLaKFcEM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Wxt9RIvZR2AuBsJOjO776LrSURQSSTrP5usKFG77D8jQoEtXXEiYTPr5lqWxRb0CP
	 wt0FnEYS9BX+Ft0/A3gEfcAB/H8Kt1VFRTsWIPnxazGgSI/Rng6KxOcD4l4KUWyXff
	 Un0E+SdtmY9F4W9RtN5VhgNrRu5kZk1Q1sDnzSNMtadOx8f02do5ehSvPgW5wt9E/B
	 zeH5xAsqmJOrZMlTSFVDwlT34dbSK2PkA5rqX2zxrS3EnSFEEM371Q6nrUxOflEdaN
	 nKq3tjdv2Yo2e6K2HV+lIk6lbV5/oLIaRWZCssAJfS+dsDOAkstY08H8LAxKpaLx4s
	 CnQx4bRUzdF7w==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58ceab7daddso2754646eaf.3
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 21:14:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxN1FD1VzJABex/SWXlqqK9qvbrBzTRcmLVotPubKJlg6DZFkJC
	WzazjjcBM09xiMl4qYdekX2d1PnNidubSLqmpQo=
X-Google-Smtp-Source: AGHT+IH4UlYTkhDBgwhLs5Ko+9DCfqnU/u3BwwicVW6sFaEGUmPmjgArBCIT1v9VMdF76M6pEn4nLlfTX3iMZz1td78=
X-Received: by 2002:a05:6870:168e:b0:203:2201:db17 with SMTP id
 j14-20020a056870168e00b002032201db17mr175473oae.53.1702444439630; Tue, 12 Dec
 2023 21:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Tue, 12 Dec 2023
 21:13:58 -0800 (PST)
In-Reply-To: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Dec 2023 14:13:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-FgPgU2MUjygxfXMVp1yV34dHr5KE6tvEcNQTAP=aH+A@mail.gmail.com>
Message-ID: <CAKYAXd-FgPgU2MUjygxfXMVp1yV34dHr5KE6tvEcNQTAP=aH+A@mail.gmail.com>
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
To: paul.gortmaker@windriver.com
Cc: Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-13 3:47 GMT+09:00, paul.gortmaker@windriver.com
<paul.gortmaker@windriver.com>:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> This is a bit long, but I've never touched this code and all I can do is
> compile test it.  So the below basically represents a capture of my
> thought process in fixing this for the v5.15.y-stable branch.
>
> I am hoping the folks who normally work with this code can double check
> that I didn't get off-track somewhere...
>
>
> CVE-2023-38431 points at commit 368ba06881c3 ("ksmbd: check the
> validation of pdu_size in ksmbd_conn_handler_loop") as the fix:
>
> https://nvd.nist.gov/vuln/detail/CVE-2023-38431
>
> For convenience, here is a link to the fix:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/smb/server?id=368ba06881c3
>
> It was added in v6.4
>
> git describe --contains 368ba06881c3
> v6.4-rc6~2^2~1
>
> ...and backported to several stable releases.  But just not v5.15.
>
> Why not v5.15?  If we look at the code the fix patches with "git blame"
> we get commit 0626e6641f6b4 ("cifsd: add server handler for central
> processing and tranport layers")
>
> $git describe --contains 0626e6641f6b4
> v5.15-rc1~183^2~94
>
> So that would have been the commit the "Fixes:" line would have pointed
> at if it had one.
>
> Applying the fix to v5.15 reveals two problems.  The 1st is a trivial
> file rename (fs/smb/server/connection.c --> fs/ksmbd/connection.c for
> v5.15) and then the commit *applies*.   The 2nd problem is only revealed
> at compile time...
>
> The compile fails because the v5.15 baseline does not have smb2_get_msg().
> Where does that come from?
>
> commit cb4517201b8acdb5fd5314494aaf86c267f22345
> Author: Namjae Jeon <linkinjeon@kernel.org>
> Date:   Wed Nov 3 08:08:44 2021 +0900
>
>     ksmbd: remove smb2_buf_length in smb2_hdr
>
> git describe --contains cb4517201b8a
> v5.16-rc1~21^2~6
>
> So now we see why v5.15 didn't get a linux-stable backport by default.
> In cb4517201b8a we see:
>
> +static inline void *smb2_get_msg(void *buf)
> +{
> +       return buf + 4;
> +}
>
> However we can't just take that context free of the rest of the commit,
> and then glue it into v5.15.  The whole reason the function exists is
> because a length field of 4 was removed from the front of a struct.
> If we look at the typical changes the struct change caused, we see:
>
> -       struct smb2_hdr *rcv_hdr2 = work->request_buf;
> +       struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
>
> If we manually inline that, we obviously get:
>
> -       struct smb2_hdr *rcv_hdr2 = work->request_buf;
> +       struct smb2_hdr *rcv_hdr2 = work->request_buf + 4;
>
> Now consider the lines added in the fix which is post struct reduction:
>
> +#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
>
> +               if (((struct smb2_hdr
> *)smb2_get_msg(conn->request_buf))->ProtocolId ==
> +                   SMB2_PROTO_NUMBER) {
> +                       if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
> +                               break;
> +               }
>
> ...and if we inline/expand everything, we get:
>
> +               if (((struct smb2_hdr *)(conn->request_buf + 4))->ProtocolId
> ==
> +                   SMB2_PROTO_NUMBER) {
> +                       if (pdu_size < (sizeof(struct smb2_hdr) + 4))
> +                               break;
> +               }
>
> And so, by extension the v5.15 code, which is *pre* struct reduction, would
> simply not have the "+4" and hence be:
>
> +               if (((struct smb2_hdr *)(conn->request_buf))->ProtocolId ==
> +                   SMB2_PROTO_NUMBER) {
> +                       if (pdu_size < (sizeof(struct smb2_hdr)))
> +                               break;
> +               }
>
> If we then put the macro back (without the 4), the v5.15 version would be:
>
> +#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr))
>
> +               if (((struct smb2_hdr *)(conn->request_buf))->ProtocolId ==
> +                   SMB2_PROTO_NUMBER) {
> +                       if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
> +                               break;
> +               }
>
> And so that is what I convinced myself is right to put in the backport.
>
Hi Paul,
> If you read/reviewed this far - thanks!
Your backport patch looks good :), I have checked it work fine.

Thanks for your work!
> Paul.
>
> ---
>
> Namjae Jeon (1):
>   ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
>
>  fs/ksmbd/connection.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> --
> 2.40.0
>
>

