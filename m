Return-Path: <stable+bounces-226904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hj/MO2/uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:56:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C52B2748
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD24130731AD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719938C41A;
	Tue, 17 Mar 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPGf1l5B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217438C2A5
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780969; cv=pass; b=nSC35KSQbdu2svHUqMrsLB4yV5nhCy1Jcx327STFMUnN8BY0Ryf57adfsWGALYYtFASs+7jSEB8oUAep7Z2MOVIWIuKi+DVZEo/GHJ2fUIj6V/SQq383JkO6lfN4P/5FPN19mX6pasvlztRlP2MYuj5KBpggwOko2vszB95aukE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780969; c=relaxed/simple;
	bh=30L/GqxGwE4ij2te62giWC36PYHpNRvdg86xgyioZ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RokSUSN1hRQYvnJ1wvuRmHtBUBI7Ia9hsxYzv8CatrbigtuZ7hJ2r9L9xf4tQ6QOiCQDQJvnk46wAu0J13+J7X3BZW4aucmfFyZLgB3I6Xp4OmcOLVgRnKPKaHeVMbONsUlEUyKdRJ0HMTDhYdoHfXaKFX8KtoC3sz/OI75c9TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPGf1l5B; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso55981675e9.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780966; cv=none;
        d=google.com; s=arc-20240605;
        b=AQlsSzQA5RnEEQKI4lppVt0urndM4oduKljpukYIXyGWkdqAyh0ZCkpLFcd+my1rs5
         8eeVSAHY2TGNwX6nsflAwizbxs8ehn6DyYIGAOXYTfYi9VPrJ3JJxOoB/+zi+SBMApxX
         daEQg6GDyB3iHsgtnTK0W1SnGNhLrE2ka5oMl5+TBXqCCNkZjsLdKsuBT81Lt+Wv+iZN
         X2LyF3bRCvpBYvchrKOYrTQLEMd7pHt5Vt5JbOm7zjthTRiiHayLbLowXL5sHYoM/G7t
         R3dqVwi2U9wmfgeVSsv1vjMxw0pBofZ5/pqR7l/xNx82DQjDkGFWAhm2/3L0d4Fii8eO
         HBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        fh=B0A/OVeo55Air6jojfmjUPrGiDd5gnN7NdjJ67hukCM=;
        b=K37Pbbqi3OOL20GfLkhASG2w9E5JI9w69s7V2bfM1YEf9zb3C5/AlXdlrZVMVrpiT/
         9/ZUsHsYTL7s8vTAR4eNLT269t24dyuSxbKfsy4HVuQoLYmUXuiBNto3XjvMGZmGbYHt
         xlkG0MiqrY3flLv4sdLr/gfdKcyOH3e/i2WTtpZYea70ThQ33xLCGrdbMRB0lSlYSUjK
         dokxfpcq8ojEJYHvGfotL6mj8l7CZlajoaXZ3imzUi0SmyfRt5D/T1zHm2nHTXwwYv70
         ipX4kQmEkbWbJmmVeSSTPvP5sB3itrema28UaeThBDVMCcycoWpgAogW7Q3ZAGYpKdta
         o6jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773780966; x=1774385766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        b=mPGf1l5BbKVePuSU7ZV7Z4BsbjEa1tsNgZOJgmenpIIuwLMrq7xLu6lfR3D4TQrsTw
         duJClHuFjDenoUKj4x/0jsyLYe63f8pIlUrEaObfO6PBTJ5jTF6GZStNLtpgSVHlT1KO
         wFflu7i1OvYannsi/rceSNpcHX6K12Ms5CKRSV1GTsgR9Q8acd6VPPzC4eG3W9WV9y6X
         oyJIhhmF/JhtaZQVx1Apa+rPEMEDi2b2gZu7KV5Ptbr5Ti15HIHGjZWGGit3HOTxXdRL
         FZiMYA781eIRU58ip0rxue5nm7vhOWN9WVchhUIEShnVBBas9uyEd2iMReWSoKls6ghI
         mEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780966; x=1774385766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        b=pg73yIUzPZ6nTfpdB2b/4idR3m++MYts7pR5tKnOhbzh8DsVJArvYMtmNXepVOSKgz
         pZVkglChwpmvYeDc0gHOlPkvJlm4Y3jpC1q3fLc2/TsjZ9edoroN4zUkTFO6KSNIejtR
         W4DCrK4+cU/h2JMhiv8IrCsZq7HNXXy2c3eE/zjL66BXnXI/XL6LsmIDGoYEP7b4rrPG
         KXggisjI3VRi+guvnBJm+g5pqRjpN68My0OJQU5WnqFuCQXaVQ8lfUPJvKMdhkyLjtx/
         M/P1SKAnlvqUVVfOuxezLkcAYdSvf8xJ+Mp+ULe/PM7ASvuPNUhYCID/FOTQbGljtjpS
         St9A==
