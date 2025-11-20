Return-Path: <stable+bounces-195427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A1C766DA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 22:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A9DC229733
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D42EFD86;
	Thu, 20 Nov 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fdfr0gvu"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA922D7B9;
	Thu, 20 Nov 2025 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675613; cv=none; b=l4L2ENEB/0ot04KnS04aR7aQOdtlufchsPeyc1f7yvWOWIV1cXRg93hz1teE2KSs1oU0PPDYjieYPLc0QD5XjRor0Y0uIzOBrddF3QiQP9G3MfX5EsDkAdHvuRkvH6JMBj12JDqb6syqkPMGrEja+579MeePdzJiSzXrQhmU3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675613; c=relaxed/simple;
	bh=sfd31VPbGOq5GA7GO/KXZQ8oyIaeU5LzT0IS8oem+Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3scG29ROJvlGblUWZ+T6+lZL03V6MIAZP0e8PmVAJFh8ApFyywlmRN9iEo8BOJM7d6b9Ir1FazsJS3Ypa5nvE3v+F9O1EIwW/LVsDfdaOekVY+BLGm1lRMhqFS5D+rWKPcfF44+FilT3Y0pY/9cBf2vDY2DXf06n2HtFJzUK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fdfr0gvu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D2E0B40E01A5;
	Thu, 20 Nov 2025 21:53:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ABRntIgvARNf; Thu, 20 Nov 2025 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763675601; bh=URtkXv82hBd9mwL3T0kChVmfaEUgedpfb7xzorGXT0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdfr0gvunyUsnBiPVjq3qVOrQhXUVksfNe6G0Ef/GGauTy0zJYjhSu+E0YeNCkHv6
	 f7MsRG1SaCCOCGrrIVUDAm85RkgW6cZhcUlfEj5CgETPcLhMeq4dJ16FhslOz61PIl
	 nQuEVf8fZ706MtOvpM0DWsOlhNjUpUxftOW/irPhSLTqHtms4N3LyI2WqPJrgVmW0c
	 fPHRX5HcqanfXYKBgXMfRMrlZLKihpA1n7P9CGj8bgaNQEjKVz8jJJA0hjPRKLc6EH
	 Yq1tc0g+qm5DM7dgEE94apyb4h9evHa12mFHSW3SlJ/PYDa1XFNUdOpvQrcnI1Ohny
	 nndM8g8blU7kD75eVTR8DPyAsGTxBptbK3scdbKeYtmTK2NmEftea9p+x2GSRbVzEG
	 V9LmH7n4lo9n5l57WjU81kz/EeSe7dFWuzEFdt+C8bnCGxK9HPQMsS3w1k5lY0Whvn
	 zg4keDCOKDO+s84k5EhzlnEpuBv38RaBHryjLQMGfblQ2R4nMVO7D2HiVIXTJMu1fT
	 XBNvaP/9SBr1tT43ON2uaZhwF8VG5iNjlELKmnftGWJhSTIS3XdORQfWCRAjxQ5Xgb
	 Tzhnx0doq/e1Fru2LGXkVdgy0JmDsOwJ02D6dMjSbZrl7Dd0P9pG8JLrdWbkVW75lJ
	 wW+G8iaTjk2rASJauEgSTCi0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 75B4140E022E;
	Thu, 20 Nov 2025 21:53:12 +0000 (UTC)
Date: Thu, 20 Nov 2025 22:53:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <20251120215305.GDaR-NwYmw4XkOd57L@fat_crate.local>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120214139.1721338-1-avadhut.naik@amd.com>

On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

You need to put here

"Commit <sha1> upstream."

> Extend the logic of handling CMCI storms to AMD threshold interrupts.

...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

