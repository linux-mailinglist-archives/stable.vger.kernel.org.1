Return-Path: <stable+bounces-242798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULwnEopd92ljggIAu9opvQ
	(envelope-from <stable+bounces-242798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:36:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A674B617E
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25D2300917F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1425D1E9;
	Sun,  3 May 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9iSFd19"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A872242D7F
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777819015; cv=pass; b=bNq1ta745Yqc5Vgx3THkXSv0mWzAyhzYcvrddKMkSBH5icqOaPZPbO9Lh5aPqfnSzOqA0ksg2Pvc96EJ9V6oo7wGnmL8HzIuNteCiozFErtVH808tI6VQy6FK5vAeBJcw5+VYNOZ7tVdXN8tUS89+kv0n3GkHD6JihmFeT0vfM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777819015; c=relaxed/simple;
	bh=Unyv3EZ/HB4GgUdtsflAJusHcnNNJnKZIPEseowCgbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7UagsdwpgpsdaaSm2DTqkdO0R1CptiELGIbSItsqHvk/GJggYw3r+Fex7doSWAUw4XvCcujwKZYVmP8NgJtEdtS6WLoBH4cPlTUYOkSYgKnFfNLCHaot7ELfWBApKuu2zC7thxNMZVbvuaeoijtR3NOa8jYoELSyzLJBT8i85k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9iSFd19; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b81586dff3so8346826d6.1
        for <stable@vger.kernel.org>; Sun, 03 May 2026 07:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777819012; cv=none;
        d=google.com; s=arc-20240605;
        b=Wj9wyT61Nlyq2F+axveS6E/j5HsJVlSOQnawMctKSyfc++6G+rtsEIwXPpdRi3B44W
         YD0l707sHAc2fWUKtHYrFFHL4OqfCQL0kDMdBYtzcnl678WLiTy1o0Ou4jvjcRF7HP9O
         OPmD/08HxsNluIA7cmYP6glfsSCaTRGpJTJDSOls51MN+U4Zyme0p/72NTrn91/NDdsy
         6zz/GwV5YYEAeg4lODFQuVdtibnSS/teOXiDk8dna4dYT8afN53mwdVoh8t2eJtLaz1v
         7jPlaRkwFtGLu7gQMTILuat6o2ETQpcFPdZw4rrVsAUtJ5EpWxyK2kre5+GKUERRYVRS
         vsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GI3d2iU/mmXcADFfS0JjbTvGYdNnQT9tF4bdBex1PRs=;
        fh=iHpabrpGt0jQXX3i5jdfjuQFo+j0dorVsqtoYnO6tGc=;
        b=ExJTx8j0NhVpPYyajcZcrAkaDWiE29nFx3GozSozJ/geHWZFT9xXPCtFfAtSvbeAqv
         PxBcen599fljlxI0w0iS4MMYkfSUE+ylGeHwwxphlmwCitDs2sDS/BxME/0NbQJob8aM
         J9gX6cgVQM2stnxewtYYmD/vzM7unzfpXkWzZk3BasUUt535Tq02lIv2f2OGrthCuiH2
         my4FYv/SFHiaT6nL12688CFJhKTJkNj3P32fMU5J9kDJBf/OBWAPjswW0NsAK6gONUSZ
         u/4PMfIG9vfCeHa/VKlLkqKEAjB8Aa1bUrwKxHoktTBxHVdm20Lm+rTiW7dkIM9ESfoE
         UQyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777819012; x=1778423812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI3d2iU/mmXcADFfS0JjbTvGYdNnQT9tF4bdBex1PRs=;
        b=l9iSFd19aW8JuzJlDRoA54ajq+zRBanIt4tZ4C/YeCneDBZrqh1h+dOWze2jyvxey1
         VnWLSqwNb9FzlYc812zbfc+DAqnU2sCWf/bXmRoSvGyDjf7SXJih1zvboI591Kq9vtpW
         +RghzxmEDiisqfAFGu0GzZObAWfTXbvKyVtpCTvRTzYa+sNdxvNvdjtUSRO07Qw/+dfL
         vHOhLY/COI4Un+2jJOjre9/Svv3WeG9FVDXR28KGaHNFjs0CmMqWGeZih/ZCSSViWkBe
         ULkS6nkjjSlO0mEdpR4ziPsB/BIY61btCZXtw4UDPJB3VSAFNv4qr37YHI3uFJyG/HqF
         efKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777819012; x=1778423812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI3d2iU/mmXcADFfS0JjbTvGYdNnQT9tF4bdBex1PRs=;
        b=bCWPYojYl7C6b1Zd08OLIyxNPbJpyaqjHYSKI8qcPbOIq2hnLOGKI/ikzyMG5vdkf5
         1tjmtnfNhbPWvERowZw6jiBs2U8yPUCJmT231hT6mu/rDWOQ7K7X7RrLNRDdrx9eY+hg
         7QC9Wbc6flhgwSGRjfuHtItE4kjF8Q0h9ilJojxC3rK+VIZqxC2fT1ZFl0OEJY7dqS7y
         2ZwmvyhMIiVzTxnW5MkPP2kZFVIapcsAmmgs8xgj9v3TPm/V01h/A5nwuF/dRsYqhXYp
         7kYOmLYD9Axuc0DKyWQmvM5nW9vmvo64S8iD4qQVh2qaJ7xd100a3SHxJLbUhD0uTZf6
         5D7A==
X-Forwarded-Encrypted: i=1; AFNElJ8rZj30JiP0xF3is5D2VSjoO8+taWNgPs5d8cnnEywZlyIqg9QK3kXNCrK8SQZ7mGXNxLhzI2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YztseU+AtnOGoc9XCEfvBz1QiIx2uSo3c7WFu+FNzA26xbBmueZ
	EdXp0GsXSLaANNOfhwldWsiUvhQK31lR4uFXHIZMv6nepo+XifXky45W5KzxIGw9Qtmi9UGVVxG
	kHM20NC2EXcq0O9B3Tkb6k06kci/YMmQ=
X-Gm-Gg: AeBDiesePTwIumfNOkexL690c3mU3Vcxq9VA5wGfZnojBmu2GGGIQbflWgDpSZ7yran
	THr68ncG3DZbuwfLZLzIIlZFegnljn6metuyGaNY7ZLV8Bwn0WdGk2rHapbo2Fe//tE2gIle7bs
	OkFvEm4Tk/yEwXGEV332bDU1SLSNx/xEWYF+CglLN/SfAh+G0xNtQbXwilCxe1q/y3PtHuQjuaK
	UxG8xya7RmZKw8k59Y7da5Q7W7MQaBCG8+ZRFv97sJpspQA9+EDvFVXsXnNPxkaSS1/kQ9ULAZc
	NiU4YAUl7IePOvKIWqw10FV/2pytaJOoepNZIbC9wfFT0SBXXxYAA4iR4uQ080f0qkpa7WL+Fb4
	qcgHq+BGaPzbruE/U12WIMauD0aVf2lfdHAjJFyMFyHSM1k6YsAi3Jja4P9kybLNujIh2A4hkZQ
	doz0FUpXtwZp/DIVZRoSqT2i+oBQu982jbVA2NZrCvOw==
X-Received: by 2002:ad4:5d4d:0:b0:8ac:a097:2810 with SMTP id
 6a1803df08f44-8b66805d8femr117628316d6.27.1777819012467; Sun, 03 May 2026
 07:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503134333.3260640-1-zisenye@stu.xidian.edu.cn> <20260503141713.3266571-1-zisenye@stu.xidian.edu.cn>
In-Reply-To: <20260503141713.3266571-1-zisenye@stu.xidian.edu.cn>
From: Steve French <smfrench@gmail.com>
Date: Sun, 3 May 2026 09:36:40 -0500
X-Gm-Features: AVHnY4IhwzVw1QzIcj7bVxZg5476jeMOsNbmOAxBdYrlyKp-zDzPHlUSlIZ2OnQ
Message-ID: <CAH2r5mu=Bv153P3KTws98MG=tC7NLvyb3sds8989pYihLq2tAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] smb/client: fix out-of-bounds read in smb2_compound_op()
To: zisenye@stu.xidian.edu.cn
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, gregkh@linuxfoundation.org, 
	chenxiaosong@chenxiaosong.com, stable@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 98A674B617E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,redhat.com,linuxfoundation.org,chenxiaosong.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242798-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

merged into cifs-2.6.git for-next pending review and testing

On Sun, May 3, 2026 at 9:17=E2=80=AFAM <zisenye@stu.xidian.edu.cn> wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/smb/client/smb2inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 286912616c73..28e01d02be03 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -121,6 +121,9 @@ static int check_wsl_eas(struct kvec *rsp_iov)
>         ea =3D (void *)((u8 *)rsp_iov->iov_base +
>                       le16_to_cpu(rsp->OutputBufferOffset));
>         end =3D (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
> +       if ((u8 *)ea + outlen > end)
> +               return -EINVAL;
> +
>         for (;;) {
>                 if ((u8 *)ea > end - sizeof(*ea))
>                         return -EINVAL;
> --
> 2.53.0
>


--=20
Thanks,

Steve

