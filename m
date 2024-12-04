Return-Path: <stable+bounces-98195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D99E3070
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 01:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DABE2831A7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3417D2;
	Wed,  4 Dec 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GF99kdzH"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C77623
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733272756; cv=none; b=imMfMLn8cUh8lwuSaeI/vz420IBypz0SCyoJ9h+lRiAg/EyO39ce5jmXjkl+jxf4cBYymDNuiLR70I36FWle64iPZsE7GChqG+HnAlfuka0KuGoc1bu7KwWcsVoZFwoY+X9qKlhCDp5lEUQFXk/NDok7GN2fxoMFl2GjZO1IVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733272756; c=relaxed/simple;
	bh=odxI3owKIjmJytS8iq98DHJyPbubrAxeu5B75aU4mcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKX7XTPLHcmht0fcT1bKTOa2sq4U1G3obVawgzcKTS2CslxLi9c81+L5tnsSF+cn9vvenpNhKYUyYMoIJ+8tJXKHiLSkUkhT0ZOfZXtRKry4fhgQLoxeCVblhoY/ORvNSgeDIo0drg2tJRUp3ztJBZ6yw1NST6DeWSEnSQHNasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GF99kdzH; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733272752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuKyh758gXL4H4w1qOWYdSoyL7IX7eUQIvDf/JiLSic=;
	b=GF99kdzHwPOPu8J2EKxn4AZYU4VtBVBTgBSgGQpLRe4dqm0Usij0/YgeP/TwfIEWMzsIdJ
	okjsGMZ6swvZymbOrNECi2alxbeBxt5roZGJetiMWmQQaCbPKbqMq59LkttJDiMm7DyKXg
	Xrn0znXvUv8G7xPO+7hnusDvfmje/Uk=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden
Date: Tue,  3 Dec 2024 16:38:55 -0800
Message-Id: <173327270646.1289915.18344519507054696527.b4-ty@linux.dev>
In-Reply-To: <20241203190236.505759-1-maz@kernel.org>
References: <20241203190236.505759-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 03 Dec 2024 19:02:36 +0000, Marc Zyngier wrote:
> Catalin reports that a hypervisor lying to a guest about the size
> of the ASID field may result in unexpected issues:
> 
> - if the underlying HW does only supports 8 bit ASIDs, the ASID
>   field in a TLBI VAE1* operation is only 8 bits, and the HW will
>   ignore the other 8 bits
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden
      https://git.kernel.org/kvmarm/kvmarm/c/03c7527e97f7

--
Best,
Oliver

