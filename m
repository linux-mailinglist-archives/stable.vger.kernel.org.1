Return-Path: <stable+bounces-240212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNYFJ7iy52no/gEAu9opvQ
	(envelope-from <stable+bounces-240212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:24:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D843DE80
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FDA93060231
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17902F3C3E;
	Tue, 21 Apr 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOv5casS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AA2F6160
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792020; cv=pass; b=u0XzKYyAlt7Ima7GkDGBn0sQk0avOxw1lG6pVCkyZihCCXVkrxfFUc/+40FP18Q7UVEmQNRxtU6gz1WoAgZiqw8taPafZ51qRXu4POoZLV2nACZmUc2D6pw9zE+X4R8QLkSRpkGDujqe4cwBXeOvFhG3vzddDhLcB28YHyKqV/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792020; c=relaxed/simple;
	bh=Vxeh3HrJSuiP4oJvDrptNJN1vnuRJPPVEP7iiGSRHi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seT7A2DbjMy1v7bxwQQp16sjFPjLbD3Ow+oP/96Dij2peyKzJTH0OfocKVBfLO+r97y4oc0rScpGsxElP6MwrHdEtj2idjSZ5Efl+/+B212f80L7vF0an1LPwvl79AjGCFu/XdCwH8YEYgwHg5i2N7cQ8jhl41RiknbkGU/Ar34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOv5casS; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d864c23bdso2372401cf.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776792017; cv=none;
        d=google.com; s=arc-20240605;
        b=GAfBZXKZhsbTj7uSB9DeY4IRj000Iy+OIcnojQ8/aD2P9tXT+n56ejY8KvNUC0zqWS
         c49OJFA9v6tJi7EsGbN7Cx3apLuSCxIF05rMK7SJLT7MpDoJvkGkxMb6MaFabkxumyGI
         06PfR36JW/5JDvLxygkd7y0AP12BOa6ElbtaDha6W0lVWQ8PBd50+OvBbcKxYPxYdc4D
         tTuuzm2rl1JfCIwqjq2B/6vaEnU8DuysVIQRil3OdPOUBlEoI2h/1Ncw1FZ+p0LDUyw1
         BrPbNYJajZ4qA0Cw17h/V8P2AeJ3DCXBR/Zvgq++OzAlOoS9pNT7qClwJj7obmn6h9f1
         0Ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ha9b3BYC/DPqvosH7Lf4u9Isf4lxfWOStmLn8gp6G1A=;
        fh=UX3S0eqxH/PJygf2a3wkZML0zTbgEDZK6s03CrC95k8=;
        b=K3ZT7G7ZHNIJm25QvJ59xE6szMlrtvRZTMBePrTBtVW+hPVgGX7yHs7eOAoQNkCC+Z
         532ihkQT5SgMj8H22uqVF+5EU/vO2rgMiNX3OvZUuSVA23gxYzumuq1XLkB5MgiRraRY
         aTZOvNfWAy5eFyITnKJ2RWPT4GFqNF68enTVZWWy6RbvvW9zR4wrATgbO22nHAHNxlH8
         lWTs2WWhDW3PzsCa9hMzoLET0P+COH2lFYYIo81EI2clUX//BcXxWmFhWDtSsu67ptmk
         yA1a9p0UgMkVI9aSfU0FwXsfLSGkFQFRA0Tml08+7D0ApUhRciJ9+2t+KSnER5cN2/fb
         KxeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776792017; x=1777396817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha9b3BYC/DPqvosH7Lf4u9Isf4lxfWOStmLn8gp6G1A=;
        b=eOv5casSBww4kZRMsL4ioPLPsN5wwgraVByVXAcUvATWEpNXh9QstLWtcBGlzioA9q
         eN27LS0YCsR4uUYFdrKG9dd+d9BMqgaI0Tr10b2PmZBIibqwyvE3lNG/tIOj1Qgg04+5
         n1RjTMilcXx663FR0V5fNz50x3rVhiOdH+bQ23vCIwTnnv0VH0GYiteDNTLkSaIDtDL8
         KCvcoGi/pXOYD2pgbxuIfpTbenqGZfDSepgUf+1Pn0z+g6TRHmjyQVjiVb/+1bCfLUp4
         kl215eOmhEKk48vdQKz4hRrHaC60gBhC17kC1E3SFdbGY1noCO83yukZ2owmxV5Y7Fig
         ZvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792017; x=1777396817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ha9b3BYC/DPqvosH7Lf4u9Isf4lxfWOStmLn8gp6G1A=;
        b=tWpNxBjGLBCpBM41xpobckLy7BkQ8TONOr4VmORnnL6lsJfwLZC0724AW8vlzu7PwG
         cLbZh8nbQLheUB1k9VM0nej6YoujOZk2sj5/GUbrmgZ4fO47QV6mVnCDnCju5in52/DD
         UkWZC7DlBWUtjetG3/LPxZVEQuBx5jXgozqnWKBdPrmF3w7Ctz5aO8IdV/N7obIZUBq7
         5OCxrwaTF4v1cpLGW0QutVTbZ4Zgyzwnt9Zx3aTtfOfjIi20zNPNpUX8LOWnJmssjgjJ
         LxKTW3rcmPAh6wlF2UrVEv3IUv4d1GjRgiURkoHOS2JJxCPJXJCpLY5VBsAw1Gijv+0b
         20XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Mcdm1X+wha0rAhPJ9vcnF3R3IY+Ax46TLr8YRHVb7R3RZZYD7yQukENHsu/uQfWTtFj3JNDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OQpY07ykyWMnOAc7o/1hx7x8gOG2QBnHCaOSKPJxx+gg4Is1
	RJsVpmBuXIRDTDL+dmCvBzqMqAGe3p2aTTHHkFyoMqu62xFehThQD3PDsscpPX+mwNUVn+PWtfv
	qT6/ylqfDVgv5gX8WBn7t03sXaXRI+lFVbhsiVh5/
X-Gm-Gg: AeBDiesd40AKeR3cuqP+jxHA/U37mHjBpAdjeJN7akWrdgXYOoQDx84THwjOPPDto4m
	D2ax78sADVVY7NM2k1ljpt0ONqjaN3u2hUs/LLLzCp+sxzxqXSbu8+dKXEemO2mSL8IoI/AITHz
	CaMxTf/pKSeXmBg6GghrY95DuCZrl1RLm5D9jpw5kLjuvHZKvtiXp1My1kMW4IIslNUpNB4GV5H
	Gq9VrpKhznk+2zUZhIBYG8Ur9jXpf48Dg/JeXCXuqR+YzwKam2IXFENMfuct6Uo8VD7daekASQW
	DE1XQsXbTOWAW4rTKUNzjgYYQPv3
X-Received: by 2002:a05:622a:5a87:b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50e4420283bmr53961561cf.15.1776792014053; Tue, 21 Apr 2026
 10:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
 <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
 <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com> <CAOQ4uxhCNhGinePrnkSfT9Mtf4o5FmBX7mTA2m4miCMOt3mJqA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhCNhGinePrnkSfT9Mtf4o5FmBX7mTA2m4miCMOt3mJqA@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Tue, 21 Apr 2026 10:20:03 -0700
X-Gm-Features: AQROBzDjNAxFnpR4sQRC9kzmG1vz5c9sq9OzKeP03GuQb7DjEPQ23ObObnZ8GC8
Message-ID: <CAOdxtTZGFxaayJpqsiFQrWBqXvDn7oyxSL3_9TWP919k0FhWTg@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Amir Goldstein <amir73il@gmail.com>
Cc: Derek Taylor <ddtaylor@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>, Samuel Karp <samuelkarp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240212-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenglongtang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 607D843DE80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CC: Samnuel from containerd

On Mon, Apr 20, 2026 at 12:59=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Apr 20, 2026 at 8:31=E2=80=AFAM Chenglong Tang <chenglongtang@goo=
gle.com> wrote:
> >
> > Hi, Amir,
> >
> > Thanks for looking into this! To answer your questions:
> >
> > 1. Production vs. Test Suite Impact
> >
> > The immediate failure we encountered is in containerd's integration
> > test suite (TestImageVolumeCheckVolatileOption). The test explicitly
> > reads /proc/mounts and expects the exact string "volatile".
> >
> > In default production, containerd passes the legacy "volatile" string
> > to the mount syscall, which your patch correctly handles under the
> > hood. So the standard "happy path" is not broken in production.
> >
> > 2. The purpose of WithTempMount() / RemoveVolatileOption
> >
> > Containerd regularly makes temporary overlay mounts (e.g., for
> > unpacking layers). Because overlayfs rejects reusing upper/work dirs
> > from a volatile mount, containerd uses RemoveVolatileOption to strip
> > the volatile flag before these temporary mounts.
> >
> > Currently, containerd's RemoveVolatileOption does an exact string
> > match for "volatile". While it works for the default path, there is a
> > production edge case: if a user explicitly configures their container
> > runtime to use the new "fsync=3Dvolatile" option, older containerd
> > binaries will fail to strip it, and the temporary mounts will be
> > rejected by the kernel.
>
> I need to challenge this specific argument because I do not agree
> that this edge case could be considered a regression at all.
>
> An admin from the past could not have set an explicit
> "fsync=3Dvolatile" mount option.
>
> Though experiment - overlayfs adds a new mode fsync=3Doff
> which is more loose than "volatile" because "volatile" can actually
> return error on fsync in some cases.
>
> Overlayfs would also not allow to reuse workdir from such
> a mount.
>
> So would you then claim that adding the new mount option
> "fsync=3Doff" is a regression because of the edge case that an admin
> decided to explicitly add "fsync=3Doff" and RemoveVolatileOption()
> does not handle it.
>
> I don't buy it.
>
> There is a more correct way to handle this situation and it is
> documented in overlayfs.rst:
>
> "When overlay is mounted with "volatile" option, the directory
> "$workdir/work/incompat/volatile" is created.  During next mount, overlay
> checks for this directory and refuses to mount if present. This is a stro=
ng
> indicator that the user should discard upper and work directories and cre=
ate
> fresh ones. In very limited cases where the user knows that the system ha=
s
> not crashed and contents of upperdir are intact, the "volatile" directory
> can be removed."
>
> containerd unpacking layers falls under this very limited case.
> containerd can syncfs() workdir after unpack & unmount of temp
> overlayfs and remove the "incompat/volatile" directory and then
> the upperdir/workdir are are free to be remounted.
>
> >
> > Conclusion
> >
> > While containerd could theoretically patch their code to accept
> > strings.Contains() or fsync=3Dvolatile going forward, there are many
>
> Following the documentation advise would be better.
>
> > existing containerd binaries in the wild. Given that this patch breaks
> > containerd's CI tests and introduces an edge case for
> > RemoveVolatileOption, it might be safest to fix ovl_show_options in
> > the kernel to continue outputting the legacy "volatile" string to
> > strictly guarantee backwards compatibility with userspace.
> >
>
> Considering my comments above, I think we have not yet reached
> the point where the backward compat "volatile" string is called for,
> but with other reports from production workloads, we could get there.
>
> Thanks for the clear and honest explanations of the containerd situation!
> Amir.

