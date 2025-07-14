Return-Path: <stable+bounces-161828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F4B03BE0
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2093AE1C6
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F523A994;
	Mon, 14 Jul 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RnKD1WCD"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA5244667
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488909; cv=none; b=W68AZ2HiO5IZ+YyuqxlWt2mDK0GUMOPSbXwsXqXmB5LSiPbBzVxuqj2HMyPK/A0icwE0X2IxlEnTYkXF0mMoghf//GomhUpRUmM2oI7iEWyr14UzxkhfPSDBKlSu9zX6rl1dT8txC2FjOimJWe3RW2vw7YZt0VdZk/0AOq1tzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488909; c=relaxed/simple;
	bh=7yADEWTeQvWEyXntYQDvCpizagg5l6hdkeckKDwGlaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBWYwZvhQHW3bEiYj/82R/pCruW/xQ5So0TrEzCi5//VZR2S95tCjczdZY55EfPh9mI2BthA/nSAkQpiUz1UcaKupHOgiDlbMI9WhtXDZimg9IPBrYRNR1dgRK4tDCchkoc7FWSBryWT6gDjCoZ3iCfYUrRRyanpIPvSGS40eVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RnKD1WCD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBB3D40E01FD;
	Mon, 14 Jul 2025 10:28:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id etK1Hnlhk3fY; Mon, 14 Jul 2025 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752488902; bh=0N129S/2LF4YYKwBMmLRjXx9nFwCK+yI/FIkVF5t69k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnKD1WCDrJC8H9UQzD4guM/gQ2Ljvr/to0bDbWn0rk7xBo48o+4b7kCFo1PcBP5wW
	 8XdhkRo00a2s6cSTi/I5M57OWQaahZ62n5tM6wQmT1qH353z+VWpPjmKCNj1GwQKkF
	 3CQJ5e2LePV0tTDtlYkYV+Dfuj02bctw6ppt3LTa1+AymQnDOl57oIEJBfTGooO12L
	 UgEAh1lOuz6Cb9jhZySE8Kgaw/hz9OfcyyvpDZ5j0lZL2u/le+FoHGP1mOSPeoX3Dd
	 PR7Xcb6O8K7HAcCDDu7PP/hXjUc6qknt+4UeOmIVixf26L9w4Zi7Ne1oDmnh8Zfpgg
	 eY0R7q3Ryiyx1qM7INHpHzFFX+TXLPP1BWYNpJ6XZ05rwY8U9ux0z/EdTlv1SOJ0tQ
	 Q8eIkxm+YbgaUDKdaxxqBhDubUam6/aN/SqIADwUbSweOc2L9VqnrMTKkSz+Ui8Ry3
	 PinV+rdR5kgjyAQEoktj9dQKl7YC5cGVxBAiilRj2AICdrJEt6nnWeMbPZQru65qTJ
	 ouhnSw0Uz5rp2hLLbHNwF64rylfP7Be5gGzPSckExs24c6sRAZWIdw25VfcPwjhxnl
	 hSBruswN6hxYhLD0o+Mn/w5OtWBErhtjExU7RRI7OQ6aIjbYGQNiiTG94mYuHwiuYf
	 nq+FrsPhw5safOxG1+m5d8Tg=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B00C740E0208;
	Mon, 14 Jul 2025 10:28:20 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:28:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250714102819.GEaHTbw207UYtxKnL7@fat_crate.local>
References: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
 <20250712211157-88bc729ab524b77b@stable.kernel.org>
 <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>
 <aHRiYX_T-I--jgaT@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHRiYX_T-I--jgaT@lappy>

On Sun, Jul 13, 2025 at 09:50:25PM -0400, Sasha Levin wrote:
> I'll add "stable-only" as a filter, but you have to promise using it on
> all of these backports going forward :)

Pinky swear!

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

