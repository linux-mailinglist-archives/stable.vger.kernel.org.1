Return-Path: <stable+bounces-270114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0KvpMPjARGpO0QoAu9opvQ
	(envelope-from <stable+bounces-270114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:25:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4526EA9D3
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:25:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mPTkIe5t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270114-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270114-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117F33024CA0
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD42BE056;
	Wed,  1 Jul 2026 07:23:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3E386C24
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 07:23:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890637; cv=none; b=Q4Jn28nDh8P1IYExzckfX+Z6nl4k5ilT7SAaZbIa2e9LTsHpcufQ+48MyAc/jXLnJ5nwKn4Tdo2pbcANvvwpQQkquqVcjrS8q45uyjdMS4s7xGjpp6sZefeeXyU3CLUe05ZbE2zbGsrm6w/9RY4lYivWvuQK48fA7U7PY2e1BcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890637; c=relaxed/simple;
	bh=xBgKRQgBgGiy7DlW67HB4qALiz0nlI8I170mBNHVwik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul6haVarmuptp8Z0txAka7G7t/DEb04lD0npE+1DrREv0j7MZm6MCrZKltjrEH9SW5qUbUBC36QKFdxaZzvbUwAe2REiYvW46gZj/X8b237xINFCdqG+z71VHfdrkvT1KqNnaFToZ8tYOeYVfMnHp/4Z1kCnzbx1khgapPFxMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPTkIe5t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140771F00A3E
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782890636;
	bh=v+IHg2WxViz+zVdAZSPxzggSpywKO1GRs/+QAIG31bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mPTkIe5tioIWueL01SArrhs05xr2CNeMjE/jBRBOzxp22v5eHL9XPsFcBXV1owih5
	 laPCDaQedW2WgLlLmVuqsTzry38G6poqBtWDu2kbTs/drBq5u+vM6lWrQtN7Zla16p
	 6BalR/gG2PwclINuokqGGiOqu+TedbC5jQwMJFKwElgRtFKUt0WFe1Wa/p+b332utR
	 DvLZ+84GARMZKT7IBkb3Aca5Jc0h+SbJkZiKHQ4IZQXWhJ5m0DKjz1AE+Rt3TDRV3J
	 4nZoAmItZdUBF0StM8doww+0d0gVaqaXM7AOeDldrQZMkWpbVWhOS6twthOr7zULB9
	 YMmXldNuguGAA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c126b8118afso53641766b.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 00:23:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq0vxDNyzL7UFq67FuhZgW0UCo7D7abFy7K4vsdoXBxGYq8IRCk5M9bBTGZgqY77QqsZWdo7UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz683TmiLClpltid59XjE7DoqUn/EarfkrxbOqoFUV4uH/dIUyB
	Mpqq+6PNNBbAbOD5ZAp1lx7PL++DOKOcgXhzrMplTFweiCldwgRzGuFpCAhy/y3bLHZyoFuslqM
	qHSB4KXL25mBrenbo/px62lVZxMft+zY=
X-Received: by 2002:a17:907:60cb:b0:c12:1e33:8590 with SMTP id
 a640c23a62f3a-c12a9de707cmr15645466b.14.1782890634754; Wed, 01 Jul 2026
 00:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701070635.53544-1-zenghongling@kylinos.cn>
In-Reply-To: <20260701070635.53544-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 16:23:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8apB6yGP9WL9WQU3cw9MqU3sQXnjYVMT=Ttr4JBt_e+Q@mail.gmail.com>
X-Gm-Features: AVVi8CcExy3OWkN0EBkYpe9NxnW1P1rNPS_pFy2kaZh_qReVqjvTxoNwjzgq238
Message-ID: <CAKYAXd8apB6yGP9WL9WQU3cw9MqU3sQXnjYVMT=Ttr4JBt_e+Q@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-270114-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:hyc.lee@gmail.com,m:charsyam@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E4526EA9D3

> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index a19626a135bd..5229522b29ba 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -233,9 +233,17 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>                 ntfs_debug("Done.");
>                 return d_splice_alias(NULL, dent);
>         }
> -       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
> -                       -MREF_ERR(mref));
> -       return ERR_PTR(MREF_ERR(mref));
> +
> +       long err = MREF_ERR(mref);
I prefer declaring all local variables at the beginning of the function.
> +
> +       if (err < 0 && err >= -MAX_ERRNO) {
> +               ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
> +                               err);
> +               return ERR_PTR(err);
> +       }
> +       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid error code %li, treating as disk corruption.",
> +                       err);
WARNING: line length of 118 exceeds 100 columns
#108: FILE: fs/ntfs/namei.c:244:
+ ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid
error code %li, treating as disk corruption.",

Thanks.

