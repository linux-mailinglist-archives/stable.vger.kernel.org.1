Return-Path: <stable+bounces-225660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNQTLN1QuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7529F45A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE10303EA8F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDE3E5EDC;
	Mon, 16 Mar 2026 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6jycxPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E230B509
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686904; cv=pass; b=eO482aKhyM0+VIcVMjHMbEoxTDjTZoOq9F/WvWakJG7QVdO2tKkpXBFefAHKNBtI57BgkXwYOTyWNmCvsHsU639kZC/fKCjSFodz3DOUVbLPp3IclVKc4f7DX95PFkNyUI38HeMdiX4kzf7A2Ex/YHeiA4UIYd+5cnC5tVyM+pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686904; c=relaxed/simple;
	bh=UvWF57nXqI9vHHj3agvW/9JVTqcg20vwpy6Zqyd76bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMMJU12o+8aD/XsCXSt78KBLhKnqGWujWMgW6+xhiowSkZBYYdtDNdQMONvVO8arWnZ/hHH7DmaaIIzyom3HdzEoV23HYwjyEjrFxZnqNRl8lnjQQamACwBBG4Uh3i1jFvX6sSnd8feOkwi8nTG3Mv+F99BcZLdTMXC7PxOI5Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6jycxPW; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c6fc2910so3761258f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773686901; cv=none;
        d=google.com; s=arc-20240605;
        b=JAGFVHz6R70YscT7B+azkYIaMD9kM388idUTDTF3FYWBhgk6h/4z4ptWulieyipLze
         U5SiYBZDmUdYd9Y1IlJiG/4e33kPukMCOuxMSwj2PbXVNqfoIqeIFhnUBJ9/nf9lqJFG
         4e4lnQtd3de+b5EVRxYEcpT+efGgBgX4ADXlkgF8p6zgj11Dq9baBfA7BPVXd00zLkab
         ld1uF/UZgyOc1BJW3b3rPxUXkk1ymBXyMUkBAdsLcUIC0lcCwC63qYR3jJnfW6NvR5Z6
         KGUNjTHEd+vL3objLatLHRCkY5YnWOIvSLCkkUANNfDD3W2nK8mioDFkqXkv6K3bbnF0
         zk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        fh=Ib63GqBV5chd3rQZ/p2tbryku1EdRqnVI4LTJOSVZw4=;
        b=VBPy0cxzuWZADXBE09AeIz6E7Y3u9Q4eCbAsirBZdtWZ8Z7BVH28WH3qKxqbfluNgN
         zaoTVH4cnbNr4XyzujqIKC6bTn7HGkCzIA3O8fpgeVSkqsSnzegMNCp2N/6qngn8oUru
         UKMcFawsGFa0B+i+EiwlTJ01uB9RKr5rdJo8LTbAWU7kmcVFhF5jo+acsWJuAjdym+Yi
         b8SiWBiABBBqD7V8Yht8QwjPUXobQCAhVMrEQGuuCawLDOfub51UuSMxWBJ3b+D34jjJ
         veqZnUenUd9OXi5HQ0RCqrplYocbwhq79ealIZh2TPu6ybqXwDy8JsRbGE6ke524wLzc
         gjZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773686901; x=1774291701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        b=m6jycxPWJ6wAimrQuV+R2rgpF6jgeDWP9EFYimZEZxzR264avQErYcND3XyRRwiBjh
         8fnrMYq0oe958ygQ71Y9CYC5uRxaR41A03wX6P1U+ppIKWqLB6lZfaDodvKjC4YMIO/r
         tOdb57w991xgNE1eTb6zygqFp0fV2s3PcEw8ddXgol+KCdXddb9of8mpOvtdNm9/1uIX
         1p1/ZVFMCDA/hu4Rmmc01hQdJWdQcqjshXpchlKYv9fD6ngkCYw1B/g3MHQVkSqMzN58
         FbNOpFoZM11UYXEPZF+h0gDc50EzAS8oi6231xJL2OO/0+CBM11y9uDPbzU0wYnsr+1m
         FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773686901; x=1774291701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        b=bzlOpEhK94jgD+hefuJq8S7Nne+yXytRB8/9qu4BbY+hXLQKWMfJlef81wKzUmwPRT
         Pb5y8gYKT78gE7DxjSYvSsvHKLtAMKTiHYdEGSbfpFsC7S/xthL9JJzwHw9fahkGvqee
         nlUj55gRawdqapO+MC7cadbIufKBy3KDtA+rFgUDeQl7PQKaWw7dhOozG+Vjb2P5SDWm
         rfJq+dhvCg9+drXYzijF+fGeGchdoNISgD/Ory9Sjc898695NjD1iOwqSm0LJcKfSuBA
         8Q3QeEMvEkmzxM7gppioBDns5xSu6I0Tdsf+7qri5t03u6GlwkVwTADMa4xYhDVPjxok
         J5zg==
