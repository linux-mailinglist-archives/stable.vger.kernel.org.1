Return-Path: <stable+bounces-52332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF10909DC2
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10D2B20A22
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B81E53A;
	Sun, 16 Jun 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b="gjG7q0Lj"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85104431
	for <stable@vger.kernel.org>; Sun, 16 Jun 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718544992; cv=none; b=rsCqjI2uJD52LQzvyF4to+UspJSmwGrZ963XEmbFTDUfgLvSecz5XK5/3czqQU6RWs2Sgbj00Aj77t9PoKdYdwTqV+Elqmdj/5mAsWwB1VWk7c+sTJjDByloDmeU0V/G6ACypG2t9rm3Qc20Myc6sM+q6mkqeKzJ5nR8drFh44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718544992; c=relaxed/simple;
	bh=OruIFgvMhQ7qzxUcF7s0sHcP0A648keVXCVfZAN5jO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHe4FBblGafUfl4vjw5tf9p+oGrF8U1i5AVla85Uef2BPcyurwv08sN0lucBjj5Zzn/ZSTzfN6UWKikBWgq06EOWLgR2iKTlySI01ekVo25N1gBFZDm1Tn7gwiP3GUaXUOi1kXGI/n0A7NeR6keNeTCDIaagkVOv8L/d/0BjeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de; spf=pass smtp.mailfrom=heusipp.de; dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b=gjG7q0Lj; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusipp.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusipp.de;
	s=s1-ionos; t=1718544977; x=1719149777; i=osmanx@heusipp.de;
	bh=uRuZS4BiS0SFU8c7PvJdb3MPVxgiDjAiUi+FNx2MxOo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gjG7q0Lju9q+873TCTB3CmRlo3S2qy3/KoxwIcWi824x6PG0zUgaezJP/j8QVzwW
	 xBu8Qu/scqNpuB0CtsgQ5TDIH34sv8hbFDn7U2Hupvb8xECSbZEi56HihBw6wkKMy
	 kFeJjZe/UqjXBiEALvwCJUF5aBwNrcR4Z0ENU3GwBG0Pew3vLLHy/yJITsoJ3mjPF
	 dcUj2/HLjCVpFp2X83ERhB+QLe9pZRO4/Xlc9Gn/AhVT5dchpDzfwatLlKoFNboYp
	 bYY9Y0+mkqgU1tDxRX/dAf+qXXyuN202kQXEg4TVLy7qfoLBpK+KpI6v+Px5HT2OM
	 GPLz9m/YMFFToeSkGQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from octopus.fritz.box ([91.62.108.110]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSLAe-1rq82D1Q08-00Jm01; Sun, 16 Jun 2024 15:36:17 +0200
From: =?UTF-8?q?J=C3=B6rn=20Heusipp?= <osmanx@heusipp.de>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?J=C3=B6rn=20Heusipp?= <osmanx@heusipp.de>
Subject: [PATCH 6.9.y] x86/cpu: Provide default cache line size if not enumerated
Date: Sun, 16 Jun 2024 15:35:43 +0200
Message-Id: <20240616133543.1590007-1-osmanx@heusipp.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024060638-unenvied-immovably-70e4@gregkh>
References: <2024060638-unenvied-immovably-70e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VROSztBPHPbnQZuwA146YVEyFNxnnQmTSwhioApuTbmuBG0dYnU
 3LaBDJUWP+4CtN9DkIZ8iOuzKosnqG8ex4qFqroEFo3WqOzpsr7xKvXbGMX7aiGmMAZBl3x
 VfnJ+9jRC9UJzS9Z6hG450aJBn7JgihngqOXvzKhey1eprlyAsCwBZ3Kihkxql+to0Bndv+
 30dkULhxvig7xQ9Uj3SwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h1urXegGnKs=;dzKW5oXYlCaZbSLUo9PmM2loV9B
 1AN9bkf73l+zxchUJXexkBBRD2t4uxQlPcixGKCibj8QbY9mNuyBt6K7FAmaaskaqOYKAnuj6
 LAxb4nWmKLB61EeJ2G4zzHlwK72I7dl1kuWLmw4wJTopzyYvMR1EvszRFTjP22EDSY6rVGEja
 Y2oe9B/e1BYlrU60ZAh8hnIg3fGOATBEvUqxEU3dTFcR25TrWBYTMH2lHv1F0GMKI1ERAUH09
 dV36kd6M0GjONaEni/3F84YMG+1cDN9DsvupMRenC79GS9Nqs31Uqi+dg41eLlX5HbREiUhNj
 9XFCdZTNIklXiGxi1C/jBoJThLZpXIA0DtdHNp8aIvWvWgYEL6Cf+m/tZC7VImYY5PGW+wkF8
 eWpa0oj5Pg200y5weUawP9M0EvL6KgWud0eI8pOrzvMDAHSvcPfgQK0OIHxa5WeIcczkZtAtb
 N29ZAQ2b7NwT72MscrEMSyh3/+YbxMS+MHRftqVRfEOiIvO5hpN9ZxDo7v7BGGht9PgEwDRJ3
 c2wmM/1UFEzb55TZ649tAYnz2JPELTGkFmgkCxkHY+q3ylW3tqX2QzKPRy2HkINzIIc/Cxs0n
 Rdc07gbsVSZv9llPzE/SIh7DKhwLwEnjRLSmNV5r5ou4CIlekzs2bM9fpKTxifz2hn7K1D/KJ
 SiZXv1aqdIFR+FJEbtLwTeLYyxgyt/n5DoVd7mmk5riPDJR7PFln3WbvFs1JB2Pf0TujWShyU
 dNUlK0NqdgML/DuuS9cNGY85tqDpZSzmU4Lrk7uOgrFVthkULvtsW4=

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 2a38e4ca302280fdcce370ba2bee79bac16c4587 upstream.

tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
will end up reporting cache_line_size()=3D=3D0 and bad things happen.
Fill in a default on those to avoid the problem.

Long Story:

The kernel dies a horrible death if c->x86_cache_alignment (aka.
cache_line_size() is 0.  Normally, this value is populated from
c->x86_clflush_size.

Right now the code is set up to get c->x86_clflush_size from two
places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
have leaf 0x80000008 (or CPUID at all) just get some sane defaults
from the kernel in get_cpu_address_sizes().

The vast majority of CPUs that have leaf 0x80000008 also get
->x86_clflush_size from CPUID.  But there are oddballs.

Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:

	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
	if (cap0 & (1<<19))
		c->x86_clflush_size =3D ((misc >> 8) & 0xff) * 8;

So they: land in get_cpu_address_sizes() and see that CPUID has level
0x80000008 and jump into the side of the if() that does not fill in
c->x86_clflush_size.  That assigns a 0 to c->x86_cache_alignment, and
hilarity ensues in code like:

        buffer =3D kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
                         GFP_KERNEL);

To fix this, always provide a sane value for ->x86_clflush_size.

Big thanks to Andy Shevchenko for finding and reporting this and also
providing a first pass at a fix. But his fix was only partial and only
worked on the Quark CPUs.  It would not, for instance, have worked on
the QEMU config.

1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineI=
ntel/GenuineIntel0000590_Clanton_03_CPUID.txt
2. You can also get this behavior if you use "-cpu 486,+clzero"
   in QEMU.

[ dhansen: remove 'vp_bits_from_cpuid' reference in changelog
	   because bpetkov brutally murdered it recently. ]

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value s=
traight away, instead of a two-phase approach")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: J=C3=B6rn Heusipp <osmanx@heusipp.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240516173928.3960193-1-andriy.shevchen=
ko@linux.intel.com/
Link: https://lore.kernel.org/lkml/5e31cad3-ad4d-493e-ab07-724cfbfaba44@he=
usipp.de/
Link: https://lore.kernel.org/all/20240517200534.8EC5F33E%40davehans-spike=
.ostc.intel.com
Signed-off-by: J=C3=B6rn Heusipp <osmanx@heusipp.de>
=2D--
 arch/x86/kernel/cpu/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ae987a26f26e..fc76b5197565 100644
=2D-- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1064,6 +1064,10 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)

 		c->x86_virt_bits =3D (eax >> 8) & 0xff;
 		c->x86_phys_bits =3D eax & 0xff;
+
+		/* Provide a sane default if not enumerated: */
+		if (!c->x86_clflush_size)
+			c->x86_clflush_size =3D 32;
 	} else {
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			c->x86_clflush_size =3D 64;
=2D-
2.39.2


