Return-Path: <stable+bounces-217436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOw5IBkKl2nvtwIAu9opvQ
	(envelope-from <stable+bounces-217436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:03:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423D15ED59
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D094F301A2B7
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF833B6DB;
	Thu, 19 Feb 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2ZoCQY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6933B6C7;
	Thu, 19 Feb 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506197; cv=none; b=UNffjSD21uqNauSV15OKeLq2dBY9r1F0yg92lE2dtgoJpeYMP1pI4V2NbROqZT/BAwh+v5iWVkdfIn9+3AJKeanYduphh9SEcHmkpRFPMrkDVRZRDJqgaNQKoxpkPfvFyAVKNhi3HCiy0Po4rrBvtzSasW8rWAUPkPkGzCFwk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506197; c=relaxed/simple;
	bh=yK19pzf3xS6eSgWh4BDlWw4MEi9y63s4HTiuIj6YxRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpuRTIXQeOY+tTt2C9LjtXXfKY7l0x1ncH1yRvHBht/sHvekCF+e2JdtXVsVSdsy9xVXWbMkx4bOP9AQrqa1XhI3EAlLe5pCLpP2bA2qDEvlwqoUAm86G/sJ7GGG/VxMIgAeB8gfC5k/GVR0sC7A9Skci7ViZM8oDsDpkTd+HzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2ZoCQY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A83C4CEF7;
	Thu, 19 Feb 2026 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506197;
	bh=yK19pzf3xS6eSgWh4BDlWw4MEi9y63s4HTiuIj6YxRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2ZoCQY7ubMdJFO+Dogk0wJElzLEhXKFZ9AkBXAx4+w9tG9dUG0pnEtgX8h0cx+fm
	 n9RakTCI8kMCHii/QQlCHqpbzeBnQeGxOzuAvJRSyQ9vx1nTYgb666rG8rkBO0Oo6v
	 QvBbQS7LB4TCat9b6w1Kalq7MYIP6LBenv9Ukhh+WC6mpLKKTRY3ScpuDPB+JoJA3a
	 7Lk55C/u9d9tzCOAjUTit6uEMYu4E4F7keqAxUURTzY0HbPAJxO3/C1mrSt1cqugWa
	 kr1GHwpPT3tgaQMsL2F0lJCRLROfCqKX2txbhENwjHaWlpuLm1z07hTaXVts9iwBsc
	 AwndwIqXFKQIw==
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
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
Date: Thu, 19 Feb 2026 14:02:56 +0100
Message-ID: <20260219130256.31407-1-ojeda@kernel.org>
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
References: <20260217200002.683975158@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217436-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5423D15ED59
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 21:31:56 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

The same couple build errors and the warning still apply, from 6.19.1
(and 6.19.2):

  https://lore.kernel.org/stable/20260215023627.56245-1-ojeda@kernel.org/

Thanks!

Cheers,
Miguel

