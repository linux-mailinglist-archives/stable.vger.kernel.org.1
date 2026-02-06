Return-Path: <stable+bounces-214639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFHuNu/GhWnAGAQAu9opvQ
	(envelope-from <stable+bounces-214639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:48:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE7FCCAD
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EAB430074A4
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3834371079;
	Fri,  6 Feb 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ2LpiZC"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFD36074A
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374892; cv=pass; b=PxkVs3j3FHEj4KNIH3rKuXyBW3BTrXs93P6UDCJPbSyJK2vjseyE5OngUr6FBoKcN5XWsC71smMXV1UHT1ZYqnP5Bsg31waq78SbVaMNVEz1TS9dvt/qgtagzc2LeogS7qh6t8jtMfK2ZPNonzpRBDcG/aS2AE3QRtQc1GMTkDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374892; c=relaxed/simple;
	bh=j9Vgb/Rp9S+5KBoGNSNHXBoW3kOrjKgcg5E/BGNAWxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjvbFuksAhAbltwnu0uhuf2gZIZurnI2DKBMwHOYiIbU65aJIEB/kmO7OCOmwCb8MJshrBLCWuaZ98o7X56QrpTYtNwd8Fis4PAjZnYTtdGbpvbQZVGApWx2RyUbV6GCdIEmzVP95pEONv7ob0pA+zHaOy7of9kKjcN6VonWBEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ2LpiZC; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124b07e5fe4so119816c88.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770374892; cv=none;
        d=google.com; s=arc-20240605;
        b=NfiRq3+zcIsJI0bNAq7GnmFjfrSlhhwXhTJ02yQlnbYDZurG2+8QoGCVo0hd90RMm1
         IR0hH73Mg7TRwLEWs1JVk9urP1UjbRDNV3K29NCkm9cFrKUgZ5cXhUjunMYBptuql75Z
         y0aoNGdebbQY8QO+FLMFMOnSKBMZc4SfBTPx1twKj32pUxPloJwl6OUbV3UQ5uGEzQwL
         uz9AxqcnMcKDfX0uBND4hN1pDohwgwznZufnIs12DoDCwrKBqnUkYohgqQnXeOnJel5L
         PEseRMnNg+QAQcf1ieLD3mM7VS+j3z3YbuCIsslPFpBic/Nhx4pC12Fg86U4vdcGycOr
         Z1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j9Vgb/Rp9S+5KBoGNSNHXBoW3kOrjKgcg5E/BGNAWxE=;
        fh=7ep0GHfhWf9X4prJkODXI+VPHlI2ycUS7ZVEn5Z3fRo=;
        b=N7fRysZhixjpvU/IaQy3AhLxjz3a+YhGIfTSLiY8nx3NiRttipU15j+Nea9MbMXpxQ
         2BVfyfXGRSWQtXe+fxEKETIgxddlYe6QthhGOv3dxIoxO38MJLIDUBO7PWH30jFAhI6d
         oXm8RWNVCHXIzw24kqjhtJPJ1l+Os379fJ5Rbef9ITHQUVew/XTj50CTva+Z9vVgQwye
         05eZpAQLvZmgK9a2/V85G/rZofLm7GROrVdsLyE1shV+Zj1IQwjmU+8zkpqHWgCtpTUu
         Znmj+E3Y91bTR8eYj5i7wDq8x/D68hrqKUlybCgy0Er5wVG0/ujR/Ja68+9ySYXCJGQ8
         IrtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770374892; x=1770979692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9Vgb/Rp9S+5KBoGNSNHXBoW3kOrjKgcg5E/BGNAWxE=;
        b=DZ2LpiZC2cxgqMFROUNUDN97yTc/3R5x5/IbxDWUbkIp79TvQq0fwUIfE6F5kdp7Ld
         peSH/j7SZ9NSaBB47PXnf8p7EQMdbw7BMs47MvUkqIXmKY+bt8XaPObminDOAkRnDT39
         jorq9KVYKq3qWcHpMkwZbad/q+eiI7yESoylsF6dJsN0/vw7ABLSMUHT9gHEoh1HmFVy
         eZdoPKI/hASA/PIwETQewz7wSuHxQdEiG9UWnENzoZ4uh0slI+v0NanbN68Jg2SECS61
         aaQ+sUdYYHWpRzZR0t+l6zVES4jcFGv1mRDTRPF7bK2z5cPeEIu2d84+erzOJRnRMvpi
         jS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770374892; x=1770979692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9Vgb/Rp9S+5KBoGNSNHXBoW3kOrjKgcg5E/BGNAWxE=;
        b=kEp65WjggYqO+Ei9yFoJwjKO+5aVDFyDGaDjUTvNY3l8IWCu01cFSbl9WvzihGnUub
         O8D7nStlYnw9IxDCMPUjUaZsUtTQUchckQBqufbigxUZUbD4M/FJVSPyBFrN4euEfkyH
         fEAeHtWO80v2X/T2rJ2dhZAQKrnPlVnzxwKZMvpHjmgG16nEFsQBLjrINVvGHikL9DL5
         5QmhKW4UG75VC+85uzSQ6+4JBAHff+JTlIsaw5uF/gfgpEo7MErmjS2J8NrzfeMrakQ1
         a9ddZvtSF4LOL1u+hLrPpX9RCa5zyoCnSTJcYXAue4BXEeNYoBtfgMRq1qIKxO5sj0b5
         Q5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfu5GE9TYN12+c+EMML++aLiAoGBlBEaufjvoyPIkmjdLxyLQnEIZu7C5Q0j2gxxAN3ZUHYHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVVSYQXOwJmEGJAR7vUnaFwlCnpkE4uRfgfXkXGlgpvQZ1kxd
	3a6YlKqZKHO8bPhOBKMuDqAxYVX8KGa/fCYCc3S+fRJ3Wy8isrYYTGBOBLFpivu+vuS4klPsZiL
	p4wsbWk73C5tHOz0W5jBrd/MTWhwZLr8=
X-Gm-Gg: AZuq6aIaW1gosulz1PgjmhsrOCWgKi7dhlEP5y27C+0nc2Y3y7tv+7isDOzXSzIbu0w
	OzcyZBsmLOhPedbSXrs99dw3vYpV2qYQJRDrSEccNm55uj2aKOe0u4ghQR2IoM2/CKpQ898y+HP
	U0M7QYoC9LhqswXgFQhcuj/9q2CxB7UQzDEDBv5vYjkFBMz7vTUm07jAFSi2Km/4ZArt8Y68vtr
	vGaFfblE3axIx55M6KPNx1/O9Eu+eV3ImD7deE2PPItp5vtuchnMxAlxDYc0FrSnOucJ9ciZ4Ry
	2cJ+jYxruu7pbzPYo4zvpGfKz1zaD2lImsRnBDru/Ndc7+t/YLhUOTh6RLMm2hpEsLH0ZAY4elK
	82OZZkrHbAPTaNHAqL828pyJMa4OnUm2L9m0=
X-Received: by 2002:a05:7301:2b87:b0:2ab:ca55:8940 with SMTP id
 5a478bee46e88-2b856c577d4mr535529eec.7.1770374891690; Fri, 06 Feb 2026
 02:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129133715.23095-1-hi@alyssa.is> <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
 <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
 <2026020348-rehydrate-glider-b1f3@gregkh> <87sebhvj88.fsf@alyssa.is>
In-Reply-To: <87sebhvj88.fsf@alyssa.is>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Feb 2026 11:47:57 +0100
X-Gm-Features: AZwV_QiAFuW40_AwuG6nVCdBznzFUxKP_r2qnsyP2HUCutmCH3bUW__7jc8v-wc
Message-ID: <CANiq72m4-RoG4YYS4dBuUo7mW+HWez2BZXBu6NvXXPChmBeYfQ@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Alyssa Ross <hi@alyssa.is>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Huacai Chen <chenhuacai@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	WANG Rui <wangrui@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214639-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7DEE7FCCAD
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 6:18=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Doesn't need to be AFAICT, because -Zno-jump-tables isn't used on 6.12.

I am not sure what you mean -- the commit I referenced is the one that
introduces `-Zno-jump-tables`.

Cheers,
Miguel

