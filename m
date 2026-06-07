Return-Path: <stable+bounces-261914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jHXpNsWkJWoRKAIAu9opvQ
	(envelope-from <stable+bounces-261914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C121651095
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:05:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kh6A5hh2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261914-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261914-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9323011746
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A02E7380;
	Sun,  7 Jun 2026 17:05:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858571C3F0C;
	Sun,  7 Jun 2026 17:04:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851900; cv=none; b=pbAY6ojwpKvH1PA0YjgxMRT6tPxDsELYFj2uOiu9b+hZrhb2qn0vEuLP1EmRkPBXgK+AwsVjw4rsgxXPwUisyNmo1dxhHD+lMASizy0A8XuCQIU0vbTvCK1r0LE+LJPoGfIkcDlNE2v8AaJSVhvOpA1/mfFaEA0GKesfm83kpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851900; c=relaxed/simple;
	bh=q0qgObeF1LZejSWpoboybLgmgbelSGwguIPM4//fyuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwIqECdApaCOx4SrlkPH5Tii0hqFt5tEpRiiABLyK3tSyGj2hlBh8SrxJSYwpGhTOQwLoH9Is6EF7Cm5DC9Sv4u/+ysAdJWwKsL14w5ufBD0XgScQ3hWwUK3sA5Aaq7TDk6qf4PSmmZUPJbdCSzDdR4SyIeMfswelyj4mXJBLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh6A5hh2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED1D1F00893;
	Sun,  7 Jun 2026 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780851899;
	bh=ql26d6LUbgj2+4SuVgw7OctlciRpnyFlg2ZCz97GwL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kh6A5hh2B+61lHznzFUVxznyXcz5QyAqvDMVhu8zlqyRImPiKyOHwtwqCI9Xjdkgv
	 zBgFAIFhKHMdL5qZP0VLRBIhfIcoMaek69XauziYkS6MhRYgR4c5EC5IWVXpCOFHvv
	 vTR22f9EmU2PL4NlWcIlSmxHpjBXEt4mP8sEbo7/BOiN9LKWHFNAAOC5sV3+yXJo4O
	 bFdT3Ey1Kf5dPoKMCqE0Mr3JWybrJKdXSCXHRcQ3Fmz6wV2Zw2Ny6zinW9CDdiKkrS
	 0bb/rzL4ciE/1qdoUp9o+5rS3fXTjKZbLUY/1Og15NJT2KMLaMm0J7q700AaC7kqTH
	 M3zTRBZmFhE0A==
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
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 6.18 000/315] 6.18.35-rc1 review
Date: Sun,  7 Jun 2026 19:04:40 +0200
Message-ID: <20260607170440.90814-1-ojeda@kernel.org>
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-261914-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,arm.com,huawei.com,google.com,linux.ibm.com,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:ojeda@kernel.org,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:oupton@kernel.org,m:yuzenghui@huawei.com,m:tabba@google.com,m:will@kernel.org,m:catalin.marinas@arm.com,m:seiden@linux.ibm.com,m:mark.rutland@arm.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:kvm@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C121651095

On Sun, 07 Jun 2026 11:56:27 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.35 release.
> There are 315 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:45 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

arm32 builds fine too.

However, on arm64 I am seeing:

    arch/arm64/kvm/nested.c:1776:2: error: use of undeclared identifier 'resx'
     1776 |         resx.res0 = ZCR_ELx_RES0 | GENMASK_ULL(8, 4);
          |         ^
    arch/arm64/kvm/nested.c:1777:2: error: use of undeclared identifier 'resx'
     1777 |         resx.res1 = ZCR_ELx_RES1;
          |         ^
    arch/arm64/kvm/nested.c:1778:33: error: use of undeclared identifier 'resx'
     1778 |         set_sysreg_masks(kvm, ZCR_EL2, resx);
          |                                        ^

Due to commit 10206eaad1b9 ("KVM: arm64: Correctly cap ZCR_EL2 provided
by a guest hypervisor") here.

`resx` indeed doesn't exist, and it seems like it was added by commits
0879478913dd ("KVM: arm64: Introduce data structure tracking both RES0
and RES1 bits") etc., which are in 7.0, from this series:

  https://lore.kernel.org/all/20260202184329.2724080-1-maz@kernel.org/

So either we make a targeted backport or backport some commits, no?

I hope that help!

Cc: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org

Cheers,
Miguel

