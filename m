Return-Path: <stable+bounces-213505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODbxCcFdg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:54:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA355E7932
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A1E3082D80
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717C2C11E4;
	Wed,  4 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnPhJVF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB452C08AC
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216562; cv=pass; b=qMlvBqwkEHlSQKXqook4rT3wZAZoXjqOCG5v/zzMiPc120dPmr1oZgKn+I+ED2KktVMr2ZBMSSI2BuxvQK1IGkXpQUWvv0bRourL2OdUHc3qWnAyTPx0vNnHDDIno7awK6OFiGdPUzF2IeLR49QpRvAl2KoWUfsJ3I3L97DK0Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216562; c=relaxed/simple;
	bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw66crpiVJavqbhUztMuLGr2emXgkifUIdttrU/YWRcQKa84RuNi350Zmvzc/6LbG8k4Lf5tafh5CME5iCClyJrtCPz4CPPqOBbPiVZ/wTHFjNy+dKmn0avZDk4EsSsG+SSqD4j5MuaZlrxwl8+LcxA0nZQwWbYd6Jo2d5cHL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnPhJVF0; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649bd1f08acso937868d50.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 06:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216561; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3rrRja2HIpJkZIfIjEYj6h/OUwzL92P0GZ/PAY8/Q9gI3dZYSoSTQYFU1fOZFPDLA
         FXsDdkcFUHVHc9Cz8qYW81wL+bpDQsUTB6/A3wIdQPIzsKKfBO1QVfjlNCt9YDGwevfP
         AJExDxgchHPbly1DckEOZdTrR3mFwcqgeAClNjaMwy9Hp+tWvyuTeMc0SSOFBT6HfvS1
         Px+v5BTjFqLUWZ+uCdmb3qzTciAAGMAoxW5VY/r9lUuMqFNK6cScJaRBotXU2eJu4bAY
         UKkzNgTZ/qtZ/BzxA/6uIN+U1Eg8MnpGwB/21mK4grSrqHAqZmn+is2ptN6tJss3i2Gb
         150w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        fh=+aeSrr9WorPPhH9RaarOWHZMUk32ROure/Z6fbGchEM=;
        b=LmBumbrjgibUdzDto3ScBG5PA6CT/A+djAygRyQ8/AaMSU+vIQcXpmSYXH5arXK/8d
         /tmhBpP2u6WrL82vPgADAo/5XedpiifkHaZIh+gM7V9wwrYdFnCwlbWaiB49tV2xpRzV
         WeCnN0BdYSAOMbg82uRMvSbIz3cmjk8n3YE/jHFmxwU1JO+CWO6QvUmE+i1sXerl5xWt
         UKNcZnIrHKCBhcGXUOgpGJczjdDQ6jLSNKgct5zIfZpwnyd96t38wda5WS7lqYQiA0ma
         ljuk/0u/mjxP0S5I+IlYXBmOL/iXEN1vXfXMWdwHVZiy7VN6+GOIlCxF9cs/QMZVN13x
         G0jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216561; x=1770821361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        b=cnPhJVF0V+R23MwZvEFDk/kMXj8R57uKAl/fIMrrJ6c5JuL7cV/9oYgpl+RSZ8Cvqw
         eVR/CV2/s4ie+LoLnF/Znp4G8tL1yEhfV2RnuBiT1WbCo8j5UYf15erusx5JANgj+vIx
         yn+ZnZHSqjESVGY3zQGOv4stNlJ9ms2D9yBoazmshnY1AjezUPKb/tcTBBEBcpT8xUpz
         M4PGo4OWWaW1t5goRzttOVE7k1aZ2oEquwJiVkp5mIk91ieWrsqRrvBFzpODfvLkTPu6
         3xhb5mGLNJGlSl+rNjs1eXYtOloaqpgtbFOM+JPWyTv8gnIo3v1dg029UVIJT3O4qCqX
         u2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216561; x=1770821361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        b=rlNzMLbnT0M2f5lHfZYMbgamdKVRNfDr2jhS/v3uOyMypff+N9asT02QXEqbSg7r4W
         zB4p2L6y9M68PgES+lgq2YXL5cDwS0Ky1xpxvwgi+/mOznUVU7ZVJpmALYYLdsUXkYoy
         2BCosuxb56DOmzGyau87zaM2S3YoSW/hGWdHBdwW2xOvPjScnSRJHL8Kivs34dGr4624
         kMbLJS09l5RGQZl4y2TBemGlA/jjHxsP6T8xY5nq8Oeh90gD9DxCX86qKgGsBC61MC6y
         p0K9hCi4wz4aHd9NOWKapj7DDYoM+v0e0qwoq/llOroH0/AFYtMXDD9PeS93x8XdVjig
         Xcpg==
