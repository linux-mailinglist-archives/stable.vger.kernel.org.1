Return-Path: <stable+bounces-254369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLtXAuGsFWrgXgcAu9opvQ
	(envelope-from <stable+bounces-254369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:23:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF725D7676
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE03F301B008
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3F3FE371;
	Tue, 26 May 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEVLVDeV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297783FF1A4
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805037; cv=pass; b=UQ5m78ZitkBwYiITKvtD+icPJ7w19eTq/3wuB8Zn6lzXSaYsFnVltxwBtAzHyT6eyZHTyhfFFgc77AiVLCRlNWc/bACAPh0dcOcmgXT7++sPP4OxSpeCKDVe3hPcpAgvactZ8NJU4VuqfckOeV5vk9fx07my/fmm2gYLpU3InQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805037; c=relaxed/simple;
	bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9FA7DdzNVXkKNas/EUzdJWipaqJ0mjOAamq2KeEHRrCtTdEtZXXJm9KrFNraqgpn0MDDPkyl4LdlbKaE943D2MrDvlrgMdEHKhs9sjnCCoip2hCw2vHxz8RL105VLqCthDoLPut4/FzOpd7xnIxRN7/8d0Kvya1vS57sjSP7TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEVLVDeV; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso236a12.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805034; cv=none;
        d=google.com; s=arc-20240605;
        b=QSRBez3i1TnmFJIIW05XGVjS65mjcNFBuHVQcuNQ1hkui6zJFdrlx370YscyX7LYuI
         zCsLE55so4BA0VZ8wrjm2Z096fteIEztZTq+SLlrouRQ7RUP8drcNLtbTfvH5mdLZSuw
         ovoJfQsAYrxsKbyXb5os7jvzqexXJynXl1j6CIzH3mVM0DahRdc6PlB59i+f/Jj/GPjH
         pgAVGSmBiB8ITikZEhzuM7FZopFiLn+OkYhh9+Kd7J+nGsd2ee9hOvAKxQJ8/9XTF2b1
         F8jKGHt/PlHAjIqUqT/Eo+qvkuz0nw/F07Nbegiz7bce2LfNTf3D6mScP6ZCZIeTx+XB
         +L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        fh=jYgpzNV7jDRUoHH2PreXXGr/SGK+BWQpLRfxBGJZUIw=;
        b=SSu+Ryj+PKghC5AMzDdMDkme6THEbdKOsqrmx9/ivDBf3eCsKDBGi+oV5/jlO5gdlD
         euYO+wEOIJBEdmKh5jitPFPCohngouWq2YR+egkeLRVqyRL2iT2O1osQBtWFcXnGLF9J
         ANRaWKymXEd2ndemuW0xTqPOjwpM+bK8ee1Ln/XCn7LYNansRbFgruXHeLkKur8np8o4
         e0CijEABk6t/T+dcKegRY9J4UrV1ujUH/nX++piM3Ll5+rgS+tByfX6e3Qbt7uUeooIN
         1Nq7T0NLDabW5lKQ4VPdMN+/i4GhMPaW4nAGFhwmJ2wT92JsFXqrM1hsrsagLPBROc79
         jX3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805034; x=1780409834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        b=NEVLVDeVmB09ZakIXQABBnMAOAN5zcI00dCeG45Q5SFKpOD117RIfBjbDYx2nZl+Nk
         M7LpvEw9vJI1Jc+88k2YAGAl8opEFblXRhSSQMcDNVRrOqCiezvSjg2aSnBwgxDBsjZm
         VF2cMj6knMRkMHcPzm1/2HImHkVNIilk/vF90V3Kh6Gua5xHwViP7RpYewlPxSy5MKGA
         RQ43+0aypv4soaRe7ovAl+xQO1zGLSAamQk7+WUAQf609Hp1vhiu+2rowtoeElWypPVT
         ljQPhBvlP8phs/jSg8gUi79aUU/+ONg9+HnDOkOFoP6MkSokufkDv1LGx8F/Q3HlQd3o
         zDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805034; x=1780409834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bJ96FDvaxxZFqINtb8HUCFzMGCIz8fFWuqOtJY3C1Y=;
        b=Gz7qrjPliXLziuIo96t/NzZgDktqA8J79NbhK4g4aBsDZTZqe073AJwQKHS1FA7Ao3
         Ny5wyUWSvt9NhLEaY7D1jMUvMAkAgGbLYkGCg51YIMeKJNuckwKHvpS6RG6DN0GoOV8F
         JHeKsukkbKOPZgE3f3RoQxx5CWJayYRr3q/sWyd8t5PB6AbnCzFe8NWSleTdn5zjzNiN
         gqxou1fiUx3rxgwXUH1GJQ7Mu0uBC5DKlTpe1Dpd3T8XYpuyYvFaLEmJPwiKd6a2O11t
         NfRVPL2+QkmxFAHYvVLKUuGcI9RVg6uZGwAzD63Pj7mXITRAMMtxxQb41KIYZQV/qxwU
         8qTA==
X-Forwarded-Encrypted: i=1; AFNElJ+vbt6FNbRlN+jnoxaldjinOA9WS9iyZb4IV+db98ACuzHLxOw34Rd6r3EvFmFXOzWaWEhHTto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydof3VrjMeUuOktyZU+kMHEZmbZR8cXX9O0EojC0XfD2XqwGLW
	C387yCS7BOijBjYAJ1rYYntybWoTmNANBCS7wpnUjzOWF2PEwQ2oSUhEZSzWN7AsgybES/R41KT
	FNVWqwnhn/m6mvV/n4FT43yq8mHJ+sCPjBkVgp0Dk
X-Gm-Gg: Acq92OG1mE1pdfT0vTN+hoCwmrY4PxFBFGo/xwKnr36eSWOUwc39CSJI7f5qDNQbnm8
	AsF9b52k7CprH2jgQiES7WDDKIGw7eQKLD/ns56iufHTnmMYZESGyfxujl1lsX8eYoj4bN1/v9l
	V8AgGhUPhH2bp7Z2HrrcO9tppkEbY1ZNPm+l/rUJ/sxDvCjuYjK42uChGJKRazLinPQ2O0knN1J
	zEfoC64+mqV+AKJ7Atw9Nfh42orOX5N/wewfZNr0QgbEkXFpJ8ifd7cnru3c3+WTXLYDA6ZE2Tk
	uUyZ9cUx3kmXh5wc/9Z/8qEBRW/PbizyCqdDujjfM0Y=
X-Received: by 2002:a05:6402:a218:10b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-688fd0d59f2mr99577a12.2.1779805034137; Tue, 26 May 2026
 07:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com> <ahVeT9TTxlJiW2Qu@redhat.com>
In-Reply-To: <ahVeT9TTxlJiW2Qu@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 16:16:37 +0200
X-Gm-Features: AVHnY4K4DHuWauxa8YYdJ76QkCUHkIbYxi3sUWupwZ45vX9yRo8ZoO63RX-49Zk
Message-ID: <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254369-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CF725D7676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 10:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> On 05/18, Jann Horn wrote:
> >
> > Fix the easy cases where procfs currently calls ptrace_may_access() wit=
hout
> > exec_update_lock protection, where the fix is to simply add the extra l=
ock
> > or use mm_access():
>
> I thought about this too, but I do not know if it is fine performance wis=
e...
>
> And what about proc_coredump_filter_write() which doesn't use ptrace_may_=
access() ?

Yeah, this series doesn't fix everything, but I figured it would be
better to at least start fixing some of this stuff rather than leaving
this code as-is...

