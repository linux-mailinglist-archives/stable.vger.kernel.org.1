Return-Path: <stable+bounces-36071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF417899A5A
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C11F2370C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656EA1607AF;
	Fri,  5 Apr 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="btXYkkgO"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38B15F3FB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311793; cv=none; b=EZ85jCNIrsI+48wbVeLVV6PJzB6jyfdnyM4m5ku6Sa+94AKg6BYBnBYBlhw+WuGAURtnb5643ww1m5Vu2xYFaWcICJBGDh0V7iy8RrWRCPxlbdJDxNjJAHNShJlUVvvxR5LxGo4Y6CRq1UZ2ColzSWRffoxkLLRdUB6UXCR0eQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311793; c=relaxed/simple;
	bh=DjqqTnB/xDnGv4Ty+rZrSmXa7eCAI5zEF/4ye71GAe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyQYC5OioR1tXl3Rj2owbvZaBQE0RGmsM4jQKiFBbp3vOsbu08AGTqO6zb/+qnLiSJS2QVqKg4ia/bzB3w4VwO9INhV5I3ogEkiAWW/MgcDZcXpWt2Qt4gEvuVjnI3Pqu25c8uobanxfpIDOW44RNu/ARv96yAKSo4ugsOjYHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=btXYkkgO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F76140E0177;
	Fri,  5 Apr 2024 10:09:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q8onslIo4aff; Fri,  5 Apr 2024 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712311780; bh=8eDaCTidX2A1BymxG+W3ltL3wmNhuIDCQ4VnQcP5vzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btXYkkgOEbgPMPzPh5x/Hj5udbT/Vp9yfqBrbb+XC50+7qEmEBGAtula5/VsRasvl
	 uNAEVNzUj1tujCCQ5KeQyyY+vZgUMcZsUVjWBBqvMvRD+ai+giZlHDXtBiXhJgsxHt
	 Mw3o/L1/gsJqiguUdOKtJHZDD3Wi0Sya3W+xohUNs9bmEhL5WJmt7HXLulFzrinmza
	 SqMYAwE7PBF05O/FwpxJykP8K4zOZNUcNRf7VWLKtyNdWr+w8KuKfqWMphJmwtY7SS
	 I5vIVoL7aEOVleSnztimqt6KbexDixnu8AJDHMcpWTslaDVDZqOxZItJKkniqCgyqH
	 OhmIU4K8W1ODqFay4ux50/QsCVQK2Tt0gIly1AKzQVRMKrbkTecukVJMkz5jdWWxtS
	 VsmP1VMqYC1Nz0vh5n/nCfHt2qrDeC7ETo2rf7Ge0MPhqX00eipdo+I+H9QN413H8z
	 QtRExZUSmKdQJyDRoDk56oVrt90jSKUZMvObOT13ApRujoJ407WyDzG+iLf7QdJZUu
	 hlNIDcq3TwRZUOGx3Gz152pmC86eL0QlrH3RB8+HeMv4qBkJzgZ6ukbNeFbkuTIKg/
	 cUD1/JgpBHh7K3ES3GJEDvJjNMLT15jAlhhVkPQJXzEDjuHFaCOvLD3a8kZakkZTtG
	 3mfnVwbhpZVfeJS7WCGZ4kgY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A387640E022F;
	Fri,  5 Apr 2024 10:09:36 +0000 (UTC)
Date: Fri, 5 Apr 2024 12:09:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.1-stable tree
Message-ID: <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>
References: <2024033030-steam-implosion-5c12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033030-steam-implosion-5c12@gregkh>

On Sat, Mar 30, 2024 at 10:46:30AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

6.1 is easier, actually. 2 patches as a reply to this message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

