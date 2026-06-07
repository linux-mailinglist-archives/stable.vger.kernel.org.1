Return-Path: <stable+bounces-261920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYzOJkmrJWowKQIAu9opvQ
	(envelope-from <stable+bounces-261920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:32:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BF651151
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:32:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n1V6wd6E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261920-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDA8301187A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8B2F5491;
	Sun,  7 Jun 2026 17:32:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14E2BEC27;
	Sun,  7 Jun 2026 17:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853547; cv=none; b=EzZXqckBP84/nw2b6oZjMA9meTzcirc6MssEHsDuNdbW8Nau+wYPmPm22K5T/x11Vd+WNOMe5a57CEkCMZPc1//HHCQw4JPTn+aggu4kTxzovOBH5JVEXOgH7Cg3lwlA+FQBdf1d7o2gslKxwxLY6NwrbY7sahLt+qXT3Wi3Z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853547; c=relaxed/simple;
	bh=a0j0JoU3ErsTFBniKpGua9PGNeNLVYZqgLXt6eePJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOu7txqy7PMLUWn0XKugUPPlQ5zFOZ1Y6e2cH1szkcEOa1Fb+F/DxoCAnC9QHBDW+A7f+TuW5UCCIKC7L0b4mvWL+Q6eG0rsszBuj2YXTnSypRGl4W9oxRqQMMsDxPi9z4iwfQ+zwLMJ/LudMDI1SuB7bYPMXp5CtYL/lkC+EdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1V6wd6E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9301F00893;
	Sun,  7 Jun 2026 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780853545;
	bh=yvbZpK9MU/gCvcBCJO5o5Z3Uy4a/Itw2KcbkfA8rBps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1V6wd6EUpouACQq+M71ngTlPk0drXtG59+vros66zxL5elU2Q1RRnxLwV+/UC1i1
	 3F8YhnLdp0HERAhCboJifnmlyp15i6qveLpwa8UzkqV57KoNErV4gMszheWFPhHn8D
	 i7Z0nT/AKYPuF5XIyjCjNJtfYurj2wXUK8cYD8fnLifDTF7iJXjv8D3zs/GmVrV7Ps
	 QP9roaUNo3Mr3DX5Q7Cfie6G+D6E7c0GGbuKkeYD2zr72kssY7m1MxYvSiRgHAX+/A
	 hp9b7aBEIngrTgTMK2qHSrVoX3E4GzFEH+46+IrEY1wnjhgxvjxzwFQSvReYfbmKk+
	 NTlZTHJHS1Cmw==
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
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
Date: Sun,  7 Jun 2026 19:32:14 +0200
Message-ID: <20260607173214.92693-1-ojeda@kernel.org>
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-261920-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:ojeda@kernel.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:email,vger.kernel.org:from_smtp,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE3BF651151

On Sun, 07 Jun 2026 11:56:37 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.93 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:47 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

arm32 also builds fine.

On arm64, I am seeing:

    net/sched/act_mirred.c:451:43: warning: variable 'm_eaction' is uninitialized when used here [-Wuninitialized]
      451 |         is_redirect = tcf_mirred_is_act_redirect(m_eaction);
          |                                                  ^~~~~~~~~
    net/sched/act_mirred.c:429:18: note: initialize the variable 'm_eaction' to silence this warning
      429 |         int i, m_eaction;
          |                         ^
          |                          = 0

due to commit a01fbdecc3a2 ("net/sched: act_mirred: Fix return code in
early mirred redirect error paths") here.

And that one seems to be missing at least the assignment to the variable
that happened in commit a005fa5d7502 ("net/sched: act_mirred: Fix
blockcast recursion bypass leading to stack overflow").

I hope this helps!

Cc: Kito Xu (veritas501) <hxzene@gmail.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org

Cheers,
Miguel

