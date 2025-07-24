Return-Path: <stable+bounces-164616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE47B10D6F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493DB1C87499
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F22E0925;
	Thu, 24 Jul 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IvdPYPa8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30E2DA74A;
	Thu, 24 Jul 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366994; cv=none; b=eVojj3UAubb/ii3HuWf7eA9kc0iC/p3vPq6+4TWByrv2hTVNa2yau22SacwxGD+gbQyStD46lpYzps52Mzzpfa6egIuFAtEM4YkHCKvR3zd6hv3GJjZiQApdUqAx80VxCt1yXVusAkTCL560F1bA4LY62jhMyf9TMK+m2kGCD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366994; c=relaxed/simple;
	bh=6Cz7GV6Zqf2gSNVM0mNkF0gdFV7Ea6eFphF/n7avkxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxEotbpM3u/ctOIqdBmH4+sLHYBW6tcdwsHH+GFekEEqFv7QT+RNzQ8FjrxDAr3nItdkYB0CuNN4gjlKnshO0rdhc/oi/z0wfvTwTUKrZ/nzbJxpNvMFsLOvkZOhcM4Nowiz42Pv1C0+7M6Py9cr3rDMaqMBEqN9dEDapSq2soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IvdPYPa8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3AA5140E026A;
	Thu, 24 Jul 2025 14:23:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sF_U7XUFOYGo; Thu, 24 Jul 2025 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753366986; bh=CXrtkrbk3JW8sRHE4cFKjVLIz7pLtFMQKpN/mwKXvJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvdPYPa8jr5yt7k2Y+fNvcjRuak3n2kQLKDQ1QO2jJvbfHeWu9QPoznlgTboJhuaG
	 5yZHtC1cEKM4XWgKq2ujjzfGuw+A1SLCyOgFeqomxBlt7Bh7ctEWLnOUbxtbZuABhq
	 8L3q0d3bGwXEbtI2jkbNTRwaIcL/qztm+gWeTsa7BSKYkFbcDJ4Y3Nv9Oi/iWioDDJ
	 L5YzDwIXZ1NvwsORtdz5Lmi3hdxBxJyLVPaQnTNkTn9vKwK6jxabBipajjF8R8BS2M
	 kOx+ifDAudokRdF9SzRaO5vkis9nwgtU32F5XynOWk8exRxexZV+3EK7SadZR24eTn
	 mtsrrXLxuGneJR2OB9VoSyw8rs0/H2ExXXekqED0dAi7OqkISZe4k0mz9/seb3C0C6
	 xoMXUzthy+YPBIOUL20KvfDJN7yrFPMRFmKS+SsSVTsReMlZJI5CH62C09ziDqLk5z
	 KelICRu9B3sPv8GlbKReZJ9g2ZvdcC3HCuS8pzCTcfQe9sm+ACLLOFoVjL+CjTeWai
	 W2tl59yCx3toL9aVXYbs4i5zWiPAScZJWi93ddhz1P3ZJ8fo9B+SB23fQ5EVFA/Fph
	 xvCh9pdd2P5FojkpL8hkv/BK3jewKa2s+G8xt4vfcmHrI7V7IlYVtyIXZscZatYIRj
	 aVuMaYRhq/mJjV3Z4NrkDHYA=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5138440E0269;
	Thu, 24 Jul 2025 14:22:51 +0000 (UTC)
Date: Thu, 24 Jul 2025 16:24:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kyung Min Park <kyung.min.park@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, xin3.li@intel.com,
	Farrah Chen <farrah.chen@intel.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <20250724142452.GAaIJCNFO9tLS_ezVV@renoirsky.local>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
 <C723416D-E1C9-4E18-A3B2-D386B1CB2041@alien8.de>
 <bc4w3nbkjzyrwmcjodrrwg7klgg532gre5v6fiwe3jvrww5egp@zezyxzny3ux4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc4w3nbkjzyrwmcjodrrwg7klgg532gre5v6fiwe3jvrww5egp@zezyxzny3ux4>

On Thu, Jul 24, 2025 at 12:59:47PM +0200, Maciej Wieczor-Retman wrote:
> As I wrote in the v2 thread, based on what's in the documentation added at the
> commit I pointed out, the behavior is a bug.

That's all missing the whole idea of Fixes: tags and backports.

Your patch must point to the correct faulty commit which causes this
behavior or to none, which means backport everywhere. And I already
explained this to you.

Pointing to a commit documenting this doesn't make the tree *before*
that all of a sudden not affected.

What I would do is, I'd go through all stable trees and check whether
they're affected. If they are, you craft backports for all of them. You
were already asking Greg what to do.

But pointing to some innocuous commit and deciding that that is the
culprit is not what you should do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

