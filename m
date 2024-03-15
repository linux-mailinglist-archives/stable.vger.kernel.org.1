Return-Path: <stable+bounces-28262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D187D307
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8E91C21995
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BE4C3DE;
	Fri, 15 Mar 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSMgeifM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDB50261
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524896; cv=none; b=fsjX4OsT6S0v9xMxZlKxibgGVE7EBOGla4M+fI2NURjBAh2+qLbMhVucMpMrBExU2h8UhFhwbV6d3pK35yFvd0PCecevJ1x/x6squY2osVYsjqitGIK9YLMe19+riZWhaJ86w0BDIP81Mqdn8n+XpkcUT+6bZXdGRFz/Rt4QnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524896; c=relaxed/simple;
	bh=CFc98OtZe4qv/zHo1nBlWHl8zydaaqFr786VxMEEVHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmLs+jxf0KvTbvEOPxQQly/SlB60LkjKtBDFneK1KXxNxCpd6R+5v10N3SUIvsP9zw/uavS69GfHwJ/P2s4ga6YKbKTmQsSITXC6+iIJhodisfgqPxU14yKwkPn3sm6puSr7oz8zWE0NIBUYiS9om0Qu+0pqRpWpoIB4ZNOOe8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSMgeifM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EBC43399
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710524896;
	bh=CFc98OtZe4qv/zHo1nBlWHl8zydaaqFr786VxMEEVHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TSMgeifM1PZ0LSrm7F345CpsaB18cHP0yc0hyEcGKDDn8qzySsAWCWK3TageSncOa
	 kAvFxTrdjtW2Tc49HET718pFGCiw8IAHwwx3KSl00m8Vmv0neuAqxCV9PjW0uiNhcc
	 hJKPWia+5AT/NeTnQEdgIF1+MKVOo9uRD7VE1kehdcVZ2V6WhVXccilqYyX78DfFSY
	 GKGe/mTvV6Lr4iPoFz3EmNeiUB5e4l3M20IxuXEx0OT8AFLAG6KG6l85uittJlVelx
	 XvolpD8rAZUIfybjloZJukDNXfe9dclMHnZ/4kJYMyXN1v2FVXzAMffEAr+49GrZMs
	 r3fQzFl0uAe2g==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d475b6609eso30355571fa.2
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 10:48:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YykjrgV9EVhRePf/4TdHKMcCMrMhKNXRD+pjm2OmcHr7QZ3mfMz
	2OdCq0pok0mfypkw4dpIvxYmZqoztogukbCMdMoG0wWsYdph1f8lec7AH61CTWwqb753Y46OhJx
	sFGst+eSFSBPQ2mEpNOoBrmCJV2Q=
X-Google-Smtp-Source: AGHT+IEkHn7deHHj9Jd9/dfGAQncvwqXSbYszo9AfHYS0Z2MYV3dGuBvRX90Uae4oz39r34HHc3W6Hpca5UcKyJtqdQ=
X-Received: by 2002:a2e:8687:0:b0:2d2:42ff:483c with SMTP id
 l7-20020a2e8687000000b002d242ff483cmr3933118lji.33.1710524894855; Fri, 15 Mar
 2024 10:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz> <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
 <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com> <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
In-Reply-To: <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 18:48:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
Message-ID: <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 17:24, Radek Podgorny <radek@podgorny.cz> wrote:
>
> it's systemd-boot. attaching bootctl output. now looking at it, it seems
> that while systemd (and systemd-boot) gets timely updates on my system
> (currently at 255.4), the stub (is this how it's called?) does not get
> updated automatically in the efi partition (still at version 244?).
>
> i can try to update it. but i'll wait for your instructions since this
> may be some rare situation and we may use it for testing.
>
> anyway, i'm compiling new kernel with your suggested changes right now
> so i'll let you know how it turned out, soon.
>
> r.
>
> p.s.: ha! nevermind, i just checked the other systems which boot fine
> and they also are on stub (?) 244 so it's probably not the cause.
>

OK that makes sense.

I installed Arch linux in a VM (what a pain!) but I don't think the
distro has anything to do with it.

I did realize that reverting that patch is not going to be a full
solution in any case.

Could you please try whether the following fix works for you?

--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -473,6 +473,9 @@
        int options_size = 0;
        efi_status_t status;
        char *cmdline_ptr;
+       extern char _bss[], _ebss[];
+
+       memset(_bss, 0, _ebss - _bss);

        efi_system_table = sys_table_arg;

