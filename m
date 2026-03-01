Return-Path: <stable+bounces-222445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PnbKDsSpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:17:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DC1CF1BE
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43BD2300DF68
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384721257B;
	Sun,  1 Mar 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPhrYxwA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2A1E8320
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360243; cv=pass; b=IUxoTaHk6H31UxxePQTg8/i0m/a9cpYoEQbdWsnGujKBo6fNbiNRHOb5qmThyXPk2RDH5PVA2bVMU086vcuTCPhypSRGoTY3fRsbRyVNjiRy8ph5vhR9tJEQw6kKnqN315Wy8Dd1f7vQxXc9g1tDKtB80yQijgq6O7HLw3onDaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360243; c=relaxed/simple;
	bh=cPv/GBYAuzG7l24u/mN4pb5aR1YQfHvPaGaOU5fVuuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDvl/rTBQmsFDzeGHK1OXQicftc81aBDPF/Q//qzSRqF8eigt76cBGlmgG9bmoFLQzUWCzSEcXZLEdsNjCqQZ5zr8nan0XECpgKJZUjfc8hNXkoOiWq3q1Ztj4uPD+gasAeaqQkQNLxN8NZH6ZZonxfli6CLUGpc3PejKheynZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPhrYxwA; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd801b4078so292840eec.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360241; cv=none;
        d=google.com; s=arc-20240605;
        b=JP6oBdFTmQYTzHiIp+e7L/HLqIMrrLTfV+2xJu+Bd4/XaRBwVfssilcv4Q06LfQ/dr
         a1u2ywUim5ubpLw2OFaZkfY/iSpOxRomBGENXZPxojA3rSptL4lmpiUaA/VM7clDYCx4
         aNQW9gf31LJ+gWNIF2C6Ga7qIMtIpohYRP5+kut0Er1n4+/KsiUP7US/4gwHxd6iWSqL
         9H7+91+SErVpgLQjYN4gK+f8myt8Dz8/G4kdR4RAPc8lgf4639F9B+Jxo6Mo86Z0oozf
         7PxOVgaKgzmg7rGiMIRqtNBUsTVdwl5eaSrxDF9n5Y+bLVRcuO6gQLfLkEY8GJPv72Gm
         nCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPv/GBYAuzG7l24u/mN4pb5aR1YQfHvPaGaOU5fVuuo=;
        fh=Me4lvb+0TzIoUKsfdx0+5scFQ0m9HX6KbyTr2oLN9FI=;
        b=Cf4UITrttWWUGh4CNiP9c+dStxnhop+07zJrnhc3CicglUwaL0AVYNujBu11WvZ2DN
         15BhBG8VHDYrGHQgn+nRRgiPsu1iw7VtOmJkdKAZXRx+UJFM6SCErFwT7UTkRey8F3Dm
         Y9qzK9eBev1nLrOwA72hkNTbq05pJgk5Wvo8NYTohNwBpTNe80OWf7bNSoqipjIL7SQu
         SZCRdHCOGARPOJhcfBOq+5+NWpJ0tygv+J4h5Tk7R1HQQxp41W1HA7RUvok7nNR1n/kT
         1vuv6Cigr4F046Vg5yqowFiWN0psH8zL25n4DRt9f629g5j1Hen41SfP9dc3veSh6NGh
         m5SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360241; x=1772965041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPv/GBYAuzG7l24u/mN4pb5aR1YQfHvPaGaOU5fVuuo=;
        b=PPhrYxwAoHMuWg7BmWGV5txSeTfhOjYUFDbIRK1rCDxcZT17iruUai9yFT3y6o8Tah
         5I7h+2XYt471XeTtfuK7W1ufsX7jMKKe+/p5LkbqsW8OvPW1mbjhp081sM/mpfzXQfLc
         ayLW8WiNOUV8CKz+IDORJwvnILg2nIiAwnlKGT/FQ1HWhM97FDCQBbJWvRC8ahdNgnhB
         REtw+znMXWog4fFi7wna5FrUXAZi0C4IJEcslhBqovTwMeQqXFU2Um5F4NB78rxaepaI
         TO6mO00Bzui0mEme6qwZ9wiLmqF5uII0e9shGrfj/0T2J1fbrX+Mc0W0vwjYPpiMq1+J
         sdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360241; x=1772965041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPv/GBYAuzG7l24u/mN4pb5aR1YQfHvPaGaOU5fVuuo=;
        b=wG2sKJncDINS/TAS0rI4vMxjqrfdzFvdEFEudBvjg80hgNR4n/H56I2okSPflZ1PnC
         zbbVFw7tgeNTGdFyBAATdGr8ACrJmEvsG1+JXTLTmFqqydU9gvQhlJWYyI+Jgvav5QiS
         FNg/GYAYxZhXJeP3dkNd69EHVW/E8K6k0TOAvzxpLxV/JAakC+1cHG6l44S8r07J80jU
         ukaPml4C2Bscep5htkAUnOa3mgArwGE8nfA01JjFg0V5dgZ3fYnv6IoXdDam9oKEEOfy
         4rshzczvWbc0YHQ0Fd5LaT2/1rsfXboAZc5eg+76nEj7zo9r9woyTtttm6cf9XeDbxld
         yk0w==
X-Gm-Message-State: AOJu0YzbNz9oSqpMU/7FXDJjP8uvoq0fCzpmHUzhvTaz7wueKxRoWett
	pWmfNzyp5p084ct4HKu10aTQLQKgQJfoRn+jEkCNf/te3vm63U8viNcdZjymt/jP2ykudCZyPbE
	ISynDkZhCB4ve/GqZ97bNdjmJC4U+KEcA1ouq
X-Gm-Gg: ATEYQzxnaDN0iJjjOsG0LeZoamfsv9sRW+GuEIn5QcbBSB4g/TMULUl/7F5vOwNFh8X
	sdgmq90Mb3NxQKrWbg7VunZ5mzPw0QV2Ul++g7Ztnc9VHhl4+K2/VQv51tZScEaWU+/L2snH8Iy
	PC4DmQLHh9QNA09R70o5Db7uzEFd3DfVzaEKtBu9u+mvvpOHK+o/+NyCWJsNgegiwnoB1Im8bqn
	MBwmkmniRoU6dqZfR5hacZxZC8mGsTKhbxilQb35iQI9DbznphDWDI3Fdvt7CpbJbtvmp/+tpFc
	5Y8YnpBX4oOIyH27Dt2VmMzXBAawytfHk5C1qs6J9O+nXuMrZIVvkLS6FY8yS08diUeB+CEqRlg
	Ae6KuQPjZHmbDa5hLtst1WbFlkPei
X-Received: by 2002:a05:7300:5b89:b0:2be:ca4:e136 with SMTP id
 5a478bee46e88-2be0ca4f0c9mr100775eec.2.1772360241435; Sun, 01 Mar 2026
 02:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013801.1698337-1-sashal@kernel.org>
In-Reply-To: <20260301013801.1698337-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:17:08 +0100
X-Gm-Features: AaiRm52jYc0vjYJgL3xYEdwpIE8wMskBgpRfrhLlJoJ1O7X_jNkvuuuX3Zq7Y1A
Message-ID: <CANiq72=WW8MtuS=Mi5gp1S4J+PFYNLROUMprFuJK4d3An5zrRg@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust
 1.95.0" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222445-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davidtw.co,gmail.com,garyguo.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 693DC1CF1BE
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:38=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The Rust version is pinned in 6.6.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Cheers,
Miguel

