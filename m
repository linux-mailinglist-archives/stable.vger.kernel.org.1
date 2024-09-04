Return-Path: <stable+bounces-73058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C2A96C019
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7231F26413
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764F1DC724;
	Wed,  4 Sep 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OXry1XAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D41DB936;
	Wed,  4 Sep 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459530; cv=none; b=dsme8z66AZbbwigS6Oq67hjDn5z7Ole10pmPfEcJLXJKiCh8cHsNDCVDp5MHseL29Lx50/OPirDtfytxoK67b6uyB3KC1CP/QSy36/poNwk0+ke08xotVB6FKOqtVOun95EspY8R+qo8qJ2jJZvqrbj7Xxz0h6+BkUwvYk85B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459530; c=relaxed/simple;
	bh=O+ihNvAF6xl22ELhi9gYOSEHsA+8QSh88lzUn7631SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYfIuZD0eHI30vWhH46YSx9bpCbT15tuR7svJRxklGlMf35dB7gGNYPRIa4XSThV9nPLO0Lvcj8wjfYrKDUQjdLDcjm45SY3felusyA6EGA9am59hgJyUTRTYjTfdfkyuPBdmPA4ooo+l13+5BeX+M4JAxOy1ZM8xrOaPMQiJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OXry1XAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30F8C4CEC2;
	Wed,  4 Sep 2024 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459530;
	bh=O+ihNvAF6xl22ELhi9gYOSEHsA+8QSh88lzUn7631SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXry1XAhcviAqBmtCmOUHqhuivBNdII//mOUp4soU48cYL5tcN1aNC7Csse4XRN2f
	 BpllK4z/fkf1kD7ZlEEGrQDjOp73KPtOH2RUewXauxr8x4Z/8Q6bEIwsyxadDFrd11
	 /Cfnh66F7o3J3w8SsTxBI/2JoMN1AUlcm7ezTVr8=
Date: Wed, 4 Sep 2024 16:18:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/3] Backport of "selftests: mptcp: join: validate
 event numbers" and more
Message-ID: <2024090439-marbling-bridged-1186@gregkh>
References: <2024083025-ruined-stupor-4967@gregkh>
 <20240903102347.3384947-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903102347.3384947-5-matttbe@kernel.org>

On Tue, Sep 03, 2024 at 12:23:48PM +0200, Matthieu Baerts (NGI0) wrote:
> To ease the inclusion of 20ccc7c5f7a3 ("selftests: mptcp: join: validate 
> event numbers"), 35bc143a8514 ("selftests: mptcp: add mptcp_lib_events 
> helper") sounds safe to be backported as well, even if there are some 
> small conflicts, but easy to resolve.
> 
> Once resolved, f18fa2abf810 ("selftests: mptcp: join: check re-re-adding 
> ID 0 signal") can be backported without any conflicts.
> 
> Geliang Tang (1):
>   selftests: mptcp: add mptcp_lib_events helper
> 
> Matthieu Baerts (NGI0) (2):
>   selftests: mptcp: join: validate event numbers
>   selftests: mptcp: join: check re-re-adding ID 0 signal
> 
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 100 +++++++++++++++---
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  |  27 +++++
>  .../selftests/net/mptcp/userspace_pm.sh       |  14 +--
>  3 files changed, 117 insertions(+), 24 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

Now queued up, thanks.

greg k-h

