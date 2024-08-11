Return-Path: <stable+bounces-66346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887A94E064
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 09:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0661B2819D7
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF21CAAF;
	Sun, 11 Aug 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qf271PSC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyEd0ejd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249B1CA81;
	Sun, 11 Aug 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723362651; cv=none; b=TSEaCmGDNt45Ba0Kie0VQo++2HZyHjKV4jC6YeFnA7R1/dzcF84OI6AWHjIFTSOTAMKNWbSlnqG/a3mBXyGjM3RgKxXHIamMDx5c0oYnKovY6z1g8Gg6QhdAKdqjmRFHWND4PDUk6+6DdYt/eNwX4J50jd7TSMepW+CzNoSvyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723362651; c=relaxed/simple;
	bh=zZcHqXrELtLbbj7H/H6KvkmieMbYWctu+Uv/AELvA8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNsqtaXvnrUbmeYC+hyg6k0rKc0b5iGwRSAyjqtxrLkk1eo2f8tAk3aRUyVDKiEFdjpe9MvBgaphwUYwchb5xmVauZO6sqyb2As+JWbvNjjLe+Md1QqR+b4u8t5xpwNTXwhAhp6Jac7Q2K3J2j62LQhjOisUM1yOEyegE2HH43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qf271PSC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyEd0ejd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723362647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCrKuXHC/HcHHhOGOekScgbdB+nT1TZUTQJB7uSWdq0=;
	b=qf271PSCWxIgJNdSe74jmpqE5JdSHUnvFVbauADCnDxcKLZw+hfpIbKNr1954i7MCotkRX
	EdUcHGh++g6CPT5xOA25EwZmzxdW07SZiMMglzvSSv69Bsy1wg4Hg9Ai6CgccpitXYcT66
	KGI1i18L7LQjtSIGD7EhFF8IhbmzsgV0gA4utjrfCO4Cu3XZaaoTZVMdTXMbkcX2emQxVW
	jW1BzK+/MqIldkcjT6R5ix4W2ZiUDXMvCBMv8cev16miQsN76cM0ELArpykYfaetxbJ9l9
	KpsGJUbaWdNm5DHmtXYeaMEydUv2YfrUtFi4LAMw4+J3veewxXD+Ks7OZj/ugw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723362647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCrKuXHC/HcHHhOGOekScgbdB+nT1TZUTQJB7uSWdq0=;
	b=iyEd0ejd5H6N/DdFyvOf70nSuI2GwywRGFytraOr4hWGwG9Z/14FyHuuOFzaopNgqp/0Rg
	hZbLy79TdYnpPHDg==
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, stable@vger.kernel.org, Borislav Petkov
 <bp@suse.de>, linux-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
In-Reply-To: <66b80624.050a0220.39b486.4736@mx.google.com>
References: <20240809-xsave-lbr-fix-v2-1-04296b387380@gmail.com>
 <87ttfsrn6l.ffs@tglx> <66b80624.050a0220.39b486.4736@mx.google.com>
Date: Sun, 11 Aug 2024 09:50:46 +0200
Message-ID: <87r0avsdk9.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 10 2024 at 17:30, Mitchell Levy wrote:
> On Sun, Aug 11, 2024 at 01:08:18AM +0200, Thomas Gleixner wrote:
>> May I ask you to read Documentation/process/ ?
> Yes, I have now more thoroughly covered these docs. On second look, it
> appears there's no Signed-off-by in your reply to my v1. I can send the
> patch with you properly listed as the author and the proper
> Signed-off-by lines if I have your permission to add your signoff.
> Alternatively, feel free to reuse part/all of my commit message if you'd
> rather submit the patch directly; it's quite understandable if you feel
> unenthusiastic about me being involved with code you've authored.

Don't worry. Just add: Suggested-by: Thomas Gleixner <tglx@linutronix.de>

and be done with it.

Thanks,

        tglx

