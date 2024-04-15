Return-Path: <stable+bounces-39406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E518A4CD0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C484F1C2205D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EE5C902;
	Mon, 15 Apr 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUXrs7NO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10D58AA4;
	Mon, 15 Apr 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177867; cv=none; b=uoddbBKwF5CfLxOQFL9UPtmicZStXFY9p7zHtPaTg2gN5UMkoSKmtQBt9XrPlKw7oBDB8sn4xcc9Xxv6Y0YKNVFYiMIUSFAgQvcQl3RuAcXLHf4HShgKko9UYTyFKbJGB031bZqkei+zDJem1/bBQspE0HbtaQlmOhrHEA+lEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177867; c=relaxed/simple;
	bh=9sj7/CX4tAfLHoOe0yR4U/g3DS+EgHEdqttmgHvQWGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZkBFrLgvLO+XMJMflJyj5lt3JqllKqqMmqScRF4jb+Ej8wugvqQLZ1C5Ht7beFGZqFkwP2Ixx4xH/MCc82UWqPBboY4+BQeOVMZwNYl0ylKXsqchU2XGv9rV58W4QL8jnliIGZZO5H0kImoVj6ITGU1dK/D/GFoctR4+eb7gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUXrs7NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F92C113CC;
	Mon, 15 Apr 2024 10:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713177866;
	bh=9sj7/CX4tAfLHoOe0yR4U/g3DS+EgHEdqttmgHvQWGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUXrs7NOrsvxaywwm3Ffq+OX/LNQ10WGsU/t7qlqiJcwB1AApeWFoJvGaEnpF4p1h
	 fkAoE1p+15D6ggaI+DavUX11vOct/XP5naCcJ9oEFlyf3SFiNSxex9bzi2vzYMeL4B
	 mdZlXixxfGvkysWLhP5FMxbHFMEPPzjrnTFVnqPI=
Date: Mon, 15 Apr 2024 12:44:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] selftests: mptcp: use += operator to append strings
Message-ID: <2024041515-latch-mutilator-3050@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
 <20240411100709.367235-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411100709.367235-2-matttbe@kernel.org>

On Thu, Apr 11, 2024 at 12:07:10PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> commit e7c42bf4d320affe37337aa83ae0347832b3f568 upstream.
> 
> This patch uses addition assignment operator (+=) to append strings
> instead of duplicating the variable name in mptcp_connect.sh and
> mptcp_join.sh.
> 
> This can make the statements shorter.
> 
> Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
> save the various extra warning logs, using += to append it. And add a
> new variable tc_info to save various tc info, also using += to append it.
> This can make the code more readable and prepare for the next commit.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Conflicts in mptcp_connect.sh: this commit was supposed to be
>   backported before commit 7a1b3490f47e ("mptcp: don't account accept()
>   of non-MPC client as fallback to TCP"). The new condition added by
>   this commit was then not expected, and was in fact at the wrong place
>   in v6.6: in case of issue, the problem would not have been reported
>   correctly. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
>  2 files changed, 43 insertions(+), 40 deletions(-)

Now queued up, thanks.

greg k-h

