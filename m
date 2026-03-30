Return-Path: <stable+bounces-231184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LO3KdJrymnG8gUAu9opvQ
	(envelope-from <stable+bounces-231184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1C35B011
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 907B7304AD0C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C93CBE69;
	Mon, 30 Mar 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba0W6mhu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E83CB2EF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873169; cv=none; b=fkZpkkNtHdXlgYquzlfBx/RJDOR5fgtJjUJ4WZYKBh9inlC3BzLsUFwetXFP2WBYiPxSei75TAwFHwb3u6mVv6i/Rm/3diaKmrxuSqOdev3rLgSQxGHa0HV69a9ffr//z8zwF+bh3OudzqA/0/OeD5iBLkVN8Ew4kWWCTcPWzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873169; c=relaxed/simple;
	bh=2rXXQOn1CT95XJRYsLVMHI/ld1K4Welj8OsJ3LafH9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX6dnjh67giTopJBaKiaUStHwBFJJIGvq+OYxFCDevpbT79dnsQYJ+G4GpY/rZJBKaDLAzMhFmYBoR/x+/r5PRmDJ9hXt5IU1REMiMx7ZsvFuTtIzjXu7JWtSRTcTfTLpyGu7lXIrUNhr+08AsNu5XHENQqX/miA0Gfn9kEym/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba0W6mhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51373C2BCB4
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774873169;
	bh=2rXXQOn1CT95XJRYsLVMHI/ld1K4Welj8OsJ3LafH9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ba0W6mhuGjUJ0ysCRk/IKMDD3lY2J3LXi54kHI0U9+3GMk1dCKK54LsEVVBsMyFsg
	 JoiRgv6OGVExx538wWWAkqzi31dXu9jGFcfblqom9SdVhdn+t+CN1dh/LM+FYgl+LU
	 K1FWIu2gAP3VenUJOPN5lDsLrIKgFp9ewGthKbPdnnUxd/45lsrVsx40QMu5XLAVtg
	 c7aCIS3zRlHWTe/b21/1UL+sjAoB98MGmqK+NZyJmxCz4YFCPunedSGrnPVXEOlGU+
	 Yf3RnX4XoCgRRjmpS0AvIBirlrsTss5cW2akscqvneqZeZL0MsaPHYrWvBGpoVa34V
	 VvP9TZi2+vRxA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bfbf74778so792217a12.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlwLUoOrYx1uvpPQmFcLEcRqOxhWmpfvx23j8y5G93k+nhvA1VLEJ3pzZuKMnF/7ddR5SphL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtm82lV7S2L0Hm1W/GZh5MDrxGi2MTTE/qB3TFbouwwgfnqxY
	tG4Qji3QHvM7WFXA86+JQsNLyS3ukoeNZWKVXwTcySBMWgf0brMOj6sELP5Hl0c2rkJkronOQwB
	5c/FEOEsV/+nYLjK3TtyTb3Y0P9soxQ==
X-Received: by 2002:a05:6402:504a:b0:66a:1744:5cad with SMTP id
 4fb4d7f45d1cf-66b2826a13amr5745113a12.1.1774873167844; Mon, 30 Mar 2026
 05:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-dtc-drop-dts_version-v1-1-41066690aefd@kernel.org>
In-Reply-To: <20260327-dtc-drop-dts_version-v1-1-41066690aefd@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 30 Mar 2026 07:19:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+r6DvXMoJ+qPOLJvosrgbyOVjw8nn453wUi7bXQOZNog@mail.gmail.com>
X-Gm-Features: AQROBzBz2IeGCM6mQ1hZFa5xz3FxJw84PrspF04V9czNebADRaW_B-TJd2hJo1Y
Message-ID: <CAL_Jsq+r6DvXMoJ+qPOLJvosrgbyOVjw8nn453wUi7bXQOZNog@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Remove unused dts_version in dtc-lexer.l
To: Nathan Chancellor <nathan@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231184-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,lkml];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 66C1C35B011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:39=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in dtc-lexer.lex.c (compiled from
> dtc-lexer.l):
>
>   scripts/dtc/dtc-lexer.lex.c:641:12: warning: variable 'dts_version' set=
 but not used [-Wunused-but-set-global]
>     641 | static int dts_version =3D 1;
>         |            ^
>
> This variable has been unused since commit 658f29a51e98 ("of/flattree:
> Update dtc to current mainline."). Remove it to clear up the warning.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This is commit 53373d1 ("dtc: Remove unused dts_version in dtc-lexer.l")
> in upstream dtc. I sent it separately to make it easier to backport to
> stable, along with updating the warning and hash to match the kernel's
> version.
> ---
>  scripts/dtc/dtc-lexer.l | 3 ---
>  1 file changed, 3 deletions(-)

We don't take changes to dtc as we just sync with the upstream copy. I
saw you already submitted this upstream, so I will do a sync to pull
this in.

Rob

