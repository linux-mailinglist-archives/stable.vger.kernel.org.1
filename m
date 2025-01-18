Return-Path: <stable+bounces-109445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05FA15D7D
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D5F7A22A4
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0718FDB1;
	Sat, 18 Jan 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktjp0CvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E016D9DF;
	Sat, 18 Jan 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211887; cv=none; b=N/nPyilh/2NjKsea9erkWVSu6SVl8zrdWfP3fq0db0qz5KHRj3UTe2ZbzjRJD5txBKJCJ8QXs0Dtjc0PNoE4hS/Lhc8IzO34Gmcu+WetCT95c06K5HkSInMVcF0ldgc3pGf3zdhyzf/69RPA/zK4ROAqTGz6h8HbR5Xti/gi4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211887; c=relaxed/simple;
	bh=Vt+PZfHgxBUmtZli9alCo6dDoWXL9HvpJhyunj5ZXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROa5EgllxJQABlW+cSq3abM7AIg5r1v4X/9IvUlXBJfDXs5D7pxZouvAkblLsrZNJp8EQku2KRndrTIPqFFuRs4Jh1Vfy06UGHC7PPTqhTfOyMTTMraWK/+VfeWQshl4Mw7eHJXGgu11v0hnApVR8DTtUSc8IzEss5tI2u7HfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktjp0CvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2289BC4CED1;
	Sat, 18 Jan 2025 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737211886;
	bh=Vt+PZfHgxBUmtZli9alCo6dDoWXL9HvpJhyunj5ZXjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktjp0CvG29IvWr7Rc5r0MHNL1r/PCaGbXABch6VMuoCE2XUgMVwP3jkoxp1Mn8JEW
	 QeYWBO3LLYZtSU9tv1riyKkAXO7LeeTbCk4EputhZeGF/7sCmrR2/iyF5qIqjP0Ikh
	 Y2Carag0bRw7EDxun2SNvtd4g0zzopv33rk7ioUs=
Date: Sat, 18 Jan 2025 15:51:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef
 for CONFIG_PM conditionals
Message-ID: <2025011837-barterer-scallop-8d8b@gregkh>
References: <20250118122409.4052121-1-re@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118122409.4052121-1-re@w6rz.net>

On Sat, Jan 18, 2025 at 04:24:09AM -0800, Ron Economos wrote:
> commit 9734fd7a27772016b1f6e31a03258338a219d7d6

Needs a bit more information here, as this isn't that commit :)

I'll edit it by hand when applying it, no problem, thanks for the patch,
that was the hard part!

greg k-h

