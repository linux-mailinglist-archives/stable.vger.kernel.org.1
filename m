Return-Path: <stable+bounces-17784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E701847E25
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904BF1C22190
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD881110B;
	Sat,  3 Feb 2024 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aGqC8Ou5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79B1FB2
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923601; cv=none; b=UV4lBAFp/zOXKttRzu2E4NiwFq6TzbCjhpEodQt6XdQzlT+9YSgWC+cipioWvZOebHO5OZJZsyL6AucAE8fP4l4Yw1KRUspDO5C/EJiKoODRbmQ2FbpDrle/L1pZXJrHnBT4qOOuu7qD5mhmLgtBAYzAEXgLRMs+HhCzgc0Lcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923601; c=relaxed/simple;
	bh=7AwpwuXdPiaeZN5gy4u31bjRp9LC+rylB/KqETBdEv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZgpExDsM6/yZtLduXIcNg83E10niRgl5WWtd+o5HJsel0cXi7jsFMPbiYVosH9wFPa777r57PGAoDRcHXmoy9W92vgpF5BGw+4ZfoF1QVx3ToksRvIHhbwuNBRnrF+fVQQrtMxtlOhluFFA564KQ4pu+3lP9YeeN6QhFpnPnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aGqC8Ou5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819CC433F1;
	Sat,  3 Feb 2024 01:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706923601;
	bh=7AwpwuXdPiaeZN5gy4u31bjRp9LC+rylB/KqETBdEv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGqC8Ou5pZYWUxvzNLMSRtzDqEfRtwJxL9pJv5nyM4Ot9OZoUsWtaaeJPXEqZk5Ad
	 0p17xTfXKQFtiN+rEuATK6lJYghYgTB2QrAA9HROQzaq8oYeMaEJzkyTGRSYIlyBau
	 uHcg5NFG2WfzXfVobxMKarEatfQudF8q1WQnAJQQ=
Date: Fri, 2 Feb 2024 17:26:40 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stable <stable@vger.kernel.org>
Subject: Re: [PATCH for-v6.1.y+] drm/msm/dsi: Enable runtime PM
Message-ID: <2024020231-tarot-stress-3e50@gregkh>
References: <20240130134647.58630-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130134647.58630-1-amit.pundir@linaro.org>

On Tue, Jan 30, 2024 at 07:16:47PM +0530, Amit Pundir wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> [ Upstream commit 6ab502bc1cf3147ea1d8540d04b83a7a4cb6d1f1 ]
> 
> Some devices power the DSI PHY/PLL through a power rail that we model
> as a GENPD. Enable runtime PM to make it suspendable.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Patchwork: https://patchwork.freedesktop.org/patch/543352/
> Link: https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-2-a11a751f34f0@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Fixes display regression on DB845c running v6.1.75, v6.6.14 and v6.7.2.

Now queued up, thanks.

greg k-h

