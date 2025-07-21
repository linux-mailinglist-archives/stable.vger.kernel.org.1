Return-Path: <stable+bounces-163590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A07B0C594
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392C117E9F2
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC42D6417;
	Mon, 21 Jul 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1HNlecw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF423741
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106142; cv=none; b=kLEjkvjOLOyC4v5drmW6TAB6De5ec3HpXGBGQRDyipLZPesOTEm5YZBj6r/DDfe6lSOkMiW14qW/xpp8YXNOUb+mnhIEJgW/+CkU+rh2c/4/FfzR/lWuzGmAqeIRa/H6A1Yc/+yUZOx0LuIDJdvFoyQWTccoObH5hGAXQWLIGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106142; c=relaxed/simple;
	bh=9z2eJxJqDjUVZtPufGHg1+xlDbGrH/9UnJBJkEPfduU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMD3dyBA5PersH0oT2hWltz1pG3/C695YrC0GMm/jUZQLyf5htteD/fbFYOOcttw9yHd6XMEz796Cys+Wky/RsT6DVgUtQLqz/gAcuO9V/9HpdZATtkGyfPkD0MREVMXZCElHLwN1w8blELzmo4AHGiMNCBtNvQMXfGxoHrhQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1HNlecw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBD5C4CEED;
	Mon, 21 Jul 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753106141;
	bh=9z2eJxJqDjUVZtPufGHg1+xlDbGrH/9UnJBJkEPfduU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1HNlecw4z7oPyt+BcRFLDb/hJ0N5+mRUKdi2SCj4GBQdwTNqVQg1qVGIIWgenYJF
	 Si+aSErSnKsoxrXSjF4rBugiAq679k59KWndZjoGeV1sE8NODvjmb3vx76u38dyvR/
	 NpcwKnOkKnyYQUS0LbWdeL6vtdaRdqPvJx6fgdV4=
Date: Mon, 21 Jul 2025 15:55:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: stable@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	peterz@infradead.org, mingo@kernel.org
Subject: Re: [6.6.y] ipv6: make addrconf_wq single threaded
Message-ID: <2025072130-commute-profanity-19c5@gregkh>
References: <20250718101603.5404-2-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718101603.5404-2-bacs@librecast.net>

On Fri, Jul 18, 2025 at 10:16:04AM +0000, Brett A C Sheffield wrote:
> TL;DR - please backport
>   dfd2ee086a63c730022cb095576a8b3a5a752109 "ipv6: make addrconf_wq single threaded"
> to 6.6.y (only).

Now done, thanks!


