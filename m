Return-Path: <stable+bounces-244427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECeHKPdn+2llawMAu9opvQ
	(envelope-from <stable+bounces-244427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A469D4DDE50
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAD6B302A1ED
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A247F2EE;
	Wed,  6 May 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcLYxkJr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3C48C8DA
	for <stable@vger.kernel.org>; Wed,  6 May 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083454; cv=pass; b=iiBSoZjUKtEtwtwxinqk+ohsg1T0KqPVnP1rYomFF2W4YZcwTIILwtcDUpTmtTU88/lmat/40sekZrhyeOJSbTMrHq+rWgUDjqAh2dRrfi8N7h4/ddB/Stpj5+Wk58GgxYBSBrAwMZmmgiUWxIokhLVkfIV8VKocYWfN2sdzblM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083454; c=relaxed/simple;
	bh=Fg8EEuRqGMcuOJonHCZqjWuPeHMx8eaMvTea/nfCVxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU7qHPbM2f9YrpES//OTvWmEw3APFlGPkw+NtjiOlMCa7e9QMrJlgsis2Gomi9NVhrvD7rp/0KnqdHDydFIX+ukpLwMg3IizC0dfwUGnOzw7veMIXbx3VUWwqnPC43OJTecgPFxzBDHG+MOVWHSS+XLSJPcYUkq0tchp5UVCS5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcLYxkJr; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcdd1b492eso1028148a34.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 09:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778083447; cv=none;
        d=google.com; s=arc-20240605;
        b=j5CXCeLjKcuYAm3/xT7nKoJ+9DjZmEWmIQEl1mnGA0U2BoKBfXKCdItjMebJHL/nqx
         VIFCyeBkkZoiUuoIdVmOhn4k0sUaLoVJ12Cx6Vc2ZcYDJMtGiZQhjdnGTjSiGfziUbyC
         UeN+2DpcknzQvlI4jKMEvorPfAkHnXed+jL6qGXqreSL5OKgPBlNUOY4wfvM8rMx2Zgj
         7n+fee8lQ0B3Fv3DzJxS+ItpZmzSC9FuIePM/tPQt3+qjdV0+3IjhnQ/uv2ZgilKgWev
         15NtCXz8gsdvLs7OL6t8PTdeyWrSkbjbkRhS7GWhTS0r7zlH2rwzdvj0jlIOxCfJGg44
         kxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27ftTifho9ijIe7sntRorAaSI5wWwVR8Uit6oJpMlo8=;
        fh=SR1nlhtPCnmB+uty7BEWDWU2wQAuJ7vuXNLuDdifdlg=;
        b=aMWzgtVhViDKzEO0hCIXPTFgt/LhO9UOfmNgauuTFZKJ9Z2VSM8zeprtXwlm3I2lSl
         MPPDVlXJ+cQ17H1dz/Zt8grLhBDcW6fDmhSXgjNha2gFIeJI2NO/cpqWgfjz/9eqlWxK
         hLaGbpc61S91csbcuE3uHvc8s6fHMLN51eExH/ktpniDaEnCbHhzvO9OyBvYE4XtDYG6
         3VfpHk6Iu3Y9OWs3btl5/FRjhv8hhJSgZVeaTxdN01AAXHCBrzFXPxZVJ2LOqBb5nG3L
         bPAODjPRIhdWEicZtTbpdEuCAF7YFIuTsC2vU8iboQMm7DTUy8tV6EXLzwbkcSshXTPl
         ARsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083447; x=1778688247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27ftTifho9ijIe7sntRorAaSI5wWwVR8Uit6oJpMlo8=;
        b=dcLYxkJrmeZiDOns0wKITnZZFT808nnc2q7+14e7hzi2Dkk4tVEa/RI0LhGbx6rAnG
         TMIHGCVttDuzCZ4512XPzbXcDeVLcfGtopxDFkEBnOkL5pehCJgNAkkhFKS/DwJf9cdf
         oU0DhrKNaP1OfsugnNxtpUngGDXXHSCthnxEoje6es2TuycRHNKBMLkFGj0UE+4hXDzg
         oW32FC6lCE58gYGjDuk7J8l9ldeAFUbq0898Exb94bTVcF8VcdRFvh9Ar/NoC6cs2WLo
         zc/dvlIlZAILJyDT/R2XeJJl/2FsxDRbdKkjPPehdzcFq/rJpvFzixP2u8LnOEzVEnNt
         VUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083447; x=1778688247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27ftTifho9ijIe7sntRorAaSI5wWwVR8Uit6oJpMlo8=;
        b=YqRlabZ0bTa8PW1Q/+yrjgAGTF5uufRfe9uPSvLZCY1rE742md0t0M0364Zbp6fb7L
         NHSiGAiudqneQkwlSleqn9Zsz2EHDEoeLI7VSoECAKTYCRfbWXEKFHPL3YAec03uKKTx
         tYKPuVj08IYky+303llppH4Iirz/lZifjx0MUnZfEP4bESgPnCJ+sLVvkpqzibP/0y7N
         RLOEM3u/TmQLzx+FHDQlmjMPf3NQnYGHfRCeNGgKmJPLv8zlr/wlqZN6C2TyKqDkNe6r
         NRaW4dvuTJILWXMAGQTcGRZC0/NCfr4XCe/C1bRo8Tfm3VV1euyiMPcoU/4BLNmnVYeA
         XdCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pj/rQczyy2t1sEDmLvUcaj3BkGr8jDze519f+Dd6tEbU17fdJVlimhjPKhH4dHuLusc3IojE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65PcV5xfEH0z2+tFjlgBwws9uE418OJtGvqCaX7KCVtofpsmr
	hma9C7lbVGsz8tbgOoSQ3YAGyxWrgUvpPrlBioAImaNFeVTNMFue9s2IZAtJmGHC/QF1cu3Vvq/
	aTnK+ou2aSEB9K+C2fa7mJ7K196+v9L8=
X-Gm-Gg: AeBDieu2N2Dt+d4aTYFqAfK9RxQscifKJVJYpBgmaJyTKphib9feHYg9tRplA0dCIcO
	dIJkrbbRd7adKBVQBO/kOE5aSumB0WG0l8C1LKdlxc4MxIh/4iQ0bpGFxEG7aUISrlfm22yX2U2
	SPRQF3cvBsswMdui0oiiq79QxVAqlkeGNUhoIuStMEb7ADZLBswV/1EDGL9R+v7Kf4qgUEwHIOH
	TGywHNuOBpR5vX7CRUnkeaNP6sJcX1RZ6EfnTpUWW+QG8W37zelqxWOpzTdLMwUl58Jj9YSkmKk
	L+FWxSEgmLvQ9W2tKcPJNaDHKTw4znIc/MAhmg5tC2q3Tcds1X9KR8A1ahF4aMIJVa/gfsSf4wN
	sD5VrBjWqTgWsdDH88u5ct1oOxGd+CLncRc5LFa0dEIkTP6WFt7vXltBn6tgPPBik4NhWH7R+Hy
	2tyPHh+8DCJI7rhVQZti1qKWineDZqGHTj
X-Received: by 2002:a05:6830:1647:b0:7db:f286:18ee with SMTP id
 46e09a7af769-7e0b06486d5mr3447978a34.4.1778083446543; Wed, 06 May 2026
 09:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506034908.3874700-1-zisenye@stu.xidian.edu.cn> <20260506034908.3874700-2-zisenye@stu.xidian.edu.cn>
In-Reply-To: <20260506034908.3874700-2-zisenye@stu.xidian.edu.cn>
From: Steve French <smfrench@gmail.com>
Date: Wed, 6 May 2026 11:03:55 -0500
X-Gm-Features: AVHnY4KD8pSY21c_3lP4hp3SV5i3cobuPX3SGSnjTR8A853UrRYet998deLuDxQ
Message-ID: <CAH2r5msBgZn6QC20gR1p8pMMv-iTKabPbqU78O1MzfW2-1r+JA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] smb/client: fix out-of-bounds read in smb2_compound_op()
To: zisenye@stu.xidian.edu.cn
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, gregkh@linuxfoundation.org, 
	chenxiaosong@chenxiaosong.com, stable@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A469D4DDE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,redhat.com,linuxfoundation.org,chenxiaosong.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244427-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.688];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xidian.edu.cn:email,kylinos.cn:email]

