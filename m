Return-Path: <stable+bounces-108135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07240A07DA4
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A8188CAFF
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67526222560;
	Thu,  9 Jan 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSqLcRmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B3221DA3;
	Thu,  9 Jan 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440394; cv=none; b=ua1jiFJ/ANrFwyhUe/PCXeebKvq4VY0xUey2qKY/jQjZ3QlCscbPB1rF5hPgA8uCdzsUOzjG/OqpjwhcxhOb+RpMKzK62xpCwLRgqmHogO+uT9ibFTXbN57YmI8Jmvj9eUkZ3Qk7VUYiYu+LQlq+t9XOK8mmdEZ9H1+7cqEKB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440394; c=relaxed/simple;
	bh=3WNjhjrCWMP3ve0lxWjpqAK+e2+TuzKMIFEAX8YG8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfv6bHyPG30bkUB1YZSsOkCHYUoch69LYIx3rvpJvK/4q5dghQQT7e/iGEerhn1iFIMuDuglu732SBtAjAEqZmw1FNb9+L5IYn0Cxe4DeiH8IKS59NGwcaeKZcT1TPumFwy5U8ldUA8/8D9sf/JIpgkxgQS0MUKEsxISxNHBWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSqLcRmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A27C4CED2;
	Thu,  9 Jan 2025 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440392;
	bh=3WNjhjrCWMP3ve0lxWjpqAK+e2+TuzKMIFEAX8YG8Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nSqLcRmcG1ELOuXucIaWZjPvGxHDC1RTsH5uQhUWoAVBx9XSEBFPsyBAJkhWi17bS
	 ATBqnkjn94ZYpV1g4OfZjq6vA11sHTDVaWyUdLHOpVju7vPUHB5ZpZtA/qbXOgvOM5
	 hig6E+hRsi/TbaWHm5aCUILUMGbPAazL7Mn8cPXVovRW+RB14k36rJzQyvXOrNso6a
	 Y87RZPyN5+xyccFz0ubs81RPL5tyFeZNtBtJqRWVoZNVZ+oZGNN++tn1ba65Tw8Ak1
	 3ua5Ttk3bTvUURbASWSz4nBvFwsf9NF4u50ciGqWXcpibNXrtnGsFn8PHLqCKsTMSr
	 IR79iODkX8l2Q==
Date: Thu, 9 Jan 2025 08:33:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Potin Lai <potin.lai@quantatw.com>
Cc: Paul Fertser <fercerpav@gmail.com>, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net/ncsi: fix locking in Get MAC Address handling
Message-ID: <20250109083311.20f5f802@kernel.org>
In-Reply-To: <20250109145054.30925-1-fercerpav@gmail.com>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<20250109145054.30925-1-fercerpav@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 17:50:54 +0300 Paul Fertser wrote:
> Obtaining RTNL lock in a response handler is not allowed since it runs
> in an atomic softirq context. Postpone setting the MAC address by adding
> a dedicated step to the configuration FSM.
> 
> Fixes: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
> Cc: stable@vger.kernel.org
> Cc: Potin Lai <potin.lai@quantatw.com>

Neat!

Potin, please give this a test ASAP.

