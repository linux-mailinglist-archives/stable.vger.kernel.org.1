Return-Path: <stable+bounces-120426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F33A4FF1D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CAF16FF74
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACB1FCF6D;
	Wed,  5 Mar 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DieSQzco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD7245029
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179435; cv=none; b=g7wJ378yx2g3cPtJaJnxRuX6OghjWklwzBnIC/9F9XWFtmgHEvqC9Vga6NOuG6frk+zyQPSc0J+g/4rOYMSv3TtcKXl4zG+lhxAnrAJy57+wm1bA1/hvtOzx4AFLHsy3NQAXkkvbeEGIswo8MVqc/pT9bglM2YZYtY+kTLMWMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179435; c=relaxed/simple;
	bh=0my7QNYyQehtBm1MK15bjvMrP85iQgU08JmoW1Q7zXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWGkd0KO50W/ILqsivH8EP+z5s/sIV2N/TD6Psymkjw4RbGEnHGiQDi0yhUE196WAyiPMaFLac8Tyltao3xiyLYT+qbc7605j1LvPqC3WqqaEwr9B/ODhhAQ6Jucob6FgjJMSw0blH8dgMemxK01iSvkxAItTsCuC5ghKP39AeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DieSQzco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B53C4CEE2;
	Wed,  5 Mar 2025 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741179433;
	bh=0my7QNYyQehtBm1MK15bjvMrP85iQgU08JmoW1Q7zXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DieSQzcoV5RBEWBZBj1F5ocIgUfy5Rwuj3HfWKUFHsGLJEL4+0uUaSfImzuJuv+ku
	 kKldt9SPxKko1xjVIHeyPjVJt6uCujgRT19+qryKU0m93pOBuYK2uWcYz9CgzlOBjn
	 XNJ+5T5T2yBmSzdgrAgt0B+qPPXoJlORsL7mM84U=
Date: Wed, 5 Mar 2025 13:57:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Imre Deak <imre.deak@intel.com>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 6.12.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port
 width macro
Message-ID: <2025030535-spotty-greeter-94be@gregkh>
References: <2025022418-clergyman-hacker-f7f7@gregkh>
 <20250224153910.1960010-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224153910.1960010-1-imre.deak@intel.com>

On Mon, Feb 24, 2025 at 05:39:10PM +0200, Imre Deak wrote:
> commit 76120b3a304aec28fef4910204b81a12db8974da upstream.

No, sorry, this needs to be the commit in Linus's tree, not in a stable
kernel tree, as a stable kernel tree is NOT "upstream".

Please fix up and resend.

thanks,

greg k-h