merged into cifs-2.6.git for-next pending additional testing

On Tue, May 5, 2026 at 10:49=E2=80=AFPM <zisenye@stu.xidian.edu.cn> wrote:
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
>  fs/smb/client/smb2inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 286912616c73..6c9c229b91f6 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -111,7 +111,7 @@ static int check_wsl_eas(struct kvec *rsp_iov)
>         u32 outlen, next;
>         u16 vlen;
>         u8 nlen;
> -       u8 *end;
> +       u8 *ea_end, *iov_end;
>
>         outlen =3D le32_to_cpu(rsp->OutputBufferLength);
>         if (outlen < SMB2_WSL_MIN_QUERY_EA_RESP_SIZE ||
> @@ -120,15 +120,19 @@ static int check_wsl_eas(struct kvec *rsp_iov)
>
>         ea =3D (void *)((u8 *)rsp_iov->iov_base +
>                       le16_to_cpu(rsp->OutputBufferOffset));
> -       end =3D (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
> +       ea_end =3D (u8 *)ea + outlen;
> +       iov_end =3D (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
> +       if (ea_end > iov_end)
> +               return -EINVAL;
> +
>         for (;;) {
> -               if ((u8 *)ea > end - sizeof(*ea))
> +               if ((u8 *)ea > ea_end - sizeof(*ea))
>                         return -EINVAL;
>
>                 nlen =3D ea->ea_name_length;
>                 vlen =3D le16_to_cpu(ea->ea_value_length);
>                 if (nlen !=3D SMB2_WSL_XATTR_NAME_LEN ||
> -                   (u8 *)ea->ea_data + nlen + 1 + vlen > end)
> +                   (u8 *)ea->ea_data + nlen + 1 + vlen > ea_end)
>                         return -EINVAL;
>
>                 switch (vlen) {
> --
> 2.54.0
>


--=20
Thanks,

Steve

