Return-Path: <stable+bounces-39272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF048A285D
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E73B22B47
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CB4CE0F;
	Fri, 12 Apr 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPVv+kHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D24CDEC
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907542; cv=none; b=FAtYrhTT0DROqCAcGHPzdpm3HG7CcqfsdrDYJMqYJ2HqaTo03hCvx18DuFRb+7ZgCT9bm0iGRVo0YG8VeBqjhp8A7Ox7pQHxo5RiHITgWO2BJRQKllO+3AGW0cc4C83CwcS1JeOPnazRjdsESXZml8fWyaRyG/SHr98UTYlGlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907542; c=relaxed/simple;
	bh=k5LjnzY3RIQ33MNTJ2eJv0Q1G2eGvuKJSp5dB7mc6BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je5sLx4E1I4i54cqCAVhaNjn0h7Mfk6ftkcTQigq/lyypQ/mg47EbUI84H90ETrUp6dLy+amYUiN7I3UG49si/GpDyPz65YTXZAwkUOCfmzXyXqsamDjyFp/67hUhpX3dFcVdgItok5MmoLOINHHaEQTqFZ/WvTU9cCMrfjCLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPVv+kHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E5C113CC;
	Fri, 12 Apr 2024 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712907541;
	bh=k5LjnzY3RIQ33MNTJ2eJv0Q1G2eGvuKJSp5dB7mc6BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPVv+kHuKt+rzU+r3JUF6fdnWok44ZZBt26IROI9l9SL+YhFdD7H49bKxRjAaWEcr
	 DcXC1WOECHgFRwDjizs71AIM2u6sElL4WA8vsG6A5JRcidSnRRor/E7FevCO3KSTvF
	 kpU13mhJyEmz8EZzMma7zQn69R1u2ioIzJLO6jgE=
Date: Fri, 12 Apr 2024 09:38:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: stable@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 6.7.y] drm/i915/vma: Fix UAF on destroy against retire
 race
Message-ID: <2024041225-racing-overuse-d9aa@gregkh>
References: <2024033027-expensive-footage-f3ea@gregkh>
 <20240412071500.275976-2-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412071500.275976-2-janusz.krzysztofik@linux.intel.com>

On Fri, Apr 12, 2024 at 09:12:30AM +0200, Janusz Krzysztofik wrote:
> (cherry picked from commit 0e45882ca829b26b915162e8e86dbb1095768e9e)
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

Note, 6.7 is long end-of-life, you can always see the list of currently
supported kernels on the front page of kernel.org.

thanks,

greg k-h

