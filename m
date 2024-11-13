Return-Path: <stable+bounces-92879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E49C670A
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 03:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B1AB29C7A
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C7433C0;
	Wed, 13 Nov 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbKbVY+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7933EA;
	Wed, 13 Nov 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463264; cv=none; b=cMenWB0C4zioSDaLbuYK/syCz64maB14sE3nHvn9sGY+dqTpPqBUD54ZqyopaK12LWpwatYaPr1oiDVtc7eWnskjI7HKfHuH42MRI46kYhVmN6vK12PwUhA2mKB7AXRsFwSRNYYv7LVBkXFNmGfEHYilVxkqZLTUYmsPZWAkP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463264; c=relaxed/simple;
	bh=fqJGAn6Td1QHXVNGq8+mVt/uTNMZmqpgdGlgIfh6pUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLRbcjDSXtU3u1UBtXe4sPjk9RqNLubOk1HWWI8p7w1vbvn092SbMMAO/sgkX/I5FAcFqIIznsx7acOjLW4564IkSWbWWiUEiHtmEqOpOtskcbZ2N+cHBCAcW7aDVxf+byifXaW1Po9D2xO5/ENH8ZhcoPZuOmqc1rj5AL5t3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbKbVY+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE98C4CECD;
	Wed, 13 Nov 2024 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463263;
	bh=fqJGAn6Td1QHXVNGq8+mVt/uTNMZmqpgdGlgIfh6pUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbKbVY+wY84ETXWojkkoFJhQKRSMXYYEf4v8z/gHiEHI697tJ7IquvcezvpUbNEo7
	 pTp1wXXK5TM0cKxezF462NnyDe2ltxsit89GPXlugMOP0U9bT4sNpmbMEIHlRbchKz
	 vBo8kScxztBxx2H+u3KH/qaDu9RKsOYOmWdWmtlzEkyUj5WQjhR7OBX9Eh7q3BxLrY
	 zZSRo6YDGY2i6tewrwdmLzsuLbjR5LMjgQwuqbzItdQLfn+OLzLQMyUdqCihETLkDp
	 6UEjy+WVfBRMBX9bv/FBT8DPRb2FaURKZec4ABLfCmwx6ny3wk+vqU0sQN6urDdAF3
	 T7Bz91vBSG2sw==
Date: Tue, 12 Nov 2024 18:01:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 mkarsten@uwaterloo.ca, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Mina Almasry
 <almasrymina@google.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Message-ID: <20241112180102.465dd909@kernel.org>
In-Reply-To: <ZzQFeivicJPnxzzx@LQ3V64L9R2>
References: <20241112181401.9689-1-jdamato@fastly.com>
	<20241112181401.9689-2-jdamato@fastly.com>
	<20241112172840.0cf9731f@kernel.org>
	<ZzQFeivicJPnxzzx@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 17:48:42 -0800 Joe Damato wrote:
> Sorry for the noob question: should I break it up into two patches
> with one CCing stable and the other not like I did for this RFC?
> 
> Patch 1 definitely "feels" like a fixes + CC stable
> Patch 2 could be either net-next or a net + "fixes" without stable?

Oh, sorry, I didn't comment on that because that part is correct.
The split is great, will make backporting easier.

