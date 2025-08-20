Return-Path: <stable+bounces-171912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5598B2E0FF
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 17:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6E9A22CCC
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F13337699;
	Wed, 20 Aug 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PRwfcjL2"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26233768D;
	Wed, 20 Aug 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702357; cv=none; b=Iqoq74wwVgPgX+IzHfg+oalB5j9d0NaPZ4wMo5ov+t/oM117YECVxIdY3/xaWknN5vDr6YPPlAnBkYeZ2eBM0EOmc/gUfLhdvrUwbgCMY9ijklorBc36/6Cfp1LP8K106oHMOVdkbb1Pl5dPHXKdcCo/h6dyAYAkApl8z35Q3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702357; c=relaxed/simple;
	bh=FfkoZlnzoZkKlxWkhG0YyxxMSaXAsMovbbjPCCgd1Cg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RSknHAH6AkqMfulGOJ/ii4pGOjeOfPkQcz92BHPoPvfVyNpuZyyS9nWSubspR7oWH3CI8NlwX24gGpJSeYBZjBaKGVX895vCdeZdQEjQk5S3fO/ilthlrx5reN11L3hcatI/a2VI2a0/4a7y4CC8V006pk/0WfbFocZicwyFcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PRwfcjL2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57KF4uPf3773383
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 20 Aug 2025 08:04:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57KF4uPf3773383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755702297;
	bh=FfkoZlnzoZkKlxWkhG0YyxxMSaXAsMovbbjPCCgd1Cg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PRwfcjL2kI/UMcRa4Wd7k5IA3UAsKH+P7wZvlLBk8/c52ZoSJlffLHYzpu9nmSSeA
	 QxlcOq3URm687lveTpzJ6NImuZ7S0QKctTxKl8Rk9NobJuFNeCSip2HK2VnXwQArYE
	 x5b/XX/uyPvrRPrgcFG+345Zhn5PPXaiy4QNZ2iu++G3JF1Y9Ms5vCBKTNJJycHAAB
	 rpZjMD2F33ITENU3jnYHFbscU9Py2c5/ZaQCasCeYkP1h87Y5LBHiaZxN/uYeJln0S
	 psKElp9WMbRUeM0fuD+jiktdMVxrC72u9kN0xtbh1kvGQLy5jZuNzLB2Xlb/ooqxLW
	 T9Mm3NfWNMk+g==
Date: Wed, 20 Aug 2025 08:04:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: "Alan J . Wylie" <alan@wylie.me.uk>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        x86@kernel.org
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
User-Agent: K-9 Mail for Android
In-Reply-To: <20250820100004.15a49b907b334e821f0a0e73@kernel.org>
References: <175386161199.564247.597496379413236944.stgit@devnote2> <20250817093240.527825424989e5e2337b5775@kernel.org> <F5D549B0-F8F7-467A-8F8D-7ED5EE4369D3@zytor.com> <20250820100004.15a49b907b334e821f0a0e73@kernel.org>
Message-ID: <7B59AB4E-F084-43FA-B21B-292319D30501@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 19, 2025 6:00:04 PM PDT, Masami Hiramatsu <mhiramat@kernel=2Eorg>=
 wrote:
>On Sat, 16 Aug 2025 18:36:17 -0700
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>
>> The easiest way to think of XOP is as a VEX3 supporting a different set=
 of map numbers (VEX3 supports maps 0-31, XOP maps are 8-31 but separate); =
however, the encoding format is the same=2E=20
>
>Hmm, OK=2E We need to enable VEX3 support too=2E What about the opcode?
>Most of the opcode are the same, or different instructions?
>
>Thank you,
>
>

Different, that's the whole point =2E=2E=2E

