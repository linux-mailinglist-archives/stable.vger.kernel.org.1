Return-Path: <stable+bounces-212783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ1GIUt1e2mMEgIAu9opvQ
	(envelope-from <stable+bounces-212783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:57:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4513B1378
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519B03007F7A
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9620E023;
	Thu, 29 Jan 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7ezL4jQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB954739
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698560; cv=pass; b=eylkbI46Pu6IqnK9XXJ7c4Bf0QTpYFMoUhmr+cvOUfINJuFabmJzuBfm4Z+nIpCYlGDrSJ3tNph9nn2alu+84h1+ylbw+rns+pH9+0gQ46AUAJEBwIDTzJ3uLTHTFG48EfX0DPTXPLytUAELrTMpvnbNRz6LHhXrggK6oFy71Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698560; c=relaxed/simple;
	bh=TjpL/Uy2+Lgb6jcTxgD69+Nc5jfl2UdVoxe7lEFbkBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcVpogmGB7a414C+Rwk9FMIt2oJadgXLLqx86QhusOvA7SWv/z7r15DVrNrW7i6c6OF9JjRBXk4m1c0EEk5SPc5XQlHFAIxV7ifPsUw3ERkryAELaRqqXZQFFpDMHgjXt4GAFSf2Wx3C69UxsDI4wYFV1a/to/GHaaYEaD/hYGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7ezL4jQ; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae5283dae8so112481eec.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:55:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769698558; cv=none;
        d=google.com; s=arc-20240605;
        b=B9ULVfqtQ0mq75BkNrcOPasoFUWN0GV0eTXCRjyXkAQwkVHus8vfEw1+QsXtblCXeT
         3zIWWw6WYwHBRok67jI2clCiU8FzMRWoT89J0Yss3MKsNO0zddFxd/TSyLs+WjlHN5UK
         gqh3OqtA1Xyp4MMs4fSWS2RmR1/yzGvOZjC2eHprERFWklVU7CMPV2b0/tOdlaJuet1n
         fz2HzYvLEjut33C5WQ3JqWaAvwhiuXEbo6cDqwotVIDKraqZwyuxzBAYvcQkIBVk8nlO
         tFce2FRWdBOMl2Ak+XqhQQiN6anvPIokHAYeA7xAHX2BEY02nyzJ/FbtN56kcLN48zi0
         jeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9A0nHvT9bg+ZuIh0V/b8YttFwH5glkTo1GcpZvxKrCk=;
        fh=5peEoEh9ICY2LpVI2Df8gJHnJY/ZIDtW6K+K9tTQjmM=;
        b=k7ooCOT/Z3gncwYyFtTeyN/7G45ETHIpfCDkiQ+aheNRar/YMlQRBG6ho9bKBgQQ64
         zmDap/KT0zzyhIvquoJGTIjK/FohA+D5QvswlTfoMp2nIihg0dry53s81N9WDSVfgOc6
         vEs+P7eRZ514vRlswMdHwjtMPHhid5x9KtTDH1ajO6XmHgE57pLVBrjnHaNS6MWGqMVS
         wljZR5nsr4T+/nk2eG1k4igALyJUCyXNJpvSqxFdnmU+LqeMz50ZpVweyp1ZDxN1fUW3
         U/ecgicrhJCDMIBxlG0G87xKjh36F/s599iuzbCLUF3/IMul3btwE0rWZ6g92u/HUaPv
         A3kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769698558; x=1770303358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A0nHvT9bg+ZuIh0V/b8YttFwH5glkTo1GcpZvxKrCk=;
        b=m7ezL4jQn2I5FDRmKJBsFHB1FpN7HOI1cSxnuBBGzAQwnnuzbLmV+kPx0RuOKsak73
         fPODFc8kvySvKBGvvQAHT4rj7Npj6ig6XZQxE8n84tb5Yz7D69cUSU32/nWZVhStJkNQ
         mvQuoomFvPnwliUKyNF3YTY5JFRkuyInLuw4pqRLZCnNrV2Su4/XWnIyEkp5WUZS5SVi
         3eNd89kiWMvCBCb1KUR/2CvvLcc3kCedFl/mjx6qyGWZSzpBNToUa02aSatqirjxdAsT
         cmYzaBFq9yvKcYRHCq0JXPQZC/j/exqKkUbwNqEuKQhF4HjsE/YFenfhRzW/bpuPd/fv
         b9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698558; x=1770303358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9A0nHvT9bg+ZuIh0V/b8YttFwH5glkTo1GcpZvxKrCk=;
        b=eC1RPrm7fCGPE1co1B1RpDJ/u7YgjNwQaxSkkSRor8sPyv9eQjxSstznkEyDa3t5lm
         pe1Qu3obQ6zzayOeKLyyhvdpaw6cazSBE+sWAYoHv6+B0jkCzh5e/fsZJ50+hEfBH6Xt
         wXCj6Eu38dLndx29RQTk+HcyWVZjEzIW9S+OLPinCKJhDVFAUtYUYBMykQ+fbJlFoZUQ
         fNm2lKbU9gpAEaN7SeiMmXHiGFx1DrvI1J82EU/cnp3ixxhQZxM3s1NNwv7Y/l+gDpRv
         Iv+Xyt9whnJ2iD7LRwqQxvvYX2+9SvGlCsKjMklFb/aEni6yTcdrt8l6lTSTt5cnsHN/
         Nkrg==
X-Gm-Message-State: AOJu0Yxcb8pIXUiraJ4yjfx/j0tn4UsqWg3/O8mxoimpqyCgfirWEg7+
	F/9Jt3R1cArNuZDEcS6r6kgej/uxkwC1jA6Ca3v7/9fhZyb39u0J+e5N0W8wMLoDxqZdP56Wt5H
	/Fbl+96R9KOgnkYZd5aVg9HOaaO5nfI8=
X-Gm-Gg: AZuq6aL8hqLYdO5F0HQ7PGX/0nJElitLLFDn21uZ18ZHM9SGg9visZoXbqEB1hwgaUU
	4hHkAh0tVkLquNXUioT21tJZUqrqsUyyuuYcB/XVO9v2017ocli94FrtekMsh8gPyOvR75O1UGQ
	WG41y4OTrx6b7a0Z+31OLkuLfS87RxfkSJLHIBmOdB1I5vXVLU/WNI51a7a3PGAr6maRG8hqZaf
	RoHMNV+F36s8bMhoA7uyjaclmDgvlcj1xG5Jb9Bhajd607EIz8n2DNYTIn0uzxuhnE2BN36y04I
	FT1mmkTtVqp5IbxQGWhhNXAEBtxh0/1hobc3NhKDkq+CUQ3AwXwbDKxpSDYvIyesH+Whlv4V0di
	tzkJbAFyWk6j0
X-Received: by 2002:a05:7301:408b:b0:2b7:7ab:9259 with SMTP id
 5a478bee46e88-2b7af844910mr923461eec.4.1769698556235; Thu, 29 Jan 2026
 06:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129133715.23095-1-hi@alyssa.is>
In-Reply-To: <20260129133715.23095-1-hi@alyssa.is>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Jan 2026 15:55:43 +0100
X-Gm-Features: AZwV_QhNEH9BtD8drlnwa931E3Wxg_hV7PXPiuW2Jk9FYe5e4PfR4AQFD-5pgZY
Message-ID: <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Alyssa Ross <hi@alyssa.is>, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212783-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,alyssa.is:email]
X-Rspamd-Queue-Id: E4513B1378
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 2:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
> [1][2] as `-Cjump-tables=3Dn` [3].
>
> Without this change, one would eventually see:
>
>       RUSTC L rust/core.o
>     error: unknown unstable option: `no-jump-tables`
>
> Thus support the upcoming version.
>
> Link: https://github.com/rust-lang/rust/issues/116592 [1]
> Link: https://github.com/rust-lang/rust/pull/105812 [2]
> Link: https://github.com/rust-lang/rust/pull/145974 [3]
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Acked-by: Nicolas Schier <nsc@kernel.org>
> Link: https://patch.msgid.link/20251101094011.1024534-1-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> (cherry picked from commit 789521b4717fd6bd85164ba5c131f621a79c9736)
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Thanks!

Greg, Sasha: yes, please take this one -- this commit should have had:

  Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
pinned in older LTSs).

which was in the email thread, but I didn't pick it up and neither
`b4` did, my mistake.

Cheers,
Miguel

