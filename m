Return-Path: <stable+bounces-223861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHjbLbf4r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:55:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27790249CB5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E10C8311B847
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380BA38228E;
	Tue, 10 Mar 2026 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KySi6nRh"
X-Original-To: stable@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F55372688
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139770; cv=none; b=U2p1EGP3FuWwp8pDb8uaAba+C5Bt/8v5wia0gUcI6SA2c7G4OrGZP+uAP4T5SGs7NZGOkemvgszUz4+8th1i1tKFN9Y3yRMkrE2NYp6UScQWKxE3VoamtytcJy9eFdqqP22XHcaTF2lg7iQeyIbaE6uCYx/2t7unzbGj1JEM3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139770; c=relaxed/simple;
	bh=08TrzIFxmzeqcAPsc5WsCF3Ee90GdElLb4u1JqTVVK8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxgRm1diEvI+1jnA2Jd1yeoiBHVYmRbjwc3sisS17YspPsfNZ8z/Ve6UerQaJfRarLDMJKt+qfrmNsn7CyRGFZfgslBErJzRVQNQnW8wx8q4YxFHNv0N0ZZSJWR7awykJTCIYHHra3j5fOFy2WXMvkA6ukdU4JgUlL73HFxfexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KySi6nRh; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1773139761; x=1773398961;
	bh=yQ5bjfcZu/ykCQ6/t0r3/b0J9YA6GcrHX58m3yxezI0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KySi6nRhaf7Rx5hSNf4MaxwUHpWvi728n3vVdVYST8Wg0zNLKC5YbzRDSGxHmJyid
	 pK9y20q2iDU0ZWlyEumsD81U0TuAxUZMIYeP/ml6bkwlKLqpVpvBcGDq58ljBVroUb
	 rJx2K5VeJyEYh0FVp0M/WLt85W69Pk6MM9XjM7F4+xoIaRRqxrIoR+QpvKfVzsSd5C
	 CILTUwYZTYN47Gy4sXUVr0wcDA7e54bsxhiVJG0gC+2vYVgAQ2qEwzB5z9g1LSEGMM
	 PIUmOh05PtyIUYNaPpFFVp8J0E0lc/Pl1nbSI2Cdw+AkgtEy+8E/e0wK8VRmQwAUK1
	 H34QxrQjdv1Mw==
Date: Tue, 10 Mar 2026 10:49:14 +0000
To: Sohil Mehta <sohil.mehta@intel.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <aa_1Bmc64hvAzvG-@wieczorr-mobl1.localdomain>
In-Reply-To: <eb26dda1-f0bf-498f-b4c6-874a6c2878e3@intel.com>
References: <cover.1772453012.git.m.wieczorretman@pm.me> <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me> <eb26dda1-f0bf-498f-b4c6-874a6c2878e3@intel.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 7a02a6c77cf386b8edf7af4dd4ae27006428b337
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27790249CB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223861-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pm.me:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wieczorr-mobl1.localdomain:mid]
X-Rspamd-Action: no action

On 2026-03-09 at 16:47:49 -0700, Sohil Mehta wrote:
>On 3/2/2026 7:25 AM, Maciej Wieczor-Retman wrote:
>
>>  /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
>> -__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned l=
ong));
>> +__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned l=
ong)) =3D
>> +=09DISABLED_MASK_INITIALIZER;
>
>IIUC, DISABLED_MASK_INITIALIZER only contains the X86_FEATURE_* bits.
>So, the NBUGINTS bits in cpu_caps_cleared[] are implicitly set to 0.
>
>Should that be mentioned in the comment above? It wasn't obvious to me
>when I first looked at it.

As I understand the features can be compile time disabled while bugs can't?=
 So
it wouldn't be practical to initialize the BUGS part of cpu_caps_cleared. B=
ut I
suppose it doesn't hurt to clarify it in the patch message.=20

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


