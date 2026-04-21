Return-Path: <stable+bounces-240184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIMgJomR52lE+AEAu9opvQ
	(envelope-from <stable+bounces-240184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:02:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3443C7BC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78442300C258
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD603D8906;
	Tue, 21 Apr 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmXxT4bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75432861E;
	Tue, 21 Apr 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783741; cv=none; b=U67J2REIXqlh5j/l6kHTtocy/lrLrscdiwUlsweqhh6Hk80qIzpbZZDgldP1VmCJ2EZQF0nhftnceoR0aWKcs8uWrx4O6KlwKJjryNOtlyNwdPEgNCeTVt2MnGQ7pMRiGi2ko/QXWXzTXTnsOUTUG7BHNdd31/oOneWphjk/w+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783741; c=relaxed/simple;
	bh=Mpbkj6yOe1GN3X5YpgKdXjzi0Cn1sKwaB2ZCYJvR0x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB5g0DcBnmpFhcLB8XOEQ+taOx0RMz1OZesOZtSv7LZOQRe0bwImrisEEzyPeeuTFFKdu6/xL1m4ynP8zLt/sIpLDEy3D78t8pyPXDFEo4Bacb/4LIZyIHUh3oQ56+04w0vgx+hBKOUzp+8i9MKjXZUzrB5sUGn+D2CkWCvZBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmXxT4bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D904C2BCB0;
	Tue, 21 Apr 2026 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776783740;
	bh=Mpbkj6yOe1GN3X5YpgKdXjzi0Cn1sKwaB2ZCYJvR0x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmXxT4bq/jdUGylFLv9mGVtoKFbMm7IOdxmOVuBB4b28dU69dWhDMkm+T9Q+DWJ0r
	 CVQJzqTUXa6/q+rkvq9bnfrBbUn2y7JSgNuJU5z3RSSkWOMVzFV2Dpkzi03eVVa2xx
	 3K1hHh/TFZ0xkeDU+lUw3kmjwigck9NeVyuP/fWA=
Date: Tue, 21 Apr 2026 17:02:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, lkft-triage@lists.linaro.org,
	patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com,
	rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
Message-ID: <2026042155-handcuff-stunner-1318@gregkh>
References: <20260420153935.605963767@linuxfoundation.org>
 <20260421095549.47476-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421095549.47476-1-ojeda@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240184-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,joshtriplett.org,efficios.com,infradead.org,goodmis.org,linutronix.de,linux.dev,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,efficios.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,nod.at:email,goodmis.org:email,linux.dev:email,cambridgegreys.com:email,joshtriplett.org:email]
X-Rspamd-Queue-Id: 6CD3443C7BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 11:55:49AM +0200, Miguel Ojeda wrote:
> On Mon, 20 Apr 2026 17:39:39 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.18.24 release.
> > There are 198 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 22 Apr 2026 15:38:57 +0000.
> > Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> For UML (x86_64) I am seeing:
> 
>     In file included from arch/um/kernel/asm-offsets.c:3:
>     In file included from ./arch/x86/um/shared/sysdep/kernel-offsets.h:5:
>     In file included from ./include/linux/crypto.h:18:
>     In file included from ./include/linux/slab.h:16:
>     In file included from ./include/linux/gfp.h:7:
>     In file included from ./include/linux/mmzone.h:1538:
>     In file included from ./include/linux/memory_hotplug.h:7:
>     In file included from ./include/linux/notifier.h:16:
>     In file included from ./include/linux/srcu.h:59:
>     ./include/linux/srcutiny.h:14:10: fatal error: 'linux/irq_work_types.h' file not found
>        14 | #include <linux/irq_work_types.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~
>     1 error generated.
> 
> Caused by commit 95721c9fb3a1 ("srcu: Use irq_work to start GP in tiny
> SRCU"). The header seems to simply not be there, i.e. either the
> `#include` is changed or commit c809f081fe40 ("irqwork: Move data struct
> to a types header") is backported.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Zqiang <qiang.zhang@linux.dev>
> Cc: rcu@vger.kernel.org
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org

Thanks, I'll just drop this commit from 6.18 and older trees for now.

greg k-h

