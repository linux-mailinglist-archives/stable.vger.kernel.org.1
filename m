Return-Path: <stable+bounces-247191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGlUDkvCBWpMbAIAu9opvQ
	(envelope-from <stable+bounces-247191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:38:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7369541C15
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9DD302C935
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DE3859DC;
	Thu, 14 May 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooTxHsHx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C73C0607
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762187; cv=pass; b=dXpV0gRJ3YMUxDsA/HRA2Vwk8XtCMAimGjW2+c12BIDTGKc3OuBodyVr8r/B4n4DGUY19YDnPldL/EYpXSpAPad+7Cb6gN9uf8Lo0YEvb+kmHTWrxNLhNB2z8vKsvh74qPlNjNn4tDQnBItfkeQGvoPXK56k4OvZ3b4EMTU3V5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762187; c=relaxed/simple;
	bh=AkeqpxOwHU4MVBjekuIkeiRjY6mQCqQt20j+XW7Rw8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCliMFsSA24nEpKopTEbOa8812hlgekatjaV5WtLpBcvkotuv9l5DhyoZl6f9Hvw70hgZcSQ1acvQIb0rRT8ThKZqk0NijARBD/44U2h7GrmFLmnmKUACewAGNv9tMtwHhwV3X6aqMb7eFF5ZeBn0mD/yaZ5PeiBxQEbXZ914Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooTxHsHx; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so1900859a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 05:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778762184; cv=none;
        d=google.com; s=arc-20240605;
        b=DOu3SfmT35cNmn7wlgZ4SIA/E31VJkEPTkXcQOHjdDkp1c3N463Yh/hOAXvVEhjzdb
         foSewmTXb0/zLyVYmiCpdj4H+NSQZdT/KFZE711eC+7zj/P/DTq7zJ+LSBDQfJAh4Y84
         f1IDVMFMGKEKb99t/YDNaPc/VTUQWOxz+R8ncEPlOhkd2qndgjLSWgiogf1GBy2tqlDy
         EY7m2rZPfF5F8syd34JdZII6mELNu5uSSh7eRsxsFLEpjDzcr1adLGOkHW90/o3/9EB1
         EsZdxo/vuN/S6FwU63xv/JRdCbYAVqzkG4OmkJknGtNm6uT2FFvScWPhnxGV44Gskru1
         669Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pVVJQr35p/hw0/aXnxWHPL3el9qF8T5r1ylGr/zjDc8=;
        fh=Ck0GfV3RD3Mb2uyZ8ntgrSw4O0VuD5O982bqx+j8K+8=;
        b=P2DPsrflbkpxuoj9fO3t15WOsObczQgbpkWDHsf6aNClEW8l9mpU2pFcCGO9L9ZSUf
         5PK92Gc1MZTm63fggJFSilwAq3BNscCx/UBWUiSCpCqR35fvhB6/iB/I3s/Nv7wRHjBT
         x1STQyE/06ojK1re8zQ/NWbRpwYxhLytrtNeJvnw2Ll4YenPnnDPH8QgyPAtWMXsNCmb
         o+zSWpmDuLuAeSMP9sKVK3LCcG+XBNJ8yIe7EeM8QlcXDmZ2DOQzjPho9tzpnBbLElC3
         UFi1B4gO/r/D0IvkcEqOjhtypyYVUtD2xBZb2Fr/kEpt7pbQerQKOusqZrISW/TQHGs0
         HVlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762184; x=1779366984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVVJQr35p/hw0/aXnxWHPL3el9qF8T5r1ylGr/zjDc8=;
        b=ooTxHsHx7J8MznclTp+7us+7mHFc/ph5Hsk7gNsr/88tUjxuYy3Th6w7GcZBa29aM6
         JYgEb5ojTnNa2yaCWnvuMZMus5pYqurIoeFaje16Mss010yI436QexFEgKV3wEkzi+Ev
         YYwFfvuqGqNYrFj8u8Nbt7IPSx/ljQQ0gBkpOjPROAo5VS7nVcp8UwrYN3Dy09WSaIGf
         sEEVXBoSM5GBIhpJLYWstAVWEoCCusEQ7pMy4unZyHaAaIm7NU9J2K1uqODhwO1dOcfH
         8fvUMCOhIaQTVEbhy0F9kCg0VBhSShWjQvIjHPbQx9MgxXTpZLmbDfXgxPgdqY7J7bc3
         p63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762184; x=1779366984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pVVJQr35p/hw0/aXnxWHPL3el9qF8T5r1ylGr/zjDc8=;
        b=fXZ1Sh5kLHWX2LRkvzloG7NSMXYXJQYyi2vEHAWo9OsvuigLTk1ko/YLsfuzkaMHb4
         TnwTyB1NcmIgqSbOzN9Rd6bFtOAzfnemTrGRz2s7iSPqxvsTTTYggE0fOl6a+hKccF2S
         zwYnFPJNdgrvywPWzDjsyRtGZ0PPCzk4YEZMuu833a17PzujH3lyxc+tN0Z/qPGs34Jt
         wlUPmnvBJjls5CyjQh8OJ9XXIQ+nhn7y7hj4RZahI0cHm/2X7CQuL2nu9zF/18nJ6h29
         X8ggDcP39qPFyEqLZ9qlJFIv1/t/Avi6xaGOyothbyRoueY6g31gcSt7R9FbmmqKOEe+
         om4A==
X-Forwarded-Encrypted: i=1; AFNElJ/1Wm3e6LHxdPJNm1GJQCxwcebgSx8gbJHztGL105XM6Wbx1d9vjiliTfD4DEi2yVz3WsaHFAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+ORxX8rQWUiLExn8xM7R0MDNgtOpEV0EFa1vBkjh9CMCs8lt
	KBIywAkjSrEslv+kIfXMYJkt0/hFA8bjsq3kVeCN6HPZioLYuJ4nej3NgfdSJzcoDVOzKeLeE3B
	uDkjD4w9HdPLJEFVMar92xIQaUQql0Yd1sexWEbE=
X-Gm-Gg: Acq92OFMiCOEdiSzG3FUFWwRiFMX7C6INCV0wonpH7Gj8UNyD0jVv3DOIwkrAtGePcI
	Mzsm9nElh2lyEsjDY5+XjxWaEPU4oeObn+9ZcHFYgczgS9Km2uxjdORiGjYBsUwbhG4Hk6mMoBs
	o8/ipBogJMIY5T1aCwloTQrvD8b6o6lvkr3c2JeaXA5yq0IH+fB+5MmIEEglI8wX39PNsbko2pE
	PKSlJ4wgta1zc6UX3ZgYKwDVWz4fWkpc8tI2G3ZpISXVVa88TCtV9KEYI6nu5/36txQdwqdnL0q
	uUPZlgy4UpMOTMPJ1E8hBDLqUBBSMiivpv0/cIWXGw==
X-Received: by 2002:a05:6402:4014:b0:67d:9f52:a78b with SMTP id
 4fb4d7f45d1cf-682a761185bmr4021427a12.19.1778762183494; Thu, 14 May 2026
 05:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514111354.3552538-1-nirmoyd@nvidia.com>
In-Reply-To: <20260514111354.3552538-1-nirmoyd@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 14:36:11 +0200
X-Gm-Features: AVHnY4JZJLsUsLE9Hb-mfZBJKrd1pymN_ng0bM6kK3OI_Lr4yXR49GXX2rr-Rmg
Message-ID: <CAOQ4uxiamuv4uqrN5KedzmJKjz0AX8xVrDuEdMqJ_uD4gEm24w@mail.gmail.com>
Subject: Re: [PATCH] ovl: keep err zero after successful ovl_cache_get()
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D7369541C15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247191-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,appspotmail.com:email]
X-Rspamd-Action: no action

