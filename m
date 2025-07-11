Return-Path: <stable+bounces-161676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDFB0222C
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464707BB14B
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12A2E426B;
	Fri, 11 Jul 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gvdf2gza"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A422AE66
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252669; cv=none; b=MHs3X0l4/THeC6q/qWbsDR5mYWAnbbB9n8HAl3tUvR0XktPczaLE1qMag9Q67QFwe9NFfbOogdp1ue7Z1zuvgSN/twDiz5VzxWiv6ARHWpjkdIZMUpc1BN/46hsD5WKSVMDpHbAx4uUsRLPca06kYgy5J5DjwdR0wbbwlSNc5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252669; c=relaxed/simple;
	bh=GLpmitkIhtk06lbgEGXvvI9ft9d6mnsN8+GGtiRs9oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAVoLpJnJI5B15HM7kQa9ZEtZyApMgyB0yDPirSTrHPqfroBeMTgtzrZGpjuIxNOcnjqwztVoitpO9Qn5P1SC5JjAnDTb5twjldb+u+KxvcrYc07N28X1U9mGPmT/zO12VBajFYXNjXfwl3XafSIDyKaFwpOQy/B9HN6KSdKQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gvdf2gza; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2789D40E020E;
	Fri, 11 Jul 2025 16:44:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XpQoQll4aoDA; Fri, 11 Jul 2025 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752252259; bh=ee6EQNl8MZlvnMAk4VBtEXa/TWZKq/MwFdZOecx1s3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvdf2gzakdr+FVyD+PsEbwizifS0anjdetyNIpFFq6YDm89scmzQOhPIdC0W5pIb7
	 V/c3ac08c1A0Xi5fdcVFr++MxTgeoQ6sWbDYeVoNCmN4Yw15yRLkVlmRCLiuXppPvo
	 M+QgVOSZfrZmoWJkaSymIoZH65z0RuzPMiL29U82VN9MlEbD2esYom0Q0rb/0jXxe6
	 mH2/qAiL+SchDrbSIdj0x3TiP4y2XoUvnOtvgrx13tmVSppWBiC1i6TyeCnqLI2ead
	 RYt8RpDvhglRxf/644cS3fnt1XD8O1YXEnPilGPskxNwFg2hBs1/rv8DJXcSw3Gio+
	 g+LRyNejsivx5C16JSOwmZkcSlpZFh1t13tgvUNdUejDcTXA+lJympoeiFaT+TjvYO
	 daCGXpsUuTLBQl1LKPQ9EAeYbQgXg+m8HIspIG/Xkmg400DNMAxzt+k/PcnEdBEPRV
	 RECNI4kdaApb90qIUeSv4ChyeYgL+EhL6W/QtjIi03yh7ExISLyVNgAE2k4PH3TP4m
	 ALZbzLyJXcQKUD5xfjtmgkSXrvgsD2CG949GTZMX3NNw6NHXUTQOG83JvAeId1Au2M
	 Bx0Ih/bpvnQkDOVXd+tErV43PaKKBz5JelZD/jK0W3aBQKYecA8wrkXIJ1FFeoT/g0
	 0+zLpxyom36siLmLTYDVsQnM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC20640E0205;
	Fri, 11 Jul 2025 16:44:15 +0000 (UTC)
Date: Fri, 11 Jul 2025 18:44:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, kim.phillips@amd.com
Subject: Re: TSA mitigation doesn't work on 6.6.y
Message-ID: <20250711164410.GDaHE_Wrs5lCnxegVz@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
 <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
 <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
 <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>

On Fri, Jul 11, 2025 at 06:03:39PM +0200, Thomas Voegtle wrote:
> This works.

Cool, thanks.

If you have 6.12-stable ready, can you pls check it works there too?

The diff applies there too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

