Return-Path: <stable+bounces-87038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE99A6060
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562481F22452
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB831E32D4;
	Mon, 21 Oct 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="er/Rt96o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BC1E32D2;
	Mon, 21 Oct 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503698; cv=none; b=MI4MQepalDnbw5uUxwFbuT4cKDFRl6cKCdT8sFLhtC1ocpr6+RcUolYrjeGks/adnzpnDHdUdpaTMaNaJNhwAJqyRu2w37/mC2rCkJjO3opKyNC4DgpmpVMLTmWdLHsw65/DMY2QLLQHSjenQvHu5PnXrB2K5BePKVxcbl0DyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503698; c=relaxed/simple;
	bh=Ua5MoeIJUOXxBBJW5sH5Y+XAP1QFbyAAuPgKa1cHEBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXkQSmm7ry88K45hsY90LiUu5SjENPo+4WSUZXIXzeTsCr+3fxZ1TukAnJyYRNiU8Mel6f3WWn5T6wvYc6CZfoZkM2WpKDoFdMPeciCLECysrkGlsI2U8dC//iznEsTSlbAjaSw5592H7Py7hBtvXKVTMGVoagak7tIcpck9Ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=er/Rt96o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD9C4CEC3;
	Mon, 21 Oct 2024 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503698;
	bh=Ua5MoeIJUOXxBBJW5sH5Y+XAP1QFbyAAuPgKa1cHEBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=er/Rt96ok9KZ+rgD1ofk9TxYNc/sco4gplkwyYXeoKLYeJGqbzyQcPPj9VR4hC33/
	 bLhvP7xOAwyRLq6v7DYLG5MKu3MYQz9SAEWR+S68h+W62DukGAmmGpdLy060snqW4f
	 jZbjMCJglRCLrGZTYIKB/8MTYMVxwa16JqmiIDwE=
Date: Mon, 21 Oct 2024 11:41:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 5.15.y 0/6] mptcp: fix recent failed backports
Message-ID: <2024102123-pruning-demystify-d187@gregkh>
References: <20241019093045.3181989-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019093045.3181989-8-matttbe@kernel.org>

On Sat, Oct 19, 2024 at 11:30:46AM +0200, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 6 patches that could not be applied without
> conflicts in v5.15:
> 
>  - e32d262c89e2 ("mptcp: handle consistently DSS corruption")
>  - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
>  - 119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after 1st
>    data")
>  - 7decd1f5904a ("mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow")
>  - 3d041393ea8c ("mptcp: prevent MPC handshake on port-based signal
>    endpoints")
>  - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
>    port-based endp")
> 
> Conflicts have been resolved for the 5 first ones, and documented in
> each patch.

Now queued up, thanks!

greg k-h