X-Forwarded-Encrypted: i=1; AJvYcCWttrPDfI+9wEsSX8Ld47IWD1rA9fq6zM9KpULmsZr4KlYiFJNFXRQU2QmlibWKxjZSBjTatTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkpt6vj9qzxBzZmD/7WKzLVxmMTUgjcPaGEVAuSgobsf3a+n7
	fw7vT9RcwzXh2WMNNJmPe+OjXsulIYdHz8edPJKPhyxt9xrjuOJAPBW4itEFaPakKnGJuD+XrUK
	6V7ZI2UMQZ6hNWYojGiP4442SV9eYRBs=
X-Gm-Gg: ATEYQzxqnmevfMs8M79i3Ra9wzYdvQJCmFZOddQPVYsXZlHD0NHUX3qQXtW8DOLu29p
	IPISkPu2PZCEFmmj8T0dv4JA9eMz/H9K4BI0uf9bdAJc8yhRhyXZpluWsPLdqKG1U0VPQ6xSX4O
	AgMkydojiGywZoSLHBXHMGnpEzeU7dsog6Xfo6EopNrROJ0cF3p5SwAO2VY8RTMnG04/0Doix5D
	mQgz8ym7aKm5Cj9vqWWvB0YOUBAsZvWlaX+/AwR+zEiNJVDMnJAOC4PbNpHb28GZa+g5oxf7HUN
	cA9I4Q==
X-Received: by 2002:a05:600c:a08b:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-486f445315dmr16500215e9.16.1773780965545; Tue, 17 Mar 2026
 13:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317203935.830549-1-joannelkoong@gmail.com>
In-Reply-To: <20260317203935.830549-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 13:55:54 -0700
X-Gm-Features: AaiRm53wUE27CrAaPdpinpr9TjQa0y7_Qnc3aVfdqtm8WwV7AAtfKLnauwMTyo4
Message-ID: <CAJnrk1Y_LmQ0kZrKSGTWTXa-fQy550mwULqzUhSZWB8d9qqvUA@mail.gmail.com>
Subject: Re: [PATCH v1] iomap: fix invalid folio access when i_blkbits differs
 from I/O granularity
To: brauner@kernel.org
Cc: djwong@kernel.org, hch@infradead.org, willy@infradead.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, stable@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-226904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F7C52B2748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 1:47=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Commit aa35dd5cbc06 ("iomap: fix invalid folio access after
> folio_end_read()") partially addressed invalid folio access for folios
> without an ifs attached, but it did not handle the case where
> 1 << inode->i_blkbits matches the folio size but is different from the
> granularity used for the IO, which means IO can be submitted for less
> than the full folio for the !ifs case.
>
> In this case, the condition:
>
>   if (*bytes_submitted =3D=3D folio_len)
>     ctx->cur_folio =3D NULL;
>
> in iomap_read_folio_iter() will not invalidate ctx->cur_folio, and
> iomap_read_end() will still be called on the folio even though the IO
> helper owns it and will finish the read on it.
>
> Fix this by unconditionally invalidating ctx->cur_folio for the !ifs
> case.
>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Link: https://lore.kernel.org/linux-fsdevel/b3dfe271-4e3d-4922-b618-e7373=
1242bca@wdc.com/
> Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and r=
eadahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3cf93ab2e38a..e4b6886e5c3c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -514,6 +514,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         loff_t length =3D iomap_length(iter);
>         struct folio *folio =3D ctx->cur_folio;
>         size_t folio_len =3D folio_size(folio);
> +       struct iomap_folio_state *ifs;
>         size_t poff, plen;
>         loff_t pos_diff;
>         int ret;
> @@ -525,7 +526,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>                 return iomap_iter_advance(iter, length);
>         }
>
> -       ifs_alloc(iter->inode, folio, iter->flags);
> +       ifs =3D ifs_alloc(iter->inode, folio, iter->flags);
>
>         length =3D min_t(loff_t, length, folio_len - offset_in_folio(foli=
o, pos));
>         while (length) {
> @@ -560,11 +561,15 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>
>                         *bytes_submitted +=3D plen;
>                         /*
> -                        * If the entire folio has been read in by the IO
> -                        * helper, then the helper owns the folio and wil=
l end
> -                        * the read on it.
> +                        * Hand off folio ownership to the IO helper when=
:
> +                        * 1) The entire folio has been submitted for IO,=
 or
> +                        * 2) There is no ifs attached to the folio
> +                        *
> +                        * Case (2) occurs when 1 << i_blkbits matches th=
e folio
> +                        * size but the underlying filesystem or block de=
vice
> +                        * uses a smaller granularity for IO.
>                          */
> -                       if (*bytes_submitted =3D=3D folio_len)
> +                       if (*bytes_submitted =3D=3D folio_len || !ifs)
>                                 ctx->cur_folio =3D NULL;
>                 }
>
> --
> 2.52.0
>

Forgot to add 'linux-fsdevel@vger.kernel.org' to the cc list, adding that n=
ow

