Return-Path: <stable+bounces-107804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867D6A038B1
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69964163D4B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43A1DACA7;
	Tue,  7 Jan 2025 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MhHgO0NB"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FF17C9E8;
	Tue,  7 Jan 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234637; cv=none; b=oyH14nFpwGrU8LbTuqjT2UyfOu1qCzMkWvx0ZchRKH5Mla9+5erB+kl3YUF5mKNb5LKg0sQM+hQXfzenX37gn789VdAG06ehWk4yEMiEEdRwUZ/qGDqgef5VJe+IZGy2ayLwcFeB7vsGJWdInRxKfytnEvMWTfY1Eaakh+9VIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234637; c=relaxed/simple;
	bh=n7CfH5P9XDrJw25hKCUmMWs4qCal3POjk/QfTTLZi84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0VGR1AiPBL7cDIXcDGpMV4V9Hj6kWzWNeZZ1DanouH0YNQgF2D/9nwfsPa7h77efMEEp1VWcuBT1USCCKuMfdXC778OPpwkZJsoXBe+WT1V8R8kPBVbYFpejpOs/HcVqMIYywdclb9AviiuxYHe8YxoQKgVBRgPlo5icfNNd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MhHgO0NB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AF3B40E0266;
	Tue,  7 Jan 2025 07:23:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vF7M6y7ldj_g; Tue,  7 Jan 2025 07:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736234620; bh=Iy2MdtmzqMdzcqhPna7eY9cGary7BM1hpOq9KoCP8Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhHgO0NBkZf/J4Q0+H9X7yr6+/nrqoSrtU8OSMG7FohDnAqZZVSGN8eigg2vK8X6R
	 OMGeBhv4yxHOhKWi33VdqS3R0Zzsrv414btJHH34U950DZE3zUxZKB98XlxfIAg3dw
	 yz2c3kuWSIWg+uuKD+qwRzQtavyT0PBnF5blvrBaEncLpmQF1Z86LlfaKR0jhUTFYl
	 cGHCvL5I0AiAcjH9+I7+Arc5PRnwaYXQqP1ihueX3N+Mkhcg1zHkWritJ7qZNkhRiY
	 U3oJRe7FD1cfXrSuBV//gS0J5YkcxJpsfmW0FPtkmpfGQdFO7O3jYrowUDYPfY811q
	 IO797K4Hfur7bdy0Hbac6MnnvK2eCPZQQx0KSAdLi522QurgKzIrg0KuHeH0tkaRhn
	 q8pD70rK6yfAuk++UDtQQ/pFrWa6+Til1LDvGfwyvX60RW+r1O73QECrprJfr2r+l7
	 KJT5R2ZePr83NcYElb06OKFWPQMS2tx51272x23OPua2vKCk6sCEjoevqqDpZT+p6k
	 DG11pRYnFMgTD8dvOsUmL04Vzxio9OkDwgASxCG3+hqCDlBmfrq831MUFxfemCD/Yn
	 YgIdHfr6bYwVww1KLI9/4bimigwcSaC3JuJmPC3zQWZmXWFN7AJSQSN1xVF87NKQ8T
	 hQZCjVqw5bf5Lw941R5B3FlU=
Received: from zn.tnic (p200300ea971F93e8329c23ffFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93e8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D5BC40E0163;
	Tue,  7 Jan 2025 07:23:34 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:23:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <20250107072327.GAZ3zWb73urbVG9BqJ@fat_crate.local>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
 <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
 <g4sefofdrwu72ijhse7k57wuvrwhvn2eoqmc4jdoepkcgs7h5n@hmuhkwnye6pe>
 <20250106182800.5ed66c548b9bb5c77538f2e9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106182800.5ed66c548b9bb5c77538f2e9@linux-foundation.org>

On Mon, Jan 06, 2025 at 06:28:00PM -0800, Andrew Morton wrote:
> Thanks all, I have queued a revert.

Linus zapped it already.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

