Return-Path: <stable+bounces-240472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOuuFUUH6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:49:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F0451792
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06FF3019930
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC13E869E;
	Thu, 23 Apr 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muT0p7Jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011171A3029
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944889; cv=none; b=TwM8onNc24u9HA2PSJ9po1AZpX5TiSdDHAu/fNCJ6it55S203bJh/y/Rjeda98XFqg+gZiBvwrCbK9cySM5SM+ROB0pX7seBUxmt1DAp8bEXdERAVA2iq3dk5XJkbwenNKiMhmO0InfDSltp3IM6Hc93ockjzcN/ar7BjjOcCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944889; c=relaxed/simple;
	bh=dfV1rrtI1D6Nm0m/pMzTJGZWNlzOOBnfkkvWYkg2dsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcutolU2c4n3ystx/lXpnUG7LTzTbeuyTpZGeJy5O8O4lnHNZXqnNfOF6stJlJgqvUWUjvlVX+xU2WMd5/XK52+fcUPEIeL6veuep5AZmJRGehBjXGv5gLn6vsaCp6LMf+cIh0g2Kshp9r5dF6GLbklO5ooMhGIURsnXpYnIjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muT0p7Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA72FC2BCB3
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776944888;
	bh=dfV1rrtI1D6Nm0m/pMzTJGZWNlzOOBnfkkvWYkg2dsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=muT0p7JkwZBo34rpNYI8I4ZpXA/hYDdcGBaT3jof4Sv7XfYKWsO8Oii8ZDErfvF9Q
	 8dvpq5rUMqYQ/7h26BI3O/cYByc5b/yEo4QGfKV0sONQ3agDE87yI81YkbPNr0ReQR
	 peGNjHL3xpXsphDZCKMtKE/0OJxT2YuoTDRSx+kJN2FjlbqCozc842azJvn6HtRWOd
	 0wbCIlpEZ5S9HQh96/8+yMz13HkEEu+YAN0w0Rj9NC57ssbYTGVmu7PLfCOwU/5Nu7
	 seYUCf/FAooCOPkWaRX+BKv1bSQqTbOFgS/9ie0Lg6HvQ3E3BLFEC//pPbDLG4/6cZ
	 4uHqqwf7ECzRQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so7816065a12.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/PfE+zSLPVWNJaaiJNh7v0ZmXVjHvFrVCCaEBG4LYQqzA1p25EzD/i9OWyt4ScTY+tbSgGNMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+CBeHMRUHMM/LwujZd2o4DsLh3ongc0rfySM65uBHqfYUmaJ
	zpWcHZ3I5IZ74Z3CHdHHd5srvSSrHY45b6lR6VdZq3ts1Fw1H7eg3O5qcBNNUz6isYNtetx53Ui
	0W3CkslRIoT2TRiI9T98Y1bmjlRI1eGU=
X-Received: by 2002:a17:907:6d0a:b0:ba4:a7a3:d03f with SMTP id
 a640c23a62f3a-ba4a7a3d86cmr1316318066b.27.1776944887210; Thu, 23 Apr 2026
 04:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422155844.1967148-1-michael.bommarito@gmail.com>
In-Reply-To: <20260422155844.1967148-1-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Apr 2026 20:47:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9GFFdZDJBCkLvSb-EW8dELg4GYZW-FruO9WSDhBkj2iA@mail.gmail.com>
X-Gm-Features: AQROBzC50YfhNPLrjuJAOaDwGjUpW59yBc1BS_nazfXlUonCbdwgWi0lBiMF4AM
Message-ID: <CAKYAXd9GFFdZDJBCkLvSb-EW8dELg4GYZW-FruO9WSDhBkj2iA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix potential use-after-free in exfat_find_dir_entry()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240472-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D36F0451792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:59=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> In exfat_find_dir_entry(), the buffer_head obtained from
> exfat_get_dentry() is released with brelse(bh) before the fall-through
> TYPE_EXTEND branch reads the directory entry through ep (which points
> into bh->b_data):
>
>         brelse(bh);
>         if (entry_type =3D=3D TYPE_EXTEND) {
>                 ...
>                 len =3D exfat_extract_uni_name(ep, entry_uniname);
>                 ...
>         }
>
> After brelse() drops our reference, nothing guarantees that the
> underlying page backing bh->b_data remains valid for the subsequent
> exfat_extract_uni_name() read. This is the same pattern fixed in
> commit fc961522ddbd ("exfat: Fix potential use after free in
> exfat_load_upcase_table()").
>
> Move brelse(bh) so it runs after ep is no longer dereferenced on
> each branch.
>
> Confirmed on QEMU x86_64 with CONFIG_KASAN=3Dy + CONFIG_DEBUG_PAGEALLOC=
=3Dy
> + CONFIG_PAGE_POISONING=3Dy on linux-next, using a crafted exFAT image
> (long filename with same-hash collisions forcing the TYPE_EXTEND path).
> With a debug-only invalidate_bdev() inserted between brelse(bh) and
> the ep read to make the stale-deref window deterministic, the
> unpatched kernel faults:
>
>   BUG: KASAN: use-after-free in exfat_find_dir_entry+0x133b/0x15a0
>   BUG: unable to handle page fault for address: ffff88801a5fa0c2
>   Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
>   RIP: 0010:exfat_find_dir_entry+0x1188/0x15a0
>
> With this patch applied, the same instrumented harness completes
> cleanly under the same sanitizer stack. I have not reproduced a
> crash on an uninstrumented kernel under ordinary reclaim; the
> instrumented A/B establishes the lifetime violation and that the
> patch closes it, not an unaided triggerability claim.
>
> Fixes: ca06197382bd ("exfat: add directory operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
Applied it to #dev.
Thanks!

