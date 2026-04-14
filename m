Return-Path: <stable+bounces-237867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKiuA4c83mn6pgkAu9opvQ
	(envelope-from <stable+bounces-237867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:09:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56B3FA539
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1BE308F07D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6221C5F13;
	Tue, 14 Apr 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKziFAxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D61F2380;
	Tue, 14 Apr 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172025; cv=none; b=TSSZzTIL2cJDJ+5QZzEk5RDsLGlXksXZbU+QmvTI8dj99i0YY9X2cFqhemcNHDOKnj+LFt6m7UpjpbOOO6QSq4NGRTuWoapZTSHdee5qbe/xH8mFoEFKYUq8dN11/vioJt2sOEM9GPY58ei+tfwwZGPqXafY9N70jsqMJhPkcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172025; c=relaxed/simple;
	bh=MWOEJ1V09Eh8A/2FnfZxd4WWSdKAeOnicDNi9gywaqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgWXMazFjQCNgThd/QF7ajlWCS7CtYJ0Z79T7iiQA7VEuYJS4X/vr9rXf8VOWeyqR5W0FKNtJ3SsGMdYBht2ovCrSFwwOZlXHbgo30iBx3eoF/Q4skjOrF5+O7mSkEUwAf8MeAZLMwumjgJiTZ33IpXvmx3uTLUNTHLkGiVWJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKziFAxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7420FC19425;
	Tue, 14 Apr 2026 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172025;
	bh=MWOEJ1V09Eh8A/2FnfZxd4WWSdKAeOnicDNi9gywaqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YKziFAxihgicVZ00C9Lr72603fUBVAfqxk2Q68FbSAENoBDIYUTxi9QNB00inJJPq
	 wQCjGZc0ch9//er/ys3dATIlllwbVME9woqwnajRQh3UR/mDqBae5bA7T/Fd2ofPE3
	 EFCLBbjuldpQeICnzGMbdobMCqfTe9BXtHf2ELmYIH8w6BSotzsD3T3unE4rmEwt6Y
	 tGOU4r2EDYwU5Bt/hpx9oI+2yog4TqzXCsaju2yvSi4I8jC/MkuBlNd6jL12deo8v+
	 jSLISqV7XEc//JucmNPSGqf+eI8f3qn2PnrCac36yCdBAtaIlJ/6UHJCXBSP1PjY+E
	 lnZQmt4OIog5w==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
Subject: Re: [PATCH v4 00/11] Add support for the TI BQ25792 battery
 charger
Message-Id: <177617202217.87058.8852713386069702541.b4-ty@b4>
Date: Tue, 14 Apr 2026 14:07:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com,flipper.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237867-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C56B3FA539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 15:56:13 +0400, Alexey Charkov wrote:
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
> 
> The series is organized as follows:
> - Patch 1 adds the new variant to the existing DT binding, including the
>   changes in electrical characteristics
> - Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
>   driver, slimming down the code and making it more reusable for the new
>   BQ25792 variant
> - Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
>   (this is a standalone fix which can be applied independently and may be
>   backported to stable)
> - Patches 6-8 are slight refactoring of the existing BQ25703A charger
>   driver to make it more reusable for the new BQ25792 variant
> - Patch 9 adds platform data to distinguish between the two variants in
>   the parent MFD driver, and binds it to the new compatible string
> - Patches 10-11 add variant-specific code to support the new BQ25792
>   variant in the regulator part and the charger part respectively,
>   selected by the platform data added in patch 9
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/11] dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
        (no commit info)
[02/11] regulator: bq257xx: Remove reference to the parent MFD's dev
        https://git.kernel.org/broonie/misc/c/aef4d87f2c1f
[03/11] regulator: bq257xx: Drop the regulator_dev from the driver data
        (no commit info)
[04/11] regulator: bq257xx: Make OTG enable GPIO really optional
        https://git.kernel.org/broonie/misc/c/de76a763805d
[05/11] power: supply: bq257xx: Fix VSYSMIN clamping logic
        (no commit info)
[06/11] power: supply: bq257xx: Make the default current limit a per-chip attribute
        (no commit info)
[07/11] power: supply: bq257xx: Consistently use indirect get/set helpers
        (no commit info)
[08/11] power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
        (no commit info)
[09/11] mfd: bq257xx: Add BQ25792 support
        (no commit info)
[10/11] regulator: bq257xx: Add support for BQ25792
        (no commit info)
[11/11] power: supply: bq257xx: Add support for BQ25792
        (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


