Return-Path: <stable+bounces-270087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cq0WBbNzRGoUvAoAu9opvQ
	(envelope-from <stable+bounces-270087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:56:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 726396E9217
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 03:56:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L5Ps2yTQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270087-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270087-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CBA9302A7A8
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14836167E;
	Wed,  1 Jul 2026 01:56:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569723612F6
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870960; cv=none; b=MKQue8hxua7isO58E41MdrQEfn0oyM0gvL4lSyJyagOJfsclUc03cu7FG1l2DbhMB8Eo/LbJdNLV1IkwvGIrgC2X48nl2MNGYrM0M2JPmh59V2LnkNfOXhQMZdXcZd5z81cw7z4wLVl+qxJ2K/91DkhD+PVRdM22ETvyh5DUk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870960; c=relaxed/simple;
	bh=4mIi4p0t8FiEl76o5sTJP13tmIjADiLco8oz+Ebzfwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0mQrmgiUBwN82PSJNB6G0gW3TuYkQlA5AwXzRsCSo5Qvc/ltDibqRoge2sGLIssYtqmBcmPNrq4TKKaI9/dwtOgKpMgm0yfpanu1ckrcAKW4h4XWh+2PLTrGZACiCaOzum6tjfeQ0zhtOdNTN8mffWchyEJ4PhmNR/6hPkw3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Ps2yTQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3ED1F00A3A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870959;
	bh=4Y7Mu3qIX1rzeTFFd6h7gzcdLQmTsS/ys3zPwHxqqV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L5Ps2yTQSTVdmSsqrMHXVjUPVhpC4DPUj7MkuqSiNaBh6/6TugMS/qy5Xqp/+zIeW
	 oNx9c6ITW5piybQ940qMOsulbKO9o8EIyvfeq0SyAp57ftyVz1NGjgOkTmEpxmXMV0
	 n3x3Icy5GPGrRcwoWpWXYR76XA43MsfNGqtkmb3fRwUX6262f1WMqsyod5b4uZ3k/Q
	 dxCem4YXO/hqeZmTBXDxembnm6gyRil9XQhFOAMbbZALT5NsphWjEte+mhnuAxzXoS
	 NLUco0NePRFEsVOjxa1hZQDTX2jjnk72DmCN+6zNyRb2eY2gjSiEa5OJPexKqOGfRV
	 gM8HFccfsCdWg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so224866a12.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqd3S+DR73qRrg7wDkWhxBq6SDCKCGaPDFo3O4RXx6AZpRDpzWFJD7Pr5clUJvKxQbRwSS0is8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgX9pLzALGEIXaP/lqu4HbTvJFc/rrIT+EUS8dT+Ssu543Kns
	oPLenU8V7hHg37973CDwmNnXPktJ8a24y+qdoBqWcqwPb4Ru9ITHsJPk9y4tG2MHf/6rd1qklaq
	9BX0BZcyOVHB/QxABNVinGQpm2MUjWjE=
X-Received: by 2002:a17:906:fd86:b0:c11:f5dc:22b with SMTP id
 a640c23a62f3a-c128716a47fmr275124866b.14.1782870957804; Tue, 30 Jun 2026
 18:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630065016.48259-1-zenghongling@kylinos.cn>
In-Reply-To: <20260630065016.48259-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 10:55:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-hj98HnPfpA06dB=ZfLi91SBXf0XT2S-vhr2UdMq6rpQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfua2ukTvLahoyDc_ECtqT1NAUTYSrwibh3ueXHU75Pcv1gIhwjxTgKQfg
Message-ID: <CAKYAXd-hj98HnPfpA06dB=ZfLi91SBXf0XT2S-vhr2UdMq6rpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270087-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:hyc.lee@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,126.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 726396E9217

> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 9c1c36acfad2..e959387135b5 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -233,10 +233,18 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>                 d_add(dent, NULL);
>                 ntfs_debug("Done.");
>                 return NULL;
This patch seems to be written for the 7.1 kernel. Could you please
create a patch on 7.2-rc1?
> +       } else {
else { } is not needed. and let's move the assignment long err =
MREF_ERR(mref); to the top of the block and reuse err instead of using
MREF_ERR(mref).

Thanks.
> +               long err = MREF_ERR(mref);
> +
> +               if (err < 0 && err >= -MAX_ERRNO) {
> +                       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
> +                               err);
> +                       return ERR_PTR(err);
> +               }
> +               ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid error code %li, treating as disk corruption.",
> +                       err);
> +               return ERR_PTR(-EIO);
>         }
> -       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
> -                       -MREF_ERR(mref));
> -       return ERR_PTR(MREF_ERR(mref));
>  handle_name:
>         {
>                 struct mft_record *m;
> --
> 2.25.1
>

