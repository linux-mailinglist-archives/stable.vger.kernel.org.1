Return-Path: <stable+bounces-87035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D299A603E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719651C20A44
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A01E2832;
	Mon, 21 Oct 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLpcHYup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FB1E04AB;
	Mon, 21 Oct 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503426; cv=none; b=CJ51BgpfKPNWiiTvC7gKcS0F/w+CiMnr62FDFDYUtMoG9GH7iwaxUgC+hYKXkxL4wC4COo96uj1lBo5+BCjwyTfYeMoeUvQODZ6m22EZqBMMfi3fTnwzkEcQohNcVL3y0yMnS3xMFBEoeH2pyFIzW9RWrbNPNojDBa9OaPMMUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503426; c=relaxed/simple;
	bh=EJHqiD3cbg3INAzyBepA0sNI4AIKiD9/D+U3XPtj9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvjh4lgwjyaYVhauF7bUWWsaDlgjEK1eMbtNxYLx5GKAmLb3DzgMMDyE5RxHhQZxSfnoZum8hznmhl7l0pmB2bKbwiLizPcqd6+1hy416SHi2vztPykLDbycomSaG7tclq/6c9VBEnR7AnECx6gurCjCi4f6YRsRrp/Gv+ZEVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLpcHYup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5FBC4CEE5;
	Mon, 21 Oct 2024 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503425;
	bh=EJHqiD3cbg3INAzyBepA0sNI4AIKiD9/D+U3XPtj9Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLpcHYupnCdnoE+hrnA2ZvuvIrhSqnm02FEwvNYWU3Haz/q+wlAcwJwbmalGU3Q84
	 4r0fkvruLT0jyAI76X0J1mO+DRb+FbBjTdNrSd580i1RUwcD96fg5UVBCtJ1EOBDSq
	 QTz39yjELZgEdHSrPHgWgLfVkr1OdJaWZENQz7Hs=
Date: Mon, 21 Oct 2024 11:37:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/4] mptcp: fix recent failed backports
Message-ID: <2024102156-diffusive-postnasal-083f@gregkh>
References: <20241018155734.2548697-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018155734.2548697-6-matttbe@kernel.org>

On Fri, Oct 18, 2024 at 05:57:35PM +0200, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 2 patches that could not be applied without
> conflict in v6.6:
> 
>  - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
>  - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
>    port-based endp")
> 
> Conflicts have been resolved, and documented in each patch.
> 
> Note that there are two extra patches:
> 
>  - 8c6f6b4bb53a ("selftests: mptcp: join: change capture/checksum as
>    bool"): to avoid some conflicts
>  - "selftests: mptcp: remove duplicated variables": a dedicated patch 
>    for v6.6, to fix some previous backport issues.

All queued up, thanks!

greg k-h

