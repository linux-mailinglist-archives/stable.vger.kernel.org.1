Return-Path: <stable+bounces-242534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PlmC1se9WlqIgIAu9opvQ
	(envelope-from <stable+bounces-242534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:42:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9574AFD7D
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6658F300DE11
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17240352F95;
	Fri,  1 May 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPJXfTu5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7335A933
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671764; cv=pass; b=V0SU5ylmfFxcNgCiua9yXTcCMPczzlWnR6jQSmg+T1Y40NbTyi2llYI9Lrq/E3X5t8NcLArOfs4j1eRLsTL1J+Sx+nv3amq2WJHBe7DKmGbfBg1fmq9ZbzTUZoBn8d5gsx3xUlK4iAKoqi0+JGqBr28m5D77dtMf8hwEZ2n3sjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671764; c=relaxed/simple;
	bh=WgieTmvbToRKceLnsndAJ7wIQelP+larHzbxN3yfFXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmvfw5ZZ/nQGD5yFgAvPNh8Iano0cYfd41yo1XoLLNDj25iLSM1JXrx8uvrrrmHNTOGign/N+KbNGOhTi7ThKJnSECGEXD+CizU1JK6Yk8MFloM1ERF0mErrSYTfqcqm65KjyqB+LHAcN/Y0EMWkK3GVJ+65A54oqAZ+HyghCug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPJXfTu5; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6b393d60so190501cf.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 14:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777671762; cv=none;
        d=google.com; s=arc-20240605;
        b=WMmBs1b3S51kOLgEYPTWdd6YQ81bQYiA4MpmRuCfYXvf1RGq1u/a/Tqjl515VObFYM
         IpKVXnWadN8tYfpVd4UzJSNrbmoRxdiK0EOKN/hK2rlq1PhoRZiuMIN6lfxXodSJ9W7t
         i2v11tTYp3YTD7YNDeWx6NxcSn3VDiYLnuBYDiKzDMZn/U4IG3o18ejLLXh/07reTZbt
         UKv4UVreefcLgmRaikrUF7ddwe3DvLUQ7OpuCAKbPkmK5R7++NcO1WBC0oJC3ovMPdWF
         IKeBfNn6qOBwRpyoRKA0O0phnYbfboJzfVQXhjjfF0fHbOfTkEbmjNVxJHGpRi/vD3Ht
         rlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WgieTmvbToRKceLnsndAJ7wIQelP+larHzbxN3yfFXs=;
        fh=nKVjZfs/zgg++N/9zXP8+TRuLCEyy7MOeksPeZB5dx8=;
        b=Lq0fN9L16c1hOBOqLsxpTCTj1cVbQOFj/7HTF0x14sng/AhQks2lBtZqvcLKpUWij5
         83i9Suxtmq9zmP4pgrXXJ6MecbQq9fX2FbwiI5pmTNI62+bvn8S6BhmDNGpKCPJbk6J6
         OZozmZA08Y/KHhLlkIjKSO+Z+ltDQzGwPPH2BR7KqHwsQ9aWZcr3PCV89zfEUlh9mN7a
         sCtMMP/z9Q6lv/0h68uXd7VpgYnauZrA3p3e4HU+m0w7grJAqenwsxQIMDYtlELbRwca
         4TC6T31lHbbXTS/ziW0VJ9Jzz/7G4J4i9XRbWLnBoU94GNj2x0yW9D4dcYp087K2Aj2y
         7vJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777671762; x=1778276562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgieTmvbToRKceLnsndAJ7wIQelP+larHzbxN3yfFXs=;
        b=OPJXfTu5pWL4GC3/tvzOAq4nEwF3IvLu/GrDg8TRPuQYVvn2rxGAlSfmoCQxHI8o2J
         rOJMGuJyIu0nxMHF/6t0dEf799ujpvby1KwFRctjEHmtBwRYrNMdeUaUXH8iweNk0Tkm
         b6tHyOXtMIv0kZ/HVQ6zQtpu3ard96TW9+AomdUlRGPkOOf+Ajk8s5U/RdllfWpjF3AV
         25kUkvuAEeks9pkNIBtilfLt9J9jSCYyWLvn3Rv7bKSRBMN7RYCZ8yPA4hcO+Hojx2jx
         +Pq/+K1rxG9ctSEVsfaVpovfSDcXSbrGWSPCf4UumBsjea3aZxMMEB4AdY4nt5Nui7d+
         zRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671762; x=1778276562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgieTmvbToRKceLnsndAJ7wIQelP+larHzbxN3yfFXs=;
        b=nievL13GPY6wic4F64LRXBtbCDuSkeIMC+tz80S4YVu8Nzyi0Jhx54KWnD0zg5VHtA
         bLTOfO56kNJafvi0nJqqIi3SMoW3+TmlgXcUoJwkV5YSb8ex49Myr7ryh91jlLyDUBvj
         Y2AfKxMzyPOGzgqSOo0RegprVf4ACq1aDOvERifFRKNNV6HQX+XmVbv3BrVg/eN/pGDq
         oX8GRXPQ0h5SojaqNUEv5nb2ZZHQOaWiIllxKW3gjbcKIYBudwWGWNWdjivYDBNmCduG
         3qh8zXwHZPrubtOc9JBK55lYf4wAPK16k0wtr41v8KR+4qEtgF11myuPXRD/Ho0Urx7A
         cRKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V+r9ukB4qze8qpTilwexeYpHVTasf7R273AiUibrPzfKQ0LCZ2qON+XRSPWYnEo7kP2iYwqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3Y9T3TFnJnO8yRk/Q8/kaXwFeobi8xzqgsxlL1HXj3FRrI2f
	2+OldqAyu7d+TcHWYPHJNDuBQVMrSRco/L8xhfZwlnsrqGFzlny37JVDtUWo1DcqxFLdw/2z5g2
	8QjBTmk/q2GAHG6G0t/YuVRynevjnNpC5Gyo3yLL8
X-Gm-Gg: AeBDieuNOATXhN2nss1kmroC66RkwPPox13XGQmlkI0OJk/EqGrPKPv4LJiHuZUBL8K
	1IZDaYyVFMz8MVZzG+cqk1pq2aDEoLpUOsR3FQFwy3VjDHqeqYGNDIDDIvJEoWskDNnUZqysM+d
	2/1AlL85Zp6mDsRoJglWN+V/E9FRbcjt9Bt2cPeDBH6woQ7RNfiEPX3x9yKvAGNrBbU8gM2ytiX
	yUEtfbAkiGGehoOBKywprUWflKaidulpJjume7yrdYWizllxpgLRAGgvp2HR6e5neelO4HflRIN
	zkmrKDN71rRa285Tu5XIleblXKak
X-Received: by 2002:a05:622a:588a:b0:50e:595d:164 with SMTP id
 d75a77b69052e-5104c0212e9mr4331911cf.8.1777671762037; Fri, 01 May 2026
 14:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
 <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com> <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
 <c4fab3dc-1627-4775-986e-6b3ea52e7c36@intel.com>
In-Reply-To: <c4fab3dc-1627-4775-986e-6b3ea52e7c36@intel.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 1 May 2026 14:42:30 -0700
X-Gm-Features: AVHnY4LBP_Czb472Au1AODOL7utJzfO0AmVPjXewZaYTSg5I8ZleemJycTHN0kg
Message-ID: <CAEWA0a6nhZ1nXCLeiCdnKi5SjUHiP9w0jO5wuTwVoPO_JYd9hg@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B9574AFD7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-242534-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]

On Fri, May 1, 2026 at 2:04=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> On 5/1/2026 1:50 PM, Andrei Vagin wrote:
> >
> > This is a different; here, we have two different CPU vendors where XSAV=
E
> > layouts differ. The XSAVE layout itself is not the only reason why migr=
ation
> > between Intel and AMD cannot work reliably.
> When saying CPU A and B, I didn't intend the same vendor but x86 in gener=
al.

My point is that the reverted change broke a significant, real-life use
case that the hardware was explicitly designed to support.

It is the responsibility of C/R tooling to ensure the migration target
is compatible with the source. Enforcing a magic check based on a fixed
offset does not provide additional security. The kernel must be prepared
to handle "trash" data in the userspace xsave area and manage any
exceptions triggered by the xrstor instruction.

Thanks,
Andrei

