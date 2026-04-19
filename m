Return-Path: <stable+bounces-238656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id upquBns15WnofQEAu9opvQ
	(envelope-from <stable+bounces-238656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03A42560E
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19941300B3EF
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04AF2F6184;
	Sun, 19 Apr 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv8QeHNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A340DFDB
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776629109; cv=none; b=PxH+qKdjgmuxt/Sto++HL2gskcVoQbRTooXZxuAoO44BgL7AsmjFcn7aagOQl6d4TNjf2wrDe9UeUzHVTJw7nENjgr2Kzi1q9uDKZMZX83dYJnzVO9YxXStmfd0tXoB6XKM3y+2JwFrPb6rlU7Lh5xbQ4NUvhd4mpSHGtyXaa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776629109; c=relaxed/simple;
	bh=HaEcoPFFJSsso0nYJs1rCaYbcTkCVAnWij1EmPFe39c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S95lokaNnt6o0s+LNkQWVzIEiG4579XtvXPpr1NW8DagzEzOIQNKIpw/Z/Ms06rIp0ndN7hZvo/H/YdOLF0pGwcEI+Z7J7HzK99LelLzuNDpfRs6F9f44oMLe1ihk8QigeQbLx41KDRQTMYwgcR4RJGcD/dSGbojbr0EhQAGnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv8QeHNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFC4C2BCC4
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776629109;
	bh=HaEcoPFFJSsso0nYJs1rCaYbcTkCVAnWij1EmPFe39c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bv8QeHNPR1lyefx454Wnu1aOCVW+FObcN7t7/RrYpU9fjyWcNt2+pzSTJaq2Ws8CC
	 X+4Znt5+R0opBNUAsoRM3Gpc4QeHQsJyb2yCsQjbw9fGYAAPEe9Mvb/fxT2CIGIcEX
	 4BzUVjxnxUeuhTb9saAX3q1r5p5YzxpPrm1ZX405ym2J0Nr6i6sQYY6xt6rBelB3eX
	 ijjn/QnGey9rZXV0Q4jsANz1Nnr5Wv7WsURSsSJfkwznehCcBMcJkwGpHBcS4pg/O/
	 F64qcsMAMe5n3IstN3F/8eHbfiVuT/cyJC+nj2eg1OKJQ7wjRpuVa3Ag6G7pcE8COw
	 CvvPWVg3UWb0g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2c7427ad9so2299270e87.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:05:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8yEasF1gJrFdgKG55CIcw4ESXl1y75SUe+wErY0CvKoxh8rMwnuWBv1IZK//vxIo7BoGMh3Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLDrylHrmn46XfA5okTlFbKnqPeK0/rhTvv72vXLqZ4zHV7id
	KUK1XLx6Ogb6eisFl7mnaZaYeTI/j4xZozMdLLmFWsDkFJjQM1jifMJGBoxG0fzR2n+06iZPYMc
	pHLvxm18w43ng18qV4DrExCPcgaunOqc=
X-Received: by 2002:a05:6512:3981:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5a4172e307amr3088773e87.41.1776629107806; Sun, 19 Apr 2026
 13:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155724.820472494@linuxfoundation.org> <8bb67921-d8e7-4535-bbec-249e9702ce62@roeck-us.net>
In-Reply-To: <8bb67921-d8e7-4535-bbec-249e9702ce62@roeck-us.net>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:04:53 +0200
X-Gmail-Original-Message-ID: <CAD++jL=PEFV_wYtiBixSLixvk3w0xeSOaSrjNtPFEC9fdd5s2A@mail.gmail.com>
X-Gm-Features: AQROBzCr20naR9jzOpPgtjd3MIvca2modC6ZBLfglVDKvGbe1Zgju9vQ6UXQ4fs
Message-ID: <CAD++jL=PEFV_wYtiBixSLixvk3w0xeSOaSrjNtPFEC9fdd5s2A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238656-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7C03A42560E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 4:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> Looking through my test logs, I find that the following build error has b=
een
> reported since  v6.1.166.

Ugh not good, but no disaster, OpenWrt is the only downstream using stable
and it only used v6.12 and v6.18.

> I have copied the patch authors for advice.

I'd just pull them both out again. It's fixing a runtime crash that appear
only when you use ethtool. Annoying, but fringe system and not appearing
in normal use.

Yours,
Linus Walleij

