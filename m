Return-Path: <stable+bounces-159160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3051AF00DC
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D41C24F53
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5427CCCD;
	Tue,  1 Jul 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYhRArRi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94722798FA;
	Tue,  1 Jul 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388508; cv=none; b=RowLolb+mSECMUL+dJ7Pqka047+QqrsIr9UHqECr6V75sURCvgH805idpwE2XnbaVrHH2r2nUBPFk/63tCpA3femsIG0HnJFBTj9xg3eEn0La1qewt+M6kWoGah9+hBpSdaurEHm//BiaT35mO4AYdZ4y/KHpRWmgBSK79yyQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388508; c=relaxed/simple;
	bh=pKyr8JW0TQc4a9O2+U1jX0oAV04HTOiS/u0v08EJjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e092yF9pslPOrVekHS5utDWV/oCSVkg1P0OtLj5P2r7K5Nhyj/4t8dTbllfu7xSC9T4RtFCm0+ncqmIBKmLaRKvTu9bCJwsr+7TN48D+WrcuxxWM97Ps7ATvFa7OBuArMcZp7l5yOSuRcoawMMPq3TfDfPkxcwIiAfcURRUmHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYhRArRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67241C4CEEB;
	Tue,  1 Jul 2025 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388508;
	bh=pKyr8JW0TQc4a9O2+U1jX0oAV04HTOiS/u0v08EJjxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYhRArRiWk2pjUzc+s8YIxak2AEqPwVzriNwx/vjL6PVJPNdgvwNRra67++AP+j8Y
	 R2qwIanE2uZWPASuNpqbBKPDyUT7hTfFPu8s1tl9IzmhNLLpDLHeVYU4bOU/fzDK51
	 ahQr62xkAt2+6G9Q3H3QBOtm+Xs7b2dZxndeK5zXMw03qwHA7Dxu04+NR5Q5Et1NuV
	 RQgbPq+PDS/ZWmrtdpDyL/I35wIwwFWsb/JjKxuhryu25E2601iSiK4u7TJC0kkm9m
	 2LiwFK+Psiri0cdfpcr0DRIX4z69rkfwr/rjcuuHiFHfmT8c3q5LXEaMgrQg3fWq0b
	 8UGlZKohN+8lQ==
Date: Tue, 1 Jul 2025 17:48:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: libwx: fix the incorrect display of the
 queue number
Message-ID: <20250701164824.GZ41770@horms.kernel.org>
References: <A5C8FE56D6C04608+20250701070625.73680-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5C8FE56D6C04608+20250701070625.73680-1-jiawenwu@trustnetic.com>

On Tue, Jul 01, 2025 at 03:06:25PM +0800, Jiawen Wu wrote:
> When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
> changed to be 1. RSS is disabled at this moment, and the indices of FDIR
> have not be changed in wx_set_rss_queues(). So the combined count still
> shows the previous value. This issue was introduced when supporting
> FDIR. Fix it for those devices that support FDIR.
> 
> Fixes: 34744a7749b3 ("net: txgbe: add FDIR info to ethtool ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2:
> - fix it in wx_set_rss_queues()

FTR, v2 is somewhat different to v1, where I provided my tag.
But I agree with Jakub's review of v1 and that this is a good solution.
So please feel free to keep my tag.

...

