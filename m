Return-Path: <stable+bounces-121249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83500A54E12
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10A41887CF1
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1023170A23;
	Thu,  6 Mar 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO7ux63/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27A148FED
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272265; cv=none; b=erApNcIuKbog1HFaFNbgKhkxjnC8HbGDSb9aL2TppSf43r62D4kL6EF3Hvmshsx44wbFnFHL1XnUr+5RS35TsTVjbicuG3+EbsMjQyETe94ByEjaTUU0TtccFZh+oLI916tmfGlEcoX/MhMQm7E07qZkZ74tla64QwpV4lY+tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272265; c=relaxed/simple;
	bh=xlmpOlIgd3SxqSEMgUrM81PV78wbSOH1EFVox32lnPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU3FmCX8z58m/GYWiQDJgeva01IrR2InONlOOfwUNhnZYJWihLEssuobpzKYNKKThwv1uYmfLIzwt5LfvpKrHkUyeuE5B5gRkFKqavbBXjsB0qqEiqGww7jO7hQK/qBr2s7WdPWQrZ/M0r0XRP8/g+piSB5hGrV9PZ8YAylG3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO7ux63/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F415C4CEE8
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272265;
	bh=xlmpOlIgd3SxqSEMgUrM81PV78wbSOH1EFVox32lnPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FO7ux63/b5lMZmMfSRJL8Eca1ynaDor2hjyIudNzcT9lXKMHNa8XrD+1WlkchJ8xQ
	 VUXHu7Yx3xwd1nXPbtpw4zH/UvSmU7Q4Vl+eZKcyxCpR3W+4ubsri+D9QV9UhkcTdw
	 0uAxkUPNkhWHkuDqp2KWcB79ikzbblTK+0POXDLxHYNplHkC8kdljRlDhBHG6kscmR
	 zAkFr1kVokocCFd9oYKLBNzkrWb6296e5WQYkovZa/zjQiVZhwI8+mLSSL/n58RVph
	 7fpRHUcy9pHpR2W2Mr/ZP6syTleGa0CMbnJpi+KyooE6gsszhA8d28ni1JPKZ7Lqp+
	 wYOUR58PV4gww==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5494cb8c2e7so856936e87.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 06:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4MOWYy1A1M1XILqOhW5GxxlesUCcVZrkXm3sV1aoh3CaF/ijBFFiIF3Zfmy9fW9w9BNMqIOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzipqe4p911tv0zLIjYcl1YFdrZ8eCgVzTYfzcq9EroVfQXHIkZ
	os/ECCoVP4bvH9pc3Q7LDyu40CFmUDziqrGJQp8TvsF4PdHqCocHOC83nVHIx4l1UTy7WP5FiaX
	TmAhFVnfbwALFYRLi6T2311BQrF4=
X-Google-Smtp-Source: AGHT+IGjETK7J1YrhmHQKe+CuJXnJcwH55rAducjFYIS5jk0izp7FcKFqeXDvsHo3erBw052Yb+DmXw+J718l1pgz1Q=
X-Received: by 2002:a05:6512:220e:b0:549:4e78:9ed5 with SMTP id
 2adb3069b0e04-5497d38072amr3073741e87.45.1741272263521; Thu, 06 Mar 2025
 06:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
 <CAMj1kXH-CDaQ0UFuwHWC2ERRmvo7tS+jcZcue00yReyAi5sVXg@mail.gmail.com> <F13ADA98-60CE-4B1A-B12F-2D1340AF44E3@zytor.com>
