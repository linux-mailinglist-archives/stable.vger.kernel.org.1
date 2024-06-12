Return-Path: <stable+bounces-50231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E990521B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A541B23B70
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5D16F0FE;
	Wed, 12 Jun 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVMaBIuC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2516EBF6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194148; cv=none; b=VS5/xcP+HMca4KnKEbI/HNnBz/IQMLY457Ug3OHcDVN7owGzd71AbO4PnXQ3ZqmspVuJ1N65MON490wvZW7bvmEEFMzKGegAWDl0eZOiB61rx41MmpsFI+SEcsqWEVfcfsDla1ey2zB6IV+UtzkyX27t84d/3tnDgvOOgwkgk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194148; c=relaxed/simple;
	bh=P9Rh1THPcDZWZ2vIRajiN5C+S0KMFCIZIRBmZaTFeOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifij00dXzfMelFrzChJfjQKGGYTRjPLmqHJiWkIYQkRb33Nj2aRmx6D+RiPJw72L86ELn8zyPhlnq2xf8KIvFZ4xOSKOlrxMKCzGZ7Pd3RzXKAKGnzDFYGWdnWLaivqtXeuOnZgHvE89X0u2eBGY6oEoOL6ygSO+f1RJGaEtNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVMaBIuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB57C3277B;
	Wed, 12 Jun 2024 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194148;
	bh=P9Rh1THPcDZWZ2vIRajiN5C+S0KMFCIZIRBmZaTFeOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVMaBIuCm8/88lNXcZ8tr8M7t7JXvfblWAQx0p/hJY5CdburnXoSSvei1bxVLvF0z
	 8zpFSFbPTQw/bd3HvAYDuu9lPiNbzO/1xch2x7dttGVpVY/7MzqwDTp1OXanQFczeJ
	 Zd7IolP70hT1mQfk4gnPHYxrPQw19n2PWyZq9uU4=
Date: Wed, 12 Jun 2024 14:09:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: Please apply "drm/i915/hwmon: Get rid of devm" to stable trees
 (Option 2)
Message-ID: <2024061257-avalanche-convene-6554@gregkh>
References: <875xv1lu82.wl-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xv1lu82.wl-ashutosh.dixit@intel.com>

On Sat, May 25, 2024 at 09:41:33AM -0700, Dixit, Ashutosh wrote:
> Patch subject:		drm/i915/hwmon: Get rid of devm
> Commit ID:		5bc9de065b8bb9b8dd8799ecb4592d0403b54281
> Reason:			Fixes potential kernel crash listed in
> 			https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10366
> Kernel versions:	6.2 and later
> 

Now queued up, thanks.

greg k-h

