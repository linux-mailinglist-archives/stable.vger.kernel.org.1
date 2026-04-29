Return-Path: <stable+bounces-241941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tgAmEKpt8mnbrAEAu9opvQ
	(envelope-from <stable+bounces-241941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2A49A3AE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA47B301651A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EF3A0EA2;
	Wed, 29 Apr 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oApJUO4R"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D693A0B32
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495458; cv=pass; b=IMFOgvjPzUdbxeS9w96guNhfvBvlNg/YIAYHiHz4p80KZN60YSEioULsrRTc3ZUNNSTHIsCmp6ZbaXqFchGXJEo6WHm7HT5oV1ryLK2pWk1IbLoYpur9w86k64Q3jaXrr/Tq3fl+ZLhClyweP3ksg3kM8t8qJOjfiNCZaHxr+UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495458; c=relaxed/simple;
	bh=VbB/PQjV2VMjjZPPCf3g4o55QMUVw+CjzxaT5Nn2ydM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT7DiAByE7IgnHlakckoOTKsKeKbqUrXkj9y74o2u46kUc8lu7rEKUkiYle6ZcpTuNwMqw/ZXdu08PtGJ5RfKb59sLcZLjX5s275zoY6vRd+ztZLFU2imX4Pnqr39XVbovC4vnin3FM0usGBEUfoK52OCoB3HisAxAB/TCXAfKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oApJUO4R; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-694891f8f75so127755eaf.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777495456; cv=none;
        d=google.com; s=arc-20240605;
        b=ZvDOoIFaunnwovANyD47s6nw7n40mUnlMxLSndU1tPVBgOoa0mzsT/9kKNVxTEGiak
         Hs28KiG6OB6KRYMiOzOHCD0VJBYPdImfz6mxAt1ngQ41XyQaAcAxBT1dw/yKcvqyFWaH
         8vByGCDMYmXWNx3N7emCVXV9QAe43nZhqJSTOH1v34/wuS/DDwDaYynMiSIBUJgqD2LZ
         PQMRyf0xlknIOpkF+uabSppZuAjj+8pBmJQTipxQ2IIlnwZwdUf4nZ4pMLdOkacXBQ0Y
         tUMam8tKOOcv77PLxtJpJAUROjwPH0u1IZwTUl03Izzw5BwJFfsFc0bBnIotZY1Z0lUg
         TPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9aeA/eopOCnUB7UamQuZDfMloVS/6yAyPLA2mNR0Pcw=;
        fh=mqKN+N/8P4c18YEicKU1+sgHBsGN5M8U4yGOEU1exXw=;
        b=LRKjP6mihnAgwAYAs8eLJm23VPrTz4ldccHuZA0qyuSHOtg8kjDS47f636lteIVbfP
         c/1+grJv5l5Q/ryajVa/uRpw70PiPushU4+XRnsjbPbSAmrhZSajvYxwzUS/MUhraFGZ
         6Udj+whIiWoiv9eHZJQQOKo40eQO3dHZT6uFqXqC8FPUdM/5lSqtLR99CcvwsPKsNnW0
         Od7TWq4VwSOdC8Pwh2iO/gj4QWcc6nGmjlUG+ULupZWnvEw/2wSAogpJ1NF60b2WF69W
         n5/9k64gPCvzIPt6j0A22GKvJ3nvR37gr1Sm2eKpHcYQI8e7eupBcQztufYNvDpSiLml
         s90A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777495456; x=1778100256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aeA/eopOCnUB7UamQuZDfMloVS/6yAyPLA2mNR0Pcw=;
        b=oApJUO4Rqj1aBgXbehyyo+GFALmZKEzP24su+RZEDNbYiVvlCXEqJ+JQ3gDoMi6n0z
         BfDcU7NQp8Nh3T5Fds9Kl4lTDM/Ht3IlV42/8GU8ueRWSw7IcH3XGMCvoFGG9kD4xS+2
         yCVfKRwNu4pRmZfLapGXe+12UEXt56ph78nwfYOY4iv7BXFPOg5AE5jimNBKrZL00ueh
         1GC6HU+UGPRpeE8e7+qZhuc1X8CArX/NNKcDB3fbgaXhTCxTrBxupiOtEDuIT1AEGnPs
         neFu+iR15RkrBuW/4QMvDZ+F29Ty6VUFRjWyhyXo/izo5/UEh0CtDPXhvTo/ykc08/z5
         nWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495456; x=1778100256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9aeA/eopOCnUB7UamQuZDfMloVS/6yAyPLA2mNR0Pcw=;
        b=qyPBkclJByQp+FI1r27wtR9ZUx3WLyhDnKpRDLOg1ydGYSnkRi3CfqhSD0CquFxSZJ
         RjQuX4PHgTeupJUkiMPh2tpodWSOgZJ+AOQ56F5tQ60NbHo04laVi1ScviwxIIqiXILp
         uonidHaQpBZ798oDwCDIv5gsr/Pnyfh7zaH/0nyw2wMcm9Rq6MPmVx+KPGQD75Fi3nz/
         bWh4eg/kfWcuKEB3XBLAiDBoxN04fb0eLzZDWA5DrJKBoXXpH0+bulE42/yjRQYOXrbq
         kxOE7aFj/2u1j48Laq2ZbYhwfoGSRIeXP//GeGI0plGF5NiAIpTUcj6NplglTyey8Q9D
         DOwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FxNPGuE0iws4vmtjVzrCpyhvRb+J9OrZovAwaOXih00TqM0tkKcgmOW52JGuuEaGCnf7nvU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyunMjld/eXEB8g5Nt6d+OWZ+PZ1wMa2yN7U7WxnY5foI+UMY2h
	zcNcL8C0zbActcPJ47Zoflej9sPX6S+jB67m/E2eZoqtQ/4Sg7B+DkMIG//qIdJRdVYwcMdA/ma
	wKbPFK0qI/NYx/Qabn/MQcUlj48bAVV0=
X-Gm-Gg: AeBDievQqgQc1+aoU/O1GR47p5ZB+FQGHZXopTC1F0rkQG7UYl6VmnjlzQuF0Cyr/r1
	PA8YDBmi2mvKEfBXZ5Az/6tDGjjB3HDh3xACMsGFyMRXdFS3cKaNQfGLUKTX3RPSgwTqt7Yo0lW
	ZGniA4/9Ce/WOw3AIPWke/5qLNk25vF8HB11Ppf2jrg1Ek4ULBF4PHYYwZX1UAbWIb8EXLWjJCw
	UqGBoYCadg6mHzpf770hC2WmAHw5Yy9qAC/px1MJAE7LFXU8tJk0VWkpT9Ak9F3DJpkCl2wgE5P
	i8gqQvO0UDpqGGipz4BH09mXU7/MFm7sfD+dS+xU7+4oy+BT
X-Received: by 2002:a05:6820:1628:b0:696:4874:2dc6 with SMTP id
 006d021491bc7-6967a64b074mr104266eaf.49.1777495456001; Wed, 29 Apr 2026
 13:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com> <3ef742fe-9761-4714-84d9-e72fabc5def1@intel.com>
In-Reply-To: <3ef742fe-9761-4714-84d9-e72fabc5def1@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 29 Apr 2026 13:44:04 -0700
X-Gm-Features: AVHnY4KX4EQR6NGsayPvCJeSGbauqVhInymNGT28RO2cooz4r5vzRVt9RAG1r80
Message-ID: <CANaxB-y4wh3JYUctDMWVuuOz9ZhVH9RAwopPZQ39JfmxkjN56g@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7FF2A49A3AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241941-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]

