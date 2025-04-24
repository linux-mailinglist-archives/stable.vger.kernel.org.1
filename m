Return-Path: <stable+bounces-136624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5AA9B910
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308824C4ECD
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C821D5AA;
	Thu, 24 Apr 2025 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W8XUTGEB"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0421A459;
	Thu, 24 Apr 2025 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526161; cv=none; b=HSR2KoxwwC8PqUNfKBOL8C8PhDfhUTo/5McbYr+r435kgk3MJzFt8+N6vsLXZWc+H4fJSi61UFIqMcRB5Wwxn8b/A75N6rBu/lQ3wvX7Tvt+jDVeKkB62I0QCWBCzsqNNEQf9QCJHlchGGT93O6lEOvDt64FR5UN7umHmHv/RfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526161; c=relaxed/simple;
	bh=y2ccDgPwRVQKx5ufljmKzAES1LjiQYPjGH+KoG4lbKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlx6D16Dj2WdCewezSPBEYabz6dKyM1Inl82r/oGjPM2SQfnqq5Kod5RQHblqoNUOw6NMsp5KNJZhWgXG0LGVnjNaxyGl+F0HBH1lps+NF4mc2o+QYEmVZrhSlePe+P9vFhPC+Mqenivx+NEtipRUEvy8XL3nQf9iwvhMkC/qwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W8XUTGEB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FB2B40E021A;
	Thu, 24 Apr 2025 20:22:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rv6bIOhr9WWs; Thu, 24 Apr 2025 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745526154; bh=sxcTC4zrBpR1qncz+kMqMgMBNGRT45RQo5+uKnSoHEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8XUTGEBC/LgTSm7m0LokR/g3E2Ofr15m0i/fwy3aroLLEsHO2nRXw1VymdRKm/tg
	 VahtgGryZgVq9BhjwJQIL4AJmt0RRxZYOFkHpPNEOlP/b/WferumOlm3hNJ4SGlkqZ
	 XCchSfQ6+vWZY6nNYyJa+e3WVp4Pg2m7buDMcgTBrODL/ztQVRo1KPPbV6Po/d0G48
	 a333UNa8sHhll9FlRFKcRlA+YVXsUE67ttpaKEVXXpdmrYvNTHbcWzRjsNHqXrdJc6
	 Yh22NLfR4714Z5vMN0dnmiVUYzBYjftlFoI7Io+DfE4EXO09NQwdXM7m5AkjvBttzx
	 IErIHQzRSxqevB30WCFIXrg35W1boBYnjFUpCMS/CDAtyACkusvsuudUz37ecH/w7V
	 U96CarM52okSUVDEohXIUSyhEFJRk1/lkyiyYFt3f8QW0ugTtmMMqEc2AP63rGLxS+
	 JunZYCWjA6oa027LTZx6MlghodfIu5HUpxwFqsgUDz/RKhGWpPbLbTjpC/hBNBTcHB
	 SLaUsGCeqTVji2DqR8i8Q1TT9AHCSQoAxuDvTMw+w3won3dANByN3HBt0u47Q1LE61
	 oJmAEwIcGLUuRW7N9s9xt4FpHTsxHnzDZj1Wr5tr7tUMper3HZRU54Yz8j7a5eihPK
	 hdfuksRmdQiBsGBegJzpfkVE=
Received: from rn.tnic (unknown [IPv6:2a02:3031:201:2677:b4a0:48b8:e35c:ca37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8B16340E01FF;
	Thu, 24 Apr 2025 20:22:13 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:23:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	kees@kernel.org, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, gustavoars@kernel.org,
	sgarzare@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Message-ID: <20250424202312.GBaAqdsMkpd-WJg5xB@renoirsky.local>
References: <20250424141536.673522-1-Ashish.Kalra@amd.com>
 <20250424180604.GAaAp9jG7N9YyYeprz@renoirsky.local>
 <2ec2ec0b-0537-4502-948f-4fa725ddbdb2@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ec2ec0b-0537-4502-948f-4fa725ddbdb2@amd.com>

On Thu, Apr 24, 2025 at 02:45:28PM -0500, Kalra, Ashish wrote:
> Both patches have been tested by me and additionally both have been tested
> by Tencent in their development environment, so i would say they have been
> tested fairly well.

Ok, once I queue them after all review feedback has been incorporated,
I'll give you a branch and I'd need you and Tencent folks to run the
final result one more time, please, before I send them upwards.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

