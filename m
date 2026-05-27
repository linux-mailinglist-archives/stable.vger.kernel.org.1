Return-Path: <stable+bounces-254475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGIjM4BpFmq/mAcAu9opvQ
	(envelope-from <stable+bounces-254475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:48:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCC5DF0A7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2E11302158C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765862147E6;
	Wed, 27 May 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLcKwS7e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+OHOPmp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE9222599
	for <stable@vger.kernel.org>; Wed, 27 May 2026 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853692; cv=pass; b=ufnKhtiCMqdMdYfqieS/6U7QVfNBRjvZeUpEqXK+Ge2L7n2m7bqi5ZunSD4EdNoWUL0zAlelIwD/+YPGN72gBOZGKEw2TnUIewCygDv6nbNtWPd6LDFrrFRoeYuKrPY4U/O2d3nBNWdFXu5+xb1Z137zNoGZsy7BAHQ56WMnQhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853692; c=relaxed/simple;
	bh=l3TYLkwmq8Lx/1h9vKpaJnCmo8epW2pqLi67STdb86s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnO8y+myOi4Yye73vHbSqnFJcHN82rPNP4WwF3fD94cQDrdJyRbc9CtYx1Rr8WBNxUN25GKr79JNUGEF144Gt1N3byGsU6dezHJobnMQGs7TSdcDT25ZxFFHSgVpYBA/vEG4udnd8QhUNesxgA2rEn2lzEyzAyGCpLI+fjyeiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLcKwS7e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+OHOPmp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779853689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5xv8byUkwzNXZqVoMu7h8lDulAV+iu6SMGQfg//Sfk=;
	b=dLcKwS7eEVNK7StXhdxFwRJ08oLs+hebjmv/4vPQxywvPG3kFYc5BewUsuZOibu8vStxEz
	aeKfkuFdJgkvBEydP50xR464c0bgrQU2xzt7CgSYphkvy0JSveX3cOD7z6gWw4TCijWtfu
	e3olI/FZey5q6bboVm49cNBAPWAiAds=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-zY8cZ1FaNzq15XO1upVnmw-1; Tue, 26 May 2026 23:48:05 -0400
X-MC-Unique: zY8cZ1FaNzq15XO1upVnmw-1
X-Mimecast-MFC-AGG-ID: zY8cZ1FaNzq15XO1upVnmw_1779853685
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e3dbd97fe3so17882820a34.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 20:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779853685; cv=none;
        d=google.com; s=arc-20240605;
        b=jsNFoQ2obtXfeZAFKooGH6GR5ad2iUMdyIdosWHU1A++ccyYRK1PFxpu2l1Tz4ZhHO
         GcN/DjrRIjbl9r//1I5zoKC6nqF5Q4zv57MrEa/kHmZlu/HNci4xL3eGs8kWakkgpPwW
         TQax/2IMBJCGS6B0qdhO2nQMn/XL2iABQMLvpFybs5ngrzAZxrJA/AR2ox5jeuAQ5TtJ
         1YyxRz8K+xzngzGGJUCD4O5TNygiKuTiSpJEYMBAhSmw6jQR8aDP9LBCwsydY2ge4rGp
         5cLwaDC8nqsLE5VVkCxboZ643muptEkkTMsA9jCs3dhTwUUt7/fxE2YhZtQ4IuXigjxb
         LawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5xv8byUkwzNXZqVoMu7h8lDulAV+iu6SMGQfg//Sfk=;
        fh=Ky+I2l+uwz/qA+WrDn1xQnaf7ZmbWWtdHBr/Cj2fmQM=;
        b=XEpSe1To8pOySERjS2pK4IqmogxCI1EuRBa0ALjrkuKbGcSsA8mVRgNGZ5KLzEsL73
         kVFTXueL5HnzOiMCCQTNhilLpjmo3lWOqn4lyT2dsoMK2m/+RDp6bg9+xxAI4Xe/enS3
         MbuLFAuHS8vYbSSxxdfOOIaUzp1r4BjVXpViWrtWWuMZYbLNhhN4FRjeiv3LdGp0J0+2
         waqw3nR8wUooubr4mO4PufYpF1SW6GDyeuYq15jFLiCMo04zZ40xkRxTs0fw7cLQWJjP
         4/9sufOfj8/GOF2c+CVv3Zc5XzntqXeo0JZdCVURsIGXxoyzOQBzK+0vIFdK9EwHDVQN
         iIFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779853685; x=1780458485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5xv8byUkwzNXZqVoMu7h8lDulAV+iu6SMGQfg//Sfk=;
        b=Y+OHOPmpQS7+Bch8A7zjO01P5C2g4/jNbw0wN/viu5QKZkIWSwWV9HmyZ5JE4a4CgV
         rJ9oefFjp6u9iZRyvuETFnBMXAILf3lxI0Y6tdqf06MKI02Fct0Lbprb+5rf/Qnkrnax
         Zr103lTioom4EpI4WodeSwwzQHWDWoh7Fa0Lhm6iPW76OwvrNss5IUG9g9chw5q8myeh
         1Xm+nWQFc9vcuDMFRQyF580IUaUV0PcoX5w0BlbtysmSD4st/lJHR7HZ7WKkIsZ1XI5t
         iB1yEMTY6mBolzWS4hvs1hajN21G0+u4zJ/2dVIMV023Ura8kGIU7s0gwEcuPYbSLV84
         TPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853685; x=1780458485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5xv8byUkwzNXZqVoMu7h8lDulAV+iu6SMGQfg//Sfk=;
        b=ocZtfqWSvixPuhN3IkKHu5D0y1cLxRaBAId4wmHK6KD1CwIO1FnAuZI1+3SckOr7uN
         9sW7avIGmFhX3dm4iIQK5eZW093RLzFNc8ixugv5wK6O28RMnPvSiVcthM6NOHNTc04t
         xykg2YzDbrUz8tsCsQm7gRUGBUKC1SB6kmf5D4nzuHOYO77Uq1THfOh0t/qYGhMG/PiW
         I9MfVJdm15n4VFrxJNOVH8ifwvehvjHTr7w+IyAf5wRAKHM9WRA9Njm0LxTYYbnu4iOV
         h4ztuhvHpIJ+crisgcUCxkBLAnyDBqKkT71IvNpn9vi0DHMsu7Xs9+02IVP0x529Yr1T
         V8VA==
X-Forwarded-Encrypted: i=1; AFNElJ8ADx8aoKKX/ewQLuiPklq1/fkpstPUNhqU0rzeLiU3KQAu14KPMbKPZ8WWPWhkNsqGlv+OZi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvoxzd+EhA+P8NJgG1bIXkHzfHk3/szUFY8bH7VwmAZmQLKpiA
	+bZ1YPqZuTrKitGjRqRegl0/NrbouR8tyd8pEshuWnSN+vyXbbh0bP8+WXGwDOUcmrscqG6aJw3
	YAzjZSRguKIJtOikSqzABN5oJmtxfWCQDdOdwMgwLlhDOMMdvLF9nSfWj7EhqvHvILaTUbyumfI
	1uTnn72jfJCHacYCX2M6QfIvvOvZCzXGC++A5HXM3ukd0=
X-Gm-Gg: Acq92OG2v4w/vPKhYsy1OqY77u3hMPB/XveIuXnHKHrlS2OCCaStsK4YC9BZaRgNWHx
	mtBf2HI4p34I4+/JWVw/SmjBGdQTyuBNDSfE3Yi+RpvFUb7yBWhnbKyxMckUskPEXje8gHWl2+D
	kznzJKWVqx+je/5/qr1pRm+AjpiSae9Y3o2wcLYZQDez857/B8915WuQxwX7UKZ4w6TobewYho/
	ki+6QDYT4qrAeB1zBh1fLXRZDaJBhXKcbfatLyT79tnFKd6bw==
X-Received: by 2002:a05:6820:1c83:b0:694:a37c:4e84 with SMTP id 006d021491bc7-69d7ebdebf2mr12762483eaf.27.1779853684808;
        Tue, 26 May 2026 20:48:04 -0700 (PDT)
X-Received: by 2002:a05:6820:1c83:b0:694:a37c:4e84 with SMTP id
 006d021491bc7-69d7ebdebf2mr12762473eaf.27.1779853684346; Tue, 26 May 2026
 20:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
 <20260502114644.76e6b5a3.michal.pecio@gmail.com> <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
 <20260502235517.089ba5bf.michal.pecio@gmail.com> <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
 <20260503071749.6abda137.michal.pecio@gmail.com> <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com> <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com> <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com> <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com>
In-Reply-To: <20260523102815.5c05c70a.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 27 May 2026 00:47:53 -0300
X-Gm-Features: AVHnY4I36gQQbSbLQZr5A82oBHEVCJk5vJLLSiZeM5MN9nVf4KePgn-mkxCGFWk
Message-ID: <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254475-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[desnesn@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8FFCC5DF0A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michal,

On Sat, May 23, 2026 at 5:28=E2=80=AFAM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
> We can make a guess that the faulting address is the ERST, which
> definitely should be accessible to the host controller.
>
> This simple patch logs ERST allocation and freeing; as far as I see
> nothing else touches that mapping.
>
> If the ERST is somehow freed before starting the HC, that's a bug.

Tested the patch and only saw the allocation messages:

# grep "alloc ERST\|free ERST\|ERST\|Device context\|fault addr"
vmcore-dmesg.txt
[    6.582282] xhci_hcd 0000:00:0d.0: Device context base array
address =3D 0x000000010aca8000 (DMA), 00000000282a4aa1 (virt)
[    6.582287] xhci_hcd 0000:00:0d.0: alloc ERST at 0x000000010acac000
[    6.598137] xhci_hcd 0000:00:0d.0: ERST deq =3D 64'h10acaa000
[    6.715052] xhci_hcd 0000:80:14.0: Device context base array
address =3D 0x0000000102ec9000 (DMA), 00000000d1c656e7 (virt)
[    6.715057] xhci_hcd 0000:80:14.0: alloc ERST at 0x0000000102ecd000
[    6.730919] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h102ecb000

# grep "alloc ERST\|free ERST\|ERST\|Device context\|fault addr" kexec-dmes=
g.log
[Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
[80:1f.6] fault addr 0x106f06000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
[Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
[80:1f.6] fault addr 0x106f19000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
[Tue May 26 08:41:57 2026] DMAR: [DMA Write NO_PASID] Request device
[80:1f.6] fault addr 0x106f1c000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
[Tue May 26 08:42:01 2026] xhci_hcd 0000:00:0d.0: Device context base
array address =3D 0x00000010750bf000 (DMA), 00000000fcec19e7 (virt)
[Tue May 26 08:42:01 2026] xhci_hcd 0000:00:0d.0: alloc ERST at
0x00000010750c5000
[Tue May 26 08:42:01 2026] xhci_hcd 0000:00:0d.0: ERST deq =3D 64'h10750c30=
00
[Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: Device context base
array address =3D 0x000000107513c000 (DMA), 000000008803b985 (virt)
[Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: alloc ERST at
0x0000001075140000
[Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h107513e0=
00
[Tue May 26 08:42:02 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1075140000 [fault reason 0x39] SM: Present bit
in Root Entry is clear

^ PS: Different address alloc on kdump though

> Otherwise, it seems you were right that you have some IOMMU problem.

Thus, I started to investigate this front now. This time I gave some
more attention to these dmar messages:

     [Tue May 19 08:17:49 2026] DMAR: Intel-IOMMU force enabled due to
platform opt in
     [Tue May 19 08:17:49 2026] DMAR: No RMRR found
     [Tue May 19 08:17:49 2026] DMAR: No ATSR found
     [Tue May 19 08:17:49 2026] DMAR: dmar0: Using Queued invalidation
=3D> [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -
trying to copy translation structures
=3D> [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from
previous kernel for dmar0
     [Tue May 19 08:17:49 2026] DMAR: dmar1: Using Queued invalidation
=3D> [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -
trying to copy translation structures
=3D> [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from
previous kernel for dmar1

I started wondering if maybe on my system these translation tables
can't be fully trusted for some reason during kdump?
Maybe iommu is copying root_entries with the Present bit clear, and
thus generating the fault reason 0x39?
   -> bus 0x80's? Both ethernet and xhci_hcd fault addr were on this bus

So, to test this theory out, I tried to disable translation and
allocate a clean root-entry table right away if I am running a kdump
kernel:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e236c7ec221f..de673f34f4e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2135,24 +2135,31 @@ static int __init init_dmars(void)
                if (translation_pre_enabled(iommu)) {
                        pr_info("Translation already enabled - trying
to copy translation structures\n");

-                       ret =3D copy_translation_tables(iommu);
-                       if (ret) {
-                               /*
-                                * We found the IOMMU with translation
-                                * enabled - but failed to copy over the
-                                * old root-entry table. Try to proceed
-                                * by disabling translation now and
-                                * allocating a clean root-entry table.
-                                * This might cause DMAR faults, but
-                                * probably the dump will still succeed.
-                                */
-                               pr_err("Failed to copy translation
tables from previous kernel for %s\n",
-                                      iommu->name);
+                       if (is_kdump_kernel()) {
+                               pr_info("DESNES V2 IOMMU kdump kernel,
disabilng translation and allocating clean root-entry for %s\n",
+                                       iommu->name);
                                iommu_disable_translation(iommu);
                                clear_translation_pre_enabled(iommu);
                        } else {
-                               pr_info("Copied translation tables
from previous kernel for %s\n",
-                                       iommu->name);
+                               ret =3D copy_translation_tables(iommu);
+                               if (ret) {
+                                       /*
+                                        * We found the IOMMU with translat=
ion
+                                        * enabled - but failed to copy ove=
r the
+                                        * old root-entry table. Try to pro=
ceed
+                                        * by disabling translation now and
+                                        * allocating a clean root-entry ta=
ble.
+                                        * This might cause DMAR faults, bu=
t
+                                        * probably the dump will still suc=
ceed.
+                                        */
+                                       pr_err("DESNES V2 Failed to
copy translation tables from previous kernel for %s\n",
+                                              iommu->name);
+                                       iommu_disable_translation(iommu);
+                                       clear_translation_pre_enabled(iommu=
);
+                               } else {
+                                       pr_info("DESNES V2 Copied
translation tables from previous kernel for %s\n",
+                                               iommu->name);
+                               }
                        }
                }

Didn't had time to check ERST or HSE yet, but with this I didn't had
any DMAR faults, vmcore was collected normally and system rebooted
smoothly afterwards:

     [Tue May 26 22:52:58 2026] DMAR: Intel-IOMMU force enabled due to
platform opt in
     [Tue May 26 22:52:58 2026] DMAR: No RMRR found
     [Tue May 26 22:52:58 2026] DMAR: No ATSR found
     [Tue May 26 22:52:58 2026] DMAR: dmar0: Using Queued invalidation
=3D> [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -
trying to copy translation structures
=3D> [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,
disabilng translation and allocating clean root-entry for dmar0
     [Tue May 26 22:52:58 2026] DMAR: dmar1: Using Queued invalidation
=3D> [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -
trying to copy translation structures
=3D> [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,
disabilng translation and allocating clean root-entry for dmar1

Seems like a lead on this iommu front.

The funny thing is that the comment in this section literaly says that
doing this could cause faults, but here clearing it actually seemed to
solve them and made kdump succeed - commit
091d42e43d21b6ca7ec39bf5f9e17bc0bd8d4312 ("iommu/vt-d: Copy
translation tables from old kernel")

Let me do some more tests to dump and check the root-entry table
before clearing, as well as to check ERST allocations and HSE value,
and I'll get back to you Michal.

Best Regards,

Desnes