On Wed, Apr 29, 2026 at 10:15=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> On 4/29/2026 9:44 AM, Andrei Vagin wrote:
> >
> > First of all, the reverted change broke backward compatibility for
> > user-space.
>
> The ABI itself is still intact. Do you mean that the kernel cannot
> strengthen its sanity check logic? The change does not alter the ABI,
> but enforces stricter validation of the existing format.

Enforcing validation against 'fpstate->user_size' instead of the frame's
own 'fx_sw->xstate_size' changes the kernel ABI, it isn't strengthen the
sanity check logic. When user-space supplies a valid, self-consistent
frame with an explicit size that older kernels accepted, and the updated
logic rejects it, which triggers a userspace regression.

CRIU and gVisor breakages are not related to migration from one host to
another. In both cases, they were broken even when running on the same
host. Migration between different CPUs is a separate issue. In both
cases, the code that constructs signal frames has existed for many years
and has worked without any problem before this change.

>
> > As for layout compatibility, in most cases CPU A (older) and CPU B
> > (newer) have compatible XSAVE layouts in terms of saving states on A
> > and restoring them on B. CPU B may feature new extended hardware
> > states, but the layout for previously supported components remains
> > the same.
> I don't think this assumption holds. For example, with APX, the state is
> placed at the offset previously used by MPX. So the layout is not
> strictly append-only, and offsets are not guaranteed to remain stable
> across different CPU generations.

Regarding layout variations (like APX vs MPX), migration tools already
track XSAVE capabilities and offsets. Furthermore, APX has its own
dedicated bit in the 'xfeatures' field of the xstate_header.  If
platforms present conflicting layouts or incompatible extensions, CRIU
cancels restoration.

The issue with checking against 'user_size' is that it disrupts
migration even between compatible systems. If offsets match
but the destination cpu has more features (leading to a larger
'user_size'), validation fails...

>
> > Even if CRIU were somehow able to locate these frames, extending
> > them would be impossible. The target application stack is not
> > under our control, and other user stack data or local variables
> > reside immediately after the frame.
> I=E2=80=99m confused by this point. If the frame cannot be adjusted, in t=
he
> first place, how does migration work across systems with differing
> feature sets?

Cross-host migration only works reliably between compatible systems.  It
works when both hosts share identical feature sets, or in a one-way
direction when the target host supports all features of the source host
and their XSAVE layouts are compatible. In this context, `compatible`
means fpu states saved on the source hosts are restorable on the
destination host.

If processes are checkpointed at safe, predefined points where they are
not executing signal handlers, target host requirements can be more
flexible. Here, I need to mention when CRIU constructs signal frames
from userspace. In the final step, after all file descriptors and memory
mappings are restored, it invokes sigreturn with a pre-constructed
signal frame to restore registers and resume the fully restored process.
Since CRIU constructs these frames, it can adjust the XSAVE layout if
required. We currently do not do this because we have not yet seen
scenarios where it would be required.

> on one machine cannot be expected to run unmodified on an random machine
> with a different XSTATE set. Some form of translation is inevitable for
> any cross-machine restore mechanism.

As I mentioned, migration tools have logic to determine where a
specific workload can be migrated. Because we cannot always control the
exact execution point at which a process is stopped, state translation
is not always feasible. For instance, an active signal frame on a
process stack can be entirely outside our control.  However, we can
reliably find out compatible target systems where the workload can be
resumed safely.

Thanks,
Andrei

