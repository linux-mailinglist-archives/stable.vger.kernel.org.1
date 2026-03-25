Return-Path: <stable+bounces-230257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pf6I9M7w2mTpQQAu9opvQ
	(envelope-from <stable+bounces-230257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:35:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F531E50A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DD223053202
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFD26E6F8;
	Wed, 25 Mar 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfSNLXJj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A2066DE;
	Wed, 25 Mar 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402511; cv=none; b=TlQvhEzBsSk3/OSPkHHyCsSN4etVc9Hus0MXJz9612oiwtFQjOTD94YOq2kEdoN6PI66g/7x9JdC1IV6Jb6juWOXlq7ikewk11dZVdAKS4tRj4cB6SLQVbNnshYbKRpvmR9uk1hMHEsrlSN02FtYkO9XpdyPzuGJt2IpieJHdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402511; c=relaxed/simple;
	bh=u+or+4ewo6DzW5OS99JNcJt3P+PYstR0dsJPR1tuZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB5+t6Zwkpr+H4YrlkeGsmt7Hvgpk9bl40AZdqQWOhbGo/Z447P9YFawER5BnBjIa8IY+eusXT7JuVGwHPhweD18Jr/qy8F36sCrDUpfo+cooehziAOHUv5Vjl+DOuyNx0icB5tw/I7dD2W/I4qYcETytrlUNUy0FDMSay7pla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfSNLXJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C30C2BCB2;
	Wed, 25 Mar 2026 01:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774402511;
	bh=u+or+4ewo6DzW5OS99JNcJt3P+PYstR0dsJPR1tuZdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfSNLXJjobHuFIyJwgQnaBha24RbrbvUDO7tgCICQaBxVu+Iy056ZzbsnHDKs74gR
	 jHgY2J++3sLB7d/nrI6XlokOLgnfwrwTTEucOZXkL3yxyOO2n/P/5jCvCecb2uhV9n
	 s3jyETmhuBCp81hJAXhmBirEWPDKgktu5zhy+ppProV3LaI47st429hj2g2LNmJ2uC
	 P1/T1NiXjNT1+bRoXFm1E1Gz2nuEerITSMeOKwPC7gbXHj9xcJAIOx4OMYLAp1pVcI
	 LPGdWVOXy4zce7aEeOjhHdO1OdZkDCPfhEpOMivLedLQxd2rEnp23AcJMu00FeTupE
	 p5htC9RVHmbXg==
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
	Gary Guo <gary@garyguo.net>,
	Tim Kovalenko <tim.kovalenko@proton.me>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	nouveau@lists.freedesktop.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Date: Wed, 25 Mar 2026 02:34:47 +0100
Message-ID: <20260325013447.66771-1-ojeda@kernel.org>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,garyguo.net,proton.me,lists.freedesktop.org,xen0n.name];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-230257-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,lists.freedesktop.org:email,linuxfoundation.org:email,garyguo.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: 721F531E50A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 14:42:57 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

For loongarch64, I am seeing:

    drivers/gpu/nova-core/nova_core.o: warning: objtool: _RNvMs1_NtNtCskfHXyXj90Gn_9nova_core3gsp4cmdqNtB5_4Cmdq3new+0x2c8: return with modified stack frame

Which got fixed in mainline by:

  c7940c8bf215 ("gpu: nova-core: fix stack overflow in GSP memory allocation")

But 1) this is just for loongarch64, 2) Nova is still being developed
and 3) it is just for 6.19.y, so that is probably there was no Cc:
stable@. Anyway, Cc'ing here.

Cc: Gary Guo <gary@garyguo.net>
Cc: Tim Kovalenko <tim.kovalenko@proton.me>

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: nouveau@lists.freedesktop.org

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev

Thanks!

Cheers,
Miguel

