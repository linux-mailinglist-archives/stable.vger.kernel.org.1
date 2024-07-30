Return-Path: <stable+bounces-62632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD759407FD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7911C2254C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF016C86F;
	Tue, 30 Jul 2024 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CI/bD4DX"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300516B75F;
	Tue, 30 Jul 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319207; cv=none; b=Eht2Swf1MdCT6BegzfQMQaxZ9Y++yuuKLtgE/86bugeqjs1wUl4qSry5pGhjjDnS+utJoUAim09P+yqR5Vl+A6FXg2YrIy3w6qQEiplyOevkvDyGmwj9hEoG1/vmXf8Q9pQRfR9fqeCL7asNj2Sq29I1JE8v8tFJHEBmQjEFgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319207; c=relaxed/simple;
	bh=qJg8BDX/xzPXVgUz2dxeadYmFh+9QA1KHD/agziyD6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL/mXuSa25GetIaXJu2r1AoRdlQB2YcH/unTszM+zQqbkWfIq3FoW44hg1W6zIqjr6jvWLb3gH8xt6AG1UO+gp3DA7Yj3Asu66I+7HWh+tP3K38cDsK1DA2miAa9m+GjlDUHEKU9tW6YBDvP6lkMxuS8qdNqEovO41vwmEOw/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CI/bD4DX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DFD1540E01CD;
	Tue, 30 Jul 2024 06:00:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i6Y13pd-NalB; Tue, 30 Jul 2024 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722319197; bh=E5fRFhwnAJ60HkJJn69/gb79SKqaN2fycXvpcvxTPng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI/bD4DXUKaNfykQ8mlT/DKqtmLpMzC2RyinSXuDWavWtRcC20n63mRFoYvZjuisX
	 wxjnTHYexLna7yfDwg2TU5F5G57NFGU8oGUGwN6O6GCkD3VHUg94l0hEHDZr5AGnQB
	 +Coahe3mwApoj3tzzlemau8JCo1WbL0jNaKvgxDEM3sTlVCtDVWF6JmgnWIpuHUR6r
	 93pQCz/MlLVme6z2WL7xGShUe5GKvsUqQIrnjrVRwElJP8ByVyr9D2vPrIgjLfxr08
	 4nUXmTmNrEUqpDeSRskExfP9YgpP0dFT//5jyDZ01ou2qMXFegKdFqLvTD2Qzy3e7K
	 fq+qv0+e1uIf6fyOPq3qYNGChL++PuPDZMBxoRe3mc63txE3gEJ2I1q/EzscQxgq//
	 N5PQStagacVj18w4Ug0zJcB/1WkVB1w9m9xPAF7hfJg7DZrtyU37eQDoxtX226Iv6F
	 c7eLrSMStT7GqNZ6sIHJQzY0D3wsPjxzsNr5Wxvjir2IaXKMH1MQXxOO/2ujaXQ4Tv
	 TJtLBsEAruZjUtWid2qLYqLRIPLsdq2QdWUpItjjdTJyTj0JVKqe1txaX4DJlyjb53
	 wj2QbFl4hXr91CvRHAeC9P5HwIG0pQqV2T7eePB44GjBqt+06l7CCoYMIW2v3j9lai
	 rClzYAk+63hOPNr13SH8U6iU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDCC340E019C;
	Tue, 30 Jul 2024 05:59:48 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:59:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Paluri, PavanKumar" <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sev: Fix __reserved field in sev_config
Message-ID: <20240730055941.GAZqiBTbPUtkgYTWfi@fat_crate.local>
References: <20240729180808.366587-1-papaluri@amd.com>
 <20240729193210.GHZqfuOs-t9HuYPF_Y@fat_crate.local>
 <dcfc9264-959a-3bb5-95ad-548a6f019430@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcfc9264-959a-3bb5-95ad-548a6f019430@amd.com>

On Mon, Jul 29, 2024 at 06:45:21PM -0500, Paluri, PavanKumar wrote:
> I will re-spin a v2.

You don't have to - I'll fix it up.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

