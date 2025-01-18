Return-Path: <stable+bounces-109446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E49A15D7F
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 15:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3B0166ADE
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27C190497;
	Sat, 18 Jan 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoOt4akL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056C16D9DF;
	Sat, 18 Jan 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211932; cv=none; b=kS37lh2/n9/jt78g2u0C1dlWkZ0B07lYMXrG3J1l3ONlohiPdnRITy8MvOK8ssg9nkQojU/LRpJZa9Hru63ZZs0SPXkIH6mISOH+ez0fHFfwm+D26aiYpE944Mq/8hWs25J7Xqk+PrEeJ2KMbgbOR3q/JMlkAndBQhpUpUa42i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211932; c=relaxed/simple;
	bh=6QsH5r2JVw4WdrWgOEANjizpEDV0xWmEzdAv5VUKOfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSMIjtpFbwFNuCqQbNtnU3o5yTx4iPWutHZlNu54QxGRhWLPa5ckAlrqJOkttnhXqZs8GyHMW02owLFUn+r6gQ1PzEbu+2t4YkYVKAtcXXQZDgcarZY8v5V8PHQvcawaLZEIJr2NFVszc/THHrQaAdbtNQnWJHDK8weUVB+cNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoOt4akL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5591DC4CED1;
	Sat, 18 Jan 2025 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737211931;
	bh=6QsH5r2JVw4WdrWgOEANjizpEDV0xWmEzdAv5VUKOfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yoOt4akLVvDhuk4A4ho3o0qaz/GrOn5YGEHRDjI8GeY8LFzMplLvXCOrwzgqeThwy
	 9Rtbxx3L+QCLw6P+mrZxUdQ334DCjua1dEid3crdaoDy03dk0G8x2oa83JAMY4BM0P
	 pcuqrF0a8zb6j4ImPX/REx4vvqmdFDVPU71vqiOk=
Date: Sat, 18 Jan 2025 15:52:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Cc: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef
 for CONFIG_PM conditionals
Message-ID: <2025011849-graffiti-swung-a8ec@gregkh>
References: <20250118122409.4052121-1-re@w6rz.net>
 <Z4ud2ua6GrwqaaBl@9bc2624f7252>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ud2ua6GrwqaaBl@9bc2624f7252>

On Sat, Jan 18, 2025 at 08:26:02PM +0800, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> 
> Rule: The upstream commit ID must be specified with a separate line above the commit text.
> Subject: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
> Link: https://lore.kernel.org/stable/20250118122409.4052121-1-re%40w6rz.net
> 
> Please ignore this mail if the patch is not relevant for upstream.

Ron, don't worry about this, it's a false-positive.



