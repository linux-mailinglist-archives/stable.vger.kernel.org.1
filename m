Return-Path: <stable+bounces-73061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0596C039
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0891F22ECC
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753061DB53C;
	Wed,  4 Sep 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZH3iVmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7131DB53F;
	Wed,  4 Sep 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459698; cv=none; b=j0XGwjc/WlxbGNYrZmat76eo2NT+2Zrbjt6MecxJG5PBnqETorXow9HVsfNSkwRrchLsKKz5giaOvAug9yefYpjaJdBRyX5Ps/jwAZH1GsjCW0XuvWyyDMvcZmX1R9IodZM0bcrxlGoCf8ybm7YZkKKqPQ8iy/veMhmdxe//chE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459698; c=relaxed/simple;
	bh=i97rSaK8JA0WCSMbzW1kYNSBkFZC9zi0oI0AqGCZRtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohR7gmKuWETBQhjcvgj+PBEooJjTcfsbcbfXL/k7vpVaxOHxtMe4yLiFIBx3ncq8Tf666pX3udeu2iJ6d23t9DWnZuwFg202Eph5nHbgYx+5QPwUVDl1iRkvET1Cz7SVNcVgtnWjN9nA3p9V8t1db8a2f0VPo8tkoP+8u9EnBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZH3iVmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225EFC4CEC2;
	Wed,  4 Sep 2024 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459697;
	bh=i97rSaK8JA0WCSMbzW1kYNSBkFZC9zi0oI0AqGCZRtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZH3iVmgDggqAa/BIolDd3jsb90xdmifyuSl3yU0UaqQLuLWP8Tm/qCZEWgVGLmtW
	 s+73ZJq7xoxDTezonp1skWHxMUMDpoCkgNrpCV3cpzW53eTHWGNV2CTBoJR6oZZMCq
	 VKZ/7bJxwaGIbMogOUNARGqJ6g5Bt3uy3+ptaAY4=
Date: Wed, 4 Sep 2024 16:21:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/2] Fixes for recent backports
Message-ID: <2024090428-reapply-stonewall-1c59@gregkh>
References: <20240904133755.67974-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904133755.67974-4-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 03:37:56PM +0200, Matthieu Baerts (NGI0) wrote:
> A few commits have been recently queued to v6.6 and needs to be adapted
> for this kernel version:
> 
>   - 38f027fca1b7 ("selftests: mptcp: dump userspace addrs list")
>   - 4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr tests")
>   - b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
> 
> Matthieu Baerts (NGI0) (2):
>   selftests: mptcp: join: disable get and dump addr checks
>   selftests: mptcp: join: stop transfer when check is done (part 2.2)
> 
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

Now queued up, thanks.

greg k-h

