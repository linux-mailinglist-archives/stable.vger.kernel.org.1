Return-Path: <stable+bounces-238715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFOyBujc5WnNogEAu9opvQ
	(envelope-from <stable+bounces-238715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFF427F1B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B563007AC4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8282D6409;
	Mon, 20 Apr 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmCuiiLd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241030594F
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671962; cv=pass; b=oz45YD1B1BTBfWIXBYv/8dRmxP0rjIfypwSeFcMoTyDqahdxPqhZ18MadzTIewwSAbe8x5J11aWFEya0yJH8lATgNh54DxXWuV6budsBvkmcAsOMz5HkHohoSrkdDnu1B2Hc24eR/BQJyIeO1zxAE+j3FeaaWgkgwXlJytmi1Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671962; c=relaxed/simple;
	bh=skJ5R+wFeOukZf+cjPX17CzqfeE4aSfaDg5kcm2isn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS3MM4lj7EIoh5EAZGIWUcXeABjCEAS2taQhEZbu8r07qINkD+C9WWLg0klbF8ZN/fMRjt7/TbgXVG70sX+z8iISyO2lZ6LOMQbOKLj1h8zmp9GsyVF5E9Fxf7hj0TiQo+bI6xmeQRddw3G4ptRIJa0kf8ndvnX0F65zU1nY1wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmCuiiLd; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so4203957a12.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 00:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776671959; cv=none;
        d=google.com; s=arc-20240605;
        b=QUNjP5zcdFL1ac2BxUG6rGLJcSs2Gjv28i+WvmEha5mZ8rgp0B9xeWlwKL3HGb+llH
         hSyg4FEQG1UMH21S2t+R1oSS5olo6xnrk0Lu9kz6o+9bzauaMnhv+RMbOIQ0JPVUlz+A
         DbU0ghn/BFFRbJMYw9tB7sRdiyWU1Z/Oe3AIUgGKJaHZwgbEHKLP3CL5nCW427i7Y0Hm
         KpzQk3OzT6Z8wXfAmKO8w4jndPvu8eQCEnVygsK5BedCGfgwT2dWJOG6XJuVrtUK+K4x
         goHEJEUgBsPQYn0skap+20uJd/fIuqF6nmBOflvqt4E8yhTG1niRsXHkVeVSOGJg8bb3
         7GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qX8bL6820CZ5JwymJvdCU8o9V6FV5GdqfCje7/oI55k=;
        fh=XJK3LLN/sWTz/htlW54U0LmhnGAPb+AlvhtQV1ZOijY=;
        b=VcJEHh0ObMPGNH1VypVGM2QwdwJwTZtkU7oNXti0UcAgYFp1cpm+PSaEs0lbuII311
         ZHbcM64tN5elAgLztyrqGBpnIFKXlkfmu3HprAwirSoblYy87kRncO6Q7jLVPw7Y3FxB
         6oHczxRQzDqW4MSgHS7Sm6UiUCaIzpmEPk/xjWexR7sDEg2LZUJ9Lb1g9DyPC9MXxs3+
         ed9WiOOquMCf8G5y7wXM0EmTz0vSI6y46Rz6VEuYnJIUgmqKMeClRSjEjTCedfE74GIw
         5TYH8i1gccfRMFuB/GhtqtibtfZE1yMHhSF9CP9x/Lb48vHtBbFJszYURI9aUsOWht58
         Yu5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776671959; x=1777276759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX8bL6820CZ5JwymJvdCU8o9V6FV5GdqfCje7/oI55k=;
        b=SmCuiiLdwNXbGdWDg/x04t78lVcyX5bGk4E4xxNO2HBb/LDafKhWIhZjPfCTkCpkCt
         4U629ZeIPAOFtQ+OExNYoDizYy8QsrmLlmwjmnc3niWcWg9TyOt8qEVRGB9zSeyOCIZO
         o9O7v/TGjnwehDnHfHDTdBwrXiEOPz9LTFjyy+AjMIGFI3A3HnI2qkslePLZMsgwg2Al
         gPRD1ezTLBfDPpFPfrf6cGcGJFYNRjBrfXcjeoPGuFsIQlHZW0RMHORdu8orPJ3fDGtP
         ZNbCeuHeJH8pxZznHir1bo74x8oEIWmQqTeSjJbB0bz+/D9EDFuHZ72hGTzlVzMTtbLk
         j57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776671959; x=1777276759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qX8bL6820CZ5JwymJvdCU8o9V6FV5GdqfCje7/oI55k=;
        b=nGTM4eXIN7vZ/Ap7Rw+1k1UUlS/CLqq0ueXKqmyoU6ral+PKoRKBSZroSczGUx/4Kh
         03SPrV6g3TqK22f4gobp3ld5Dz64au19TBHKQymjjNahfYJiJWVnNapDGpSwdFK3SlGg
         z3st8FQ+4yuhNpKFcKVUrtGB8wfDAaRS9WNpdzpK96sQQA+Wzkps0KEEJ/lVTVIWuFEq
         +Sx+xMl5jUCKNYhXt7i2jqRveJ1sHlaYhegE8n9WvmlceCJBP6Ij3XS9LILjHit4twg9
         8Jb1G2NP+5jCbmGaFy7rnL5/WkXXH5Ayo4hgFWXPgSHCETH0i3HEO4xa2iQiXX+I4CPh
         zVtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DfXj5sFac0nQ2eyKGloa3ulkXiMPeie+WVHwLEE4SQRXCpP+wF8yzY5qt27GXyO0DprIFdJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKF2Je8uCz4dUWHK6ATe2+DzFjktni88X0Gu3z6jKut/Hj0Ssa
	G5zmCPnXfhO1tMQba7LaZ3+tSpgsH/X67rMRd8QaH/COHWl6QUtznbnz7ofUFi2vHC0sAXetUaW
	3XN8fC2yoeyMsFhmTpkbP9BJ/IcI9wyc=
X-Gm-Gg: AeBDiet3IHgWBJhT1XFv6ED3HJj4t8ybzyPH/gh8XtzezvM8zE8J2KdMRhS0KqaodkF
	7X9h7TAYYwOBrsDPmG1Wn46zniiXTRPXFm8pCGoc3xu/4mxlsaPiN3mioH9Y5WUlQ+vxg9jHDHt
	Ne6qHvR0CV1TKRWmxLXYZhVwPqXjJtETuYxDpiS/8K7IuxCJWTwv0uGfoDVLISz57pmCW+TfmfW
	oOHiEQ92s3EOWMKvapbBKn805fjKtUQcTAxjXOuhVyApgzuaZZyJgndXP1/tkg2DiDW7ovKFulb
	62Uo7q3XqvYrN5YYiQosF4EhGexr9zSaMbC/hfPYTmmt8gfqlFn3WAz7crfLIpo=
X-Received: by 2002:a17:907:6a16:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-ba41adf9231mr607331666b.31.1776671958701; Mon, 20 Apr 2026
 00:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
 <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com> <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com>
In-Reply-To: <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Apr 2026 09:59:06 +0200
X-Gm-Features: AQROBzDzAqpFjrbD5bTYNQHJCrGk2bhPT57K41uT-FxOcAInwVKNr2-vgwcmqn0
Message-ID: <CAOQ4uxhCNhGinePrnkSfT9Mtf4o5FmBX7mTA2m4miCMOt3mJqA@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Chenglong Tang <chenglongtang@google.com>
Cc: Derek Taylor <ddtaylor@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238715-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6BEFF427F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 8:31=E2=80=AFAM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi, Amir,
>
> Thanks for looking into this! To answer your questions:
>
> 1. Production vs. Test Suite Impact
>
> The immediate failure we encountered is in containerd's integration
> test suite (TestImageVolumeCheckVolatileOption). The test explicitly
> reads /proc/mounts and expects the exact string "volatile".
>
> In default production, containerd passes the legacy "volatile" string
> to the mount syscall, which your patch correctly handles under the
> hood. So the standard "happy path" is not broken in production.
>
> 2. The purpose of WithTempMount() / RemoveVolatileOption
>
> Containerd regularly makes temporary overlay mounts (e.g., for
> unpacking layers). Because overlayfs rejects reusing upper/work dirs
> from a volatile mount, containerd uses RemoveVolatileOption to strip
> the volatile flag before these temporary mounts.
>
> Currently, containerd's RemoveVolatileOption does an exact string
> match for "volatile". While it works for the default path, there is a
> production edge case: if a user explicitly configures their container
> runtime to use the new "fsync=3Dvolatile" option, older containerd
> binaries will fail to strip it, and the temporary mounts will be
> rejected by the kernel.

I need to challenge this specific argument because I do not agree
that this edge case could be considered a regression at all.

An admin from the past could not have set an explicit
"fsync=3Dvolatile" mount option.

Though experiment - overlayfs adds a new mode fsync=3Doff
which is more loose than "volatile" because "volatile" can actually
return error on fsync in some cases.

Overlayfs would also not allow to reuse workdir from such
a mount.

So would you then claim that adding the new mount option
"fsync=3Doff" is a regression because of the edge case that an admin
decided to explicitly add "fsync=3Doff" and RemoveVolatileOption()
does not handle it.

I don't buy it.

There is a more correct way to handle this situation and it is
documented in overlayfs.rst:

"When overlay is mounted with "volatile" option, the directory
"$workdir/work/incompat/volatile" is created.  During next mount, overlay
checks for this directory and refuses to mount if present. This is a strong
indicator that the user should discard upper and work directories and creat=
e
fresh ones. In very limited cases where the user knows that the system has
not crashed and contents of upperdir are intact, the "volatile" directory
can be removed."

containerd unpacking layers falls under this very limited case.
containerd can syncfs() workdir after unpack & unmount of temp
overlayfs and remove the "incompat/volatile" directory and then
the upperdir/workdir are are free to be remounted.

>
> Conclusion
>
> While containerd could theoretically patch their code to accept
> strings.Contains() or fsync=3Dvolatile going forward, there are many

Following the documentation advise would be better.

> existing containerd binaries in the wild. Given that this patch breaks
> containerd's CI tests and introduces an edge case for
> RemoveVolatileOption, it might be safest to fix ovl_show_options in
> the kernel to continue outputting the legacy "volatile" string to
> strictly guarantee backwards compatibility with userspace.
>

Considering my comments above, I think we have not yet reached
the point where the backward compat "volatile" string is called for,
but with other reports from production workloads, we could get there.

Thanks for the clear and honest explanations of the containerd situation!
Amir.

