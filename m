Return-Path: <stable+bounces-98882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206A69E623E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CF118815C7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41F1E51D;
	Fri,  6 Dec 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBQGOm4G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7884C9A;
	Fri,  6 Dec 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445079; cv=none; b=lla4rmLryR7f9IwNcs+E4BWpukfnXQKr1TBU5njQCzC0a+E3ARbyzxCB5IZVUtX9jScpVXFWTvSXjpjBREMatfQVQR5wECXq0lDv0a88djd9SfpwjHKTES6yBxjaVl4NRdKgw2bOWfp20O+EOmIfKWPz6yuQfBDCRjbL0T7LOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445079; c=relaxed/simple;
	bh=oSFCJFtrmko5FW1hJqyZm/2NvrAwFXm49vsC85hy6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOICfyJmFuEF/QOkJkpIHH07fF8WRVY3pzhFHLqDhC8aT0nm6B5iquddYS49VoHOLpThXe50uiiaozkKOJpx1cBq9RCPDB6kuNZPHTaWaJ79COtETbx4lO92Lg6T8At0ymZV/AjB64ISwok4wOmEb8Cbbd+1yc/AGK0V11oqDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBQGOm4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51EFC4CED1;
	Fri,  6 Dec 2024 00:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733445078;
	bh=oSFCJFtrmko5FW1hJqyZm/2NvrAwFXm49vsC85hy6K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBQGOm4GJ+mPgir+zD32WCHNo+/V+9F6S0Dc3+Cxpt69Jf3ggA9xkENZL1W1oqOdC
	 +EC+f6D1C3fItTsyXFMIlVwnXfb34G0sm9H+FXRJHsfwocqsit8ctPdwhyCpmnRb72
	 LfHiLMq+AlGFrXWebF+0Y2yvV0jLVvJPro8XN9LkLtcxPytV9FATTsm0hlVwPkrFXN
	 ooFNNIFgdjOlMddCX+EjfFlbvQpUjwcxc+QhFpnrkUAOxKdrwjf5x0WiYckJF+k9EX
	 WScVRnM+knJbqUt+e1hAWns6L2gWEh5nl8JxBIAgU6hPgZ1Ds8qKATI2HoGuej9+TV
	 tEAF1i47JNvAw==
Date: Thu, 5 Dec 2024 16:31:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Message-ID: <20241205163116.12c356a1@kernel.org>
In-Reply-To: <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	<20241204171351.52b8bb36@kernel.org>
	<CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 10:09:02 +0100 Eric Dumazet wrote:
> inet_diag_dump_one_icsk() could retry, doubling the size until the
> ~32768 byte limit is reached ?
> 
> Also, we could make sure inet_sk_attr_size() returns at least
> NLMSG_DEFAULT_SIZE, there is no
> point trying to save memory for a single skb in inet_diag_dump_one_icsk().

SGTM :)

