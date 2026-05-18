Return-Path: <stable+bounces-249216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMR/NkbKCmqf8AQAu9opvQ
	(envelope-from <stable+bounces-249216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:13:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BA5687E1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2433040DA1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E513E024F;
	Mon, 18 May 2026 08:08:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C42F7F18
	for <stable@vger.kernel.org>; Mon, 18 May 2026 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091702; cv=none; b=u5mhUf8r33RPlt+AU054p1lSZ3bBKJnnMa032elFwk98FXcilxedDVdlu53lbdWfUEAXJd7+Nhs93Ia2H1+rH3JyGxpkBhkQ6GMJQJsmDB2BAyHF0IwQc+/c5q80CAdomPktvIv9st5N4K/qtrZa3MHOCZFIqQra3wmqiLiNROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091702; c=relaxed/simple;
	bh=zhB4j+JhWVd8A037JLrJiPDfZJuTf+SxKAz96boFBnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIWnu4QGQ4dcfUgFuFSRtMzFwuHC7D+xoxu4IFB6v5RAtonNEhQEqrp/1An+S0fpZrI9MlT/vT+0SJEhJL9UrRXlDnidCYBU8uUrLHWI1YZcAuqfE8R5x1XDcHQqe7BaA8f36sqV+zAaYy62v8FcOHb50CT8om6PzPRfmI7DozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5751b7d147aso612390e0c.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 01:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091700; x=1779696500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUYYkmPBjhPBpcIVZ7SX/KXLmdloPWmcos5I3ZD4vTQ=;
        b=RrmMGNr6hvXZOLJ6pqpA1ho6IqQRsRUChohK5tnTZLgFSoPUka7wOjakOXC0GLJCFJ
         nFj3f0BOWv6K0v44fUkTRm0qMySuAH3+tKWuLaLMjoV5kdOIMMjGzgBoI5PmdKf7xsT/
         d2bu/Dk4e3XDYll/yGt6Oz/+lCMFDQ4qrrWfaHvxQzZkIEpXzsZSKInVT6Ntf6knTJJ0
         Px/tgnV9IlGhXW6uMDgcKpdTvpfYlxjqM/9MDePxRumUkOA8Y9ADoGQK/FXaSJ1QWgxJ
         +qt4q+m2yBV67jamqboAan1FEAZxf2blYqWR1BicJdkqm499wGvUmFhWjWSiYvNInV/+
         wPRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9E4JRV6LNfOv8TZ46tIe9tb0UYRbE9cgHlGLJPgRSlINrIUrRruM7Sea0z4LpD4c0G/3kuA74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZxT57fpsKDAwsVOQeoJTYmWubaVz+/499FG1tGi4w8DPJYYC
	9KV/P4YNokTv+NTdjTql8HiuB9QqW+kE5DLQvQ6xxVQ+LNPjfbXZjuLstQ/kycUW
X-Gm-Gg: Acq92OGeEkYgACSjiqjICSNqN1pSKnniTwO1T/dMtNNQzkgpcotZeGgk42x8yCoSm2l
	Hi1nnwnLwo6p8+tI4/GP0+z1O+zoTQCj5FjwBPXIKhh5CSd9Hc0VCjW1QgX5/YVW1HKOBGxV280
	fyIM0ZLnpl6OltfdUXhJnJIgLYuqORW1foFtnAMtanASgl+GeTUp0smbNYMcFDPvfe+kOLXlpr6
	bF1vFD1u95vqvtVGbh3eYFCGX2iw79Xd9FCbAtsUIfYWyB7zzacuvRUVFhta6mQtwUpR0ymiwOh
	Q0D4L6GTZFggdn3T63iko3cA8pRIlIA6CtOCNVM+gXWt6xxIT1k9udEt2a2VC1bHNMNbrwff68D
	b6dHBHwwQgM/6PXO6V+C+rKhRo7HFWjYyPhPBhYX9jV9tMOdoJKOccY4JhJLUPquxb9HMGHCZXh
	HYGcIO+WudWaj8cpbKDYHyLFfuGKeqtESnnuuvo7vYN6yTQz7jyjfI17aPB0lm
X-Received: by 2002:a05:6122:2988:b0:56f:a3e2:66a4 with SMTP id 71dfb90a1353d-5760be39af3mr6845695e0c.1.1779091699646;
        Mon, 18 May 2026 01:08:19 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fadc1dasm5638529e0c.16.2026.05.18.01.08.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:08:18 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6324ee4040cso544445137.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 01:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/l0udok+cDAe83Qno0OfPady7yrIR5LEQ0tUySpku0oZ2WWfUsvaRAbE7ruoG72q0dyS4DGvE=@vger.kernel.org
X-Received: by 2002:a05:6102:6046:b0:631:b834:e052 with SMTP id
 ada2fe7eead31-63a3d72bf03mr5639387137.12.1779091698017; Mon, 18 May 2026
 01:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514174342.28451-1-sozdayvek@gmail.com> <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
In-Reply-To: <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 10:08:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUahvn5dr-sdN=4GP+0Mc2usG4CqVxYqkkzZz5RJbqZsQ@mail.gmail.com>
X-Gm-Features: AVHnY4INWu1Mc1mhZBJHaVUhCQbAP7LxhrNHnPE0OdAz1Swwb3lrj_NGD_y1250
Message-ID: <CAMuHMdUahvn5dr-sdN=4GP+0Mc2usG4CqVxYqkkzZz5RJbqZsQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length message_store()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, andy@kernel.org, hcazarim@yahoo.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 728BA5687E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249216-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Andy,

On Fri, 15 May 2026 at 09:13, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
> On Thu, May 14, 2026 at 8:44=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.=
com> wrote:
> > linedisp_display() unconditionally reads msg[count - 1] before
> > checking whether count is zero, so a write of zero bytes to the
> > message sysfs attribute hits msg[-1]:
> >
> >         write(fd, "", 0);
> >
> >         -> message_store(..., buf, count=3D0)
> >            -> linedisp_display(linedisp, buf, count=3D0)
> >               -> msg[count - 1] =3D=3D '\n'  ; OOB read
> >
> > The kernfs write buffer for that store is a 1-byte allocation
> > (kernfs_fop_write_iter() does kmalloc(len + 1) with len =3D=3D 0),
> > so msg[-1] is a 1-byte read before the slab object. On a
> > KASAN-enabled kernel this trips an out-of-bounds report and
> > panics; on stock kernels it silently reads adjacent slab data
> > and, if that byte happens to be '\n', the following count--
> > wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().
> >
> > linedisp_display() is reached from the message_store() sysfs
> > callback (drivers/auxdisplay/line-display.c message attribute,
> > mode 0644) and from the in-tree initial-message setup with
> > count =3D=3D -1, so the OOB path is only userspace-triggerable via
> > zero-byte writes;
>
> Isn't it also triggerable when  PANEL_BOOT_MESSAGE is left default
> with PANEL_CHANGE_MESSAGE=3D"y"? (However these double quotes makes me
> wonder if this even works, as usually we compare symbols against plain
> 'n'. 'm', or 'y' (without any quotes).
>
> > vfs_write() does not short-circuit on
> > count =3D=3D 0 and kernfs_fop_write_iter() dispatches the store
> > callback regardless.

I think PANEL_BOOT_MESSAGE is the only way to trigger this, as
writing an empty string to a device attribute is a no-op according
to commit afcb5a811ff3ab39 ("auxdisplay: img-ascii-lcd: Fix lock-up
when displaying empty string")? If that is still true, the issue
was introduced by commit c8ffef985af564c1 ("auxdisplay: linedisp:
Support configuring the boot message")?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

