Return-Path: <stable+bounces-212784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHNDLEF3e2mMEgIAu9opvQ
	(envelope-from <stable+bounces-212784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:05:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E504B147F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B6D304E0D9
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51B238D52;
	Thu, 29 Jan 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMC562Ks"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F8238C36
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699003; cv=pass; b=iGIIQrpFmVswl9FRuQgKIYeZI21rCCtWWF3OkEL7gXUmo6Z5t15ebvwj/300KqeNSi02Rrq4FCL1jGb821pCabwgcAt9yLIL0lBG152+3w29wm73q7K4Z3lUL7AHUAsLPUkgYWqAJf9ZvKl2aHow0aFixCYqjWKRe4qG50GjIOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699003; c=relaxed/simple;
	bh=ihxdbA9aShF+7kWPeNKBVmXLKbh/aRfqBhoeJfbUS6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WExh/5/xhcKZjN1+z2/7J1WsMbszO3D7IJH4M9DXOOV/xAGNvFuuBgV1eHQO+clGfz4CBC7724UDiP2GMBzavYlLWASfTzr04tUhP0/lq1qrWs1+clrDLdDddUg88KNMemcTJI1+j0KRG3r+xST+4jQlGJq483RMt71DhvzyhD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMC562Ks; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae5283dae8so113525eec.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:03:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699001; cv=none;
        d=google.com; s=arc-20240605;
        b=CyqBQ/BIn2nDH+UgaojxIrWh3Lo5NXBLz0OwlVjCOegEYQeCOB9hOF0ZDycVKn2UpB
         1FLNSD8sv2M/Q+6N6f2CNTKN0g9tTdGehK+SJ6aR2+4cSfZh48wUCTXGZA+ilqxUGkFh
         EwfX8xi4L+83Kr0x/rg6T8ythRyBYIitaARCaz8x9asl1IcsvKvT1XK8mz/RDB5wmm9b
         576UloZXmGPtgUBFFe2y6/3cqaOEe+LKvV+MXX465wIp7KTItycL4NmK5e4sBeeAFrog
         MiCXbZGObX2mGW9d1LaMAUZwzhy9+QS5MGjBWDW13L3Rejb/hyyvI6dbigba9bcYCRbZ
         6fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kUswblZQKbr03ESBJYrgz8t3nJhmcwz89bayJanXGWk=;
        fh=pa/1alodWdNrHbJcph7sgeaL0K4e++pL4SBMMXlmhm4=;
        b=dcKRNDgtbunbRPll8Cy/Q7uJ5CaCLPx9JtCUFDg6p+qQGSK6/NxF/wX4t5mDpDqDCK
         U37gIHWadTA/StVBkPwmFTDPTB7xAOGCwIIQidZTQ32xp4ZENHugNKLmrKHqx+WfB8gR
         GMg/0B1vI3OELxZZ3FpzId5JfrYVHR+I25omZP601hUHMsbGTrW7Wv1ETjZMpmV/Ip1r
         CJaE7/+MAqONtM50upY4M40F3oxTcnWhEiqrhGZbhtqS9r2aaHO0ZbCWjpdk2y60y9Sc
         Rbr+drQeYFfqBC3MVnvT2vOqQsjMtmvl2L2jbKauP2Uvv9Ud2nLGgnNSBz5/xMHXB8dx
         Krcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769699001; x=1770303801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUswblZQKbr03ESBJYrgz8t3nJhmcwz89bayJanXGWk=;
        b=KMC562KsoSn4hcQ4BhfXPmDcIs0mWzFH8BhPoiUKBDkPiDTMVBm/8eroiH+MrKmCse
         d2/9IeZssuJTsJBg6sED3foKoPcAshHXNbLtxY8vvvvTWXyOJfSEdq8cmX8flwLM0jZO
         RpFgkYqfXDUSwdIaFDH9RijK8Wz9oSEuS5DEqHdtVVPAafXdsDFXJsYrYC7pEZvyFs+g
         jUP98C2HNOz4phCiT2O6oelhjyzsgFSue5gxTWSp1TOfXp6kPLxNviS+0bNyT5fPmY4h
         LpFDP2MjD9AeJK2rtcQuAMe/oYxRNRQntaQb0I6fF9ABDtGaEzxc6nAgolgIe++Tl6JQ
         xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699001; x=1770303801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUswblZQKbr03ESBJYrgz8t3nJhmcwz89bayJanXGWk=;
        b=cj2DsS3hYeu37GPHgoGI0/0b8lwQT3PgSOlRgBNMkotIrXXe9v15Naqpspm+ZRZ2t5
         Xuz8SpLiXB4IC2ug/g9RGguJxBO/PLMb0BnbpfO2WhUzqAxMTKiS9S4H/TYQI/UzMvTS
         kI/JcbLyjx2mgCrMQMp0QdIEjyt/Hypek9inJA6ByYMO4y86pIkcD3oBla86FSO/5thK
         9/RFsKq31TdIsxdGHes6O0d/Vjd/w4Y3+cJR55m2xWgw5MHuYMoKJENkqhZP5jUS+Etn
         jhXUeFgvUOaP5Urt5MrPU8o2+hYg2UDvGKR/mw/4XKu/lXBUGIyTrUpu42NErLn2Dw/x
         +bog==
X-Gm-Message-State: AOJu0YyaIMGcVewRNwDEZF1FBvYnuF7YILYvIVVuuV8dkPOp2MFjYlGj
	uKmdf2pctY/gjwyqQ0kgK/6naqSOlnixmxsD7lssS4tL7CRJfHLs2XIY3v+IHxl++hwpCcSoHGp
	fjEIqfGZBRKSM2hFSAh7s5g21bVJnAx3smNln
X-Gm-Gg: AZuq6aKjuHSG2jVXgVL1U5677vHFDJzeM+gDs1MBF0B6faWSawbI8K7gdjjT70GFydN
	oxl4n2DHftpV7VEM6eX3t26i13XB19wITNTYs60NbqGvAzWbDiuBNY8N+ptiElBRi1FMk5XYNRO
	kfAt8AeRDJ1uEURy3i8enDmKoBATUHdY6nU7/kqLdUC2h6KpI7jrrK/8hJnuOXGKm1oCjicoIdm
	/KIkrnp1L2PnOc6wGaJaGRf0Dgd+RQQG8I8FPCOoQJVTtsuZqTCJCkM+/4URggER2v0L5fl3Edf
	gygiHuE9/L7YzWDf1yG/bN9wN9whs/E1H3AKPZ+3uhrWhhw4xoE70xltXfZSGHcG61mcnqBwCv2
	3BRdhqxEofRqa
X-Received: by 2002:a05:7301:3f16:b0:2b7:1cbe:fd31 with SMTP id
 5a478bee46e88-2b7af844cc7mr1012682eec.5.1769698999116; Thu, 29 Jan 2026
 07:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129133715.23095-1-hi@alyssa.is> <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
In-Reply-To: <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Jan 2026 16:03:06 +0100
X-Gm-Features: AZwV_QhdUoY4amuDrPWjV06uhITz01HNgOPYNaXybpwrRDaZuxufaDgzRcqCxM8
Message-ID: <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Alyssa Ross <hi@alyssa.is>, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212784-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alyssa.is:email,umich.edu:email]
X-Rspamd-Queue-Id: 0E504B147F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 3:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 29, 2026 at 2:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
> >
> > From: Miguel Ojeda <ojeda@kernel.org>
> >
> > Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
> > [1][2] as `-Cjump-tables=3Dn` [3].
> >
> > Without this change, one would eventually see:
> >
> >       RUSTC L rust/core.o
> >     error: unknown unstable option: `no-jump-tables`
> >
> > Thus support the upcoming version.
> >
> > Link: https://github.com/rust-lang/rust/issues/116592 [1]
> > Link: https://github.com/rust-lang/rust/pull/105812 [2]
> > Link: https://github.com/rust-lang/rust/pull/145974 [3]
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Acked-by: Nicolas Schier <nsc@kernel.org>
> > Link: https://patch.msgid.link/20251101094011.1024534-1-ojeda@kernel.or=
g
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > (cherry picked from commit 789521b4717fd6bd85164ba5c131f621a79c9736)
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Thanks!
>
> Greg, Sasha: yes, please take this one -- this commit should have had:
>
>   Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
> pinned in older LTSs).
>
> which was in the email thread, but I didn't pick it up and neither
> `b4` did, my mistake.

By the way, if LoongArch (Cc'd) would like to backport commit

  74f8295c6fb8 ("LoongArch: Handle jump tables options for RUST")

then this would be a good chance to do so, since the one here would go
on top of that one (Alyssa backported the x86 subset of the patch --
for the future, by the way, it would be nice to note it in the commit
message in between [ ... ]).

Thanks!

Cheers,
Miguel

