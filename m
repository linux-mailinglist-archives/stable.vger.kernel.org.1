Return-Path: <stable+bounces-192409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746EC31848
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3444F76E5
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C832E731;
	Tue,  4 Nov 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rqqxztu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACA32E13D
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266504; cv=none; b=DT7sB4eUY4BPils3aDmas1krX8z8+QGbRwHXVNP2hyqAiqgQpKPTArHooLqRBOtHFxuvnvjSBKEmX2Lf+jJ+ls1kQtc7+vyoZnaFa3jIsDm6qJAiLGo9rb0wUNZN5JYsoo7XK1P7VPeROtEr/uqVsB/G9aLFuAefi4P82TeHlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266504; c=relaxed/simple;
	bh=bOUseqs0/yr0gyLsEbF5SZzGuVHo114FDuUCPMgV0CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHq7lneTHGIBttM4LalJtzygW6ChsLzxr2ky71YOM0rp8REtq1uzUJgumcVadyltbGnY1027Yg02It+KQLCgI+iq6HkIW8zZUGwtx/Htw+8dvmVs/L9ura1bIbBrOYcjg1hZDcEKSU8EDswUcj5Jm3blTyfNJ5uia5IVGCoAVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Rqqxztu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FCCC16AAE
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rqqxztu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762266501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOUseqs0/yr0gyLsEbF5SZzGuVHo114FDuUCPMgV0CA=;
	b=Rqqxztu5gAR49K4yDbS8TJh6E4ugKy5FZDUu7tvMaMpl1CtILOe9Qavc8L5xW6x+242z7p
	ajFdqAKKgAwZgObw688KgTogNMgBwMnpGXhbGuDe03/2W+kdZIn5SAbNtulwG+Z3oR2BzE
	3jImKgxZHnh0jpv3d7WQchw+kjr0uJk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ee255ef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Tue, 4 Nov 2025 14:28:20 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3d3ed0c9f49so1681276fac.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 06:28:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbFNOQA48JI/Y3oO8ULpjFVyjLPuj+QUryZP5q7Itkrn382tsjkZye0Z95xx7glk7nQlle8uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhugDpztPd720pQSow8PphNrbN6nSamM6ET9IK6t5Z9gnUYPt1
	qi8D0/DaqeuAVZONvY1mk5m+4OuWl7FnI6FsZkeCMguNxbmBJcBrt91znXH/hwROVYn5sqky5xJ
	vZ6H1ghJ17tMeyQ2/G4A0FiLyouGYSMs=
X-Google-Smtp-Source: AGHT+IGza8zzX144QnXoi8LJlcrNNICdujUMm9bvpPztquEv4qZX4iTQn23WLE4gSQ0MKPZYc0di0vFXGT3WuVLb3xw=
X-Received: by 2002:a05:6871:af89:b0:3e1:1de:9c0d with SMTP id
 586e51a60fabf-3e101dec119mr304129fac.17.1762266498684; Tue, 04 Nov 2025
 06:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPT9vUT7Hcrkh6_l@zx2c4.com> <176216536464.37138.975167391934381427@copycat>
 <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local> <176221415302.318632.4870393502359325240@copycat>
 <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local>
In-Reply-To: <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 4 Nov 2025 15:28:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
X-Gm-Features: AWmQ_bm6guEyV2s4zGI9wdjGi49bamfyTDiHqxDlH_4YqQNR0PHmH9jtIBy2EWU
Message-ID: <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
To: Borislav Petkov <bp@alien8.de>
Cc: Christopher Snowhill <chris@kode54.net>, Gregory Price <gourry@gourry.net>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org, 
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com, 
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com, 
	darwi@linutronix.de, stable@vger.kernel.org, thiago.macieira@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:21=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
> And the problem here is that, AFAICT, Qt is not providing a proper fallba=
ck
> for !RDSEED. Dunno, maybe getrandom(2) or so. It is only a syscall which =
has
> been there since forever. Rather, it would simply throw hands in the air.

Qt seems to be kinda wild.

When you use -mcpu=3D, you generally can then omit cpuid checks. That's
the whole idea. But then Qt checks cpuid anyway and compares it to the
-mcpu=3D feature set and aborts early. This mismatch happens in the case
Christopher is complaining about when the kernel has masked that out
of the cpuid, due to bugs. But I guess if it just wouldn't check the
cpuid, it would have worked anyway, modulo the actual cpu bug. But
regarding rdseed/rand bugs, there's a workaround for earlier AMD
rdrand bugs: https://github.com/qt/qtbase/blob/dev/src/corelib/global/qsimd=
.cpp#L781
But then it skips that for -mcpu=3D with `(_compilerCpuFeatures &
CpuFeatureRDRND)`. Weird.

Another strange thing, though, is the way this is actually used. As
far as I can tell from reading this messy source,
QRandomGenerator::SystemGenerator::generate() tries in order:

1. rdseed
2. rdrand
3. getentropy (getrandom)
4. /dev/urandom
5. /dev/random
6. Something ridiculous using mt19937

In addition to rdseed really not being appropriate here, in order to
have seeds for option (6), no matter what happens with 1,2,3,4,5, it
always stores the first 4 bytes of output from previous calls, just in
case at some point it needs to use (6). Goodbye forward secrecy? And
does this mt19937 stuff leak? And also, wtf?

This is totally strange. It should just be using getrandom() and
falling back to /dev/urandom for old kernels unavailable. Full stop.
Actually, src/corelib/global/minimum-linux_p.h suggests 4.11 is
required ("We require the following features in Qt (unconditional, no
fallback)"), so it could replace basically this entire file with
getentropy() for unix and rtlgenrandom for windows.

I dunno, maybe I read this code wrong --
https://github.com/qt/qtbase/blob/dev/src/corelib/global/qrandom.cpp
-- you can look at yourself. But this whole thing seems to be muddled
and pretty bad.

So I'm slightly unsympathetic.

I'm CC'ing Thiago; he'll maybe have some sort of defense of all this
weirdness. But really -- you're doing it wrong. Just use getrandom()!

Jason

