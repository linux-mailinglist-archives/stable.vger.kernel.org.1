Return-Path: <stable+bounces-254380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKSTIV28FWrKYQcAu9opvQ
	(envelope-from <stable+bounces-254380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:29:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F65D8BCA
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D088031102A0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF4400E1A;
	Tue, 26 May 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="oqDWHhvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD24028F8
	for <stable@vger.kernel.org>; Tue, 26 May 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807912; cv=pass; b=KXf26eTdkSj9BQZmcwp+b2c1t4sDBjoCZ6lOTDRokDYsh3aMKvRulFvMfv2Fr6hzJq4CY70XhVCJ2tpmITdHGLwMRYbhDySBjgJgc7/2l9OFkisLfVQK04sntB9lzARsBq31IiqqNKPdNJ2yoAdCyHlgWtwmrdCfyNazciwfG7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807912; c=relaxed/simple;
	bh=u1yJOQuOKXOiRRDyhwM+ozB7fQcCiHcXtKSpYBm0xXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VziP6g5b2v+yTgp/63HzE72j1FUt+6neBIcXIHg9Ac1JboIraFGVCY5qafD+ZikWkeVh1PuftQESgDU8a4fqsAHCSwUTOO4zMfBpzHhJEuX565pzkn2t/jRBdvcF0PCo/ppKNJsKRtiynCzahMWov/aBj9h3oAg8fKrLqOpKpC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=oqDWHhvM; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8028fa6039so7154559a12.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 08:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807908; cv=none;
        d=google.com; s=arc-20240605;
        b=lhyIsAeJds7QGpxpNHd9LPU3sImys3y2CUmletLAwWB2ETdxsS4kz1mf69Lzr+z6u7
         eUxfk18x9HdIyujwM9sZvC5c7iZbT1qp8xwz8IkJPyyHU+dyF/tcCmtmCoD0y/VFKMfW
         TipPd9aq+hVgwZncBfp15p2ucgJmwgMODVwldj7Bb0DQoAX7ige6E7hu20jNBTeQc6NN
         7WKo558hkoJzqLpBa6kO7kefX61JBBufKwf10oso6HpsZkds8Rwgcc22NsfuRY/fw5wP
         MNEYIyJN4sVQHlJ2AYGeF4jzOTjVQjXvQ90/b8petE/k2JeuEeO1XumHs9rLaJEHwAcr
         eFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVInBApiiCyZtDdm028WUm5/9PeZkUIZdu7Bh7ZMnDw=;
        fh=uRRQwgVce4WFOe2ueXT5eL2X5smNEfCo2Mjd9HoBlL0=;
        b=PcgqRrRTRNXhVHvLuDt9z7p8Snxg1aE7b7vC8m0DXVtfTibOG8Np1b/QrYbPH0kCax
         g6/Ec42U0ixcVy4Fn0HRAVmWp46T0P0Ta+TXYbWB4G8G4N3cl0LPtTmi4MfCaDuHn+5A
         qyCWhmO7KhtxL5qBA/HiKhxJ9nfB0lA/lpZ6OgKPWJwx3orVmOOO9Xl+ASUZvfuWY5hj
         pUieLfEz43Bcxi4Kue1t2MlyTdGPDStvigtXhhOJL39BtIzlH4YBmO2oX1IhwxxwPmDu
         uTJPuEJtmKSZUzjJQyvvlu3z/wK/+lNPRB4riKC6bdeTZG0R1YkJ7Hgvz4gjMrKVXJ71
         phQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1779807908; x=1780412708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVInBApiiCyZtDdm028WUm5/9PeZkUIZdu7Bh7ZMnDw=;
        b=oqDWHhvMXgCM7o5XB35mPm9bGZicdId1IgJ8alIP2INwP8OYgzs40/nF6fww62nwMQ
         iIDOvnf+3EOaPtQgXE434CaQvRbik+qbKvVgCQYqQD24e6+ZxQTeL4gYGNrk6vIhkp2Q
         vejFQoaGZjXwahtKI5FhGeBWnHsFs68sBUKYBaUm+fDrzWZMDsViTKcO8lzP/Th7I8Pj
         BLFeHUtUp7EosCpxQ/L7lRHmVlsuGKXW9OCYQVwpL0OMAgwXmK/oNhZofGmaZ5iByG11
         g+GcumynlnLXIVsed1byY59MaUFSm4lLv91z+9VZTviAxLpIl68c6Wa6LTu9cGOcBob/
         N8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807908; x=1780412708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVInBApiiCyZtDdm028WUm5/9PeZkUIZdu7Bh7ZMnDw=;
        b=IdWzCaUDDzqmDDXd9zCJsuoVYMY+eSg3P2214zDcj6mY3l0CNnJiKZ/QWXfGXgCSG8
         /NaTOJrrY0CvNBxnbQA3ymLXNQMWOHZ7deP86G+ICaSMkGnpOKnInwPQMwoe1gW+ZUtx
         x54AD5CaTlxxocGNEHOd0z3rzy0ZmDhLiRoKlWirZfFkLlGiyKnKvEt8oBDcv9HGCaFU
         jPEK8nhfXQAzmFpt/vJwy+aat38cFeF70ZAR5LOzEj8I4WpfQAYUvPVvLZe/wMku5gQT
         21bY85U6c4bjGf6lGpZ0hKz3b+aYTSCeLbfDyTEHp65R5cPe3nEhSFTAFiFeZPJ3xcsf
         WKTg==
X-Gm-Message-State: AOJu0YwDOXOhuzV63ST4qoqGCCnYD2GkuBvCbdcjPKm+70TUsy69GpEt
	6+1wa9caH355P9Z9QihOji8vUW2aOMoC1y1JEkf2yRt08KsCvZY+WakrUQkm1pxEm0/FpEa3wcd
	gZxAYH+yA14BtTJIowdxBP4wh7F1xxglB85Npk28VOpV+owzZQgLIJQ==
X-Gm-Gg: Acq92OEzezeEbke8/OIi2q8yGV07GrKdoeChrpToOyR0GtK/nBn3dnknS3U3q5OJc6w
	VZM42Xf9BEb8LNM6TQjJ1mmaakon5u9rete7rbJ2j3qv7qngIJamcqV9g1TILobYaoFsJzhsc68
	e6OV4Z9iKy6KHjiElK4Y6gmDi3mwJnL/ZjmCfbWRREfW7vZu47G2SvVlhOImFNSUu5/dpXncyrm
	jUH4AJjanx0wXzGKwgiQgUhFlSqz92PBLz0odbKkSIOXSp2J8PDeacY14lEr+kXPmyURdYS81E+
	UiRDy+OYzvDSjz/G1saxdsN3I71ZeJJE/AYZF2M=
X-Received: by 2002:a05:6a21:4d8d:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3b328eac376mr20467308637.33.1779807908292; Tue, 26 May 2026
 08:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523142700.582574-1-sashal@kernel.org>
In-Reply-To: <20260523142700.582574-1-sashal@kernel.org>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 26 May 2026 11:04:56 -0400
X-Gm-Features: AVHnY4LtivBL3jKxxEHqzvN--166MvFyzNBCRm6yRjhNQQ4HMZBbwkuMk17zfos
Message-ID: <CAOg9mSQ3H6WHBPA3JoY05tCHv9fMAJucHpLv9vDR15NSwOecpQ@mail.gmail.com>
Subject: Re: Patch "orangefs_readahead: don't overflow the bufmap slot." has
 been added to the 7.0-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[omnibond-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-254380-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[omnibond.com];
	DKIM_TRACE(0.00)[omnibond-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hubcap@omnibond.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid,01.org:url,omnibond.com:email,omnibond-com.20251104.gappssmtp.com:dkim,linux.dev:email]
X-Rspamd-Queue-Id: F02F65D8BCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kernel test robot sent me this warning from
compiling on powerpc... I've pasted it onto the
end of this message. I think if I refactor to get
rid of the goto it will clear the problem. In case
this factors into whether this patch should go to
stable as is...

-Mike
--------------------------------------------------------------
 From: kernel test robot <lkp@intel.com>

To: Mike Marshall <hubcap@omnibond.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/orangefs/inode.o: error: objtool:
orangefs_readahead+0x21c: can't find jump dest instruction at
.text.orangefs_readahead+0x2dc
Message-ID: <202605191252.LGmijl2x-lkp@intel.com>
User-Agent: s-nail v14.9.25

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master
head:   4d3a2a466b8d68d852a1f3bbf11204b718428dc4
commit: 415e507cdefc510c01de8ab6644163327ee9a5d0 orangefs_readahead:
don't overflow the bufmap slot.
date:   6 weeks ago
config: powerpc-randconfig-r072-20260519
(https://download.01.org/0day-ci/archive/20260519/202605191252.LGmijl2x-lkp=
@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.5.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=3D1 build):
(https://download.01.org/0day-ci/archive/20260519/202605191252.LGmijl2x-lkp=
@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Fixes: 415e507cdefc ("orangefs_readahead: don't overflow the bufmap slot.=
")
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605191252.LGmijl2x-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

>> fs/orangefs/inode.o: error: objtool: orangefs_readahead+0x21c: can't fin=
d jump dest instruction at .text.orangefs_readahead+0x2dc

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=3Dy] && (PPC_PSERIES [=3Dn] || PPC_PMAC [=3Dn] ||
PPC_POWERNV [=3Dn] || FSL_SOC_BOOKE [=3Dn])
   Selected by [y]:
   - PM_SLEEP_SMP [=3Dy] && SMP [=3Dy] && (ARCH_SUSPEND_POSSIBLE [=3Dy] ||
ARCH_HIBERNATION_POSSIBLE [=3Dy]) && PM_SLEEP [=3Dy]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

 -------------------------------------------------------------------

On Sat, May 23, 2026 at 10:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     orangefs_readahead: don't overflow the bufmap slot.
>
> to the 7.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      orangefs_readahead-don-t-overflow-the-bufmap-slot.patch
> and it can be found in the queue-7.0 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit ee1b4cffc18f986a3287260db59e38d82d99e188
> Author: Mike Marshall <hubcap@omnibond.com>
> Date:   Thu Apr 2 18:07:25 2026 -0400
>
>     orangefs_readahead: don't overflow the bufmap slot.
>
>     [ Upstream commit 415e507cdefc510c01de8ab6644163327ee9a5d0 ]
>
>     generic/340 showed that this caller of wait_for_direct_io was
>     sometimes asking for more than a bufmap slot could hold. This splits
>     the calls up if needed.
>
>     Signed-off-by: Mike Marshall <hubcap@omnibond.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 2d4710d0e05e1..af7c9432e141b 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -224,6 +224,8 @@ static void orangefs_readahead(struct readahead_contr=
ol *rac)
>         loff_t new_start =3D readahead_pos(rac);
>         int ret;
>         size_t new_len =3D 0;
> +       size_t this_size;
> +       size_t remaining;
>
>         loff_t bytes_remaining =3D inode->i_size - readahead_pos(rac);
>         loff_t pages_remaining =3D bytes_remaining / PAGE_SIZE;
> @@ -239,17 +241,33 @@ static void orangefs_readahead(struct readahead_con=
trol *rac)
>         offset =3D readahead_pos(rac);
>         i_pages =3D &rac->mapping->i_pages;
>
> -       iov_iter_xarray(&iter, ITER_DEST, i_pages, offset, readahead_leng=
th(rac));
> +       iov_iter_xarray(&iter, ITER_DEST, i_pages,
> +                               offset, readahead_length(rac));
>
> -       /* read in the pages. */
> -       if ((ret =3D wait_for_direct_io(ORANGEFS_IO_READ, inode,
> -                       &offset, &iter, readahead_length(rac),
> -                       inode->i_size, NULL, NULL, rac->file)) < 0)
> -               gossip_debug(GOSSIP_FILE_DEBUG,
> -                       "%s: wait_for_direct_io failed. \n", __func__);
> -       else
> -               ret =3D 0;
> +       remaining =3D readahead_length(rac);
> +       while (remaining) {
> +               if (remaining > 4194304)
> +                       this_size =3D 4194304;
> +               else
> +                       this_size =3D remaining;
> +
> +               /* read in the pages. */
> +               if ((ret =3D wait_for_direct_io(ORANGEFS_IO_READ, inode,
> +                               &offset, &iter, this_size,
> +                               inode->i_size, NULL, NULL, rac->file)) < =
0) {
> +                       gossip_debug(GOSSIP_FILE_DEBUG,
> +                               "%s: wait_for_direct_io failed. :%d: \n",
> +                               __func__, ret);
> +                       goto cleanup;
> +               } else {
> +                       ret =3D 0;
> +               }
> +
> +               remaining -=3D this_size;
> +               offset +=3D this_size;
> +       }
>
> +cleanup:
>         /* clean up. */
>         while ((folio =3D readahead_folio(rac))) {
>                 if (!ret)

