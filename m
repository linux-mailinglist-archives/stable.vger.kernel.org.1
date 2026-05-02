Return-Path: <stable+bounces-242602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMG+H/P89WntRAIAu9opvQ
	(envelope-from <stable+bounces-242602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:32:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CAC4B22BA
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8FE30125F5
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA071FBEBC;
	Sat,  2 May 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbkyD7XP"
X-Original-To: Stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717222F388
	for <Stable@vger.kernel.org>; Sat,  2 May 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728712; cv=pass; b=SzLVzRXly6ybcggAQkvP6uM9Wp13hDJ05QDM4NJy4g3iOne9bIOJ4boFKzizzbN/ONa9RzLx6fShZd+xJGhXCGUaGd8r9mLTQDtwEcNf5FR71YOA/LkjdO4E0uLPMJolzbrinHjd+CTcLNYq36LyCQs+EoR7ConQvpfWIbulq/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728712; c=relaxed/simple;
	bh=pgccSiTk7cwpR918eHNO4Vz2jYqp1tuwAppiPbXW6rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwkgGucviQsbCFKsbjlBkRmzYlokwLh4rJNwcu/zrlj54fql9S/zPm3h0awlJ3eFn9ewtPUu+gmWHM1NYXsYD3ArVbsWg56+AS3srx5T08Uy7Vhk+VVa4rylyMEVsruzU0D8odq+BXtlMgBdTKiTcbgAolkWGnKK3v1lHpjBoDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbkyD7XP; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso38923456d6.1
        for <Stable@vger.kernel.org>; Sat, 02 May 2026 06:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777728710; cv=none;
        d=google.com; s=arc-20240605;
        b=l2df46A3O+gOKJefKzwmmF+og6c3F3KteYxBwsOp61CxyVkvGsS8j5ZCboZT4mn9bZ
         n8XuzzSsVaFrmphZ51T4V66dgVE/rJ+IQxDeAJ5DgIphNUcD257xndL+W0a8zkRK9uEh
         JV6B8uE7xWD1fBXKsidPAjeZ3ZMCFR6IbLDvNOoG6CCkvINFVqo1hYHtLHHXh51IvEY0
         7OMhV02xQ+nuWdm7ZxVjVCN0pYYTCWzKwnThjjP4d0i75osq6zCkIQxQZxZXn/52nDN+
         uCXR3lWxvRvXOkrj3DVi7QO/uDT0+bKjapW9bjUgB6svimmIC+r8TX5RVVcYZDG4FTKC
         VTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hrz1mttDC61uI6sTdrN+XNGEUMww2d9RdTsgZTXNbkg=;
        fh=SMItuREHOGSq13s1J2UoKhbq1sUKUsNco0kf2D85WuQ=;
        b=NG+1hmNoxiHtRzWXWHSbo7I0qU+d59v5itEuv2PYSNKhTJzr0jYcRlCFIoIo4e6rJl
         YK5qL0pDRyVrr6Qugap5NVzz9Qo0DBzQVPa25Hr3fCAWith8m43c+NY2CGTlVqWR3YF4
         td3ocXKQWCD9zD1fJGPQ0Fc1AriBkwFBXf8xs+TpuHOfy6foQE7xbPBT5zzDQ+ySYbCg
         mLX/wS7I/BoMXcVU5dB3jIM2EksTl6OyOpaHb7gfTYL3qJNuYRtN7fTpdFMKM5I8RcrC
         4pE0DwE6ap4RYlRJeMLgSkIoSJrbE0SyI2vibM+cU//PSYC5ExC9D7M1U4TH806NAa3Q
         iOIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777728710; x=1778333510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrz1mttDC61uI6sTdrN+XNGEUMww2d9RdTsgZTXNbkg=;
        b=qbkyD7XPoCk03zOijwy5/n4SVmcp77/JlJM8lrIxLPPpdLTmH2rwM1OF9gEEEZMBbv
         g5D1srBK8wU0K1qKE4OYTullwdsIB444AuqmH4fmt6MJeeyl9h1a5tETHBBDLpeUf2xq
         woX5gTTSCuxbl+wGpXZc5i383FPqPEXXcwSoBmh4wP8zPM0kFVEeT/415w5rVbw4NEYu
         9n7CXAWZGHpJJ6ja1fJswQHtkTDLt41I6qcmjyR5z6OaLOZ6ya3N+btz7tR93k/pePv0
         h+/RgR/GUxkcSUNSETLtIUzAfcbYcjCs7+QxkCIa88NjD228NdCnDEDL7xhH0Mj3IR+d
         Q/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728710; x=1778333510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hrz1mttDC61uI6sTdrN+XNGEUMww2d9RdTsgZTXNbkg=;
        b=huTrc9LCqCQsehygQe5jaLwlpVZvW5cwUr/g//mIlxvmS0EES/HKOsW0yUTH1eQ7hH
         jxSI2K7CpzqhNOzZIUH4VHbYjxpzQQhZ2mpOccGGK7cIX7MgQwhFzryEghn9Qx6/2S/I
         SzgOKkdOluFfx5hpQ47UUOmj8nM/IQu1d31GNQR0TvATvfAvKlRWB6xGxvsisJTyjdlf
         NTS4Fbwokwds/I3HI1AdXidmM9VS33m/wy7MiPRv7hBL6NeZVlu1Hs4/6mO4lnwdQl99
         ormbBqEb/sMFZnAa5wWTJhx0CBAt8x5TiO51hInVN4Zcki2/+pRxXQeP0XpsSPo35mug
         ActA==
X-Forwarded-Encrypted: i=1; AFNElJ/vVfQnrX1yBGazQHFAc4Cz1OB50UTVTBBslyt/9WwcRMthVG1wPa00JAZ1sMVB1XvTCJibwzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOfUdYFwU9rVZ6iOwwe56tZxr9SD7XE0gHHgUsPMdFlLUwcA8
	Gn6w72u/LPDzGteFh6vCBEoMk1p36MTeEA7mxO9PlftDU0PdjotuelJXKrgb0INEgPApXbmgSZL
	J/SLvvsBjtd58x1z1QYr0c+LvzqzGBcY=
X-Gm-Gg: AeBDieu/VN3WSldV1ihg9NVvdKUHEplTiwP2m5mBbVnAIRiqj/VWiJLGSlNEX4ErpR6
	iP40MVYpl06zy61Gmnxfo5tTWxO9jt9NAQCPr/jalI/wnj5+f0OmegBQEv1PLkeTRuUTqPrgsda
	Q/qVgYn8rgMYc/DuWPPK0lj/VO8mSBF8Nz9GpaT0eKAJZWGVkS147zefPwm9DLzk2qFRFLYm/fC
	dNiN4nqvcjaUbTL9AtWOos/fZ12HQhkb1vNDnxQQmsLyeEHHRTUKpyRrmGGgnslSWEsiJ1l9kmM
	svi5wnfM6qj0yrWhRuk33XYRYSIODb/THF3evCMlPl23ZifYpCrwK0YXEmIu1eHAOjFj56jQXoh
	n7cd18r7X4pFx9mNKn1ZuslG13jufgn3zvK1PlMClbR4Vwtldejkih6CSi0lR4YEJZFhPlrE=
X-Received: by 2002:a05:6214:4c86:b0:89a:1c81:65a6 with SMTP id
 6a1803df08f44-8b668732e3fmr40217166d6.17.1777728709600; Sat, 02 May 2026
 06:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502095435.2969835-1-zisenye@stu.xidian.edu.cn> <20260502104836.2980415-1-jasonye247@163.com>
In-Reply-To: <20260502104836.2980415-1-jasonye247@163.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 2 May 2026 08:31:38 -0500
X-Gm-Features: AVHnY4IA2OM7KepiFDCKXPMHG0pkdd0-xitH6I9Qe-pVWSU9I1aM70hKjPNlndg
Message-ID: <CAH2r5muMKoKagbZiezK5HpfYtD0Tva5auOhJoRjXtSaNNzyYpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] smb/client: fix out-of-bounds read in symlink_data()
To: jasonye247@163.com
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, chenxiaosong@chenxiaosong.com, 
	gregkh@linuxfoundation.org, linux-cifs@vger.kernel.org, 
	Zisen Ye <zisenye@stu.xidian.edu.cn>, Stable@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4CAC4B22BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242602-lists,stable=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,mail.gmail.com:mid,xidian.edu.cn:email]

