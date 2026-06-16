Return-Path: <stable+bounces-263637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1vdAqsGMWobagUAu9opvQ
	(envelope-from <stable+bounces-263637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFED68D15A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:17:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=aefJsPGo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263637-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263637-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDEB304970E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF933318EE1;
	Tue, 16 Jun 2026 08:17:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9C3655F4;
	Tue, 16 Jun 2026 08:16:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597819; cv=none; b=r0/xb2sRCDjPDwQ3XCZZ1F8L2c+/Zm+ewoABW4Mqn2KK3u6dVNPOZJUMOiS871T+Px4eO6V5HlOuRaPuvAJHLcKWeMNRGmMfHb63UaZEfSqgZjBegJXR86JpodXiezBbuebfj6EFpJNksKl/ccxoYC8Kk6YwV6jKKEbvU43QOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597819; c=relaxed/simple;
	bh=qF4lbq48coGeLxO66I1Vw1XLaBAmpIRnv7yjWcLCKmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWTOGG8SWoDjMT+Q1KwzRl6NGDE3JOYc2ZHmO/VRkK+/AWFffrX23yvFieUS0rODMcREaLjGcwjtbwvjtm8z48YK8vjlJ0FpFZe6V02nWghqq59cH/JrAogH+K5i425oomxDnX/nMubmPilf99PlloYt9Sq+RCuOVj2aSqiwAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aefJsPGo; arc=none smtp.client-ip=85.9.206.169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781597804; x=1781857004;
	bh=58Uh4BmTYBSHk+XlpcizYHlof13uI2OQMFFLUYMY02s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aefJsPGosdUrk/8b7SEsNnsTkFYymeQaGMz+PV28zYbZIDZg5oTRiMR02FkH72b1t
	 4pffG42Fjr3jllCENEw0nRZpzrCrdLYGTTgD4jkIY/y9vch7UXevcMTZXdQxgD/ySv
	 yEXrY1fSz4AJl/JQ8jgK3e5Tk3+zwtBmwt8d41mmkkaLg9LjHynjlTS8nwQmpuzpyT
	 rg4tXby+nBjkwfPVvx3hfJpMIWgXKBOSdyrK/9iOpnoNFrC746vEAYwUhfVE5Qq5bW
	 xdjfuC77leAMOmIvQBTTGdJqKFTA5zgrdksPxrZjkq51qOtGxXVPS2/mZuFNR8y3Nu
	 TLcjWQ3+x3dsw==
Date: Tue, 16 Jun 2026 08:16:39 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Dan Carpenter <error27@gmail.com>, Mark Greer <mgreer@animalcreek.com>, Vaibhav Agarwal <vaibhav.sr@gmail.com>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, greybus-dev@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] greybus: audio: bound the topology section sizes against the fetched size
Message-ID: <20260616081635.169787-1-hexlabsecurity@proton.me>
In-Reply-To: <2026061643-crowbar-handgrip-620d@gregkh>
References: <20260616-b4-disp-4352e8b0-v1-1-3e09f62e0ad5@proton.me> <2026061643-crowbar-handgrip-620d@gregkh>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 084c8e8cd8c7820c2ed1ef584462455b8b1e9988
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,animalcreek.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-263637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:error27@gmail.com,m:mgreer@animalcreek.com,m:vaibhav.sr@gmail.com,m:johan@kernel.org,m:elder@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-staging@lists.linux.dev,m:greybus-dev@lists.linaro.org,m:stable@vger.kernel.org,m:vaibhavsr@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:dkim,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EFED68D15A

Hi Greg, and thanks Dan,

>> Are you sure these checks will not overflow?
> Yep.  The cast to u64 ensures that.

Right, and to close the other side of the comparison too: `size` is a u16 a=
nd
the function already does `if (size < sizeof(*topo)) return -ENODATA;` abov=
e
this point, so `size - sizeof(*topo)` cannot underflow either. The left sid=
e is
the (u64) sum of four u32s (max ~2^34), so neither side wraps. The form
`sizeof(*topo) + sum > size` is exactly equivalent if it reads more clearly=
.

> But we trust the hardware to send us proper data, right?  If we don't tru=
st
> modules, then there are lots of other places stuff like this needs to be
> fixed, how many data paths did you audit?

I audited the four size_* fields that gbaudio_tplg_parse_data() turns into
section offsets -- those are the only module-supplied values that feed dire=
ctly
into unchecked pointer arithmetic (control/widget/route_offset are dai_offs=
et
plus those le32s, then dereferenced as structs). I am not claiming a broade=
r
greybus or topology-parser audit; that is welcome but separate.

It is less "modules are malicious" than "a malformed or buggy module respon=
se
should not walk the parser off a slab object" -- the same
untrusted-length-to-offset shape already hardened for USB/HID/BT descriptor=
s.
If you would rather treat module data as trusted and drop the stable tag, t=
hat
is your call; I would keep the bound regardless, since it is one branch and=
 the
offsets are otherwise completely unchecked.

> How did you find/fix this?  You need to list what tools helped you...

I do not have real greybus audio hardware, so I simulated the module side a=
nd
drove the negative case directly: a topology whose fetched `size` is small =
but
whose size_* fields are large -- exactly the invariant this patch enforces.
With that I reproduced the read two ways:

  - in-kernel under KASAN (7.1.0-rc5): slab-out-of-bounds 4 bytes past a
    kmalloc-64 object; the patched arm (-EINVAL) and an in-bounds arm are c=
lean;
  - a userspace AddressSanitizer model of the process_header() offset walk,
    both -m32 and -m64.

Tools: a static read of the audio_gb.c -> audio_topology.c data flow, a lit=
mus
greybus module under KASAN in a VM, and the userspace ASan harness. The
verifiable artifact is the KASAN splat (trimmed under the --- in the origin=
al
posting; full log on request).

Thanks,
Bryam


