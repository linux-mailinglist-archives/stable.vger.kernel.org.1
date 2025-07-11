Return-Path: <stable+bounces-161682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45AB0236E
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EA8A64BD9
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAD2F2C6D;
	Fri, 11 Jul 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O9c/u0rY"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD892F2348
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257737; cv=none; b=CONNuOz02yto9BwTbL4ymrid0CinmtLd/d4wtVnpjp7l9mHWECS6VlY6tpmxP4dXoBetku842/kCpErS70kx6AWzb8BHVSH2hUaVOmBhqXdYWTcvDd1l16Hqmr16NAF5p3mLv8yBwsm86TsSrJuguqc+T5BLdBt9agq/Lb2JEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257737; c=relaxed/simple;
	bh=Y6VjsHe3WCDLkfLLCySx4ZHPMq9nnh2GS4GqYpZEDaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4R90WKGQEJma0ohZ6BG/tG2VOEATcZ4Gy/9PHKM/KEbrc/FTti+dIhgP6y8QovzyqTLyg4XZOpvjz0IWnOarb12y+5/okjTlaWPWJqf4KyoKPyrNCsrY67BcvxT0Wy/DDRILAZNKTcl9T4WnHENU10LFEg+CBcuybqF/mIZ2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O9c/u0rY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F01440E0202;
	Fri, 11 Jul 2025 18:15:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id roP4cuLe-1WG; Fri, 11 Jul 2025 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752257730; bh=fJAyomN3e4M27v/CdnXm8jrsVkXhp0GFNzrBZL+2GEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9c/u0rYwo6RKPOtuhuYgB/P2qi3zbxa6YmU5BLLU9aYdT4GpwWDK4yJGbGXmg84k
	 Wv8sHeGHI1PTOIA/V7o7ykFUmAgokg94PbyLLo80+E1yEx0HMsxFLDsIPCWUwkCW2q
	 GoGoiG5+qW2YZAptAETurReoA/cL3RmRJp8Fd86V0SAxMv/yB7CKF25LlHe9Hd6L+f
	 UzebA7r+DGNKi7TR9q3XLs6BMDkFZRGl1BKnE4DC95GObfqFr+SZ/A7PCPPUo9fnOj
	 W/XYqnNYBt455aQXU6qWNWAlEMUdoZohXADWvj8QPCn3AHIvZcLsau67QDgGoBKKSM
	 YidzEqaqkImn2txHSGy4n0muBldPql99cYE2zuq0o6J+fms8PXrpTNf4Uvi0lSmqr0
	 uH8Wj8s7CQzEEOqwBT78+oUJjno69cvX1y+YbRVcsNUZ4bE+/Y4kRCrvVBQlSN6Sgv
	 bjeg98HH7GeeJo9eZqyUKOpf8eJbBTzTCBtWSDlxW0C2rQ1OywK8/gWo0MdlMl1Td+
	 kogPmJcS00FloNv3D2XFHMBOsO5JWENb1z8UbwEbL0Qot8Xq6IHib0xRjeY/dmeosD
	 8eS26UMYvFG7kTvoxMrE5hNrWm6yu3G7lC1MhDusi/gD51fh2Pb7ineaxTOoIED3vA
	 j9Ua+HFHic/KnedimHaBne9c=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E16D640E020E;
	Fri, 11 Jul 2025 18:15:26 +0000 (UTC)
Date: Fri, 11 Jul 2025 20:15:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, kim.phillips@amd.com
Subject: Re: TSA mitigation doesn't work on 6.6.y
Message-ID: <20250711181517.GHaHFUtblXgUqlf-ym@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
 <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
 <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
 <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>
 <20250711164410.GDaHE_Wrs5lCnxegVz@fat_crate.local>
 <bd209368-4098-df9b-e80d-8dd3521a83ba@lio96.de>
 <20250711174157.GFaHFM5VNp1OynrF7E@fat_crate.local>
 <1a655339-cf7d-d711-f8a9-a5a689422be5@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a655339-cf7d-d711-f8a9-a5a689422be5@lio96.de>

On Fri, Jul 11, 2025 at 08:11:03PM +0200, Thomas Voegtle wrote:
> works.
> cat /sys/devices/system/cpu/vulnerabilities/tsa
> Mitigation: Clear CPU buffers

Thanks a lot for reporting and testing!

I'll add your tags to the fixes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