merged into cifs-2.6.git for-next pending additional review and testing

On Sat, May 2, 2026 at 5:50=E2=80=AFAM <jasonye247@163.com> wrote:
>
> From: Zisen Ye <zisenye@stu.xidian.edu.cn>
>
> Since smb2_check_message() returns success without length validation for
> the symlink error response, in symlink_data() it is possible for
> iov->iov_len to be smaller than sizeof(struct smb2_err_rsp). If the buffe=
r
> only contains the base SMB2 header (64 bytes), accessing
> err->ErrorContextCount (at offset 66) or err->ByteCount later in
> symlink_data() will cause an out-of-bounds read.
>
> Link: https://lore.kernel.org/linux-cifs/297d8d9b-adf7-42fd-a1c2-5b1f2300=
32bc@chenxiaosong.com/
> Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/smb/client/smb2misc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
> index 973fce3c959c..2a7355ce1a07 100644
> --- a/fs/smb/client/smb2misc.c
> +++ b/fs/smb/client/smb2misc.c
> @@ -241,7 +241,8 @@ smb2_check_message(char *buf, unsigned int pdu_len, u=
nsigned int len,
>         if (len !=3D calc_len) {
>                 /* create failed on symlink */
>                 if (command =3D=3D SMB2_CREATE_HE &&
> -                   shdr->Status =3D=3D STATUS_STOPPED_ON_SYMLINK)
> +                   shdr->Status =3D=3D STATUS_STOPPED_ON_SYMLINK &&
> +                   len > calc_len)
>                         return 0;
>                 /* Windows 7 server returns 24 bytes more */
>                 if (calc_len + 24 =3D=3D len && command =3D=3D SMB2_OPLOC=
K_BREAK_HE)
> --
> 2.53.0
>


--=20
Thanks,

Steve

