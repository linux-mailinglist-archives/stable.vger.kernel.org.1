Return-Path: <stable+bounces-242601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIxkEKr79WlSRAIAu9opvQ
	(envelope-from <stable+bounces-242601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:27:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4464B226B
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 882383007976
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D335257459;
	Sat,  2 May 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK7XQj0o"
X-Original-To: Stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3E247DE1
	for <Stable@vger.kernel.org>; Sat,  2 May 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728423; cv=pass; b=C42IlXcrsE+VtTaPC0Z1X8SslPQR5Apr1trfvtkINJZD5nJbd8fogkSdNanqGKVe4/1MoV8Z3Q+nAOPBgDeDhEEX7vC2ETbuY1jVuopAPPtkoufv+0eV1ggtMxrjuEeqc5Q6ARrricrcmxaIX/Rh1NHCY4hZO3B9qcRhwAcA10c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728423; c=relaxed/simple;
	bh=ax+q8rVZxVd5b3oJ7d58OiRhgALzGey32thxe4LddhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXm4dtW23NDMDfymX6jmwtlbNYLry9cpbILFw5GEs2QojdgB8qDmZTBj6XRVeIWlGKduuMLE3qoB5AY4M53TSnkiC8hNO4VQT2ASmTHAOTw11ZT+MCtS6IExtE4bZJC0qOPWiYVGegqFoF3Tnv2KT3gAKcLZXMM+DwUkek44BpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK7XQj0o; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b5de17382cso10223026d6.1
        for <Stable@vger.kernel.org>; Sat, 02 May 2026 06:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777728420; cv=none;
        d=google.com; s=arc-20240605;
        b=WzADh7qoaIIoSMEymo02QAelsvORCwrjg2bDItR/4mbLE1YMpxl0vJ33zyzyxQMkOD
         6RnYckgMZBjtbM6OdnrOZp4A6pGNXsAnQt5kPtBbTps7jAS1gRXldoI9QUHOyHCs7eiA
         Oq02Pxn96kzz5swDdrV/OkJ44+BBwaYEWYvBHojYTuommHjIjQSv2yb+/ToKZXzEczpb
         zAa7J8QEutyroSk99J5qdYEXY9ZEmZqG0CT1rWUtZKc9q9VdRNPQWwwMoB117bTMnN5k
         qsWD8XAStQC3wv7Ve5anISc60npIIENiwKT6UJiwzhOePNlF2C/eMq00rRPQZ7fnA/zp
         KiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96mEUW8wN+2bhoRt9GlOUt/xYvY0MYV0pTk+gcc6ObY=;
        fh=JyjYJ/jYwtM3XB8Jh8CSSYwGZjbA5gtZnygVtAD6YtQ=;
        b=jClQeA8qYr86qvtl/3hBqTF/o9bnWiArZrAV6DuEv3VKmIAZK4l0BOEwt5B3bDkbly
         utIUQ9zskGMwSKpUPOR4tGTbjPehm0qtOotQ/DqHTAmpfjbRgzi/XqH4GbeVVp2fmF5z
         Ti5miBLrJjQRbZJBMFMRWT3tFN9THk1sK8A0HN7wbkiU+2zLXOXMB8Zzm/9jB0O4pJgj
         90KOdIezoTAc7DCU5LAVTrZYHRXC8bK0CmkW/GAetxsZr7nZswmeom72IlKjQLvOSDkP
         k3fClY4xRhG8BuEj3uHU7hPzFUqZ6ExN/JbHSFiwpvLDAdwTaLEx3Mto4IBTf2NVW5hG
         kCOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777728420; x=1778333220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96mEUW8wN+2bhoRt9GlOUt/xYvY0MYV0pTk+gcc6ObY=;
        b=pK7XQj0oK8oC0gvB8T5haAa8GxcnuUKpqrE4STaDtYj8DCB82GToQJsIAUFwbadfXT
         CfuhzaiySG1cgCv/G8Kf6D9+zMuJCauBYbelE2PuovlT1zLLxUJdrdQO+Nc43khIyuTf
         80FJeBMf6x/DTLHhqUeSL76R/hE3nJtw+3gmQbkFvGAvu3KumJx4CdvcSHC4kIx2LgV6
         O4WA3RmrCGa/nQwHY7AbvgXgYW0uTfCMhxwssN5KoG1kvYKu0YaCuhSb0zzIptiBzM/o
         T3MpemCTaDzvm0x2/jffaG98qdBlzOk9XkBhuZXI1AttgHEq00aV2BB4u6d8kFMDBmPj
         YGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728420; x=1778333220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96mEUW8wN+2bhoRt9GlOUt/xYvY0MYV0pTk+gcc6ObY=;
        b=kEKzmu6AMC5xIs6Lr3j9pUOI/sdknizt4PReoJOuKvHE2TdP6w7G1LcD7qckuDH620
         5abG0sBjeM/Om2EAnGEi2gzYIosXP2GYfcxQCu/jG3aUhOLzAtcgE0lWHWQPOiPCbqus
         Db0I/DXRTtUYG2XrykwrU122EzgftaINoAIALq/vuWGAJn33T/03YcVunhFwYvBHsqMW
         rtodubW/Y83xNmeVlHVCV7cI7Z8MCr+pTAqGAd+TA7hlQtVotmiHhJDDvmPUIImrTLAr
         NKDBnQd3IQAGkrA0qbQT0AMKIiMvNzRJvz0Hxr4RSwjWmH2JltLfVIAIUv8JFgY0k3ED
         1E/g==
X-Forwarded-Encrypted: i=1; AFNElJ8DfD7gbI4pj73WuJ1G5SHEyrnmsW9OWo17dAZk3KxjTqwS0upi3+DQSDocKwglNQfrSnKDeKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqjwSqfxOdadkhDkEsiEL+zXDYSHliiMqeiSGQSnOjKSGprpE
	+aw0Ll/VdLEkS0XDQq1cGnwr+r0AxusAI8U6qLF/qC32iG4tPu6Lnh45JyyvxQ1X8hrfg4vDj3f
	F0yXaRMemyv5fg46Pke9KWAUN5xl3bQU=
X-Gm-Gg: AeBDiet0lN5Y0Sn/8e/0uXWq+gyYTwhCSmMsQu2UuL0tobNqV8HuwlqISyUpW2GlEiw
	2FvvbJ7sHkulF/ciyf4uylP3Su6GYNPuptQ7Dva0N/B6iUdMy3m0kGJEkDoBN7zvkuh5mw+GweR
	0KqVeslmV0GnUCf5PGNwlupzGRXpfVrA6gDxndc0B/1yzA88ZMMEiHlbthEwO/T+C1A2ODt2BwD
	WCnKcZPjh/VGz0THToCSn20aGthRGOK16hfGATW4BX+0YkvDDt41c5IbRrFEmUu5cidVVVPyYW5
	qgDtJZZn/aA+uJfkuZyTYpDBcyqr/keDWqXS9rbFCidsrGJytfbQVXmCplCxcQs1FBiL0DffRcG
	7VanR079PbBILvYvFPoZJgGDz1emyEkSG+0vVt7n9cmOZlwSWYKbG3eALADOpq5kcRjbzspI=
X-Received: by 2002:a05:6214:e45:b0:89c:5f6e:451a with SMTP id
 6a1803df08f44-8b6667ee116mr55192506d6.21.1777728420510; Sat, 02 May 2026
 06:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502095435.2969835-1-zisenye@stu.xidian.edu.cn> <20260502104436.2978678-1-jasonye247@163.com>
In-Reply-To: <20260502104436.2978678-1-jasonye247@163.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 2 May 2026 08:26:49 -0500
X-Gm-Features: AVHnY4JCm6Q3MxWZymRf8uWukt1vQnZmtxcBPNotbvr1eoqDne7c192vEX0LPHY
Message-ID: <CAH2r5mvEG=zFV5r6bFLDiCj4NqaDgP0j8Aonx4EqSpG8Tp6kKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smb/client: fix out-of-bounds read in smb2_compound_op()
To: jasonye247@163.com
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, chenxiaosong@chenxiaosong.com, 
	gregkh@linuxfoundation.org, linux-cifs@vger.kernel.org, 
	Zisen Ye <zisenye@stu.xidian.edu.cn>, Stable@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AD4464B226B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242601-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,redhat.com,chenxiaosong.com,linuxfoundation.org,vger.kernel.org,stu.xidian.edu.cn,kylinos.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,kylinos.cn:email,xidian.edu.cn:email]