X-Forwarded-Encrypted: i=1; AJvYcCVFZWWbpwUYDyMEjQrmitaLZZB1UI69gRR5Owz78ZlVLz/ppyYSrl3Z6lzcnG3Ihk9+W/naNfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvOTUzyZTCpTEJrBCBgCDqUBm8ypafLD0Ivb2wmD6jDHpZKmo
	RZz9HqUbQvI6+rZXPz3db9jkwkFwX1FsbI37BjAyhf0kXbeV5n8nrBCugbeU9I854WnyiHK1rDx
	rsd9UjCwNL1hRC3Zljr90csXeVc/oQfA=
X-Gm-Gg: ATEYQzx+75Uf6IF9ajxvJ9sKBkwJtVcgn6akDvCQxShWaEY8GX/Q4vAzWhwMPduZbey
	kdVQS/QJj+Lsr9mglH4WpG3Q4qktC6gNDVQHu8hi/YMwo6saFenSLD38dlLOf/qdqyW+ggOIpaz
	8NGGyQk/prqhXKtV+IMauv6NnAW8gMPB7XZm9JrnWFPWB/sRQWqz12En3OM7feUbAenfeXLLNZm
	89Z+hBDJbdbsGMD95FmrJm6MCZjEu09Qgi0+kzmnCvzTyOd4HRMEYhWzvVxe24Fjrrvku5EL8tj
	GHTo6g==
X-Received: by 2002:a05:6000:4310:b0:43b:492c:8349 with SMTP id
 ffacd0b85a97d-43b492c8602mr2857424f8f.3.1773686900933; Mon, 16 Mar 2026
 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-2-mszeredi@redhat.com>
In-Reply-To: <20260316165320.3245526-2-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 11:48:09 -0700
X-Gm-Features: AaiRm52ozqBHON4mjfX3OgUHvOecBGZhPeVdde2955BrAmJ9byyH-P5BG2hpsWc
Message-ID: <CAJnrk1ZCLS4BhGJm7y4HC07tvAL-KHeU_B-0ep_1r9kaaf1Lnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 18E7529F45A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 9:53=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> When sync init is used and the server exits for some reason (error, crash=
)
> while processing FUSE_INIT, the filesystem creation will hang.  The reaso=
n
> is that while all other threads will exit, the mounting thread (or proces=
s)
> will keep the device fd open, which will prevent an abort from happening.
>
> This is a regression from the async mount case, where the mount was done
> first, and the FUSE_INIT processing afterwards, in which case there's no
> such recursive syscall keeping the fd open.
>
> Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

LGTM but left a comment below

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c    | 6 +++++-
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c16b94357d5..f0631c48abef 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
>                         removed =3D fuse_remove_pending_req(req, &fiq->lo=
ck);
>                 if (removed)
>                         return;
> +
> +               if (req->args->abort_on_kill)
> +                       fuse_abort_conn(fc);

Maybe more straightforward to move this logic a few lines above? eg

@@ -570,6 +570,11 @@ static void request_wait_answer(struct fuse_req *req)
                /* Only fatal signals may interrupt this */
                err =3D wait_event_killable(req->waitq,
                                        test_bit(FR_FINISHED, &req->flags))=
;
                if (!err)
                        return;

+               if (req->args->abort_on_kill) {
+                       fuse_abort_conn(fc);
+                       return;
+               }

Thanks,
Joanne

>         }
>
>         /*
> @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap=
,
>                         fuse_force_creds(req);
>
>                 __set_bit(FR_WAITING, &req->flags);
> -               __set_bit(FR_FORCE, &req->flags);
> +               if (!args->abort_on_kill)
> +                       __set_bit(FR_FORCE, &req->flags);
>         } else {
>                 WARN_ON(args->nocreds);
>                 req =3D fuse_get_req(idmap, fm, false);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..23a241f18623 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -345,6 +345,7 @@ struct fuse_args {
>         bool is_ext:1;
>         bool is_pinned:1;
>         bool invalidate_vmap:1;
> +       bool abort_on_kill:1;
>         struct fuse_in_arg in_args[4];
>         struct fuse_arg out_args[2];
>         void (*end)(struct fuse_mount *fm, struct fuse_args *args, int er=
ror);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..84f78fb89d35 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
>         int err;
>
>         if (fm->fc->sync_init) {
> +               ia->args.abort_on_kill =3D true;
>                 err =3D fuse_simple_request(fm, &ia->args);
>                 /* Ignore size of init reply */
>                 if (err > 0)
> --
> 2.53.0
>
>

