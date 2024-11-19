Return-Path: <stable+bounces-93990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24D9D2660
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F70281F55
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B71CCB2B;
	Tue, 19 Nov 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KalCWegP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B251CCB2E;
	Tue, 19 Nov 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021562; cv=none; b=K9XX87BJabDAj560sW3JVjq+TBYE85DFue7Ak6Xb3lF+8BErCJOQIgmQ3z72dSwEOURlFqV7AO2VgqBWKXye4CkBMTmXL5h///FWmdn+zAr+OybyL6N2MzY0YgMYtEXfxuov9KFl6od3hMgm7cjq4rhtApu9w2Ojy7hkAWYj83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021562; c=relaxed/simple;
	bh=yl8iqZVQmlkS7Fojqxk7oxtkvip7mrEBpO7+48Yz1j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJSaxHL4XugSJw3K9J6HfRnCKLsEQw0Rz82nAiaeo2xo8BpTC7o3RPw4v5on5Z6k4Ur4TiM51YPaOpQ57kr57QasGM5wxDo0v/3bUerNFOhvKOYJnC0XeOUDhV/S9TIL2ux/6FcsoxSY+z0f5M1WDrncx9BDkKj+HsGQoI9V7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KalCWegP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAD8C4CED8;
	Tue, 19 Nov 2024 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021562;
	bh=yl8iqZVQmlkS7Fojqxk7oxtkvip7mrEBpO7+48Yz1j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KalCWegP7Fqn0DIvP3ttfqggO2V8khY8wjN91O3Rd7nfTXtY6/S4nQv2V/CDlBiTe
	 asFDhY8KVZ0NPRC069sBthecKUn5LFBFKPgBI2bdv5TepRA1mZoTvj65JrqWUQplcl
	 VjMB73dOfc3E0MQOYBppkeI7dIDf7/rvG8AEVA0c=
Date: Tue, 19 Nov 2024 14:05:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.1.y 0/7] mptcp: fix recent failed backports
Message-ID: <2024111923-preppy-raider-2faa@gregkh>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>

On Tue, Nov 19, 2024 at 09:35:48AM +0100, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 3 patches that could not be applied without
> conflict in v6.1:
> 
>  - e0266319413d ("mptcp: update local address flags when setting it")
>  - f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
>  - db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
> 
> Conflicts, if any, have been resolved, and documented in each patch.
> 
> Note that there are 3 extra patches added to avoid some conflicts:
> 
>  - 14cb0e0bf39b ("mptcp: define more local variables sk")
>  - 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
>  - af250c27ea1c ("mptcp: drop lookup_by_id in lookup_addr")
> 
> The Stable-dep-of tags have been added to these patches.
> 
> 1 extra patch has been included, it is supposed to be backported, but it
> was missing the Cc stable tag and it had conflicts:
> 
>  - ce7356ae3594 ("mptcp: cope racing subflow creation in
>    mptcp_rcv_space_adjust")
> 
> Geliang Tang (5):
>   mptcp: define more local variables sk
>   mptcp: add userspace_pm_lookup_addr_by_id helper
>   mptcp: update local address flags when setting it
>   mptcp: hold pm lock when deleting entry
>   mptcp: drop lookup_by_id in lookup_addr
> 
> Matthieu Baerts (NGI0) (1):
>   mptcp: pm: use _rcu variant under rcu_read_lock
> 
> Paolo Abeni (1):
>   mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

now queued up, thanks!

greg k-h

