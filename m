Return-Path: <stable+bounces-179022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8AEB4A091
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516771BC2352
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EACB2C3257;
	Tue,  9 Sep 2025 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yClCobl9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001F1DA4E;
	Tue,  9 Sep 2025 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391527; cv=none; b=jZrCb2sU2G+0+Y5RsHKtDdvK1zmCAxCVX0qfJ5nFqQ8K4OHP0yV3Szlykh2hCAgXv6jIfOnTyyLvaBM0oVXQAm1D974tJxxwBUOKushAPd338MFBZ18ir/Zfr/Ddh2ISh/nhxX2fDi5lJBLT2YbBnC0tCTQVeOkqSo2B+1tb3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391527; c=relaxed/simple;
	bh=oirQprCJ1ESduAaLG341IAD0wVCBpr+7HmBynU9vLKE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nvhe7Lr2LYuShOROyoVPh46//k7bA+uwE2syneMxqaT81FnuOLt9pbWE3h39qAPqlk/Onqdm+C4wGoXl33krpnkkC2jrLb6CgUkrac8Im3Z3GN9EZhwAdh5jyjDnvJYrGSsZQUXBOGnjXMYV5yEgwKcOwqhSud/LFLUFws87kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yClCobl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560B2C4CEF4;
	Tue,  9 Sep 2025 04:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757391526;
	bh=oirQprCJ1ESduAaLG341IAD0wVCBpr+7HmBynU9vLKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yClCobl9sVnh1i5/FMXkKY1Bbi4M1x49V6PSeAguv7zIeJyc9op/jeClHjNhHueWv
	 6yi6GaDy/xDdg/iuAzfBQaFoh+Uw2p2Li3gi+MXpAAercb9l3Ahozq3Vk9pHKZbrkk
	 dPvO8cUmCXBhsdp9qtYoI+8CxcH0YqpeGtd9vhic=
Date: Mon, 8 Sep 2025 21:18:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17-rc1" <stable@vger.kernel.org>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] samples/damon: fix boot time enable handling fixup
 merge mistakes
Message-Id: <20250908211845.bfc7299d783c361b10ae810b@linux-foundation.org>
In-Reply-To: <20250909035141.7545-1-sj@kernel.org>
References: <20250908193548.a153ef39d85cc54816950f71@linux-foundation.org>
	<20250909035141.7545-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 20:51:41 -0700 SeongJae Park <sj@kernel.org> wrote:

> > > Note that the broken commits are merged into 6.17-rc1, but also
> > > backported to relevant stable kernels.  So this series also need to be
> > > merged into the stable kernels.  Hence Cc-ing stable@.
> > 
> > That's unfortunate, but the about doesn't actually tell us what this
> > series does.  
> 
> Good point.  The issue is that the sample modules can crash if those are
> enabled at boot time before DAMON is initialized, via kernel command line.
> 
> Would you prefer me sending another version of this patch series with an
> elaborated cover letter?

Please just send out the appropriate words and I'll paste it in.

