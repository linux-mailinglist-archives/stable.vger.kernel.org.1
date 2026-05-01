Return-Path: <stable+bounces-242521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmgGC4S9WmTIAIAu9opvQ
	(envelope-from <stable+bounces-242521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0B4AF940
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8238730179C6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303E3624C3;
	Fri,  1 May 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKNyuhZz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398035E93E
	for <stable@vger.kernel.org>; Fri,  1 May 2026 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668649; cv=pass; b=cMiW6PxQPlV2IGpOX5IpkGIHoLY6waUMmeLpKKt9JpySRww2DhgfbrceXjCEGs9WrsaaaPcCGu9Q0zHn+YpPg3cu3NDfG3POycq17lZkhM/w1x3Abvx1wVYd2RfDGNvOscZjVG6hCf3EedfYJ72oInMezgQW5ljKz1ofjWFppAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668649; c=relaxed/simple;
	bh=Y8DnUMJtB/9SdZbO1iWIKt9PLqgioxwgKgi17q4zI0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R35/BGzIuH2fJqJPyxXzFIKH3iYt9GJVqxzyG950DCEzkuI8ZlaAcr9zE0rci3uGNiWGL9REIzx5X4n5OOEOz2iOSlvO+w9nV9QUtRQwEY8o5Tl4UBG7PoKKVFGfkY5rpAsOoDH/AkQ+JIi0G0iiyf2MJDyV5tnBJrCtvqsXaEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKNyuhZz; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6b393d60so166141cf.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 13:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777668647; cv=none;
        d=google.com; s=arc-20240605;
        b=FHRvacevnkrm3XZw04yIMwLRIEiKASAkAQ81VsXppH5JOzPu4Vh6fz/lnQi9BlK9OI
         5IlTSONZJQZ3BZaPaIeydzarOln8NcQWxK5keW2ZpvHmrDcl4cUVCbnqo/gaYrYXIABw
         OAUNU7foWhbfoIheSOorLwqlrMWnOifZ1+wFVdK2wcPGvduz9EzT7PesvWWtEl5kaC3l
         jpgjREKzPnELu5H/sIK6ZZpeGISZ848C/Yi1ncnPKNYYPo+xWNcSXuUzDgcb4SQZMASs
         RqmQVej3/J+Z2O0+stUBzEJj2saw+hSIf5bjKxvp4g3msekCcY1DuYoZ4VLSlMPZRUHT
         esbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLeNVROK1eF7ljAIfPrkdINek27dKJxmmQ8JNE05Atc=;
        fh=78FSiPqmM2uu4SyhTaDxRVRG1mRXBOTSFRhnKq/VYp8=;
        b=l3M8YDQTdvJRXFrJrflIWAQZFVrccNBDeEgJDwwTQeQZV8BRnXo+Y2Q6IVz2pLez0x
         QK0XchC4ZwzKtC4qQoT5EHU0In9zGH87vnl4oG3vw1dM7km0+tVmXaDBZQ7dZuuu2W9m
         /r7BUIU7VFXrBjFJfB4eVEJavN/nbZmySTtWHCvqqY+FObWyhjOuC5EZUsiRYLnn8mxV
         zPRFnJK0n+caPSoCrVq3dZ32KwXQfN5Br2F0oWr10fcjMyFjqDqlrIOMznzOWTBCJ2LU
         Job0dhP0wRvr2n0D3G6v8lA2G9l3YEZ1Ly+ZYlYOP8lSsCEcBcTgG5xgJ4apvCEQVoGa
         IN9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777668647; x=1778273447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLeNVROK1eF7ljAIfPrkdINek27dKJxmmQ8JNE05Atc=;
        b=EKNyuhZzIJ9l+A5yrwYjrxsCjOuSoGRsR4uMsROKBa81NrnVB9VgtcovbilX9g+SNP
         4zfq4mHgy8bWDhZTChIfw7Nh6eOUWEDXgq7OIjiqbjI7d+nSV4DP9UPKC1I2ZhPRx9HQ
         ZOGPafTqpKurF740P4BqGoCWXZjvJvF17zpq9RW7kSOp0aUak+NSboW3xq+2GRpiV4K0
         Lb57f7RwwRWskiLRPyq0/OUPq55gA1CgCiFB2kOchSW0dAG2VhldVhvll17EJV1tBhL3
         3BEsZyb00Ft0IlGM00gEbyRy9IDeWVzpf1Mow3qh29uJL4TclPGoTBG4mLvYUzsnttbs
         M3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777668647; x=1778273447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLeNVROK1eF7ljAIfPrkdINek27dKJxmmQ8JNE05Atc=;
        b=D70oJHzzCSF/eWQ9cd6heZxFIzQ55vgXOBeDsqF0hNEv7+RzBW7wdl7lzIxwZTzqOx
         qnmTqLYQXd9HK2dncU3mEj8Xv1wnN+4ubTPJlLQHaYzaSCqyj+XIf2LO7wLOMgGAesId
         OfQn080y4Lvwrm3IZjpRQM9CFIF9k94669Q1x29RMbwtMWl/9/V5eX11ULrFQ+8FmbgE
         CKhntQ+gZTSxVFMdBWByYuAfqRazsTPOnxlut5rIJx7fPAPOckZINcgdrYDL9UqS3OP9
         Fz0+BktO1fug46kpE6PcHW6FiDLF5p+Ozk65pMVbXg19amgSRKFBxYSjQCya4eaQnIpg
         QI3A==
X-Forwarded-Encrypted: i=1; AFNElJ9tzTauB8weSiW5kYLa5mBj+3eScYLDh87GdhgJ0QYEuXfeeGnqjq6orCFS9Q7zuv4O2iQ8mw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2vrlRHuDO+fXwEf0zNrTPGeKgBqEfWYKsFqKKdF0+Cjm4fQt
	8sTNpdtQCJCPXkbfPEyQrN9J2TaBKjXm0S1WbwtVM3FxNC8zPJ7FgZHskD0n7+1Lug7I9frrjbe
	JUoYU3UGDQRzAd++84+FAeuhyy04iYbSZpqS/NU+/
X-Gm-Gg: AeBDieu0LCPgtiHLseNrZTfJgbdwVhyvU66ZZA1SSvdagB+GZRj39BC7jtUtvPVp9Oy
	Nn6qB70D9I0EtVsNfJxq/lB2B/w7nPoA1nSqnAc0JwgUf/d/bnGoojstg17tmOVboacgqyrybj9
	L2+yqm6EVXVCt48sSF2yL690+HfSlk+o3AvOuJBnfbQTPZ4qYz7/Zy39PXUaRCDCIbn6ESRMWbE
	V3J71NMWJRKeSOKQ+SM1Fds68VrKuNHW9pswaPdYIvYcZws7qCjFevdfQC3Ys95uil66+goNIQk
	I8XXw8+Hxpb5/iMsO04lw9VgxST0
X-Received: by 2002:a05:622a:4d93:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-510730c9c82mr1115161cf.5.1777668646571; Fri, 01 May 2026
 13:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com> <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com>
In-Reply-To: <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 1 May 2026 13:50:34 -0700
X-Gm-Features: AVHnY4IRsFbySZWSmvVxQmYenpaVUpBgFxrPv6QcBgfT3XOCDvCHF46HgNDL53c
Message-ID: <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B0C0B4AF940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242521-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]

