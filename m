Return-Path: <stable+bounces-16427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F9840B35
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0071A1C21030
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA86155A5D;
	Mon, 29 Jan 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="saLNUoZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54F155A56
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545285; cv=none; b=FgQTgU52kLjqKvbX7bzShs7/Ona/qIIPv2X05XcpJr3ijAb3XszYwKYr+4oWjQKAf4625I/2pQ/CezDeaLgaJmoA6GKaimsa455yWLGbsUc87KizUm20RgaHGz6SL7Cugv+bija6TTR4Mt8ijnSCMLn7Fsx3JcqSYuHutAVfNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545285; c=relaxed/simple;
	bh=lc8Ll0BbxCMLN+CqKqsmQbirFduT5PFjY8QeBmiA3zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbpuYZWysVLuO/2TdnBE/ZFCIht6JqijeE7Az0WKqXI/73LioZW2/VJ4ajYme2rOAueGiWXeZ/Uzoc5VJpT6l9EObJkQw0miMFSmroCNqZBQETSu6kqk4rzbl7UM0/b2PBIZQYcY9gnu0hgiWFF+emQv9bEubX73x17tL3WdQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=saLNUoZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC264C433C7;
	Mon, 29 Jan 2024 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706545283;
	bh=lc8Ll0BbxCMLN+CqKqsmQbirFduT5PFjY8QeBmiA3zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saLNUoZxJvMwzMc8QWjFvt+yoKZpF9KHxXsZ2UqU8ik1lLR+Dsb13xAQWP5+trMpS
	 3z2u6NCtK2aX5Mnmws86XmFUA+91zw26JpWv1yYooRrjORoJ5zMSkktcCYD1hqRhPt
	 qLLS9SpMgLQPBH4J6MAJQJ3vTmaLXD22ipe9e5M4=
Date: Mon, 29 Jan 2024 08:21:23 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
Message-ID: <2024012936-disabled-yesterday-91bb@gregkh>
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129103902.3239531-1-amit.pundir@linaro.org>

On Mon, Jan 29, 2024 at 04:08:59PM +0530, Amit Pundir wrote:
> Hi,
> 
> v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
> to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
> display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
> ("drm/msm/dsi: Enable runtime PM") from the original patch series
> https://patchwork.freedesktop.org/series/119583/
> and it's dependent runtime PM helper routines as suggested by Dmitry
> https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
> fixes that display regression on DB845c.

We need fixes for all of the newer stable trees too, you can't fix an
issue in an old tree and then if you upgraded, you would run into that
issue again.

So please, resend this series as a set of series for all active lts
kernels, and we will be glad to queue them up.

thanks,

greg k-h

