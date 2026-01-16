Return-Path: <stable+bounces-210104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D010D38609
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BA9730A13EC
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F23A0B19;
	Fri, 16 Jan 2026 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eipR8nkF"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C722D73A0;
	Fri, 16 Jan 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592172; cv=none; b=YFGRoaYaUdf+Hfal/68tuPS617PkCKio5ykT6CH8GbiytHHZ3UspW6YyKjyBYbA3K/FctP/iMQAtzXxeo/JDB2b3DuDUM9DJLkERnnAVPEmwx6M6kN2oC0Z5MteUlcgdV0kWFTMRNG2uNwTzujdDyduu9ZydZ/6sz1f4nIHlcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592172; c=relaxed/simple;
	bh=OQSJm71mqejadmYLuc9oR3EA6Ci2x9fyJh28nlhxIAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF3MHxm0zaTZmgbvk2fUTD3lgLqEWoIuw4alK1y69MJa6qICyLNN24H+CLue9Og89vGrP3iggAAheSaRtHg+hD6bgABrSZWzoysulA8Tcah3blt7jI+fzQahKP7/WV9oUqrHw6ZAGLwe+5jNSG0dvlYKS5ftDlH7cP8KXERjv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eipR8nkF; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [79.139.240.21])
	by mail.ispras.ru (Postfix) with ESMTPSA id 13AE8406E9AC;
	Fri, 16 Jan 2026 19:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 13AE8406E9AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1768592167;
	bh=OQSJm71mqejadmYLuc9oR3EA6Ci2x9fyJh28nlhxIAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eipR8nkFgonMZ0n64yvPbJX/6Wgk9zLkrakH217z2AeUnob+YL12wincysZJ5kGhB
	 q5ksCVN4Z+o/RJ1bYIl/rj8j2rgi7fMxBwIFH+e/1OgNVAhp8f5/5mESegzUUqR5jY
	 qD8/d+p0Gkstvqu+/KrVM1iwqMXIoNZLpt2SqvUo=
Date: Fri, 16 Jan 2026 22:36:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Cc: Christian Koenig <christian.koenig@amd.com>, 
	Matthew Brost <matthew.brost@intel.com>, Simon Richter <Simon.Richter@hogyros.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1] drm/ttm: fix up length check inside
 ttm_bo_vm_access()
Message-ID: <aWqS00tHXSsh_rwL@fedora>
References: <20260116185007.1243557-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116185007.1243557-1-pchelkin@ispras.ru>

On Fri, 16. Jan 21:50, Fedor Pchelkin wrote:
> The backport of 491adc6a0f99 ("drm/ttm: Avoid NULL pointer deref for
> evicted BOs") is currently in 5.10-5.15 queues and it may be fixed up in
> place.

That's actually in queue for 5.15 only, not 5.10.