On Fri, May 1, 2026 at 12:13=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> On 5/1/2026 11:44 AM, Andrei Vagin wrote:
> >
> > I've been thinking about this more, and I believe the claim that XSAVE
> > offsets can differ across CPUs for the same feature is inaccurate. The
> > XSAVE standard format uses fixed offsets specifically to allow migratio=
n
> > between different CPU generations. If a feature exists on both the
> > source and destination CPUs, its data resides at the exact same byte
> > offset.
>
> There is commit ba386777a30b ("x86/elf: Add a new FPU buffer layout info
> to x86 core files") for this reason:
>
>      ...
>      The XSAVE layouts of modern AMD and Intel CPUs differ, especially
>      since Memory Protection Keys and the AVX-512 features have been
>      inculcated into the AMD CPUs.
>
>      Since AMD never adopted (and hence never left room in the XSAVE
>      layout for) the Intel MPX feature, tools like GDB had assumed a
>      fixed XSAVE layout matching that of Intel (based on the XCR0 mask).
>
>      Hence, core dumps from AMD CPUs didn't match the known size for the
>      XCR0 mask. This resulted in GDB and other tools not being able to
>      access the values of the AVX-512 and PKRU registers on AMD CPUs.
>      ...

This is a different; here, we have two different CPU vendors where XSAVE
layouts differ. The XSAVE layout itself is not the only reason why migratio=
n
between Intel and AMD cannot work reliably.

Thanks,
Andrei

