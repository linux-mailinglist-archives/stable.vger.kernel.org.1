Return-Path: <stable+bounces-177560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73171B4116C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26794700328
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACF1BD01D;
	Wed,  3 Sep 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNNtW+WH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67383273FE;
	Wed,  3 Sep 2025 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860173; cv=none; b=fY97rC+d/LlIMCYnELwI5Kja4Kqs047U+IixN8DRWf3vc1euLhz29qYbYtcwZozIL89sc9hLcG0i3V+9r0CHmDiMYdrisKEIXsLePPn+CrZLpRvWsG7JH6z1rIpkW2yT4GGMxyrzsoJ0ox+Bk8/+a/YevNPYXtAu7oU3QHSUg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860173; c=relaxed/simple;
	bh=W8gvhl8dl1yzUVTiRhWZwaQLNYWxzLCPwvBudrcMLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWnIievyUJNY8tV4v81hx+tLeiU/5K65vPZsHy71IixxMh1mxPT0gmvqrpLHgju07XSgvfay+rX0l5gEraOuvkjCGUiBfmknuJYd6V8JU4sBS04LccqwZDqTVQGiR8xUnwjBnyAry91LMsGTn3MI5nAqzEAxSj96j8bySc5ukjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNNtW+WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7041EC4CEED;
	Wed,  3 Sep 2025 00:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756860172;
	bh=W8gvhl8dl1yzUVTiRhWZwaQLNYWxzLCPwvBudrcMLuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNNtW+WHaqFRVrrpV++cJPKgU6YItSMPUkmHfFkJXl5OIcW7ejLcnaNOB6ljKl6uW
	 ziyNF5d+BrmZEqYL/neFpMxkuHng4UgcDJ2MwDJ/3naW3+4AGR0HinKOV279c90wW8
	 jALoepiIVFCm6YX54SIhmHGjLKZ4evcwjQTktRtlFtgNndFMIjLLIjLzcBZtLkrPKQ
	 qIXMveY8RJgNsNwhgOekSl4yIEnXrWAmwayqaQvrdvUxMUvkwwJFvA3p7djXwaEPYm
	 necAmngaHlobSB8oZ+wxycR0AXuJha76YcW0nGeHh6wb1TyGkt369wZ0iahqCY351N
	 oL3EfKYPSvhCQ==
Date: Tue, 2 Sep 2025 17:42:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix to enable RSS
Message-ID: <20250902174251.03950c03@kernel.org>
In-Reply-To: <11AD624D55764BDF+20250902025713.51152-1-jiawenwu@trustnetic.com>
References: <11AD624D55764BDF+20250902025713.51152-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 10:57:13 +0800 Jiawen Wu wrote:
> When SRIOV is enabled, RSS is also supported for the functions. There is
> an incorrect flag judgement which causes RSS to fail to be enabled.

Please describe user-visible behavior. Does it mean that VF with
multiple queues will receive all traffic on queue 0?
-- 
pw-bot: cr

