Return-Path: <stable+bounces-187902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15967BEE777
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 486D84E69C5
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA542EB852;
	Sun, 19 Oct 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QqhCqM+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D402EAB7F;
	Sun, 19 Oct 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885177; cv=none; b=EL2A6FWCvmdfT2DsJbK212ReCX06E/HyJA7RtMAqEZ6w29N2cAlH8hgEY+rFVAtPqLL+VmE2WpjAj9gkpUMK+6RSw9Qhw+Moo2K5fh7R+t3NkuwXvPELUt4atb3egC0UViEqCx4MM17tElHjischn1i/wWBPTbQhvT/vHlgxhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885177; c=relaxed/simple;
	bh=ujOhsMLCU5gtvuFQtE4UzP3DeHQGBSWWiQAySIFXeNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts+q3JnY0a8YygFITnmaPujzkCFXrUU9Og7+BYXJe4scrG01DZUHqt91HK6qVOVCC/M+Ci830whMEyTwH/5hGuGXzsAnDl0ijEUEkZSwxDAFrc20J4vqe672vI1hF1UJuBUA6h/rXuma0YxkUpeiGLliNqItU+kqVc5VoU1id1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QqhCqM+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAFBC4CEE7;
	Sun, 19 Oct 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QqhCqM+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1760885168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVsHpEonJ9hJ08nKYXXeX3RSwBmNJmh7Sjc0rqA+k+g=;
	b=QqhCqM+/mWEww0HVeWZyAj8R1BuUhv4M56nzm+ajEWeA6lPnIAoJLwolD8WicA+HOPh5ri
	ZtO73Kr1ShRX+6yVEWPM9SoRhKdTY2/L78ahLZf3LJosn+7Zf7b2EYXxYHDCBcKMX8Ijbl
	+DGMzjyJSQ71geANCBEHPfEGwVfwUOM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7030dd29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 19 Oct 2025 14:46:08 +0000 (UTC)
Date: Sun, 19 Oct 2025 16:46:06 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <aPT5rnbfP5efmo4I@zx2c4.com>
References: <20251018024010.4112396-1-gourry@gourry.net>
 <20251018100314.GAaPNl4ngomUnreTbZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251018100314.GAaPNl4ngomUnreTbZ@fat_crate.local>

Hi Borislav,

On Sat, Oct 18, 2025 at 12:03:14PM +0200, Borislav Petkov wrote:
> > This was observed on more than 1 Zen5 model, so it should be disabled
> > for all of Zen5 until/unless a comprehensive blacklist can be built.
> 
> As I said the last time, we're working on it. Be patient pls.

While your team is checking into this, I'd be most interested to know
one way or the other whether this affects RDRAND too. Since RDRAND uses
the same source as RDSEED for seeding its DRBG, I could imagine it
triggering this bug too (in unlikely circumstances), and then generating
random looking output that's actually based on a key that has some runs
of zeros in it. We'd have a hard time figuring this out from looking at
the output (or even triggering it deliberately), but it seems like
something that should be knowable by the team doing root cause analysis
of the RDSEED bug.

Thanks,
Jason

