Return-Path: <stable+bounces-87039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00C9A6067
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B9C1F2242E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B505823DD;
	Mon, 21 Oct 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpwhBDa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD281E2856;
	Mon, 21 Oct 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503773; cv=none; b=oEAaOsJzKuBy3GpAboLTZDCjXuv35W3RmBvMNPbdbF0sscWtpsZtglLdZ4nr3TVjieicOqbxFdfGfYk4yvfOpzN1z+dv4P+xz5F/6JhbsjM/+qSWSBApQWcSyqvx4ETpPJ5RnH4JtAtiDkU7W8rSx0nZ1UaYidXcEK9+0OuNcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503773; c=relaxed/simple;
	bh=IFo5N4pNsj5pBc7slyhqY14XbbQUpMphUHA/SggEr+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uewIy7bX9fhoPvS20Fej2eoq/eDmktG8ZQ+Itn7hB+cJUT9Uyuf4FbDb/F2OtkNDp3Ll6T9KSRIu6sluiF/2qI3H+ZHpKyorB+RNVo2LwFfPytvp/+1ujCz8oUGLFQqvP1n0zXY1L230NGd+RRKt8RMTrR8TbAeMHgL7Uz9QSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpwhBDa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A10C4CEC7;
	Mon, 21 Oct 2024 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503772;
	bh=IFo5N4pNsj5pBc7slyhqY14XbbQUpMphUHA/SggEr+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpwhBDa+Bdgwp4TeTYj5WSYj6+aRZJg/QLWEw1ONZr8yxXV1mMlXz1sIWWVk5kiVP
	 dH6HTcZSIbA1msoSqzNQ9fMdfTXhZRspM1t5snJsgwXW70jdw1w18GLw3M0Xrvc7cW
	 +bZ84vs/aKYeye/ZJPInPeSDdbCpKBQEobAfAjTw=
Date: Mon, 21 Oct 2024 11:42:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 5.10.y 0/3] mptcp: fix recent failed backports
Message-ID: <2024102141-patience-diaper-4e34@gregkh>
References: <20241019102905.3383483-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019102905.3383483-5-matttbe@kernel.org>

On Sat, Oct 19, 2024 at 12:29:06PM +0200, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 2 patches that could not be applied without
> conflicts in v5.10:
> 
>  - e32d262c89e2 ("mptcp: handle consistently DSS corruption")
>  - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
> 
> Conflicts have been resolved, and documented in each patch.
> 
> One extra commit has been backported, to support allow_infinite_fallback
> which is used by one commit from the list above:
> 
>  - 0530020a7c8f ("mptcp: track and update contiguous data status")

All now queued up, thanks!

greg k-h

