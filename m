Return-Path: <stable+bounces-45218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEE8C6C35
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B7FB22F7B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1215AADA;
	Wed, 15 May 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="rf1hovah"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E4159596;
	Wed, 15 May 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797998; cv=none; b=kqe7yoAu+gY7ox9kpDJc999LcV28tYHHVQKelHAp1M3HHQDgttv9gLQ67cg5NLQPAXQreDerWxFshW1fQ+PDarrOrXKbrnMHnioo9Z5PdBC/YEhbp8bXJjg7oiUOeOj2apIfyGCuf4Gjw4Mu+4lueDtllhvMdaQxisKXaQoXsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797998; c=relaxed/simple;
	bh=y2zayKWnk9+auOzdACJ/SZye0xW8Lm8mzmgdTyPY700=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVcxmTasObkSLbFsvTUR3DhusB+7SbVXWSWFVGblcO8boOIiYmXONtmjCAvJxN6Zc0uAjgedN/kr9+//1vYyB/dvv7i8UmGi+XOD5i2IqvUem7gCZ+IMb5Q9q0qUNug0nFD6pLqde2oiKlj3VE7epVRnofRbRYW9NVrYsj075go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=rf1hovah; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1715797983; x=1716402783; i=kernel@valentinobst.de;
	bh=mSXPAJKXxzZyEDc83l6Cs0ff5IlLiJEXhV9mzqpTkAE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=rf1hovahGEVZoPzUBVzzohJ6u+wjvTv1yoDQMIRoZy6uQvD4mmqzgTOqHLkHtcsG
	 V5T6I5EqiHQsEQ+AKq6VMJ86mC46jiks5xD0hbjR23kdY75lC0DEvSWM18p/pqond
	 NtNA/TWdNBduEaT2/6aNPTKnb2QMWWVeUY8U1H+FfWJOj/rOoiVwtb8qxhmWu3nI0
	 PdGDPHQPruv9vDHXwrxtmZ39/nrXIdLu4FL3g186i+X96xe/UjKSetUkcLZgdPEvK
	 xSUTPRthFeJDnrbZt/u6eWhvvBvxBJH9LZb4rOwPiDiHQkVZFlajyOyZahMYujtyS
	 DiVNhA4m2gWUpQSVgg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.245.131.25]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8GAQ-1sbqiY0Ppo-014Dgt; Wed, 15 May 2024 20:17:38 +0200
From: Valentin Obst <kernel@valentinobst.de>
To: mhiramat@kernel.org
Cc: a.hindborg@samsung.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@zytor.com,
	john.m.baublitz@gmail.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mingo@redhat.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	sergio.collado@gmail.com,
	stable@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH v3] x86/tools: fix line number reported for malformed lines
Date: Wed, 15 May 2024 20:17:16 +0200
Message-ID: <20240515181716.3313-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240403091748.ee180a7a1d4bf92e0c46fb8a@kernel.org>
References: <20240403091748.ee180a7a1d4bf92e0c46fb8a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:ttCaaco3vEonRvTh930mfcrIADBoReXBM9hGliQ2QuSLUQbtV3q
 N/CLOKE9dhGTC+Q1Szo0uzGyPjKzVaxlZAlnD325gGzJn7zCarZ0iikssTW/yJU5Gj22Kyw
 ovshi4BPFTmICFJx+sJi5gAFXFwkJuE82yzzSer5N+DQmrJwLxsH6UPj+9AGh7GOJd8m4GK
 QH2DnBjfJvcKx4RlgJNOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CUGfVys0O1E=;LeLgmglAvO6+O7ly0QdmWWvmXNB
 IUE18NMJearSvvzLQ5B/cEXEthivYfvTsI6x1ycGX1c84XTosfMb5Gg4aaKmTFoOeoEMgXRai
 OalavXFvI41+rX8PaKecKrUM0b//tZy/Wwf6rU1/MJ060c+Ulid0Tztl9Us5QOaJ/Eo+pSkPA
 qKWEjDaa0RZBy13MzzH0ncJAZJfMx0UGlgF7tseGMinH2+pew/fdDoNiOPI0O2wwf1O+ixdRK
 L07PEypW8DTPLoMJ3ziRAv861oM2NSrr8ZdmJDC381ZneYCsT1hOB8MidkJiG9kLynDnIGcri
 OqjKK0NnFgLB4ecll2Dlx9nt2QiWLbD/wlUcgZO4cypNvr+aGfVcwbi/zz7BvB//aMnhqyrlo
 OTvaDKqNTChT8VJmAfWFnd34lXebm9mZvNHCUp2JiuZyS4zWmUT6eNojwdwv/+pIwhOyqd43C
 VyBMGTRW6BN8ps3aXk2UA9dtaVcipTF9WVBNcJIkFCFN6zF1ZjpT/3S2kI0uU+oqE8o+y0Wmw
 vKiiTB2w2c4iHN3pquAt4heraFi6AhGewEpkwbzx0NnEReCjlC82i87gK8Fo6O2q2VmbuOvoW
 7uqu6T6n6rBG2ZcrbhV7//oXhwIZUz2oD5jFPYKSGJFVcAAJ76K58ni51XmP2zzA8tEoCykN2
 /G1zy5SzoMs4YgERH3vA5mPllsBy0yS4h0sdJHmlu8ru7rapGYl0JP0vLMtk/Ka3GZUQMFGci
 aub9+5PoF//aMllPmgXnqBb3uS8tu6qxQghdyIwT6EBJCM3etPDrSw=

> > Commit 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
> > included symbol lines in the post-processed objdump output consumed by
> > the insn decoder test. This broke the `instuction lines == total lines`
> > property that `insn_decoder_test.c` relied upon to print the offending
> > line's number in error messages. This has the consequence that the line
> > number reported on a test failure is unreated to, and much smaller than,
> > the line that actually caused the problem.
> >
> > Add a new variable that counts the combined (insn+symbol) line count and
> > report this in the error message.
>
> This looks good to me. Thanks!
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

So what is the status on this one? Is there someone here who can take it
through their tree s.t. it might make it into 6.10-rc1 or 6.11-rc1?

	- Best Valentin

>
> >
> > Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > Tested-by: Miguel Ojeda <ojeda@kernel.org>
> > Reported-by: John Baublitz <john.m.baublitz@gmail.com>
> > Debugged-by: John Baublitz <john.m.baublitz@gmail.com>
> > Signed-off-by: Valentin Obst <kernel@valentinobst.de>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

