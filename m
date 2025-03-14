Return-Path: <stable+bounces-124412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C0A60ADF
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52E417DD2F
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C919CC2E;
	Fri, 14 Mar 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFiYHKvF"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516019C54A
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939873; cv=none; b=C/olTonriomNS6r5UnFTd1ZfoKFL9lFuzoKlqrODM1K0UvOOYJHkh3sWX06qiTz7QfUPbaRMNVyN8rU86k4P3EIHfwdHNJUqUlhf5DAi/116OSFziAFhMh0nm2BJ6T9nVdM0yEVHgAC2prIcekg8iRuGolFlsGJbPUzobroALk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939873; c=relaxed/simple;
	bh=pO7tTO1rV95NIoQMWhWLdGMcS+ijoaLqtx251avqfLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjtxi8hQgB/dgCSBJiQytciPPiTlpBUfeUgfREmotZEgNre54s9G4rSgTuKHuW6zDEw1Fzek1WXOHrmA7styIqTPrTWMFloSMdFGmHoDlXWEXx3riX8EOA97PnWnBls0YwD9ClBssf2kjb91b1CgJo6IvACJPGl141d/U0uwTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFiYHKvF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 01:10:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741939858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pO7tTO1rV95NIoQMWhWLdGMcS+ijoaLqtx251avqfLs=;
	b=kFiYHKvFgG2Jjgo9l3Rdp1qidd2k9Mv7b/wF/TKi73ClvF+zfwzJn3EIbeGIuVKkuoOjHJ
	uZhkeU9N0XONZQDPvyXiJxn1Ce4rR6QlheSzBz/g1OXa9P6wgVN2ciaZ70+MYt2q+o5Zxh
	zvp3pp+6WtTaaAP4I8APYTnMXLq3I5A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, devel@daynix.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/7] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Message-ID: <Z9PkchMNGN1cdLgJ@linux.dev>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
X-Migadu-Flow: FLOW_OUT

Hi Akihiko,

On Thu, Mar 13, 2025 at 03:57:41PM +0900, Akihiko Odaki wrote:
> base-commit: da2f480cb24d39d480b1e235eda0dd2d01f8765b

I don't have this commit, what did you base this series on?

FWIW, the patches do not apply to a 6.14-rc* and seem to use something
older.

Thanks,
Oliver

