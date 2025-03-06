Return-Path: <stable+bounces-121247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2AA54DF6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C05188B0BD
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6701624FD;
	Thu,  6 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PQuN3o4Z"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A1DF71;
	Thu,  6 Mar 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271960; cv=none; b=JB0lwF3qNswwSsIV8pXWORRqryFwlTAWWSuWGMlJW6eJExnOJuz6KXNGlI7NnK0BtkSKXqsOpHDNCWfEyv6tNbOjIy3MNAKcMRxOhinYwW28TcMJ3JFIykh9Uh0mRqI3wTkp73f08oZ0GEEbf93SQ4xilSSqyXxMKGnrkT9b9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271960; c=relaxed/simple;
	bh=I3Rdo9Tv28/kEBJt/wJqtqa8Cn7oNKIw8YLpsVR+l5Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YRVHMDB6zmdGQPvqpskRtd3i/dWwz6fLFA7pYjgG3uoXk5ALdQvI9rOl+fFN/MRrk0tyGrKV/lCFvBPJthwKaxNJEaUrT5zk8c0cyqhlBApLdw2T4LfyKaHfFQWevIE1Y3vvYbo3aHFu1ic3UCJ15djKFVs/XJxCTYk9dXL5NqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PQuN3o4Z; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 526Ed1lc3967114
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 6 Mar 2025 06:39:01 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 526Ed1lc3967114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741271942;
	bh=dkXVBGPY63hZMCagXcTMmvllJsm+GP6pR+jupmxbpNM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PQuN3o4Zp2D/sAjCbf7GoU5PafOnVPHLsRfh1IOHeiEwZgHLgGHUehm5w0Apn2QCi
	 CcY72l6Bv4tIVQ2AuEZ7GP1TnixhVk2+WobaNwOCS9zZG8PFwRpPTAVspzOo5BNHLI
	 t1WQl5ovT7u2duCWitMr4WZ4KRZ5+TjKGfbLsoyoEeQE56r4Bxq/DtALq0r536r3sT
	 mNYkw+Vlkr36nUWOeeQQZzuP4/hSSdsM0RydrGz5jg3riQGYpvhd24qD9tMDfmmILy
	 GRaaxL1ejRa8YDg4CA9i6ADRsXUQ/+3iKUWMTCXfUk7nMZGnVa5o+05upKCB1DsADS
	 An7G7KmUutP5Q==
Date: Thu, 06 Mar 2025 06:38:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
CC: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_Regression_for_PXE_boot_from_patch_=22Remo?=
 =?US-ASCII?Q?ve_the_=27bugger_off=27_message=22_in_stable_6=2E6=2E18?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXH-CDaQ0UFuwHWC2ERRmvo7tS+jcZcue00yReyAi5sVXg@mail.gmail.com>
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de> <CAMj1kXH-CDaQ0UFuwHWC2ERRmvo7tS+jcZcue00yReyAi5sVXg@mail.gmail.com>
Message-ID: <F13ADA98-60CE-4B1A-B12F-2D1340AF44E3@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 6, 2025 6:36:04 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>(cc Peter)
>
>On Tue, 4 Mar 2025 at 15:49, Ulrich Gemkow
><ulrich=2Egemkow@ikr=2Euni-stuttgart=2Ede> wrote:
>>
>> Hello,
>>
>> starting with stable kernel 6=2E6=2E18 we have problems with PXE bootin=
g=2E
>> A bisect shows that the following patch is guilty:
>>
>>   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 200=
1
>>   From: Ard Biesheuvel <ardb@kernel=2Eorg>
>>   Date: Tue, 12 Sep 2023 09:00:55 +0000
>>   Subject: x86/boot: Remove the 'bugger off' message
>>
>>   Signed-off-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>>   Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>>   Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>>   Link: https://lore=2Ekernel=2Eorg/r/20230912090051=2E4014114-21-ardb@=
google=2Ecom
>>
>> With this patch applied PXE starts, requests the kernel and the initrd=
=2E
>> Without showing anything on the console, the boot process stops=2E
>> It seems, that the kernel crashes very early=2E
>>
>> With stable kernel 6=2E6=2E17 PXE boot works without problems=2E
>>
>> Reverting this single patch (which is part of a larger set of
>> patches) solved the problem for us, PXE boot is working again=2E
>>
>> We use the packages syslinux-efi and syslinux-common from Debian 12=2E
>> The used boot files are /efi64/syslinux=2Eefi and /ldlinux=2Ee64=2E
>>
>
>I managed to track this down to a bug in syslinux, fixed by the hunk
>below=2E The problem is that syslinux violates the x86 boot protocol,
>which stipulates that the setup header (starting at 0x1f1 bytes into
>the bzImage) must be copied into a zeroed boot_params structure, but
>it also copies the preceding bytes, which could be any value, as they
>overlap with the PE/COFF header or other header data=2E This produces a
>command line pointer with garbage in the top 32 bits, resulting in an
>early crash=2E
>
>In your case, you might be able to work around this by removing the
>padding value (=3D0xffffffff) from arch/x86/boot/setup=2Eld, given that
>you are building with CONFIG_EFI_STUB disabled=2E However, this still
>requires fixing on the syslinux side=2E
>
>
>
>[syslinux base commit 05ac953c23f90b2328d393f7eecde96e41aed067]
>
>--- a/efi/main=2Ec
>+++ b/efi/main=2Ec
>@@ -1139,10 +1139,14 @@
>        bp =3D (struct boot_params *)(UINTN)addr;
>
>        memset((void *)bp, 0x0, BOOT_PARAM_BLKSIZE);
>-       /* Copy the first two sectors to boot_params */
>-       memcpy((char *)bp, kernel_buf, 2 * 512);
>        hdr =3D (struct linux_header *)bp;
>
>+        /* Copy the setup header to boot_params */
>+        memcpy(&hdr->setup_sects,
>+              &((struct linux_header *)kernel_buf)->setup_sects,
>+              sizeof(struct linux_header) -
>+              offsetof(struct linux_header, setup_sects));
>+
>        setup_sz =3D (hdr->setup_sects + 1) * 512;
>        if (hdr->version >=3D 0x20a) {
>                pref_address =3D hdr->pref_address;
>--- a/com32/include/syslinux/linux=2Eh
>+++ b/com32/include/syslinux/linux=2Eh
>@@ -116,6 +116,7 @@ struct linux_header {
>     uint64_t pref_address;
>     uint32_t init_size;
>     uint32_t handover_offset;
>+    uint32_t kernel_info_offset;
> } __packed;
>
> struct screen_info {

Interesting=2E Embarrassing, first of all :) but also interesting, because=
 this is exactly why we have the "sentinel" field at 0x1f0 to catch *this s=
pecific error* and work around it=2E