X-Forwarded-Encrypted: i=1; AJvYcCVKup+h4ImIGoHiDwUsFRudUYGdvON06RXsxOFcG2kTMG1pKflxcf9lj4bf8OT8LPppihQq38c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaqRa+c02PIWCvq4n9TakSt01NU5vpwHiVtrH+1aqetMJx6JT
	9mSivXLC9sLQHug0dHK/YaYo6vO06Dh5DQ3OPi8jMPVUBKJM/VNwbof40PkXV76ApRiqsI9WSiz
	n7Hi0bGg4A8UWZ3RzabZ74ZJL4tzfdpo=
X-Gm-Gg: AZuq6aL4Wkb7iWLPoUBrRSmj5jZIrJJcQkk+/dTL6mUlUArMM9SfkkeI4j9vXVNYO/V
	IG/gOsQpg29JE51FS4ffTpWwQ6r4FuvgTykwnionC25JFiMsTDg288JIL2/vzo6KmSSIyU7r9ZK
	W/zHw9S7pFThLtMZZDX2hQceQjEuFMw9GJmkLLZhVjk5pIn+cr4FgTi90+ZXMrc73v4Ca0Qqbzr
	wtURungA6VVhToYT8QRRg8B4tKmcS7EKHhPu5jCTdL8EW5zxxqyDZWl1NuAClyGggU6oM0=
X-Received: by 2002:a05:690e:1508:b0:63f:af33:e413 with SMTP id
 956f58d0204a3-649db34a3c1mr2779141d50.24.1770216561010; Wed, 04 Feb 2026
 06:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
 <20260201195531.1480148-1-safinaskar@gmail.com> <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
In-Reply-To: <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 4 Feb 2026 17:48:45 +0300
X-Gm-Features: AZwV_QggcuX2I10WK2N_MAlIFYH5fFixDaE1iHycnt6z4Zzioth3_9pqZ8ncajQ
Message-ID: <CAPnZJGBUGa=LExdU5KTSndeXPvtfxXo-2AqK_uU4VWi6mXoG0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
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
	TAGGED_FROM(0.00)[bounces-213505-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
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
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: AA355E7932
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 4:01=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Feb 01, 2026 at 10:55:31PM +0300, Askar Safin wrote:
> > Christian, important! Your patchset breaks userspace! (And I tested thi=
s.)
>
> If a bug is found in a piece of code we _calmly_ point it out and fix it.

Okay, I will be calmer next time.

> > I tested listmount behavior I'm talking about. On both vfs.all (i. e. w=
ith
> > nullfs patches applied) and on some older vfs.git commit (without nullf=
s).
>
> Looking at a foreign mount namespace over which the caller is privileged
> intentionally lists all mounts on top of the namespace root. In contrast
> to mountinfo which always looks at another mount namespace from the
> perspective of the process that is located within that mount namespace
> listmount() on a foreing mount namespace looks at the namespace itself
> and aims to list all mounts in that namespace. Since it is a new api
> there can be no regressions.

Okay. Thank you for your explanation.

But then instead of a loop (
https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L5518
)
I suggest simply using ns->root->overmount.

--=20
Askar Safin