Hi Nirmoy!

Nice catch!

On Thu, May 14, 2026 at 1:14=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
>
> ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> IS_ERR(cache). On success err holds the truncated cache pointer and
> can be returned as a bogus non-zero error.
>
> The syzbot reproducer reaches this through overlay-on-overlay readdir:
>
>   getdents64
>     iterate_dir(outer overlay file)
>       ovl_iterate_merged()
>         ovl_cache_get()
>           ovl_dir_read_merged()
>             ovl_dir_read()
>               iterate_dir(inner overlay file)
>                 ovl_iterate_merged()
>
> Only compute PTR_ERR(cache) on the error path.
>
> Fixes: d25e4b739f83 ("ovl: refactor ovl_iterate() and port to cred guard"=
)
> Reported-by: syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da16fb0cce329a320661c

Does this fix really close the bug?
The report is a UAF, which was fixed by the other patch.
Right?

> Cc: stable@vger.kernel.org
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  fs/overlayfs/readdir.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f9..0d471064cfea1 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -844,9 +844,8 @@ static int ovl_iterate_merged(struct file *file, stru=
ct dir_context *ctx)
>                 struct ovl_dir_cache *cache;
>
>                 cache =3D ovl_cache_get(dentry);
> -               err =3D PTR_ERR(cache);
>                 if (IS_ERR(cache))
> -                       return err;
> +                       return PTR_ERR(cache);
>

This is good but also no point for returning err at end on function at all:

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -838,7 +838,7 @@ static int ovl_iterate_merged(struct file *file,
struct dir_context *ctx)
        struct ovl_dir_file *od =3D file->private_data;
        struct dentry *dentry =3D file->f_path.dentry;
        struct ovl_cache_entry *p;
-       int err =3D 0;
+       int err;

        if (!od->cache) {
                struct ovl_dir_cache *cache;
@@ -869,7 +869,7 @@ static int ovl_iterate_merged(struct file *file,
struct dir_context *ctx)
                od->cursor =3D p->l_node.next;
                ctx->pos++;
        }
-       return err;
+       return 0;
 }

Thanks,
Amir.

