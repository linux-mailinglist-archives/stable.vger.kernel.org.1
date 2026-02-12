Return-Path: <stable+bounces-216003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIBCLa1mjmk3CAEAu9opvQ
	(envelope-from <stable+bounces-216003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:47:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C6131D01
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5804C3010779
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937E2DC792;
	Thu, 12 Feb 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KiJh4ihL"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6F1DE4EF;
	Thu, 12 Feb 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940070; cv=none; b=hUH6hVCCogsQxnudTasFw7uArrfntk7qmTdZ5Z0cztVwUPPP81cFl3pNAmmwbSTfJVTp8br6WZr7sn+V9D0zsEhgmmVMTz+QPZ6RToILSO2LEEvUs1z/+lTPHfVOqGSTIY7LxStyztrYrt2nBMLOPhvE0sci8wR7HoFgzXnO8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940070; c=relaxed/simple;
	bh=JQ4QFdI7vFACFPvG4h0FBVdmNClm0UGbesKFYGg1Jro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A77/rfx6s8uUBGslp8gVDBdt600zOjjyzvFSdXFaos+S01m+zkoOVFTv5ZF1v/slmfRnoYN8GQk0RwXqV4gtl7zLYt5Q7BVfWP+ElVnQV/zUTGP1OeZBBwScuW6wnQV2QB+iNLW9o1zGHslYV6fxtKsFGz8MepENp9iE9uBPowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KiJh4ihL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79BF640E02D3;
	Thu, 12 Feb 2026 23:47:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6lbKNNZijb7d; Thu, 12 Feb 2026 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770940061; bh=TnKrPtjgOPWvMHqJ/ETndzIsZugTM6VpVVhv5Fg5+yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiJh4ihL4FIejxogzM1SUlY3igcQ4Lty7zvtr76pb43RkCfY/O3el0M9gYGOWy7oy
	 eGRGTMqOJi2iAX8HE37shli7+6d+EUD7HwxJ25npbkcK3HiPADJLczj+ltL7KdMJiJ
	 X3oD+un6uHvUAAhptSvMxQrRrX9FsmMEC5dEmq1YqGXLK2KrDT1xAU/FN7wX/0Nvmw
	 wwENSdM9PUs98fv8T2R52O21TT8i3NfoVsWpZf7nIxTrR+M6rnGPMOIbMnujZ0Zgb6
	 Uoh6cK/cy5NSiJyCZAzn2EF6AVn5XtE8/UOsXSmxrP/gPrpCDBJnwe/4FfHT1UPEt+
	 7pzTeoM+67FBAjx8QA/fFzm0JK79TpVRrR+TkHbVAg8vx/CyyR8qBfTT802mXJZRS+
	 4iIXJYUMXeNUfyvyqimDYRs34Lj99ouE48OoiTi0A55mUEnCwNMvUXM5AlzD8R3Pzk
	 Z8/LUHldO7IKKUwdB5WwODzMWAg5hExTaumE5PaP7P2A+BhLDD5cUvAFuVrgbj0p3t
	 yTr/ZmJ575kX8oqMLk9u6UaIBrztLnQdByfjaDMVgQkuXPSnMm9SuNpBnIITbqAcm4
	 DEWU5N8POWeisZs94FkTRuYRjKCCC9cKwzQLMt7ZcDB9il78ivGAt14BNG4E/6NyxC
	 4DDIbfgd6vU/ZcaqZykt4WGY=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 134A140E01AC;
	Thu, 12 Feb 2026 23:47:29 +0000 (UTC)
Date: Fri, 13 Feb 2026 00:47:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, pawel.chmielewski@linux.intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Message-ID: <20260212234722.GFaY5mimfap5YbOi30@fat_crate.local>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
 <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
 <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
 <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
 <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
 <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216003-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: D82C6131D01
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 03:04:44PM -0800, Sohil Mehta wrote:
> Can we just deprecate the "Flags" bits of /proc/cpuinfo at this point?
> 
> No production software can be using this meaningfully.

Before you do, grep glibc sources.

> We have always said that the *absence* of the feature doesn't mean anything.
> The feature could be disabled or the kernel doesn't know about it.
> 
> And now we've realized that the *presence* of the feature in /proc/cpuinfo
> doesn't mean anything either.

How so? The presence means, the kernel has enabled it. See
Documentation/arch/x86/cpuinfo.rst

> Should we come up with a more thought-out mechanism for user space
> feature detection?

No, because it'll be the same crap as what we have now.

This one works ok-ish.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

