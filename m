Return-Path: <stable+bounces-222479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMHpOh2HpGlsjQUAu9opvQ
	(envelope-from <stable+bounces-222479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 19:36:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7281D11C7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 19:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB9A30131CF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512323164A9;
	Sun,  1 Mar 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eic81z1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140238F48;
	Sun,  1 Mar 2026 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390144; cv=none; b=rmS7UXWXnCdhaymFwswt/r5BzQwCFXuZLbQ+4Pw6pxWOzQqfFdwUr0cyRtigyCNIxgBeorDOkPej+NlVUX0KtHYTi8JBpXcI732zxShXA5gyjwoPd27KudIB9CEkTui8skOeATQTniy8uvWE7JdShHSB/Ls9fcJKwXYKFTo4neA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390144; c=relaxed/simple;
	bh=oj+YulpikB1uFi94WPItGqbVjjllwsHzoozkfVq7F+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUIbfsW/dTjoI8F+qRfbNZTTYZGlWvKBXfQ0X1bBTFDkDMIQsH5eMVbkjxu7+DXMvefURiyuH0/tlQi5qJ44wfpFDn1hzY1/ao3SZ9O4OW2AU4SrOwtETYBneqUGss5QwmvgA0E/LriOlA2vfaO3xEwnsT+RciBpsLS9WEe86XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eic81z1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03FFC116C6;
	Sun,  1 Mar 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772390143;
	bh=oj+YulpikB1uFi94WPItGqbVjjllwsHzoozkfVq7F+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eic81z1wP0qWjJX4cBcBILfHCBmQ5WE/2BqxdOLcFh+YZnz9t1YZxQWyUpb0J/6AV
	 h4jzZRVm9ln9eBw91Ha9v6kpdsUFaTZT1AN+IcVJZK587MUbaQDoOxyEC8PinR+M/t
	 KAElE/1kmCy65HVNMtoVexv+eKte06c2X5ELs3EFGASwXOu8YSIXshQ9ovoaWmkA74
	 6OVIB+DctXapAVw//8bbgJwAQiWZXXuxf7GMYljaIRcnyRSx1HpSswYNAG3xdgUspt
	 9IKtuirYI9qIxML3PDzrQfPsMo2u98KX4TgtiUhokKw00FDbDx4/rh7FBU4ODqMOF0
	 8ymb10Hs/9D5g==
From: Miguel Ojeda <ojeda@kernel.org>
To: sashal@kernel.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH 6.18 000/752] 6.18.16-rc1 review
Date: Sun,  1 Mar 2026 19:35:30 +0100
Message-ID: <20260301183530.178726-1-ojeda@kernel.org>
In-Reply-To: <20260228174736.1542240-1-sashal@kernel.org>
References: <20260228174736.1542240-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-222479-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C7281D11C7
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 12:47:35 -0500 Sasha Levin <sashal@kernel.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 752 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar  2 05:47:08 PM UTC 2026.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

I am seeing a trivial Clippy warning on Rust nightly -- we will most
likely send a targeted backport to clean that one:

  https://lore.kernel.org/rust-for-linux/CANiq72nWYJna_hdFxjQCQZK6yJBrr1Mb86iKavivV0U0BgufeA@mail.gmail.com/

Thanks!

Cheers,
Miguel

