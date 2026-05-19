Return-Path: <stable+bounces-249491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECYZKfchDGrjWwUAu9opvQ
	(envelope-from <stable+bounces-249491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57A57A507
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43E86300FB05
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209B3921DD;
	Tue, 19 May 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoFarAgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BA3DAC13
	for <stable@vger.kernel.org>; Tue, 19 May 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179069; cv=pass; b=VVfZt7urhubtd1yvfcsyZRFX6CpaSXMahB+/sobV+vHvTrkerZQkKdlY+KpL+K9ZLo3xUOT1JEwrZg3CQkrUFH29Hmjxqrvv/55G+DYaLnPiManoTrMvyXFAN9XVc1SIn/BGzRn6tpq5Zrwi8N41+YqgJFkI0sG/VBZ3VjM3sIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179069; c=relaxed/simple;
	bh=+2JphY+nktmaf/PwzUVblf+PDVb8dtBzAGeaHQJSKkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2V+aEqXhXqBhf89xxDZVCjf7NENmY2aRyTPTEf7Xv5G/gi6gXTb3rZTsfvTQoGHesyPDEmlsWdQXiORqmOJotni4fgW6zgwvISg+D/1exPOnsPCiWoQLrBNoQQcva6V3qFc19Ohq63LmlSH+WWaNjTpG7l1hDwBX4vg/eONOPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoFarAgZ; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd5e373d07so28301047b3.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 01:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179067; cv=none;
        d=google.com; s=arc-20240605;
        b=UMZXKAv0j3rHFYCuWh2Zb7pPpdDH+RGCNRV+I1NyWpsN2TFawQ3OBgRKKBm0gDsEJH
         o4iyqXP4HX8A+0sfApPQgmIY0k+Cz1GnpGYxnIr/WOqIb+XysKDjA/BGj5PrJui613TA
         Fflj5XVsZIoqsXHC8gTCyyQ4gR9uUFA4NhnSAxjY0Ss1Hytj3tIikPPgd7EZbPlyUFLk
         MK3ZIeZhYVUIDm/lToc1cDU6vhhXHBgsdJRpNNdNByMiuJsep/pxwhDPovdBpq0Gtkp1
         kF7a/Bqwc/lGoQ3C0m1VfNG9asbmuLRbzz4kUYQNEQEpku+eqE9Gh7capwgQgx1tLwJU
         Sd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        fh=FEQn8KVzBKNM+cFJtZ1xktVqtG6uuLr+vq+308dP5KM=;
        b=aEFprdeRg7NJ+xSF1Kz+eQdIVEsaDrV48Kr9NKzlxY6DUgYFTJu+h32pxpqUP9Pqod
         3846IXnbtvKFds0E7TYDwHLht7cAbTxJcQX983BzW59krYbKDzlHd23VMIv/MEqQnfeR
         +vXyTgHNJjA5+C2jz/WCPa0AQlTsqKSF1Bl8g9N/0fEFYfjpl1FRZxhAbYDKOSqepcm9
         VoPvWuoXOFCgUiDFtzKNIibUEtXSaTpmLk0oTLokkT5QcnC5/dfMRmNWCi6WmmdxLgrX
         6TI4rW9tdjudMIP9VtFhrJ+e6LSQIt1vrtMC+arQUQJOJtfz4TefFZt9SMZ5lFKuolNT
         Abaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179067; x=1779783867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        b=WoFarAgZheN3OTzUYVPihx5Gav+2Iwpt46ncYsoF1Nh9RrC9u12u1FyDibMWYLfL/I
         AuCa0NQgTjcqQ6BOY3Ch/d/aR8shm3KQ7qXrDlIZccZIuUYVtBLjKg6IFAwO3Q/NwFoy
         QMee7SGs2ePyEtLqWcir0tG9IbDPT0jutxfa6BAM8IrlEb8sU4GNYL+3e8FFakBMsN/j
         MZnAmkjlk2Pw2AVYQAFyxDAt+rVPmCIsqQvHSS17UNw/6EhVulGaapf6L56N03YhpNWA
         +tmMqAPfGwPXhndKdUfKrb4fXOWD8qV7PAp06+PmPbgPLmwuZKdzy8kugXGraOe+f/Va
         qVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179067; x=1779783867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        b=QZVXH3kGQK03B8MoOd1D4JkWV9xIvakiR+i3VGKeyCEnsV8wLAGuYBwslXffdqqGqa
         0n8SrUW8QwdmPUJjVkkOoPv0XyuqvBEsUEuKsvblOH0ECEcwWxyv4N9RY0ghk8FJ+KtL
         0Zdsl3X0o3ftSjc6rAcvcYe5EN9/XJOLgVK8rR24nFO/J6dKgcdwOsEvGI8DOrETIidK
         A8we0Plz5JDXqZhbfGbSdtZ6+qGzAci4UETmKOxXJYeGCqB6tuL8CT5qMVorS3JdOgGs
         uuQfJr0DdLgr1FQETvyqlPSrHGRi0PbJUJEd/HUAQmjtCCSDu0e2sdFhp49RuHzd7k7b
         yu2A==
X-Forwarded-Encrypted: i=1; AFNElJ+9DpR0VfN/0Moqc+9MZkTxoOU/M1RYl4vncqRQl89yb4qO25b2Cl4KRdnNqYsu9Rrsk6LXHc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAArVSsz4/C1xHJkmdWNFHPsD0azzZ8uZej2DDGCdPDogVawuY
	MY4GmzbuLnvrXOOTqHbw03mgOT5o6zHw7UNFl2lRp78GHrAbjYm4oe0DCb+KR0KMqds9UVe5NPi
	zAtTV/OhhOfF2rz5T7H2KwadBmBU2vsw=
X-Gm-Gg: Acq92OHkPp8vxiMAhmqRG6CUd4dNNzhcVlsC9QYcN/ejZXDG7zL/zhpBK5+f72g0dG6
	tfkPthf3HJnfqgP8MT3dCKcAQiUpZgst9kEOoI2AkrqYK9b2XeQ+6rcecncvMIq56sPDNsis01Z
	yg8ECJso0tidZGjnQHIAqMNzeAU3wemXwLsOavhlaQrmVZ8ziFWYyyYRSGxoDtIUA/uY0RYkmXi
	rwrWZfab9GmgCqSyKubrPDP5WPJ5/Jr8pvG9qFDuR55Bjq2JAKRuWX0itWayJRALjWn1FIMvDma
	zJqlM1qgIaiNp5SHPtxAhkmvXqlYCaCi1Ndlm0Zv0tVxuu7jLZIZesbSnKLTm50QBbsqIA==
X-Received: by 2002:a05:690c:f02:b0:7cf:ab4d:a0e6 with SMTP id
 00721157ae682-7cfab4da692mr7412417b3.19.1779179067451; Tue, 19 May 2026
 01:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515084030.21986-1-kartikey406@gmail.com> <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
In-Reply-To: <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 19 May 2026 13:54:12 +0530
X-Gm-Features: AVHnY4It9V2jN-5fjRsBqTKrkzDjZ0cvyy8FQ1o37xh7kT1TdZijJ2KMlBZd7uk
Message-ID: <CADhLXY5Mp3QjKoYHpgdd+mehZnOt2fkhCWNNrjfH1rZsKPjycg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v3] drm/virtio: use uninterruptible
 resv lock for plane updates
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0B57A57A507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 9:44=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/15/26 11:40, Deepanshu Kartikey wrote:
> > +int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_objec=
t_array *objs)
> > +{
> > +     unsigned int i;
> > +     int ret =3D 0;
> > +
> > +     if (objs->nents =3D=3D 1) {
> > +             dma_resv_lock(objs->objs[0]->resv, NULL);
> > +     } else {
> > +             ret =3D drm_gem_lock_reservations(objs->objs, objs->nents=
,
> > +                                             &objs->ticket);
>
> drm_gem_lock_reservations() is interruptible. Given that only one BO
> needs to be locked for the fix, make it
> virtio_gpu_lock_one_resv_uninterruptible() and fail with -EINVAL if
> objs->nents > 1
>
> --
> Best regards,
> Dmitry
>

I have sent patch v4.

Thanks

Deepanshu

