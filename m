Return-Path: <stable+bounces-28207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C298E87C4E3
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76191C215F4
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF59768EF;
	Thu, 14 Mar 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbzfDuKG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120276416
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453196; cv=none; b=EeO4bqt4QuVQR9hLiyMNQIlkt0JxQEe/02QzbReYUbY5P5vXLVLWTqO7d34SE/xBMO/qHozcGCTLkvBUOf0nCG9JgkhvRAfbV1tDZ2gOLh0Ajgkv1E9iEnpppy7z0m03bx0c0KbtcEZ3Och8GHUVQcM8vpmDJi9h+mkEwv8aW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453196; c=relaxed/simple;
	bh=WPRfkxJqbJBYPqNpxCyMjPF27M2MVRXoenCnOxv8VfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVhF/2HB4CKPGROktURZsi2NOQDZKPgMxq4IxUiqbS19o6Zcu4ShSEkFpMi0Ukb1MzxNKWuCnCyyAuXWxW8JPA5GTXx22kmVIDIMpWDYbDsHE0TQ8VeI0Zfzq2SiCarQvbWC6tORvkwd+2VwVfpHq5u4sS5LbB/RJu8fzCDxgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbzfDuKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E73C433F1
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710453195;
	bh=WPRfkxJqbJBYPqNpxCyMjPF27M2MVRXoenCnOxv8VfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FbzfDuKG5SJAT17JTkLwXswieoLq4cCm13Ud/J+wId3WzGbuxONv4nooZrIIlWtwP
	 TV7gRO3f7aWmNpwWKCqZZ6sFXr6aGwRKeCmWtbTjwFcnxgOvA2Vapzepd3oEI6+jbj
	 OhcW94EokTr3Ehhm67bFJwmYttJF1ZTgq0tzqDK0Eoiu9YrdBf86edTnKSudPy0yjK
	 XQ07crASzeC4krlBSDubvyHh7R48H12MlROz218DVDWzQTImw9PnF18484RbSvQlI0
	 jhreYyOg+IA4d86DcMQHeEAMGKTRQTsMr29SJCG2NyNKtdqISZTP+Bbc/ZZ6dAgDHB
	 nS75jsKOO7l1w==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2509c66daso18846691fa.3
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 14:53:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoUdQ1AxVf6nuqeDEpfOkPOuLnKJbKCCu+2Qki9zp3fhweamdj
	EfMmLunYAgV2+FQoeGZIoafNbhvtcrKN4CzVS4KnUKbJb61i/JqMEP8bS6EMhIKg53+qFeQ5QoV
	g4ORlLhjlbLwbE4A6e0WvWfUzoTM=
X-Google-Smtp-Source: AGHT+IH+JKw0N+3Gs/RY5NStXciyGSAfDdP5e6wmmSFfMTkxWU4/NM5mxE0nKf/+8/S3+UVsTbzgaOYYe6jSVdBJx+U=
X-Received: by 2002:a2e:9b99:0:b0:2d4:7756:3549 with SMTP id
 z25-20020a2e9b99000000b002d477563549mr1887421lji.16.1710453194104; Thu, 14
 Mar 2024 14:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz> <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
In-Reply-To: <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 14 Mar 2024 22:53:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
Message-ID: <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 20:35, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 14 Mar 2024 at 19:32, Radek Podgorny <radek@podgorny.cz> wrote:
> >
> > hi,
> >
> > i seem to be the only one in the world to have this problem. :-(
> >
> > on one of my machines, updating to 6.6.18 and later (including mainline
> > branch) leads to unbootable system. all other computers are unaffected.
> >
> > bisecting the history leads to:
> >
> > commit 8117961d98fb2d335ab6de2cad7afb8b6171f5fe
> > Author: Ard Biesheuvel <ardb@kernel.org>
> >
>
> Thanks for the report.
>
> I'd like to get to the bottom of this if we can.
>
> Please share as much information as you can about the system
> - boot logs
> - DMI data to identify the system and firmware etc
> - distro version
> - versions of boot components (shim, grub, systemd-boot, etc including
> config files)
> - other information that might help narrow this down.

Also, please check whether the below change makes a difference or not

--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -477,6 +477,8 @@
                efi_exit(handle, status);
        }

+       memset(&boot_params, 0, sizeof(boot_params));
+
        /* Assign the setup_header fields that the kernel actually
cares about */
        hdr->root_flags = 1;
        hdr->vid_mode   = 0xffff;

