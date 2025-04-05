Return-Path: <stable+bounces-128375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5DAA7C803
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD5E7A92CD
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA91C6FE7;
	Sat,  5 Apr 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUaXS7KI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC238DD8;
	Sat,  5 Apr 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743838940; cv=none; b=uaFdd2pILMc1MHkOAKyXsmNj9KSZJYYzuBRvsXf9tKIvMNN+DZKkqt4o//iUJwwBZrfRqVsn15kZOpSQ8g12ijlQMgGTLhMsy+zAK9lp3yAuQAtEL50pyB6WtlptqIOd5cE6owH6SnZ4LhOYR8JwtVWO2UbC4XIMMMiccVnroBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743838940; c=relaxed/simple;
	bh=a3X1BuwK5GJvXkzacEEZxUuSWgtDsg63WeAj5YiJFzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAFrccJWZdpxyvV5KdNNMJy+R9ijxGEgBfIgSQ4m4IZsOItNNqaz0c11Va9yvYcKXcA4zdf2UBQCTXPeAfsHadFxhWLBcojNfPAZyH9NjFOFlH1Y29pi5V02l26ZrD/PAa0CnVSQ6xCnpzywAbeaKiGK8I+AS6B9yFc2ifUmyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUaXS7KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6046C4CEE4;
	Sat,  5 Apr 2025 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743838940;
	bh=a3X1BuwK5GJvXkzacEEZxUuSWgtDsg63WeAj5YiJFzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUaXS7KILjJdkaNzR/PQDmAkJpUqgFHJ8t1x0K5B8avKiTTOw5OtCKUygwLq5u/F/
	 nQ0Ifcx2qLUyfsueiTtNqI3kHuR4Fm/IDrR3qpCeBWkXAu0WvIFB4O9oNLvR0X/hmd
	 BsaUFtk10zmjjZig0rAKh88Ovw989kdVen3RuIxY=
Date: Sat, 5 Apr 2025 08:40:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: msizanoen <msizanoen@qtmlabs.xyz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org, Roberto Ricci <io@r-ricci.it>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Message-ID: <2025040532-salvage-armadillo-77b6@gregkh>
References: <20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz>

On Sat, Apr 05, 2025 at 10:09:24AM +0700, msizanoen wrote:
> Handle better cases where there might be non-page-aligned RAM e820
> regions so we don't end up marking kernel memory as nosave.
> 
> This also simplifies the calculation of nosave ranges by treating
> non-RAM regions as holes.
> 
> Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
> Tested-by: Roberto Ricci <io@r-ricci.it>
> Reported-by: Roberto Ricci <io@r-ricci.it>
> Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
> Signed-off-by: msizanoen <msizanoen@qtmlabs.xyz>

Please use your name, not your email alias, for a signed-off-by line.

