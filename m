Return-Path: <stable+bounces-188004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB354BF0257
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6206F3498E3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131D27A12D;
	Mon, 20 Oct 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="go/uKGAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92A189B80
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952215; cv=none; b=T1BHwVuoQ7F7vlxEOiNrv/DiKheBBxI0C4dfN8xdUrciI9P2iHs2iIJevIoL34BWupvT7Bz/magD2ZX+h067Ciz8+NK+PQeEQtdEf41Lp4ygyOmBt/ZfnJApClIgUNa7hjCqvgk1GFA2Is51dpWuYAKlDIYCbAI8DrrQ1s8IkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952215; c=relaxed/simple;
	bh=nZ2duEGBug1ry5EV1Pgtv6Z12+XiUE08TBphyrRKAkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rThzGpefZ4JlOVQTlWj6KbVb7B8oMwjzaErWByagSwJSz5kpXKMTbl//OEbsMNEqpUuprNJdDuZ94yRhDJHjtYSLe+sxww2fwjMzikXGKPaKNa592ke0UuvQurxErQxZgX3/+HtHo4w5K494TzDCLz0i9k6snjNwPallpxleI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=go/uKGAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4874BC116C6;
	Mon, 20 Oct 2025 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760952214;
	bh=nZ2duEGBug1ry5EV1Pgtv6Z12+XiUE08TBphyrRKAkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=go/uKGAV01+gllfTX4IhEYyuqR4KCCwrV4WxUUKh/gfIpi5dSF/YCPLbtDS4uinPr
	 fyOaH20LZS9jw3nxmVFJafuyaJ8C8tCV8O9UySSapXUqdjUxlMWC7D5uNmUSZFRncL
	 xCSt3CCWpy5rJD3uZ8qIxVEzsMvzCdtz2s13shms=
Date: Mon, 20 Oct 2025 11:23:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH 6.6.y 3/5] media: s5p-mfc: constify s5p_mfc_hw_cmds
 structures
Message-ID: <2025102030-tribunal-level-9d7a@gregkh>
References: <2025101646-unfunded-bootlace-0264@gregkh>
 <20251017143208.3997488-1-sashal@kernel.org>
 <20251017143208.3997488-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017143208.3997488-3-sashal@kernel.org>

On Fri, Oct 17, 2025 at 10:32:06AM -0400, Sasha Levin wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [ Upstream commit c76c43d77869adc1709693ba532fe7fb4f30aa45 ]
> 
> Static "s5p_mfc_hw_cmds" structures are not modified by the driver, so
> they can be made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch breaks the build, so I've dropped this whole series.  Can you
redo it and resend?

thanks,

greg k-h

