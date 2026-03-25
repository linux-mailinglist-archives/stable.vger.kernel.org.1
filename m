Return-Path: <stable+bounces-230255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DbvKaY0w2lVpAQAu9opvQ
	(envelope-from <stable+bounces-230255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:04:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C431E2F7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8595305554F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 01:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE69223DE7;
	Wed, 25 Mar 2026 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+IXTww2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B718AFE;
	Wed, 25 Mar 2026 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400653; cv=none; b=RaC1NqGBLcjtDCi9IGuyAR5TsfAAzYusSWlazuHYPu3EvgJzG/cZGY+3jk5RBScgb02hqfjj0XOCJd8F/BU1oOn7sR1pY72ugob5MB/E+ZpiA7D8S+WF9xh7IqAvxrVXB/tuHvjREd2K6bNFFW4urjwQzZ+dY+DwhM9TL+yL9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400653; c=relaxed/simple;
	bh=xuio0iUNCd9Dsa7TTkNCacQ8OxsZcaqyEFOvTKUEK6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttqVBsRW1OKWCJVNHjJzwdeWqTHs2Gdo2qQtgWjP+Am1mf+IElmF9FxgtqpIIeXaDPtcP64A4/xsceTQC184l7lMEToFf9TZbtGz00t++TRMavKSCM6u1CxWR47L3lnL6d0g1ux2kwRGanWDjNzAo1nAHkCbDQMv3+ZaY/HZwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+IXTww2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B7AC19424;
	Wed, 25 Mar 2026 01:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774400652;
	bh=xuio0iUNCd9Dsa7TTkNCacQ8OxsZcaqyEFOvTKUEK6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+IXTww2TQ6aT0wzvLKu3u2se94ZDbvY9MgeE8OZ/jn6e3j/Wgp8Y+DZNoOr7GRKJ
	 Rz0KgBmWU8vuOpjZf+xalWcZ4/unyUJAKlIsQ+bCAP1vRgxlwgSJSuxyRS5xmjauvq
	 gxgwPnswNQnKs+TLKkywzsgN6X3+jOkuU6dsDxdBa1hL+/E0l1TW7JBPn7XsQL+qE3
	 9Ctk/M+DkzLcPVDfowZ5GxDIrx5iEHhNsmww7j0NBpCixDeuEKH4NSY+115Cvy4fQx
	 cbUeBsTbznRc00Da62Hj0py6zFCXymI73KJoMa27lzFxg9GYXj8QcsCJOcQUOVdcbt
	 4EmnvPD2x68Mg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Date: Wed, 25 Mar 2026 02:04:01 +0100
Message-ID: <20260325010401.62938-1-ojeda@kernel.org>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,infradead.org,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-230255-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 2C2C431E2F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 14:43:41 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

For UML, I am seeing:

    In file included from kernel/fork.c:108:
    In file included from ./include/linux/unwind_deferred.h:6:
    In file included from ./include/linux/unwind_user.h:6:
    ./arch/x86/include/asm/unwind_user.h:23:12: error: no member named 'flags' in 'struct pt_regs'
       23 |         if (regs->flags & X86_VM_MASK)
          |             ~~~~  ^
    ./arch/x86/include/asm/unwind_user.h:23:20: error: use of undeclared identifier 'X86_VM_MASK'
       23 |         if (regs->flags & X86_VM_MASK)
          |                           ^
    ./arch/x86/include/asm/unwind_user.h:26:7: error: call to undeclared function 'user_64bit_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       26 |         if (!user_64bit_mode(regs))
          |              ^

We probably need at least:

  aa7387e79a5c ("unwind_user/x86: Fix arch=um build")

Or perhaps the split of the guards added later.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

I hope that helps!

Cheers,
Miguel

