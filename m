Return-Path: <stable+bounces-100100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14D9E8B72
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF261628C7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78002135D0;
	Mon,  9 Dec 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSu81+od"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84D17C219;
	Mon,  9 Dec 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725376; cv=none; b=KrzytlSWJ6Vx9hc7adKc73AH1G9c/y7Z/4SUgk5tEuFXXNMpTnDXNnMroqVfvR6iCT6rcfbRKYHK2jlihERFNgkmr8Oqe25yiiUrPMAzgKC4erPitUdWTrOhRJuVYT4TKlWE5Ofpst4GGrRpGVPYShvLlFxSe5LDn5LbZT5gxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725376; c=relaxed/simple;
	bh=ElUtOrj0dAdamjnKg9XM01FTLMw/ydQF/BfFdlVyKc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6EiTWxylOC6vCY1fteFCk/irw6h/f6U2gd6L5hO08rG/QWbQyBV302ThQim+HP844MJH6IYQXt7XQY3rC1BjmcmDOAmvBntGQYeAsFBWjk+bd4a4cGPU4um7KpqGxFweXPjCvalgtbguF8KJDaggCDxw7PYwLiAp3oGDgl95zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BSu81+od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F783C4CED1;
	Mon,  9 Dec 2024 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733725375;
	bh=ElUtOrj0dAdamjnKg9XM01FTLMw/ydQF/BfFdlVyKc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSu81+odsvC+NzMaK94V2QNYZQK+VoQVieItXzr08UG9F9RqICly/bj//hWEyiPsu
	 mKe7OYzbqB/D3nbJw5KCFQpErJpbTucZod9g+AFpIl0tNcN6XhI6HOpg+w1H1dJsUV
	 oWH/NxMkL6/33TIpQtEQEwZncgFoVaQN75nBgxB4=
Date: Mon, 9 Dec 2024 07:22:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: almaz.alexandrovich@paragon-software.com, stable@vger.kernel.org,
	ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Message-ID: <2024120905-unchain-lividly-3a0b@gregkh>
References: <20241209065223.3427374-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209065223.3427374-1-jianqi.ren.cn@windriver.com>

On Mon, Dec 09, 2024 at 02:52:23PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]
> 
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Jianqi.ren.cn@windriver.com <jianqi.ren.cn@windriver.com>

You need a name here, not an email alias :(

