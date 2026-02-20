Return-Path: <stable+bounces-217523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFwNCy60l2lq6gIAu9opvQ
	(envelope-from <stable+bounces-217523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 02:09:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB7B16414A
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 02:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748743016EF0
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0A1F1534;
	Fri, 20 Feb 2026 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/+4jXqH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18B1C84BC
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549730; cv=pass; b=lPMI7r0q7JiJ9dtLHznofI4ihe2p0QR90bAOW+7uMrQPr6n+9GuhkQYr4OQ1dJd4WPNuryQAZud8flZO4rOgCuRS4ayqzkd2/exIU0YqmvcqFOjJPlk+x34+E+ajaekihih3WIIGMYNrCYnYoHyiNVpbIHnf0YIPrA3ztc2Yluo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549730; c=relaxed/simple;
	bh=GKl4Ak3kePB5mweTaRAQBHrL+QimWx8N3YM9QBuzD5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoG4WI9ZzxFIIUZdiefv9YlmxELGeFK7DXUQ2KledeQUAHktqMO9lT4sPUGcnHYbBv/CiJsKnvdX5cr1XsKczN0B+rEjA/iFTjBPnCNj1RdxuJNeidc5pag9J+IbgprQQUOCtNuabbhCCfX0uvn9J10Kr0xa47d1cSPczoXMToI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/+4jXqH; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127148c2112so146963c88.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771549728; cv=none;
        d=google.com; s=arc-20240605;
        b=JdwM88vc6d93kuQQVmVUNGZ4ln/+kDlaDuTUcAyI1e6dW11RF/iN2V6ZzthIcImDAl
         wT2mHnS6Uo+jWKkNB8FyZSBv6Htju0pTHMM7Z7af9fLe4ZOCBkf9sLwbrCsexD0/EJBM
         AcKAFGZip3lSX43IrScQ7xu2bCFD42cD84PDvOse2e1fwjN36FYmad1W3ECk7z7panS4
         372OhQjZwpx47bkRW3XwkvRG1i/6tBIV+iK2orUx1nbDM55lgkg4E21/nyO2i9JlBVRn
         iadQetfh4VfJ5+YgHUnO2P2Zq+wjYuQTRBnqf5rCelaf1FmsC9b47KAo7PhTmMrVeHhL
         khTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Zh+5deos70/vX+uaYsAg3kTPskQ2Dqdg3LzYmhAdjc=;
        fh=I8NXUp6ZzZSVmNYG3lN82hyGtNdV/Wd/eAwyMJsIepA=;
        b=hem+qfZzdJZ13Be+o+n00p6pzztychEwcvh6nemGgDJo4AOjoUjmgIdtFgQM6Gs9mm
         Q+UmuHEXyVsN9QQYyJMj8c5aOKIagvNT/HOmC16H9LMvRmr0WAJGt7oudBw3Z2GwLe+K
         LssgMMwzizRZedgspZ4hU4nEZ7of0AR0Xkzw78Fmf1j2jPwKDhi12uOHF6ms86gc1NS5
         wOj1mVWsrzy3W9ZuNXWZ3cV6JPWdHA1Bu+OscWrJxS8ArGraMWe/T7hHwDNEML4ZC5Zc
         i0wKaHwOpF9wYuxkmNgRq7a5W+cGpq/u4r0ch55u1HfMh2EDELBfS8Zl3W85Jd6m0HJw
         A20g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771549728; x=1772154528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zh+5deos70/vX+uaYsAg3kTPskQ2Dqdg3LzYmhAdjc=;
        b=N/+4jXqHb9zYlj618P3PHHEMMZR8iInpWIwsvAChS2x1wfwdLoubtV5MmjiXY8C8gH
         KeofD+EgHxzFRDA2qSVDR6WKl2sA3O9t1wo7JX7ArSdMiNj9TcHa2jytsIzfgmz2qs4a
         LXo7B7GV7U95O+hGkuj+IZSUgkKM4UN5vvgqkhaYspPHX2641Rk7cOghLG01P4hYv/Gv
         q4TGfUZjGEqDVDt5NXSZel6mNBNfAU+6QNXFV2NIDfppIG630UGUdTg3bLssWM68v9pZ
         39yzh1ibLAGvcQ1ryLg+zC2XI6zCcHNP1yPpkssCE525xBqcmA2Pt0G/V5o/0OFkdITZ
         TOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771549728; x=1772154528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Zh+5deos70/vX+uaYsAg3kTPskQ2Dqdg3LzYmhAdjc=;
        b=osJlZiOuPzq+9ulHw1IMx7h7CETJh4e+tqYL+lbSeE39ujnwalr9Pb2U48aEwKjRHc
         Ka1hwaQAIZA8Jps6+cQhnZxGVW+x/fno2KK3cyoFr9VkUGlKMDTnmZc+vvKtVHWlaAv/
         j/zDTrpw2p9PcH9NyO2uEgtxkVcxMNRCzL0npDcckjRZbakvfLz2niMV0X6xcKjoOANt
         W435DYUbZ/i8+iB8iRq7laFaXBt3aH0c/ni9F6qzHzw55T0FZMjjDbaWnq4Sl4QNREYi
         YkmOirY17ylJ3CSz+WeK4dSXEqxuox8A7PAMbP4n8EDyFMzQOAWsnXh7jI0ruAPQhxvE
         kvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWKKOom7w+h9232tbkmdCalUf1NaDprgQR9IHV1iKcNp+bay37tDnS3KD46aRvyaGl7BR7+ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+5O+l4BDMJouMluiw2EaWS/nRqNaXQXcj2LDams5Kn+T/oWu
	9ks7DF7bYy/2NZGabOmfP6aBXepKuvEYmVFMUdnzlZU6oyiU5yrEgJt/P5SN77AH6/UhKjQ9dmR
	6IR/dRhJ+7ZDLSkXtYnc9yWXE5JHQsEY=
X-Gm-Gg: AZuq6aL04laL0w8LtXGng/AkOyXz8FM+FYcLWWZeLnmXRQuRe9Ppw/kVE/3jCec5Ndf
	kkbRTa0YpEfj8Hfbije2pJmbSttaulpzJmF0gC8V3QyXB1pdqzmZkZSiAJsFYDiv5uhqeqLeZ49
	Ri8DLX+xKzkQLV2/omx6BnqBeurPe83F0rzG5oRxew26I6m2EYyXo4iJd1MzhejolhqmJksnphH
	PHMfPr1WgEijTlSrShoGxtU0IoeNHtlAKoxIpPAYgnlnJBtJ6ZZkXbi9oIs6NQbCTiTCeBuKv4+
	8nMkJV/RJrrXgw1LX/JzCE7lG0Z7RYYC7LwXkJPsZw9TF9oIlj8TRyECS24+NGRb01buQV3tPXa
	XtBDrF983l5eLn3gC+qAWLypl
X-Received: by 2002:a05:693c:2c05:b0:2ba:7d5a:a816 with SMTP id
 5a478bee46e88-2baba09cea6mr5293706eec.4.1771549727949; Thu, 19 Feb 2026
 17:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131613.45344-3-phasta@kernel.org>
In-Reply-To: <20260216131613.45344-3-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 02:08:35 +0100
X-Gm-Features: AaiRm51o-obmzy4pYlYDNUV1wrkJLUxZpogWi59HE2mqfpTZBOza6sr_g8MHzdc
Message-ID: <CANiq72kgsgSW5tPj3xA0DLhJS8yBS_uDT=xDbNE=rf8t-H8Qzw@mail.gmail.com>
Subject: Re: [PATCH v4] rust: list: Add unsafe for container_of
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217523-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EB7B16414A
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:17=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> Add unsafe blocks to container_of to fix the issue.

So I don't think this was tested with `CLIPPY=3D1`, because there are
other safety comments missing even after this is applied.

Please note that `CLIPPY=3D1` must remain clean for all Rust code:

    https://rust-for-linux.com/contributing#submit-checklist-addendum

I have pushed to `rust-fixes` the patch with placeholders to show what
is missing.

I am not sure if I will keep it there. I am not too happy introducing
`// SAFETY: TODO.`s, but it isn't worse than the  status (the comments
were meant to be there), and at least this shows what is missing --
our pre-existing "good first issue" [1] may motivate new contributors
to complete them properly.

Cheers,
Miguel

