Return-Path: <stable+bounces-254049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHdMFspTE2qB+gYAu9opvQ
	(envelope-from <stable+bounces-254049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 21:38:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2435C3C98
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 21:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4079A3004257
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904C30FF36;
	Sun, 24 May 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ETUP3pLB"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D23126B2
	for <stable@vger.kernel.org>; Sun, 24 May 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651464; cv=none; b=SgUu5scydJlRW9TeMORWGVZT0U4osLgWGCB8C1m/kX71TKHNYYVy0dO4wyWHJhQj0tai5bqiMgQgR3Et9m0mtjzVLBM5tLP2QX9wSuCWtBJzG0GInv+XPIDrB7XaVxH62y0Z/dtsWenCVC3bHy3Ce+n+Dzk90+sct4Xn/AYyiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651464; c=relaxed/simple;
	bh=nh9N1mVHaeTmIBzbeAuRS13fF+gBjhcjJIgjg74tg1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II4+SQCKc9cHbXMfv1O9NYGW3KeZ/AFxUOsBmJAmpzQzqbTzb74HvnB/fslba5fRw6uhmVPTXjntEerhImY98+KVvMKXoLuexNo55azNNDtt/O2LAa5rDQj6potvLF1COJ/L7d7YhyAXu47In0Jnqde3uOv8eD6a4v5Ml1rguCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ETUP3pLB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7296B40E01B5;
	Sun, 24 May 2026 19:37:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xvh5XFpGmKy5; Sun, 24 May 2026 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1779651448; bh=fxgEs6EFFrixRBpE9oQQIAnmN8UezPCFryJH52eTrBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETUP3pLBssVbmvtRY2YFmgUATFBBHKix/p9hotmgr2CnFY0ztMqV/pYiWVZm3MyQ3
	 StJE571E41AU79GkBm35TGqC95hvKynO/EaZS3dITNWLq/RrANGPUNQ8U9RLPXZU/K
	 tCMjkiHqwK6TxVoy4Nzj1SgxrZ9CohTqpHamVem8Ikilf7i6jFuC6Zr2orU49tAfWB
	 sFNL9uGWD7/QzK9QKZOvLKkOyr82V6dGEC4ldk1NcSzO/+8BerH3W+mXTYOzDbdOHk
	 mpFY403BAuJScWSyF0fvgvl4NU+VyhiG89e3pW7+4cOcn1Ec4TcJEDXTz1qtKU+vkR
	 BxqUd2pu3eX8/KByL0c7wrrLYMRb9XiDSlGjCzHXEEr74Up676LjkOw+y8C1ooFE5V
	 mQvFnm2QAP2Hy4M1fizISSfLDUZWT1SnZbgRmJcoVcrIRLBO1vOcUbcgG+dI9nYZMt
	 MABs0RTaps0AIgOv7HEWGEGRieCqdMCn6HQuGdLBgxbf2n5JCR1RQwcx/KLvPcivGj
	 trP+L9iYg9UUXmqd9ZGYUqmdEQoN5KGXJXBWhoOpW/hw72E9ICd8TdUWeNw+xZqMG2
	 /nrJmNlfkUFyDYNc/Z/0vpEmhRSS2ZivM5FZcd81IhME5b5TG/2Vqffe5glyrDn9F7
	 rSuUW6O+xAvSHMzUEwHSOHzE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00:b8a3:f58e:8829:9ca6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECD7E40E015A;
	Sun, 24 May 2026 19:37:22 +0000 (UTC)
Date: Sun, 24 May 2026 12:37:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Uros Bizjak <ubizjak@gmail.com>,
	Jan Ingvoldstad <frettled@gmail.com>, stable@vger.kernel.org
Subject: Re: Linux 5.15 bug in vdso_read_cpunode() in segment.h introduced in
 2025, commit ac9c408ed19d535289ca59200dd6a44a6a2d6036
Message-ID: <20260524193714.GAahNTaoD92atkAUdQ@fat_crate.local>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com>
 <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com>
 <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de>
 <F51A475F-F50A-4DE2-A098-871047496301@alien8.de>
 <2026052230-obtrusive-prowler-86c2@gregkh>
 <20260524020311.GCahJcXxBMmgUUaWNv@fat_crate.local>
 <20260524150046.agent5-0001@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260524150046.agent5-0001@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE2435C3C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 11:24:15AM -0400, Sasha Levin wrote:
> > So please revert it from 5.15 - we don't really need to backport it to
> > stable.
> 
> Reverted from 5.15 and 5.10 (the two trees where the older binutils
> RDPID-mnemonic concern applies). Leaving the patch in 6.1/6.6/6.12 for now
> since you only flagged a build break on 5.15; let me know if you'd like it
> pulled from the newer trees as well.

Well, it is not really stable material at all as it doesn't fix anything
out of the stable rules doc. I probably should've killed the stable tag when
applying...

Also, 

  118c40b7b503 ("kbuild: require gcc-8 and binutils-2.30")

which raised the minimum binutils to 2.30 which supports the RDPID mnemonic,
came into 6.15ish so I guess the 6.x ones should be affected too. I don't have
the toolchain to test tho. If you do, you could run it with an older < 2.30
binutils to confirm.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