This patch generates a build warning, can you send a v3

  CC [M]  smb2inode.o
smb2inode.c: In function =E2=80=98check_wsl_eas=E2=80=99:
smb2inode.c:124:25: warning: comparison of distinct pointer types
lacks a cast [-Wcompare-distinct-pointer-types]
  124 |         if (ea + outlen > end)
      |                         ^
  CHECK   smb2inode.c
smb2inode.c:124:25: error: incompatible types in comparison expression
(different base types):
smb2inode.c:124:25:    struct smb2_file_full_ea_info *
smb2inode.c:124:25:    unsigned char [usertype] *

On Sat, May 2, 2026 at 5:47=E2=80=AFAM <jasonye247@163.com> wrote:
>
> From: Zisen Ye <zisenye@stu.xidian.edu.cn>
>
> If a server sends a truncated response but a large OutputBufferLength, an=
d
> terminates the EA list early, check_wsl_eas() returns success without
> validating that the entire OutputBufferLength fits within iov_len.
>
> Then smb2_compound_op() does:
>     memcpy(idata->wsl.eas, data[0], size[0]);
>
> Where size[0] is OutputBufferLength. If iov_len is smaller than size[0],
> memcpy can read beyond the end of the rsp_iov allocation and leak adjacen=
t
> kernel heap memory.
>
> Link: https://lore.kernel.org/linux-cifs/d998240c-aca9-420d-9dbd-f5ba24af=
19e0@chenxiaosong.com/
> Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/smb/client/smb2inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 286912616c73..a192d70cd29e 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -121,6 +121,9 @@ static int check_wsl_eas(struct kvec *rsp_iov)
>         ea =3D (void *)((u8 *)rsp_iov->iov_base +
>                       le16_to_cpu(rsp->OutputBufferOffset));
>         end =3D (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
> +       if (ea + outlen > end)
> +               return -EINVAL;
> +
>         for (;;) {
>                 if ((u8 *)ea > end - sizeof(*ea))
>                         return -EINVAL;
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

