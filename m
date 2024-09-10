Return-Path: <stable+bounces-74131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DB972B2F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580B0B2244A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBA17E00F;
	Tue, 10 Sep 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0uGS7AR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4301514DA
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954620; cv=none; b=mQ9rlmsmFHHBqzJkpBPi5uVO+EuvbKsLf4UrLkmwhzUmrSNO8xuc8KWJLsrYneyg/PxEN2NU46a/2Woov9B9VfIeqHAtUvoWuDC06E9sHYQYlh/4mOnyFM3Hw53JfrxiJdbnaJqfA8uz7IiWu8XtS/PSqGTcXbAfQhnYyqo5iIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954620; c=relaxed/simple;
	bh=Te5i/tPo5k3QCrIs3A3Zb8hXiH+hY3iSuYO4RfgHySI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Oci4dDOWPoXOOpXzT8CwUkoe48uBIos3YKdKN1kniwrNdvmxJ6cO3/PvcPdFatPGqR3LmcI6MfByvTdO/vB5Ucw181BI1c91W3KF3ZusgO+bYIgVG/dDUqBgSY86qKJJ8h7vg0eIHHtFYfre9gdygx4eDtLZ/P3qjaplMBJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0uGS7AR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3AC4CEC3;
	Tue, 10 Sep 2024 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725954620;
	bh=Te5i/tPo5k3QCrIs3A3Zb8hXiH+hY3iSuYO4RfgHySI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0uGS7AR4c0o0WjJY2SKkGKScuI+t/0mBUJsEcjwjLxO5qrIKWDxm5WWvGnUsZtVT/
	 PWZjrqCsyZ3sb/YNOCzJGdxeUKY19QAWYB4eIN/d40+fsJExzxuMXeRHOvFDd+aR74
	 Ho8zZAFkX7v5bgGYvzjESbOPuZUcL8szxylwnVSI=
Date: Tue, 10 Sep 2024 09:50:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>
Cc: stable@vger.kernel.org,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 6.10.y 2/2] drm/i915/display: Increase Fast Wake Sync
 length as a quirk
Message-ID: <2024091008-gong-traverse-9386@gregkh>
References: <2024090806-marbles-stegosaur-6314@gregkh>
 <20240909085918.3239275-1-jouni.hogander@intel.com>
 <20240909085918.3239275-2-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909085918.3239275-2-jouni.hogander@intel.com>

On Mon, Sep 09, 2024 at 11:59:18AM +0300, Jouni Högander wrote:
> In commit "drm/i915/display: Increase number of fast wake precharge pulses"
> we were increasing Fast Wake sync pulse length to fix problems observed on
> Dell Precision 5490 laptop with AUO panel. Later we have observed this is
> causing problems on other panels.
> 
> Fix these problems by increasing Fast Wake sync pulse length as a quirk
> applied for Dell Precision 5490 with problematic panel.
> 
> Fixes: f77772866385 ("drm/i915/display: Increase number of fast wake precharge pulses")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Closes: http://gitlab.freedesktop.org/drm/i915/kernel/-/issues/9739
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2246
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11762
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Link: https://patchwork.freedesktop.org/patch/msgid/20240902064241.1020965-3-jouni.hogander@intel.com
> (cherry picked from commit fcba2ed66b39252210f4e739722ebcc5398c2197)
> Requires: 43cf50eb1408 ("drm/i915/display: Add mechanism to use sink model when applying quirk")
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> (cherry picked from commit a13494de53258d8cf82ed3bcd69176bbf7f2640e)
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux.c | 16 +++++++++++-----
>  drivers/gpu/drm/i915/display/intel_dp_aux.h |  2 +-
>  drivers/gpu/drm/i915/display/intel_psr.c    |  2 +-
>  drivers/gpu/drm/i915/display/intel_quirks.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  5 files changed, 32 insertions(+), 8 deletions(-)

BOth now queued up, thanks.

greg k-h

