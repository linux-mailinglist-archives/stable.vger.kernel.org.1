Return-Path: <stable+bounces-192191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE33C2B90B
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6024B188CA88
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D91307AEB;
	Mon,  3 Nov 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dABSMopx"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF2E56A;
	Mon,  3 Nov 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171432; cv=none; b=ab+WlI76dg4LKo//+48PKjYq7AtULDw6pJazlLKHHSPSVkfUxylmdcy3ihtTvgQBP/I58ut6UqP+KzMN2Rld4X1rFHcxavwa8q3mkDhm70ivV66rAOuzlA3pJA+pIPzndQxAL4DM2MJiZlNbY9+eEwEyYP+7oIpPWGANpcO4hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171432; c=relaxed/simple;
	bh=acw7Ir0FmQ1xJRMVEmdHS7HJOrRUkpHDEiC5cQuSsBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwZ2q0AFRIFwaBW1g41QlW2fZiA/cekKZHHxox69MG4L1Q8vHsW6nDX+lrIaYR9UL0Z+UW/uLJlhlITiLIRy/txhIFt+8H545Qe+JQw2iA1Cn812wCz9PErJJRRmVSag8eohdGLizaRO39qvMy229E4XeToCJ9oOYX7zNL/guF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dABSMopx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17F7040E01A5;
	Mon,  3 Nov 2025 12:03:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id exd2t9Cotc1L; Mon,  3 Nov 2025 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762171423; bh=9GiFv1yTzalzrkPadTjytgcZ6rFofTRbemaOz0R9fYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dABSMopx3PzPo11JZu0fbwmTYbYRcJOrzRxdeLgal8ovpvUJaV4KXNmOjqPqlXlp0
	 +5NOOkJz+gjzQAhzOOvUBxA3nwxl0sHlyf2uIEgZhhHu3EWU9IVWmvf33tMfU2PSPd
	 agIEXdNoUmdWcrAQK8RS01w1dVljpZ2GswbUQZ22jVzB4w1JIr7+wMXYFjMCteH0w6
	 Vq9lIF3w4wrpriJm5sO51p5N5Tz7zXPWFmGh0RHGXF8LSoiVNQxTXjsRA8RURxVe2R
	 CU/pK8jrRFGq5GwcrRLroEOd8uPapSjgZ52IVGxNtlX3oWH9EWM4qrFpvETTYesOld
	 a8l/Ct3NOKJFhaJ6GfMZTAtV3qlQp0WQ8FpbSQp3EPtJ81NQK1hGFAV7/CUzAiYtrt
	 wx9BDWHJps7DCLrvTRUOmkMedZjLltKNp2xiVceVG6/JbB9mSq+GPSeY4c/ORyARHG
	 kdTl7lv+5pmH8XzhNvlCKy89NhuyqMt+L1gSkniO+qAt/Fj5L5dbDwXtCDaP9u8CKx
	 fEFP7+nO4MUszXYm1rH9stxQxr9mhl6DDJpstO+2mWNNCQ0/P809flVyQ5xi7VJM/N
	 5h8yRfoGAeMfHc4gifBbk24NHUx+5eg6nP7T0zkHaLR+/kT59YTDCrECfXw2A/PLv+
	 nm9ZSrVjfRLtojNd/Ruv16Ng=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 612C640E01CD;
	Mon,  3 Nov 2025 12:03:25 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:03:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christopher Snowhill <chris@kode54.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <176216536464.37138.975167391934381427@copycat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176216536464.37138.975167391934381427@copycat>

On Mon, Nov 03, 2025 at 02:22:44AM -0800, Christopher Snowhill wrote:
> Although apparently, the patch does break userspace for any distribution
> building packages with -march=znver4

Care to elaborate?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