In-Reply-To: <F13ADA98-60CE-4B1A-B12F-2D1340AF44E3@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Mar 2025 15:44:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE2APmDBoTWnDJBmEcU0-B6kKFARCpmN4kYrufy-TMwHA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq9U7f90urMo0XcPl7Hrufvxw5r9sdfmrpJxs6eD734ZJAE8_OhFQtdjeA
Message-ID: <CAMj1kXE2APmDBoTWnDJBmEcU0-B6kKFARCpmN4kYrufy-TMwHA@mail.gmail.com>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off'
 message" in stable 6.6.18
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 15:39, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On March 6, 2025 6:36:04 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> >(cc Peter)
> >
> >On Tue, 4 Mar 2025 at 15:49, Ulrich Gemkow
> ><ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> >>
> >> Hello,
> >>
> >> starting with stable kernel 6.6.18 we have problems with PXE booting.
> >> A bisect shows that the following patch is guilty:
> >>
> >>   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 2001
> >>   From: Ard Biesheuvel <ardb@kernel.org>
> >>   Date: Tue, 12 Sep 2023 09:00:55 +0000
> >>   Subject: x86/boot: Remove the 'bugger off' message
> >>
> >>   Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>   Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >>   Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >>   Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
> >>
> >> With this patch applied PXE starts, requests the kernel and the initrd.
> >> Without showing anything on the console, the boot process stops.
> >> It seems, that the kernel crashes very early.
> >>
> >> With stable kernel 6.6.17 PXE boot works without problems.
> >>
> >> Reverting this single patch (which is part of a larger set of
> >> patches) solved the problem for us, PXE boot is working again.
> >>
> >> We use the packages syslinux-efi and syslinux-common from Debian 12.
> >> The used boot files are /efi64/syslinux.efi and /ldlinux.e64.
> >>
> >
> >I managed to track this down to a bug in syslinux, fixed by the hunk
> >below. The problem is that syslinux violates the x86 boot protocol,
> >which stipulates that the setup header (starting at 0x1f1 bytes into
> >the bzImage) must be copied into a zeroed boot_params structure, but
> >it also copies the preceding bytes, which could be any value, as they
> >overlap with the PE/COFF header or other header data. This produces a
> >command line pointer with garbage in the top 32 bits, resulting in an
> >early crash.
> >
> >In your case, you might be able to work around this by removing the
> >padding value (=0xffffffff) from arch/x86/boot/setup.ld, given that
> >you are building with CONFIG_EFI_STUB disabled. However, this still
> >requires fixing on the syslinux side.
> >
> >
> >
> >[syslinux base commit 05ac953c23f90b2328d393f7eecde96e41aed067]
> >
> >--- a/efi/main.c
> >+++ b/efi/main.c
> >@@ -1139,10 +1139,14 @@
> >        bp = (struct boot_params *)(UINTN)addr;
> >
> >        memset((void *)bp, 0x0, BOOT_PARAM_BLKSIZE);
> >-       /* Copy the first two sectors to boot_params */
> >-       memcpy((char *)bp, kernel_buf, 2 * 512);
> >        hdr = (struct linux_header *)bp;
> >
> >+        /* Copy the setup header to boot_params */
> >+        memcpy(&hdr->setup_sects,
> >+              &((struct linux_header *)kernel_buf)->setup_sects,
> >+              sizeof(struct linux_header) -
> >+              offsetof(struct linux_header, setup_sects));
> >+
> >        setup_sz = (hdr->setup_sects + 1) * 512;
> >        if (hdr->version >= 0x20a) {
> >                pref_address = hdr->pref_address;
> >--- a/com32/include/syslinux/linux.h
> >+++ b/com32/include/syslinux/linux.h
> >@@ -116,6 +116,7 @@ struct linux_header {
> >     uint64_t pref_address;
> >     uint32_t init_size;
> >     uint32_t handover_offset;
> >+    uint32_t kernel_info_offset;
> > } __packed;
> >
> > struct screen_info {
>
> Interesting. Embarrassing, first of all :) but also interesting, because this is exactly why we have the "sentinel" field at 0x1f0 to catch *this specific error* and work around it.

We're crashing way earlier than the sentinel check - the bogus command
line pointer is dereferenced via

startup_64()
  configure_5level_paging()
    cmdline_find_option_bool()

whereas sanitize_bootparams() is only called much later, from extract_kernel().

