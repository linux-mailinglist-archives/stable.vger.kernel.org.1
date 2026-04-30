Return-Path: <stable+bounces-241963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHI9JUai8mm3tAEAu9opvQ
	(envelope-from <stable+bounces-241963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE649BBC5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE07D30091D6
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97AE573;
	Thu, 30 Apr 2026 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtyXF0+2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9E40DFC1
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508929; cv=pass; b=TTHY7VbPEQte07LdNSQBxh9vMX/gqGEfWJPyVKfr80FV1djQU6onE1Cuh7WC9T0bzZ4yUQY42cHI7OcIqon3f+czvKft5zQzPBqWhq7DXKy/p8DVQSNr9LsAFknjsIxREX4wE3OKfoVAmSCIRsKoBwux7rS/L0weKlZbMGGdA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508929; c=relaxed/simple;
	bh=2ftKwyQUTO10w0p4XlLTgNdZkLtUGTvLoPBlLI1YUsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCyRH6JTXUZXnYiVKOq4n/8AaG0gzqHTBXrFLPWoiTl5HsahIDPYwe+2aOJSj1x1tqN6Av6GjUTgXvcyMEIiyglRoh03STkYhmN8y6jlePdYrhA1jjUZGjs1Xl9sXvP0Uo0FDKokriRDsrTRvbNY2C2vp/8uRybbpCIDtjzxf/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtyXF0+2; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4303eb92930so263757fac.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 17:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777508927; cv=none;
        d=google.com; s=arc-20240605;
        b=Bi8BbD+PSiGqeLWU2KIJ844zAI5m6a8KPLJe9zfy03jZ0qBcLfKl/+Zv5iBaW0MGve
         6dOPPPQdTOy7x89eezbos0K0/Wylj85qrdRJSROb6H8kDmBihgAC8MrDi6e6MJYx7udK
         1AFTJKdgzZaRNriFuCyZ26YDHJ1R7TX1qSe4d5jntVJ3UiV4li9k9IeE+ok1F9iH3vto
         0H7vWJSQL6/rFsYQG5wao8Qs488vzmGQ9i4xUzH5f7kyY0GsmhQbMCd4WXJDVUPzyJJ8
         XPpbvDPmJn8VB917zV9IFVHDap6f5xr6JYunV9Cmdmzcb3nGyHbUn+fH10zZQ92IJQlq
         uAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JH3hr11S4P5ZvOMMt7/qOE1BZfjmtAau6k7ZWMhb4fA=;
        fh=BnvOKKRQ3+j/v7xZIvioDhz44UxM87Yiye2sSVwqKxk=;
        b=A9uVB2QkEZKRfdzFnA+90vqIlwbs2F8pk+doqQcZkwd4GpPfzNFWffrcsPA8izLm/E
         GsG3dN5aH9wCZt02LCpIjxEhHz6uWO2fmZI4iX9KqtpVyzlOvleB+tHbA9Z33wv96DxS
         hvHbbYfBqEuc/TU4acAMdj5Rr4LqrlpSK/tE1b3S0SJ5Pbljaxts1B1XQuRJlNGbDn6Z
         u5NZDAcOmHG/hlYyYrNHnOTuoMsVhO8HQTPghGr/UijRyQWa/H5OaCcyIRJtb1u8VvOW
         FgHOMLR1QMHkjaQ21YpvAKgkyRi59G+wQ6uYnfjh2nxBvEjHcbf3DSOUN4WYxP0IpxdO
         jWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777508927; x=1778113727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH3hr11S4P5ZvOMMt7/qOE1BZfjmtAau6k7ZWMhb4fA=;
        b=KtyXF0+2bb9tcflg5QB7h10DRqFtOSVWIvKaWxRFzc9f+R0veIdlkrO4qCvi5s1JeV
         I6smVYkdMnVIeArvX0bSOef6MQ48W4w0sSjKwPBAfJfB18xoTFmWlh/zpAJAtXtajZEX
         8YOP47RalMVs0FKPKjBymK/XI5/A4wyyC/8tdlX54IAJ58OtfZUdtNrXUNFovO0172S7
         f6L61bxha9WAXXrSV21IQwFszmZYlWbjczUpYeGT0w3WmpkpbrqYC2y2yjMT3PE0xfFy
         tTwEbgMWD1wGDQzbon3RQcLam9vQ20lIayFwePM/QxCFCbaALjoGpxP7j95Ep/qzjxPz
         jnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508927; x=1778113727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JH3hr11S4P5ZvOMMt7/qOE1BZfjmtAau6k7ZWMhb4fA=;
        b=RszmiLmYnf7EV2SxDDapjp8yr1ZrN3EeoLvEZCKo0/8Ll/5mDrhaWZ749OpbcxRdbo
         jcnr/I61HElW87BfUafFsHs+Page3PBoiPkEqNwdg0Ye8uYFXfl+AQivBvJ0yPYyIBRs
         A9CYXhDZ3VnGuqByBh22e1BtDItVt1V49xm3UlL/6E1P6q/IOXykz2NvJlBppikFMoIP
         9xvveGgMLUEBMYxLGP14kTL6akVAErh3R7z/0ijNecvbDN35D/Np+1uri3XzpQK1qoZr
         omnNIothRhlhX9/PQ26vAwqe5jGTReJsmN8DKJZXFMB0oJFXpn73YHJLFICzMPd5C+J4
         h2sw==
X-Forwarded-Encrypted: i=1; AFNElJ/emqb60Ox7IKSR5KUwsohhoOi4ZTGwWlzs52loN5uRPJ4Bz3dZzBhNvhYVLvYhPCO4u8WmUj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYjp5ihhBHYWrvgqoicHjFKEElU9nDIsc4W0az0ENiyqmFRVk
	SiUfUGEuFpNhPhV4og4hb1RUFKKLsIGYgglsjfWGpgISO1Xx4u6XeSQde1hyXcYmqk9W86b1yMs
	Ue5XL5B3nFIRJCi9uhsi64sfR9cmU4U4=
X-Gm-Gg: AeBDietX6J2LelZbtMq60iSDGbgX6iePLuSp1HJVgRSEKqhb9UvleQKeu19lEpj6/Bx
	5amSEGQ9MCyfIP3MsTzyAFY3Q3N0oUcpKOEg3iganRhkXmV2+RPtI95H3kY9JEi4x7eSGqduuRU
	pUg7mI+ogbVUfQpy8oHR7KQEUXGsPAguPCEuKweYaG1cbXIBWe3o89EDqqoLsEzwn38EtSWi474
	/g7PZS+44mUpPK85yz7WxrwxJMTIZCuK/tmS+89J8DW4O6UR/sHHeSH6iFyY6DWZyJgpvzv7Jfh
	w0SOaRmgbWOoiVRu4A==
X-Received: by 2002:a05:6870:3182:b0:42f:cdab:1a71 with SMTP id
 586e51a60fabf-43437e12c29mr245278fac.15.1777508926773; Wed, 29 Apr 2026
 17:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com>
 <3ef742fe-9761-4714-84d9-e72fabc5def1@intel.com> <CANaxB-y4wh3JYUctDMWVuuOz9ZhVH9RAwopPZQ39JfmxkjN56g@mail.gmail.com>
 <a1614b76-192f-41b3-a4e9-a4ce6816d745@intel.com>
In-Reply-To: <a1614b76-192f-41b3-a4e9-a4ce6816d745@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 29 Apr 2026 17:28:35 -0700
X-Gm-Features: AVHnY4LFNLnNTRp-9JNIjCeO2LcOT82LxI878kawXd-pRTDtl8nGbrVMJdKdNAM
Message-ID: <CANaxB-zRCvdEQ1K1dMbC0MpqQ=16kpnD-ds9jStV-OGUpnb_og@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9DFE649BBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 2:44=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> On 4/29/2026 1:44 PM, Andrei Vagin wrote:
> >
> > Enforcing validation against 'fpstate->user_size' instead of the frame'=
s
> > own 'fx_sw->xstate_size' changes the kernel ABI, it isn't strengthen th=
e
> > sanity check logic. When user-space supplies a valid, self-consistent
> > frame with an explicit size that older kernels accepted, and the update=
d
> > logic rejects it, which triggers a userspace regression.
> Sorry, I don't get your version of ABI.
>
> Eventually, XRSTOR will execute to restore the state. The kernel tracks
> each task's requested feature bitmap (RFBM), which determines the size.
> As describe SDM Vol.1, Section 13.13:
>
>     An execution of an instruction in the XSAVE feature set may access
>     any byte of any state component on which that execution operates even
>     when saving a state component is omitted ...
>
> Given this, the kernel must ensure the backing memory is valid and
> sufficient. So this consistency does matter.


We need to add one more paragraph to have the full context:

    Each instruction in the XSAVE feature set operates on a set of
    XSAVE-managed state components. The specific set of components on
    which an instruction operates is determined by the values of XCR0,
    the IA32_XSS MSR, EDX:EAX, and (for XRSTOR and XRSTORS) the XSAVE
    header.

    Section 13.4 provides the details necessary to determine the
    location of each state component for any execution of an
    instruction in the XSAVE feature set.  An execution of an
    instruction in the XSAVE feature set may access any byte of any
    state component on which that execution operates even when saving
    a state component is omitted because it is in its initial
    configuration; when restoring a state component to its initial
    configuration; or when XFD is enabled for the state components
    (see Section 13.14).

I interpret this to mean that XRSTOR will not access memory for a component
if its corresponding bit is clear in the XSAVE header.

However, my point was not about the CPU specification, but about the
kernel ABI. The reverted change broke existing user-space applications
without justifying an ABI regression. Even if xrstor were to trigger a
fault, the kernel handles it properly, so there is no real issue there.

It feels like we are trying to justify the change after the fact. The
rule is: "we don't break user-space". As usual, there are no rules
without exceptions, but any exception should be explicitly analyzed
considering all side effects.  According to the commit message of the
reverted commit, that wasn't such case.

Thanks,
Andrei

