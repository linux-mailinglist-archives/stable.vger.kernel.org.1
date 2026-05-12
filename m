Return-Path: <stable+bounces-246691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FTiL8anA2rR8gEAu9opvQ
	(envelope-from <stable+bounces-246691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:20:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6352AD28
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7043300BCAB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862939EF05;
	Tue, 12 May 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqw9CWhG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0F3A0E97
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624448; cv=pass; b=R/ARyeV4ttm2RTtU1CvlLG2REmkjxLyS/jAt1wjKxWt6v/lkmZy6yV7mXlkcHmDdr2Cic11cdrobOjDcqRu6aNIPmC/WvurDcQYk3E4e08whVCvHLBiJT2cbd8G5xyl6DVatrhNYSyZQDSouEt6OffY+rbvKNv06tVGlI7spnjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624448; c=relaxed/simple;
	bh=qAOaMhX4hFGUXuJDfpTr6sF+f3dlVHW1uLkRCwtcU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lrbysp7PisH5sdrFBZFmZzEV14ojhNOY6b1Rg+cWf1Q5tr4IcnOogCHHUukzXxepmzFW9ZtgSnnLuPCxvw3TVZBjIKgAV+xGxcxdTspWe/Q5ko6mmQDkbq3lqCDjNW2qtqQ92KYlFFA0aMH0UqipGeh6p+yGkQjQ7QLY68fxNis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqw9CWhG; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so9709947a12.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 15:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778624445; cv=none;
        d=google.com; s=arc-20240605;
        b=UE9xOUHRPHw/+jmbSyiYVuLLFoCSitT9JhkDxrUopQTHFzBgMaCf/Atmv/E8oeyq44
         QR4p7WdHHDeip/T+V3AXp45Gb6YHRAZ4kuS5fSFkdVAbxmPdYAuKAKfLGf2igsbxPldl
         8RSDVHvNlg7MIq334tGE9VTq/NnGrAAw8IsXnntPLAuQl6G9xXauIJpFZXAtXeuz0nXi
         DSfHFIzWPRxu4qtzG3FgUJUBqUX9UkKBnjP6elIA6Vc7A5wxSRwCda0ER9v3ZkRoOBp9
         KxgyGVQfyRJMKgXs6BK4Foz3dOKgP3Z5GO3uZnzl8ZFqfN6+hcbc/OCn0g7B4zAOjEUQ
         lkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dWs55en/zxUC3Jl0cU0W4m41MbY2arDOleFNWdTIEvc=;
        fh=H3+tmmdB/FmEbUGtXtwVpW4F56m2HaRIwdZiLXFEXOY=;
        b=OFfZjXGW+cq+CtZZamZcnerpv6rnMvy8Hfw5hRtUTzmSCkVyTcNBkRGJhSZa9skYHe
         qS6+BLVU8t9vnt14N8H2KIPxsbfuEjNsqpXVxd3YMW3pCTeI2tbGaW5Vyi1MMNK06Kg5
         sZQa/8xovAyXBzP9CVF9e+d4tXH7cQe633kpxXb0Vu7DQP5A5LbqjfEEb3ZbHQ0M3ax9
         wDe2LQvTdBuVFHMmTGhjjWnz2TJ4Cu7FiyJAljFYxXUppZJBMKtQ7AXOS35Dz1L+oYH4
         9jGpjTNyV3Vbklw97RHLqiFH2oIrPevqJYMoGcr4+eOYlQzetYTz57nttUAGfEqG48qs
         EUiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624445; x=1779229245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWs55en/zxUC3Jl0cU0W4m41MbY2arDOleFNWdTIEvc=;
        b=Yqw9CWhGFEqlBPfNlu9tMEhYFVS/DL+AMjpbYUzOn5qMTp3T8JlUA8aBlETM3TSIrq
         2KhUByhmyR/+Bi2MmmTs0v0KbHqxcDBNcob98XD6eihwgg4EicudvVmBdM5cFxFeJSIv
         6XMVznGUbxkK9Gdr6hQ/QJd+0A295nqBgTEEdsJCYGiL7QSGX8NET7VoEYjqi8dK41dq
         ihbBSTmwDZ+dXC6WF0OkwFSqURgSbG/bOKc8hFRyYkzpI8VVGqF6U+j3QsNFN0MflKB/
         uBndawSnrV/fGLP08jmXbbPdXEc3C7LDlhPDzKJ/W+aofG74LgLeJ1U4/wQXj/ZEoLX0
         NGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624445; x=1779229245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dWs55en/zxUC3Jl0cU0W4m41MbY2arDOleFNWdTIEvc=;
        b=BzrtL9wnM9H6rXsNKsoLVDDKOsAR9ofOZ0YgiCUu2aar4p2ycu16EcqkKIyqgpRKBs
         EnsMxjJG+oh1ktCe2c2SBBxQvdmfagewzDmiqWRSX/Pcuj6AknUog38nwchoaQI0GW66
         SfiNJsI5EaZnw5Ieit+qqyrTVVZCuYY2Ca8EUxelvKhfjaqhHpwN/sG01Dkq99U08qF5
         POezp43vh0fq5qXtAHV0wQB7HFOFGavqAglJFc3V8OPFVC+73B4x6mGxFQ1wpV7+ID20
         hg9yW6qQ/MuB+CmqJ3Xv1E1DPspL3xQ7OuGZ1iWqZcqe742g9oXI0lbI9ljLv56fEuvg
         0Aqw==
X-Forwarded-Encrypted: i=1; AFNElJ9zDHM8oMHdS7nE5QchR+zjvr1lK7IUXNMrcy5wwLJBgnWUUTOGe3Fy7C//iXhswKClH1/ZMdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf60ex4BQRBKHc+e1WiyO+GAN2gJ07hkF7u/X8THZhrgo0Yc5N
	QJE+cjNbKhOnQhzURMDtxZEifFsp6t8VEuGUr3rCmtanqXl43LL1JyR1cy27+Nf/VFslSwVpE2x
	7eKCHbAsdgIxCciDhGfOb1mpFSGZ6wv0=
X-Gm-Gg: Acq92OE5nM2GsxPHi+WdNDSReUC1PZouWkTmiu91zvfRLtCTz0LKzsNz9pfFLAoJtTl
	+dDMzlY2467oFNG1FSdI87/qdWN/+bwEvn5olTIrXGPdm3XDajJosR/2zRj6s2wcecUCSDONTh5
	1606LpsjQ+TQShYm9GWwSo4h1CNigxr9TKjlz9JfBacJ/cd+43e+e9nRTMMb6qyRBw2sgyqjdEL
	8Mrn8cXXGjnC5OD9A1dMd6hPZpu/jsdn3OV/S0vA/IuiKEtjDXKXwuqri6vdhfWX5lXanxmOSSh
	aQHV4Be0zJe+VoGnkuBFaURsxVd9BxMn5ZIrBpi4XeXnHVNxHic=
X-Received: by 2002:a05:6402:8cb:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-68256d5afa3mr265913a12.19.1778624444602; Tue, 12 May 2026
 15:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512200448.3818665-1-joannelkoong@gmail.com>
In-Reply-To: <20260512200448.3818665-1-joannelkoong@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 May 2026 00:20:33 +0200
X-Gm-Features: AVHnY4L6IF1zgyncSGc2FdF5VTc6jMql8HGOFQnJgnPOs0Jo3RzOddRTuqZ8XY4
Message-ID: <CAOQ4uxhAbS+pQiOygY9m+UzqnuuWL9+Y0hj40Nck7_8NX0Xh_Q@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use copy_splice_read() for FOPEN_DIRECT_IO
 splice read
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BDD6352AD28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246691-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> When FOPEN_DIRECT_IO is set, fuse_splice_read() calls
> filemap_splice_read(), which populates the pipe with pages from the fuse
> inode's page cache.
>
> This contradicts FOPEN_DIRECT_IO, which is set by the server to indicate
> that the page cache should be bypassed entirely.

Generally speaking, this statement is not 100% accurate if you consider
mmap(), so "page cache should be bypassed entirely" is a bit strong,
but I agree that this is a good goal to aspire to.

> Subsequent splice reads
> can then read stale data from the cache instead of fetching fresh data
> from the server.
>
> Use copy_splice_read() instead, which will invoke ->read_iter() on each
> splice read, sending a FUSE_READ to the server every time without
> populating the page cache.
>
> We do not need to add checking for O_DIRECT since this is already
> handled at the vfs layer in do_splice_read().
>
> Fixes: 2cb1e08985e3 ("splice: Use filemap_splice_read() instead of generi=
c_file_splice_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3bdab8d03373..3ebe18ed0264 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1859,7 +1859,9 @@ static ssize_t fuse_splice_read(struct file *in, lo=
ff_t *ppos,
>         struct fuse_file *ff =3D in->private_data;
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> -       if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_=
IO))
> +       if (ff->open_flags & FOPEN_DIRECT_IO)
> +               return copy_splice_read(in, ppos, pipe, len, flags);
> +       else if (fuse_file_passthrough(ff))
>                 return fuse_passthrough_splice_read(in, ppos, pipe, len, =
flags);
>         else
>                 return filemap_splice_read(in, ppos, pipe, len, flags);
> --
> 2.52.0
>
>

