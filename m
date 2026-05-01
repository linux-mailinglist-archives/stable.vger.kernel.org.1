Return-Path: <stable+bounces-242461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDluIkDQ9GkYFQIAu9opvQ
	(envelope-from <stable+bounces-242461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:09:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB684ADF1E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013E430528E4
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338853D649B;
	Fri,  1 May 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVcTON9n"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F643D5658
	for <stable@vger.kernel.org>; Fri,  1 May 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651001; cv=pass; b=cNXWVzNyyMCAxKds8DBiE11FvOqAf79hS554rilBxiihhwkKt0ZowA+jnRZqi9g6g7LDhrhg84KGMgDKQz91Sh+zOd5+tN5LIxLyPFHmsgXLKU0X17Tm3FFsctck3CCf6n8JYOjgJUlYG/SQEnNet3f8hiNCI+yj5IKmshPTEhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651001; c=relaxed/simple;
	bh=rLeo1DZ2uy8lnjKFZqaIf3DVB3fBPXOskHiDnXgyH3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdhgCavpSrTvBzAmrAgfmpq6R5qmV01+NuNI0eAzSI+ue9GCMfW+rWWPO9sgVUdnYoaoDeTNA8nyXUHaflU3N/DCFDnQtuXhL2VBvHJbvDcYKd2K+MrimOTTLScegNbWq4ZT0ykmhM3Ev0R7VqHpnQYkpEvTdgbffvw+j5F64l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVcTON9n; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ee34d7e55aso123565eec.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 08:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777650999; cv=none;
        d=google.com; s=arc-20240605;
        b=RtnOcJVNw/WjEujevYKqYd5eKb54rYeDtmuPGtDfDcZYySc7tANetWXHKpRZJohVgN
         Q8Ltg4Zxe2hQ/xgvxHTtEupKN+bNHGi4Q7AVZrZK48mXDpheVPJtDFNfZUIjTBRs/EcM
         vl8xY2zOCa/qaR5SBAf3/MpvSbCajL2FiBFzPqHgOK7juMxctTmXGNCz+WC2+UM5N51k
         e8pV2wEXXzcOPHPs7BLtdtr7u9fjpV1xTQ7LuV/ka6ShyLySIl11uxj07eNxoqQ8ruWj
         2saZ5HyEDa5fdYggZBt8ZEQW9z3pDrKJQi+6pV0YaOJFoU3TPUNs7bL6bvMnDjURW+p+
         nDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rLeo1DZ2uy8lnjKFZqaIf3DVB3fBPXOskHiDnXgyH3Q=;
        fh=bxg7Sfz0vypmrj6VxlyrL7X1B68rS3+q2LZiiDvUfWs=;
        b=Iq5bsor8fv4pqJ6/RyBJ7H4FP8VCRTtHv8zluVMTvCZWfJgGp1j5+Mmk2VojWmrvN5
         5DGE3nruIG7DtzCo46sLN+JaggeZa2mPYuJ5FanMM13iADjnD4Vjd15aFZB2QNW8hKSQ
         Uh572YznJslNWsDGcyoJfoac9jhgpD6OvK8wVz71D7rVmnJ8o1QWM47oDOuICGpIWraf
         615CXvyFRt7ZVisFHr59qFk2YDI81nPen7Csq4/QUzVduo0XRSyT/QDt7CnBCs4yBJWC
         RMtHqpdMJrZKTpFeP8mXhzsUUSGpPqjgIu/2JgmG51u3Z+jMdiVr2b4+Zcr1vA8nNNk0
         bmBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777650999; x=1778255799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLeo1DZ2uy8lnjKFZqaIf3DVB3fBPXOskHiDnXgyH3Q=;
        b=sVcTON9nbMqJQwrHaCVyi8xxbZs5VLvfkk6fwLCTtT25xNfhPPKt3NLadwX7oRVXaU
         WG/aaT6Pp5UOh2W5QbudmN1j/4mB86Qhz1rxhzeJp40xzTumHsRCJmaG8DohGEzYodXM
         coLSe8lylpOPm93sRfqU/69enKifhS676yT9hkDmFX+9sBKGLWbdfnftXjuNWfSE3J3Z
         6ZhW2ayLEKazeS3ecE03yAg6cB640dA2X3fdsEtFOvaiAtVpj7Hh2/1LiUe1Dqs4WrTa
         9cBkkYY+HxXV8cD69gPk8WEGEeJDXpczljQdFKksrk7usWsi2HLtx+7hvQRmY+FdYfDc
         GvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650999; x=1778255799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLeo1DZ2uy8lnjKFZqaIf3DVB3fBPXOskHiDnXgyH3Q=;
        b=EAYfI4XtuiiOL8dSP/yYO/4L1cneGyXQB+PhXX1KYy7a1//WDNOINAnPpovMZv5810
         nSQVG0jHe30YjJ0v5Gs70yxxwcfyCsiUxEwer+Hl6DlEb4hAijHXcj7zwRZtcbHxFV6e
         X5gOTFKzr3DkrpsSh2FpeYyiAwLl1yXHr2ll9PBIruOi6HsF5iIL6GvjF8/s9kBn/gD8
         ipJu3jyWARgJfl8fm1dGHA2W9EdXWYzotviA89Aa0vqklNmkVL0QKogZkZdctEcZa6KG
         Wa4LJIK6CBkzcQb3PFHKl1Ku0i9Pnq6Nh/+Hzz75OryzzXFCVdf22oagHIe5hwOYJiUC
         Dy3w==
X-Forwarded-Encrypted: i=1; AFNElJ/JDL5N3CqCbuGERyEmHT2KZLW37b0MieciNJu97+9yUdfasOaJFabwjk20kbMXN4wtG4zf1es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzrEYixofsNLxtMRnebIz2y8mEAkWCWToGsQuzHM3hIC2200n
	hxlFhUGKZ8kcLy7O4G4TXFxjFarfNiE66TnvmoIp/Zg5ErJwxYyql1PvD+UmH6uIXi/Cd9eWDjv
	UwfMwKFzfnw2bvNvLBrevuo9wu0Nu5E8=
X-Gm-Gg: AeBDiesSbnX+36HmRPlKUlnQrEHUXcmGac+coIab+NpvmbAArIiiMtLjPeFRYT3tgh6
	OCKqVrCxm604ydZjWIwZcqaOqLmEkQ4dQEc1PJ7u0l3JREjR/0biWq7+TUnWmxWQeYYUuc1RLFn
	WA77FkgmbOfS9o8y7AzjKfYNKbBSWK4yZyJkDQZPzzA8S7XdF4crLsEhbmM030aM27GMrW4akAX
	tSIBiJqfUxG679LzTx817w4Sx7X2ph0xz9/VLZEB3mOL9SSFwbn6HIMyKqRoImSYTDuGZIcG2yA
	/L056+4nfZT+n79riJxtBGnBMXZsOoyXzSG5LxQb6LWTDvT9cCeXULCJCGD630pEzX92l4G0M+u
	K5Ju4FroO0C7mBnAvnTKTXQgbCDNV+aYZOA==
X-Received: by 2002:a05:7300:e8a8:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2ed3d8c1fb3mr1606082eec.3.1777650998802; Fri, 01 May 2026
 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
 <CANiq72kyqd93wd4cNxRZmWyO7HnGKo31i57ouh5gV5n9jEdu+g@mail.gmail.com> <DI6WWCFCV9X1.3RUBYO7H8KBW5@garyguo.net>
In-Reply-To: <DI6WWCFCV9X1.3RUBYO7H8KBW5@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 May 2026 17:56:26 +0200
X-Gm-Features: AVHnY4Ld8Y_0tqKfw6BckxbSdY1GsKL5l3wTmXckGs45RStH2zPW-f5icnnbVFg
Message-ID: <CANiq72kbFoYqMP47=sb0QRpEz70osvHD0TzMVopbzQ_nXdYp3g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: pin-init: fix incorrect accessor reference lifetime
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8CB684ADF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:email]

On Fri, May 1, 2026 at 2:26=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> For this specific one it would be okay even if you fixed up the typos, as=
 I
> haven't merged the PR yet (I hold up merging just in case you modify the
> commit).

There is no linux-next tree until Monday, so up to you!

Cheers,
Miguel

