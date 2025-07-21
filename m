Return-Path: <stable+bounces-163629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DCFB0CD43
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E196C4893
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65A242925;
	Mon, 21 Jul 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZptrzZr"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4B22173A
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753136703; cv=none; b=ACH15m1f6pxMpOS9CUN59Fp1km7EShgmBl0SwSePME4+x2FvyYeWe6Nw/C+ILGSa6xF0xLOlEd6YON0m1hsUYnN2IPb6zc9zqVIfAtC4w3uyem5WAtISJLG67fUv7IF582ApGRHebzn113hxYLfpIXilOj9p6xjYPZeaQAeur18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753136703; c=relaxed/simple;
	bh=F+ws2eLWfD2NkWojYPpMSKKKu95g8Nt03OBK7Uspbo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWUDl3pKNcdO3rL1mf4MPrR1Jt4uaAgZVb2madwny7etNlQPweK88XI0Y9RZBqtqbhHTYRR2at+oqDP7Qh9RufmHfb6RByKCP8obK72ZhhNHljrq0z3XOd3E9kmrYVjZXl3OBoFweutNRDA/p0l/X1NHr3DUy1nKCXC/eUsrdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZptrzZr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753136698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0Swdc+rgZd6RYXOhWJTdQCOj/YJAeib/YMEr/j+xKM=;
	b=HZptrzZrIHb7zDppmEpiXbGBgqebupTQ8pylKpzfG1WZ/EjdDd5SeiMXYBLDklKXGyITLi
	8X+IcIKCMWgDj89IagWjCFxQnHacJ7CT8bZBk2TkoyPreH7B9QssECZFafwEcr3k17Kf+d
	b0IyMm2aybdhaf6d8GJ8DTu8aeKfnxQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state
Date: Mon, 21 Jul 2025 15:24:45 -0700
Message-Id: <175313657127.2592298.3949452294355380877.b4-ty@linux.dev>
In-Reply-To: <20250720102229.179114-1-maz@kernel.org>
References: <20250720102229.179114-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 20 Jul 2025 11:22:29 +0100, Marc Zyngier wrote:
> Mark Brown reports that since we commit to making exceptions
> visible without the vcpu being loaded, the external abort selftest
> fails.
> 
> Upon investigation, it turns out that the code that makes registers
> affected by an exception visible to the guest is completely broken
> on VHE, as we don't check whether the system registers are loaded
> on the CPU at this point. We managed to get away with this so far,
> but that's obviously as bad as it gets,
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state
      https://git.kernel.org/kvmarm/kvmarm/c/c6e35dff58d3

--
Best,
Oliver

