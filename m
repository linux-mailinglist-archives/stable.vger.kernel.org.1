Return-Path: <stable+bounces-121202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D3A5472B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03251884231
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6B1FCD05;
	Thu,  6 Mar 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFCuTAu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7841F9AAB
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255239; cv=none; b=D79GG91GRaYY0cY9wXXPX9xPRjv6OQcAQ+WXcyH+8vyMwSiG7dxj11AAe3tE38s8yUPw6ExaslTArL1zZW3B5cNM3CaXK3+bGAThViXvVuDI1Q1Ck2jkIdyfvDmjRIXa8vaaHh2YUkQ55Gg69M6lYEV7RMv9XFNfIg9YuuhstGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255239; c=relaxed/simple;
	bh=GSB7yQOoKyX/vU+kTqJjEa8oaQ4N+jTIbAyj94CcFTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYyKEN3pvB4Q/2amTaFklE9lHLULV4K+xRogfd62eEgeZ8JIsA/8lvsXE6TjiLLgFMoQogPOvPoQ+IPI14UMkIfYbSg60AdP6wHe4hL8I7+yUp4NsAQi24Ua0aMfir9AsPcyrCWhL7oJR5V3PQ4eMMKDcvjcQ+T3DUXaP0/k/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFCuTAu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E72FC4CEE0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255238;
	bh=GSB7yQOoKyX/vU+kTqJjEa8oaQ4N+jTIbAyj94CcFTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uFCuTAu8PfHjIXs/p9rQVw0UrP0DDMGyAPk2+l/MhcdBkdryv6Rn45A9QLLMwvYUy
	 +2VjLFaT+beF26ViN7acoXSPcapxJz7QmapQzeg7aVs/00KTi4x8zL2j3au6gOTS0s
	 vWkKMelm7WDqLq1mdvXxxIwHFR/wUoNn4PWkXdnsN/cjksGHk/bQvbE2Gi7VijhTQS
	 6D3BfBtlKSBjiDoEnoBir0EJzH8Y/Ges6fAY5sr9tbUxcSV9Kn1BrRQPS11xvOTkA2
	 Hcff0TB944wiVRjOu4VT28CblLb/UUf4xZTYlAIIVqSAFvCewWuD2Nu8EjQxKYUxPQ
	 nLOpFwblMVnDg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30b8f0c514cso4109511fa.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:00:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yz6adIn1C9gEFh8JUvCT3UR12YYYzigN0kYMTIoOGQxctuGkZWG
	AvFVkp5wcUlcQ5wvZ5ZLAqo/TX1Z6y4VR1qR50IybGOMdD0ECdq8AndKRkvCoLHlT/8qBX4ZyGA
	DFyFYLxshffvRTzDgNAkajTj2Pz8=
X-Google-Smtp-Source: AGHT+IEHDihtZvyW6AUMTAIWcsnuYqqRNK3/za5EL1gD8gtCk6u6P6VN4N2SFkC4K0/YJr3gy8JMhMny7a/Wz7yKXc8=
X-Received: by 2002:a2e:a78a:0:b0:30b:ed8c:b1e7 with SMTP id
 38308e7fff4ca-30bed8cb307mr3336551fa.18.1741255236811; Thu, 06 Mar 2025
 02:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Mar 2025 11:00:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE7bzBV+Gzt4iuAfDpFzW=b0j0ncH9xxCGZkiexvfH3zQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoHQC_8tCb38Txb7IkFt3VdWFC0GhUbc2Mz9v5AZzXuyslmM5jF8w0UOKk
Message-ID: <CAMj1kXE7bzBV+Gzt4iuAfDpFzW=b0j0ncH9xxCGZkiexvfH3zQ@mail.gmail.com>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off'
 message" in stable 6.6.18
To: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 15:49, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> Hello,
>
> starting with stable kernel 6.6.18 we have problems with PXE booting.
> A bisect shows that the following patch is guilty:
>
>   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 2001
>   From: Ard Biesheuvel <ardb@kernel.org>
>   Date: Tue, 12 Sep 2023 09:00:55 +0000
>   Subject: x86/boot: Remove the 'bugger off' message
>
>   Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>   Signed-off-by: Ingo Molnar <mingo@kernel.org>
>   Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>   Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
>
> With this patch applied PXE starts, requests the kernel and the initrd.
> Without showing anything on the console, the boot process stops.
> It seems, that the kernel crashes very early.
>
> With stable kernel 6.6.17 PXE boot works without problems.
>
> Reverting this single patch (which is part of a larger set of
> patches) solved the problem for us, PXE boot is working again.
>
> We use the packages syslinux-efi and syslinux-common from Debian 12.
> The used boot files are /efi64/syslinux.efi and /ldlinux.e64.
>
> Our config-File (for 6.6.80) is attached.
>
> Regarding the patch description, we really do not boot with a floppy :-)
>
> Any help would be greatly appreciated, I have a bit of a bad feeling
> about simply reverting a patch at such a deep level in the kernel.
>

Hello Ulrich,

Thanks for the report, and apologies for the breakage.

I will look into this today - hopefully it is something that can be
resolved swiftly.

Can you share your syslinux config too, please?

