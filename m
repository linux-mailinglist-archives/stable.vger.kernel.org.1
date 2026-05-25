Return-Path: <stable+bounces-254105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AanCPwFFGpKJAcAu9opvQ
	(envelope-from <stable+bounces-254105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:19:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B105C795F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C5233012304
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C726D4E5;
	Mon, 25 May 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwlIToct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398C329E5A
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697140; cv=none; b=iSjCUx/5xjnm22Z8pyJhJ5vl3A2pqk+cm30lupVM86tA1FzFLPixY3cljveawNXz7P+Aw6Udc7c5BxHb9Clr/Mapo63Y9FBpBCAkJLRd9dH10GYv25eI+2OE126dCiEs01UmTaLFFvI72UVOU+7HxZWleF9xSFxsuxQucPkibGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697140; c=relaxed/simple;
	bh=jlAGElbDSwYe7W4fp2ll8Crxv83yKatGQRMqBajZFqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj4MD3B1qrnSk2KIbs7d9CMQKOOggSesamNPWSZYcgs/l5AhpUwnj+29ForED6X89fLG/B4i22Rhi8lQOuVGL8PA6ntM4H+CLTXTyg2MWflJglAoCNJDOwTmcydAvmjrjGYczTJUSuR6X1UjRo/F3obaqZgyYD5f5SVNT4AISOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwlIToct; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AFC1F00ADF
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779697139;
	bh=jlAGElbDSwYe7W4fp2ll8Crxv83yKatGQRMqBajZFqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hwlIToctPXfIR8I3xZlJ13Dv4JVXLxahZ1KqVhToxy7LlLg/ZxSDracBNqedJpogD
	 CZrr2XBw/H9RQK79gntcxg5ju3k/468DHEhk8jA8eE26pWbIpGtwVKXHZsBYLRpeRm
	 /t6xx0PsnVd76G5RqOax3sDUFqGlmG/vGBbcP/oozPwbV8RTF5v9eg6o9PiR1MjIrO
	 EF47kpoL4Uvpc6YvqlYH/k9S6PGVFNi+AAAQ3p/m0oJb5sEYabOTC/p+QTSzAPUP9/
	 p+oS8HLUdVtXaXHCl8UQMAF+nKVMCfpqDsdOpT8eTFUprFrt1KmqD8S3EADqBZZbQG
	 u4slrJU2/WAyg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so9329084e87.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 01:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/KtiFcSF/FEXCI1YL6T2US9wZgxrv2/o462FW13V3nabPGpOERmmUYBSxOrimP3do0GSeJ0g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rvf9OiXtuWF2r+chMI0+c9jTvtQjIvjrSS8XUyU1vdKtCVys
	T0hlh1dIpp+sRQAP+Bizj1lVtPxhWG3Ctx9H0GRy5fECa1scOn4On/A50/wTyISCUWwK3Zx8mwR
	/bh4LQ//r0SrRhMrGQe5wV7IXvK8bW6Q=
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr4487621e87.41.1779697137800; Mon, 25 May 2026
 01:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
In-Reply-To: <20260518014920.135011-1-enelsonmoore@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:18:45 +0200
X-Gmail-Original-Message-ID: <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
X-Gm-Features: AVHnY4L3wfMFUnjNE8lm9cvN091uSgyxKr6Hy7t4eK0YNSLwuts2rYxfVsneK30
Message-ID: <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Shubham Bansal <illusionist.neo@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,armlinux.org.uk,arndb.de,kernel.org,linutronix.de,infradead.org,gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6B105C795F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 3:49=E2=80=AFAM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:

> The eBPF JIT unconditionally generates ldrh/strh instructions, which do
> not function correctly on the Risc PC because its bus is unable to
> signal half-word accesses. Work around this issue by disabling the eBPF
> JIT when building for ARMv3 (the Risc PC is the only currently
> supported ARMv3 machine).
>
> Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Looks correct to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Please put this into Russell's patch tracker!

Yours,
Linus Walleij

