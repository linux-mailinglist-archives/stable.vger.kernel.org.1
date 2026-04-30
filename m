Return-Path: <stable+bounces-242100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAU9MwZN82lnzQEAu9opvQ
	(envelope-from <stable+bounces-242100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D03A4A2CAD
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF89A301C88D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3076406268;
	Thu, 30 Apr 2026 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXNby89r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2752580D7;
	Thu, 30 Apr 2026 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552630; cv=none; b=q/jg5UpFj14pZ+gi367vvA/RNJCDE+usmC9kOvRha6DV66zKMOPU7VSJxZvblxOrI3C6CLG4M1ZQgYGHFnqpLRSpMBeB5racGIoWoKTNWJAPhm2UnW1V+9ksJcrfzbEA5jEwiMj6o7qHFaHGJRVA1w9Vbh9/caEjzhr46Vb/D30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552630; c=relaxed/simple;
	bh=mR9AQJnykFvzCVGNFszfC6SYPqN8+eFh24emSOY9PvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DMMaTgsEnH6NuyS13X2I5xSRih751lsVr4esCPlOOIhJQ9KQWuJffLyciKILp9NjnhtJjPcIzUq1EsBkIL2zR5yEUzzdiuMQ/chvzljCuglU80aGITV6bzGT1rQiNHfqEmy3Z9Xdn/A2l8noKYl+M+r7pDhqynNgfuDXDPMSrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXNby89r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E048C2BCB3;
	Thu, 30 Apr 2026 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777552630;
	bh=mR9AQJnykFvzCVGNFszfC6SYPqN8+eFh24emSOY9PvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qXNby89rGpmxXEpD4eilUWVa7ROY8o55qxV+s0sQQ4z1fwIhJr9vDdm4TdqxthZny
	 98IMnwzqgEKBfukuXylk1WiNXrup/tR+tPOhKnant2PNuYzceC/u17AA3/iOTRFEBW
	 jj3Lwzx0EjArowVkbBAqcypMxoj+Cqs9cTN0JweYa8xYKKM5QL5EaGA4dgUD0g+asU
	 20p5y7CSLSVGTIadqAdQiJDdJkyXJTEp20HeVhIR3sAqwqGhhTitez2e8PewsDKMzr
	 0vnIo0yxjNr/aeWjDWsOfqglJw9JajaLK9HwZeN4Xh6IElrArQkIOujXXQSyjAGpOm
	 AwSXgQJsBoeVA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Alexey Charkov <alchark@flipper.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
Subject: Re: (subset) [PATCH v6 00/11] Add support for the TI BQ25792
 battery charger
Message-Id: <177755262690.2557411.9260557703583835724.b4-ty@b4>
Date: Thu, 30 Apr 2026 13:37:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Rspamd-Queue-Id: 5D03A4A2CAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242100-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 31 Mar 2026 19:43:37 +0400, Alexey Charkov wrote:
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

Applied, thanks!

[01/11] dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
        commit: 2a0bd270f95a774349e85c8eabac5a275298b6fc
[09/11] mfd: bq257xx: Add BQ25792 support
        commit: fb0d8bbcaf2355a7a06b053efa77f09766948313

--
Lee Jones [李琼斯]


