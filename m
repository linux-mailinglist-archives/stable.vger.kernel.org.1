Return-Path: <stable+bounces-241179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PNeQHvNR7mlDsQAAu9opvQ
	(envelope-from <stable+bounces-241179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:57:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68346AB68
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26E173002899
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926F27F75C;
	Sun, 26 Apr 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJCWko7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6C243951
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777226224; cv=pass; b=qG/1aPTfC/cz4N7pGg+LN9cQxkXxdqUgmxcfoowrOUHrRggLj4HgaHi8CbPcDxe0ZXuQv4Q72llDEfOlLAV0+YujkrKC+l2YSPotZYUxXScP3tnrnhjxAPovidSZ7CRMdhym5I6W8IPD3xqhM6CAix7YVi0VmqdmTAcIdahpubg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777226224; c=relaxed/simple;
	bh=NH5Ca0/+4wXvIc0ULtpzOoFpV1NJR/xYZtYPCbAh5HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olG9Jkg6zhPWHbUx8SFTJVfxDZq0+G5m9zqMoTcLFk1FYX6Mc8Dq03AwJp26NTVNw0tWXWQmsFg08MR9vatqfqXQ6IFxvC24f7ZGcUleif7sRO3LeWT3LhueSOZvX0sA5+2Gp0jMw1j2SNHRQ0378jBDJa5UtfEw3/TRkgnWHxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyJCWko7; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d935b4b15aso568395eec.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 10:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777226222; cv=none;
        d=google.com; s=arc-20240605;
        b=MdDWNMwfLQB4aZJw6QetBfoBJhejGpcZ3P6/ypvmb1sr4lrkqpfD0OYBldjrlopdZc
         9HgqGSbNeHNRs772Ek2lqdKsgktDDos9NtxCBlpjpuU405cFDrC80IPQeJqE0KYO6yeu
         XIFy3/QMbi6h3LfN7o4OYZ7ZNTGOulhLP02RiVb7tUx0AuWWjtEDqFQarXmoYQIFUEL9
         zOp715w1VLVeOLDBM46joaDPSvmy3a6PndHZIONDC2IBxPMMl1bHELgPM2ceUh409CAl
         UxVgwUcGUeFh4DeOW5A7bFcOnX9eHniNnhh2a5kigx0dAWMzpD4IWZyfHrdDHoA/8koc
         Z9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NH5Ca0/+4wXvIc0ULtpzOoFpV1NJR/xYZtYPCbAh5HM=;
        fh=RMqbNv1+rut4SheMXmmNEoxm4J/nrSLQWx2tAO7ALJw=;
        b=HZeRwgSjYZT7pLgvhmzymZWBreOba0i2eAwM6B+udFgdwPjmMdbPsZm8iULfFZxADN
         hEOdhP0V7dIXLYaq/qcWlEFMUK3eLDQYXdg30mFSi+CBJ8CT7Y2VO6k4yxYV7S4QhwNy
         iYA0qEJxDDnFd9zPwCW7XEV0MZIVIGnKNj6tsEOvcU3CBFNAtYPzfBOATfTSY5OOXIOE
         AvoOwG7NQ2gnE4jUigzE9cVBH3e6dKgBWSM51JKCa+hxTE5KQlbxJwrg69SZj6+5tQmi
         1Dn6AIGHDC0DPevcQ0kBeWttf/w7Nn+LwN6dtBxKD3GGz4/CHCB2SUBaLJrLLYP9f88Z
         PXjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777226222; x=1777831022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH5Ca0/+4wXvIc0ULtpzOoFpV1NJR/xYZtYPCbAh5HM=;
        b=fyJCWko7x1rpRqrEtQCl3FOGARiWq8+++TDuyLfu9iAZczXTf/uo3jYJAsvLnHy1Bh
         l9VS9JBFPaA7ciIbzrCLqeuhEs8T2+YeQTGfVY0t37a3GVEerGjt4vDewvAbeCFSeWnB
         Q8zT41LHpuz2Ge3Xbslp2/ChyfJPc8r4Qb3P1s77wiHa4fTt1dstu27YF/A78aI9N4PA
         bjDeMKYs05kyOZPV6XMz1t9ApQAFkaE61q8NLu/AYhq/42KyqLbRK2TORTaUEVZ6Zj2e
         b0EeeFU9vGfI6Ci+GbtbuuVJmp/wO60UrWtVIEqzFFNPE9/NgL+tQ3zDv8u3dAVV9RJh
         Dwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777226222; x=1777831022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NH5Ca0/+4wXvIc0ULtpzOoFpV1NJR/xYZtYPCbAh5HM=;
        b=BEve0J2uKqGdIdSBBoqZpRCPPzebFyQC/5V9ZX9aOEcmTLPgFQdHfRK3FB4omD59mU
         lrwJRj3BydbUOu4EzNAtR1RbMgb3Pou71Kew7rOsTQaPuw1KX8qF/Oasl2SxK5ecWTkN
         5anZ+EGag2cmXPzOTRU5ulTxRmgkB/c5JocXMyTILBXOPMebM+hWaCZN/vQTBKk/M0OI
         jkWul7DDp3cgsya/u+qtZqq8VPYSkYBP1Fmq9ENEQYFoUtKZnyCwO87g62tD0Q5TYsJH
         /yYtlkk/OQr7dcIeqwcGRjV9SwSmbBi77bAA+RibsSvh2D5nDP9O0Blz4UWV/+b8NhtX
         f7hg==
X-Forwarded-Encrypted: i=1; AFNElJ/QQj817C3t/7pEvfj8IVI5HB3U4QifiLJiJ0ZauFwrVxHYUmNkiFRszcaxTYn2bOtVNtrNM8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDt/sRRS1ooPxfPuNboFADRym7kBgKW1iEz36SFR2ccMq3McV8
	Bljl3tFeVX74pTU39Iu9iTJq6M/ACJF2waL9rUjDvVsucFytgCvNcJ3KY6WLy/sMUvYx2cxkWzy
	0WJfShmTP7RlHWtQFavXJ1NoQBr8Th/0=
X-Gm-Gg: AeBDievA9PYvRgQcaYCQPcimQkFpHzvV+IymdCbf6mnMFevq9XNv/qVAmjh40v0vgk7
	BfXzM+1x+V7DFzg7g8UTfNtBg8QmNVK1ZOjNhrCjuUryabvkuKS37UDtxUSLNW1H8Rcy0w32aUa
	mevhwRM/2RcOTpd4CQ1V6fq4frvl94rzecoqJqTrxYKsPFbM65YfJTW8fLWonA/DUV+G1qUNXJ1
	EXwPcqm5KxKpROQVp4mezYD7BelrcZstpWjN6XZXXUZIAkiuMXZxId9F0k0YZxgRGr84TvSNsiw
	p7E2wjxRXMnptOEh4kSH6D4EZF5gShDCmyIQSQa1qoM5k/s6kXTuW5/NxNFhDaNa5MhBm4R/7Ao
	CdtacMgTvL7+C29DhUOwbbGZu1t1oBgSWxg==
X-Received: by 2002:a05:7300:1351:b0:2d8:7302:d3c with SMTP id
 5a478bee46e88-2e478a2e845mr7971028eec.4.1777226222457; Sun, 26 Apr 2026
 10:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426175317.10171-1-sagartaunk2@gmail.com>
In-Reply-To: <20260426175317.10171-1-sagartaunk2@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Apr 2026 19:56:50 +0200
X-Gm-Features: AVHnY4If1kUhnbPtdCjXPwJsCndzaVYnNn86BhTWC14Y0K6aWqOuzjU2VdrbCts
Message-ID: <CANiq72n2eoHnU++GyXRb0bbXXXU_3W=yjkJ0Yi54O2Q1oprNOg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: workqueue: fix SAFETY comment Arc refs in Pin<KBox<T>>
To: Sagar Taunk <sagartaunk2@gmail.com>
Cc: ojeda@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, contact@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1B68346AB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241179-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,garyguo.net,umich.edu,onurozkan.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, Apr 26, 2026 at 7:53=E2=80=AFPM Sagar Taunk <sagartaunk2@gmail.com>=
 wrote:
>
> The `WorkItemPointer` implementation for `Pin<KBox<T>>` contained SAFETY
> comments that incorrectly referenced `Arc::into_raw` instead of
> `KBox::into_raw`. This implementation uses `KBox`, not `Arc`, so update
> the comments to accurately reflect the actual ownership transfer.
>
> Fixes: 8373147ce496 ("rust: treewide: switch to our kernel `Box` type")
> Cc: stable@vger.kernel.org
> Suggested-by: Onur =C3=96zkan <contact@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1233
> Signed-off-by: Sagar Taunk <sagartaunk2@gmail.com>

I should have mentioned that, in the case of making it a fix, one
usually uses Reported-by: and Closes: instead of Suggested-by: and
Link:

No need for v3 for that I would say -- the maintainers may fix this on appl=
y :)

Thanks!

Cheers,
Miguel

