Return-Path: <stable+bounces-217945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GtCM4wFnmmhTAQAu9opvQ
	(envelope-from <stable+bounces-217945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:09:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457A18C47B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5ACF3053E14
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534823358D3;
	Tue, 24 Feb 2026 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJcaled3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A833554F
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963781; cv=pass; b=IIwRJbDBUI8z9j3nGVXNez+cdglnHS9SWGN+aVuLxcOZ+1PVKgnjCuxwO6ZD5+35yuZvDXLebYTIrMUf9qn2p/2rJk/Ah/1Dc673URDIenBo51EOOfr1wfVT2YSu2SnQekNZTcRfg1HPzSz3xTi2FOwOn9FMF2ex8IbI9JUZcfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963781; c=relaxed/simple;
	bh=2Cg/DXUaQemdS7si661sB6VqKVJNE0PpNQT4QAW402w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3YPXy7sB35cpNXvss1BqOQhilN4/mZlOJRW5x7KQJ/taNlkzu96GiQe/ZQH06+sgEm8Fra1QUGsgcdooagC+mC/j1yQ9S53MjBTqTyvtszbpuYmIfBkCjuo9GxWHGkJSV/5LZ+kncjR6SZi8DhYyDQunT0xwE/xaj08a8wO/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJcaled3; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50697d6a69cso32859391cf.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 12:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963779; cv=none;
        d=google.com; s=arc-20240605;
        b=Iv6YYw4fQcAcJUhuE+KK8p19aF+UmGbOFkROzy+LQXV7x1fC2bsBIFfYPkltfVCW0D
         lRqPZ4OQUaVniZ41BW+wHiMxupMaPQPNWkl+wv3QBz0Giy4JA6+L7AIKPGpiA9JpuoQo
         BXQ5VulPSz69wTQ7ZmEK27+0QGd9ijahhyWEt02Uou6kqLgcuZ3cEU3RT++x3hAje1Yw
         WWc2JzKGNPOvvdRohkaWRkD7PxoE1Q5wl9gov6vUUMFmhMiMwx2Fn0LKjM/M4GroYF/+
         z9GGGbNjOoNdVmUl1tmSvS7g8UKfwDYFdYYo0P2rpw+GgGLywbtrBH40X5S68VGMoh5J
         VngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        fh=Hx01wOOgbMwuw5kHRxkym6wd1U73orQZyGhv138+VZo=;
        b=AE1BxyUWUJ8BKbXBQolum39BS3666lI2Vu6E24gcBYqRwug3ggL7Hnhc1dsrCNDL6f
         +RSRFcgflPOAHKq8D5muEQwQuiJmx4vLUh+lY4uviuvcDiiH3BIam0gAwFu7HWHBD/Cm
         EYP1JXDs31O5unUAHuvmP0G7ZtZi41Zeo/gqa10MRMiKLMRVFiNF1oQVfbE0XnjeP654
         gY4cwX3H7TMG+yMGctiBQ83+yQWrjunhK3FSI2PHTzxgt6U/gNBD8ta8e65bTTzQin1I
         /TPrkPWqyqfR/HJd4/xEUMXPTmo7Fum0X48Ogq5x+xc0lPkZ6dJ2NGdFAkXGD9LVLH0J
         37uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963779; x=1772568579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=WJcaled3m4rBPyjQcD4YEGhqpMqXciFvxDGDqawJnXTo3PBfC4cw1nBi4+ors4LGz9
         aG0KN5kh9om+TTrTXXFwzDQMGjKIKgBItoEpOQ6c+VxTiS1pBfDZl79MTOYsVBuhEqub
         +Eoz1MvlXYTJFjP7a/rGvujL+ch/6wd/+kZ1YjUPlN7aySKajKYlkZScS28tEZifgG0v
         3cH1dwFvEYjQyn+jHiXRO6DgsQCjIFKWMvyhlDvY4iuXinDF374LYfwTQHctFEHLJ0jw
         RK2SmLpLnmRONJ7JyQYfpmPJuKbaLBpLNzphejagMtsuv4pf+Q7j3u3vwFhpHW7E2E0l
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963779; x=1772568579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=QMV2DnuJuiqxTSGCtFbtsGvDNyD3I0GjIuqVo8rqKFe3n5sJpENaL/gJhsSc/KTlnl
         FGDGmNU1djy6GTwi3p3cTbSBsYoDQbqYSAx8vFeWydCVXXo9Xk/MYitHvi/vyhP58abp
         KUlEAMAKKjX1Isl7D8SXhunTDAUKcpe66FmMZtO0BNpykl39Yp4P9LP0ZK23hwsMnTKj
         zg4OLfyhFmhl69Iue+6sjCtWu/WNMTk5/Y1qprQ9LIbEPcevnkV3oaOzArqwy3rQAyPJ
         sC2tIxG2Q3Uh3J6D/6n/AmOfm7n2VW6xh8ZxLLlD9cHVqhZ2CFvbkqzaB7bGvAQfh3xp
         SWfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjzdgiBn2YSQ5AHa6V/0M4AGwxLUfsXhEIED+iRgn5Jv0I1+GUct/xGIbadKBEIjwpy8Q0cho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTB8odm1Vo2kEIBVUD/zbUGqGvI76mRi0cwTDmav8ZxORposiG
	ry1P2Yrn0ydPadk9PP3l9TUsakgovP/sZ7v0Dg6EqWpHN3GlXeihXgbOyEDsy2+CkWJb6PoBPar
	53B0qscdt1jgstrrZkN0zhzh2pd9LZAw=
X-Gm-Gg: AZuq6aLrdkZPkjrmnvfOokTs/hvU7GyryaHU/JgxZh0UvtPTNCVfgTI/nZyD8izsq4/
	cOD4ToNCt67tlMzQt3ZZ0ZPrWf9JjaiuF7EC1lD+hPNv1lGVkgYr9/dEiO3wAWIm28pqZUerxWv
	G3zNO34FPa1dyIMmqUuaHQc4ymQbrYY7Et0xgOhG+3B3rnED5l/gJn9NCx3ADU8gZ3lB8CxKANe
	quQqebRhefr4Vx/CMqAi35z4T2/45Kt8vp/YBwu1O3zhmVhnLV+tgxZtKhFD5WA0h8nqYDcXBzu
	+IfK8g==
X-Received: by 2002:ac8:5a05:0:b0:503:2d06:8e15 with SMTP id
 d75a77b69052e-5070bbd5fbbmr189408691cf.21.1771963778577; Tue, 24 Feb 2026
 12:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:09:27 -0800
X-Gm-Features: AaiRm51mgRlWbkXb6u9q8vdEfIKt7UeLJ2adO4XjFSbDCtDEImXRc2B_2FbsvY4
Message-ID: <CAJnrk1bEm=pe2M367CsbQNYyUEdXCVzAyboqqHnSCxx7fxZKZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stable@vger.kernel.org, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217945-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2457A18C47B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Makes sense to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/control.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 140bd5730d9984..073c2d8e4dfc7c 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct =
file *file,
>                                               const char __user *buf,
>                                               size_t count, loff_t *ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         ssize_t ret;
>
>         ret =3D fuse_conn_limit_write(file, buf, count, ppos, &val,
> @@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(s=
truct file *file,
>                                                     const char __user *bu=
f,
>                                                     size_t count, loff_t =
*ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         struct fuse_conn *fc;
>         ssize_t ret;
>
>

