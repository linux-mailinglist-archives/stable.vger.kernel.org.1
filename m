Return-Path: <stable+bounces-128416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB0A7CD87
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D8B188C2FA
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6519EED3;
	Sun,  6 Apr 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZTI0L/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouZORyKF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72142BB15;
	Sun,  6 Apr 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743934119; cv=none; b=INnakCvLk7Vy5IjasR6RDZzdcQmpd8FKKmwYHypQap4gdkxWfnWWx33drN0ZVVt2DVHgY0C7TnlnjI4ad4S4GlGwJYy2SJ7779uOPT6qJHkSk+rqoBegg9wzAO6vLylggL6rl/2hALUYXWvU4I0F+C6Oj+RZQtAy2Z24tN7nz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743934119; c=relaxed/simple;
	bh=FAk68485K3iO3UVVWI2skQ7S5XAtPGQmk/zpOA4Zzck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYBVMeT9EzwzPCxedj2miiTcYQoT5MdAC1l2EadnHOUkmhZrY1whxPZlIv/8Vvn1AncEHo5pmY6yFrWvr3lzLGeUjz0txx3Fp5XNERbLRIFjN9BCZWIPAXH+amexwXGhQXQzHNcYZmMODQCdmitqFkFnxjx1292ts8UL3SSk2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZTI0L/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouZORyKF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743934110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQwCOy6q9LbJSv6h6iboKgyxHq/ApOr5eANcz1PszCU=;
	b=HZTI0L/3ifr8QVkdVDKgPuI906FSs7jsQXMp9Z8dqGyBz3NGgdsfamkpZMO1u5ptlkr+/9
	mPHGBMxNWmNRZ6zG977pJESL979B/9kkKcD05Kf65bnhVgCszr9L8uyVDIvZ9b/st1BAYR
	rEZhUXcB63UhO6MZsAIoZEG7Cd8jZclYPkcTHPobjoa3JBDD15k4h6TqaQbEcoMO27yrAf
	swMdEx++R9P3hTSu0BX2iwiCZgLcVlhos7Fs7QIduq143ICSwA5UUItneKm1nvLwaE/Cxv
	kwnNQ15PBEJZUQU/PZvP/xpzFuXyA6MNGG6B5VFiXEbEGvRG5IDr9kgljkz/BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743934110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQwCOy6q9LbJSv6h6iboKgyxHq/ApOr5eANcz1PszCU=;
	b=ouZORyKF32pmlPw1hKPc5hYgNHbzy8az9DUAOueIpumwnXA1yOx3iFZeAyElhtXDe5qEv+
	kn3D3zuGtTWVPTAQ==
To: Petr =?utf-8?Q?Van=C4=9Bk?= <arkamar@atlas.cz>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, xen-devel@lists.xenproject.org, Petr =?utf-8?Q?Van?=
 =?utf-8?Q?=C4=9Bk?=
 <arkamar@atlas.cz>, stable@vger.kernel.org, Juergen Gross
 <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 1/1] x86/cpu/topology: Don't limit CPUs to 1 for Xen PV
 guests due to disabled APIC
In-Reply-To: <20250405181650.22827-2-arkamar@atlas.cz>
References: <20250405181650.22827-1-arkamar@atlas.cz>
 <20250405181650.22827-2-arkamar@atlas.cz>
Date: Sun, 06 Apr 2025 12:08:29 +0200
Message-ID: <87ecy5wqjm.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05 2025 at 20:16, Petr Van=C4=9Bk wrote:

> Xen PV guests in DomU have APIC disabled by design, which causes
> topology_apply_cmdline_limits_early() to limit the number of possible
> CPUs to 1, regardless of the configured number of vCPUs.

PV guests have a APIC emulation and there is no code which actually
disables the APIC by design unconditionally. There is one way though,
which disables the APIC indirectly.

xen_arch_setup() disables ACPI, which in turn causes acpi_mps_check() to
return 1, which disables the APIC. This only happens when the kernel
configuration has:

     CONFIG_X86_MPPARSE=3Dn
     CONFIG_ACPI=3Dy

If you enable MPPARSE the problem goes away, no?

> +	/* 'maxcpus=3D0' 'nosmp' 'nolapic'
> +	 *
> +	 * The apic_is_disabled check is ignored for Xen PV domains because Xen
> +	 * disables ACPI in unprivileged PV DomU guests, which would otherwise =
limit
> +	 * CPUs to 1, even if multiple vCPUs were configured.

This is the wrong place as it invalidates the effect of 'nolapic' on the
kernel command line for XEN PV.

You actually explain in the comment that XEN disables ACPI, so why are
you slapping this xen check into this code instead of doing the obvious
and prevent acpi_mps_check() to cause havoc?

Thanks,

        tglx

