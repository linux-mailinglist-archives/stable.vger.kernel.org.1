Return-Path: <stable+bounces-127302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C4A77741
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3362F188BE69
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFA1EDA0D;
	Tue,  1 Apr 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zpxvI+fP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CF2E3398
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498552; cv=none; b=PdHcWoK/xMAFcxocuCYhAVTluGQMn06eXlWpViSwko2ps/PGlHDO5jpzeDWc126dNjM1RmzpZ0tqVCyloNZoYZC75e2qZMEoPrCJ8nDj/r/39kxp0R3Ky2/LjVpbjZjv9bz9wcnXe0hgmRxcFP1/w5ifWXETz+GZH7ydqtzNPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498552; c=relaxed/simple;
	bh=hWyFAYQ1knay2GlTn4pB+3uhSzDyUXRmXhGPM9Z4Y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DppT/+uYXBYCHzneiWjqgb2aZsipfWjxC3Amdh4Prt0HOcTn/FtmS5b6rpjs1UUNmVV9Gl5yeBvVUX7D1voKf8UcUrBzRLrgHTlynww5O83mS2xcxjMSfOvnQ+VpUHh7D8L+IjIJ6BsrOfrD5Ek4prP5VoytmYF+vf5YG5etmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zpxvI+fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DB7C4CEE8;
	Tue,  1 Apr 2025 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743498550;
	bh=hWyFAYQ1knay2GlTn4pB+3uhSzDyUXRmXhGPM9Z4Y84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zpxvI+fPrSjgwiXXS/StRBrxsWFM5Y6gkQ+Q4KfZfRsHqsg6W7WriKQ64NGVpwwr6
	 ziogfk9miOehmGRqBrx/jQakU1jFJXiSF1JFAvQLVpTsEipw4VLninj3oyP7dWje6/
	 W7lYbJhCXw2hk8qE6rE5m4PGSrhm+VFxsJeqZ3ZI=
Date: Tue, 1 Apr 2025 10:07:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>,
	"Wang, Wade" <wade.wang@hp.com>
Subject: Re: Upstream patch pairing request
Message-ID: <2025040130-exuberant-suing-aa0e@gregkh>
References: <16adf217-c851-4378-bc4f-a9ccfc361120@cosmicgizmosystems.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16adf217-c851-4378-bc4f-a9ccfc361120@cosmicgizmosystems.com>

On Mon, Mar 31, 2025 at 05:34:34PM -0700, Terry Junge wrote:
> Hi Greg and Sasha,
> 
> The following two patches have now been applied to mainline.
> 
> commit 486f6205c233da1baa309bde5f634eb1f8319a33
> ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
> 
> commit 9821709af892be9fbf4ee9a50b2f3e0604295ce0
> HID: hid-plantronics: Add mic mute mapping and generalize quirks
> 
> It would be ideal if both of these patches could flow upstream together although neither actually depends on the other. A verbose description of the user experience with neither, one, the other, or both patches applied can be found here:
> 
> https://lore.kernel.org/all/f107e133-c536-43e5-bd4f-4fcb8a4b4c7f@cosmicgizmosystems.com/
> 
> Let me know if there is anything I can do to help.

Both now queued up.

thanks,

greg k-h

