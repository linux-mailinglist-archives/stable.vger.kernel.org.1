Return-Path: <stable+bounces-188005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC4BF0274
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4B33A7652
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D752F5A0C;
	Mon, 20 Oct 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7R0adCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DAC2F5A09
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952335; cv=none; b=O1Bvann/QQkfnAiZjeZ/JzEXgRUbKR58CwhcP0jvzPhjzmco0CrmC9dyM59+RUOHLQOLkVFij1DRnXrjN/netRka/hSKbfwpNR2W5t8Q2Ec85V0fFjBNbmMo+VybTAVdmLddJlYpX1skVJoOHtfk9YGeE+TjOgVSKtxwJr/j/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952335; c=relaxed/simple;
	bh=W8HXV47Y1iv4tzHg93ARptZ+Ago/9fhqC5B36Voyk84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQIEI8AkAgj5t+a2JS6EShpDs9aL9jZiB0WaVueeOToInIPZavi7KXk8gOOwipDSrEyZm5Iqe15NPJqtKX25uleb6VMXH7ns0xa44f0uuytP44LOVTKrArd+NPtMitXN6kAiqgJkpVlZ0h+RuOL/L4PtUZJpR+4eIoQ7Fy2WMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o7R0adCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A32C4CEF9;
	Mon, 20 Oct 2025 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760952334;
	bh=W8HXV47Y1iv4tzHg93ARptZ+Ago/9fhqC5B36Voyk84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7R0adCEVEDLXqy19JiuvwyYJVPcf1XYFXQ/W6rQcxa196PHsvcz+BL8isox3dS1q
	 77gKzo+mheUEfAfXOKBrSm+JvPd+bzMMLv0GNJW5Aw6pNE+KMQQkpWh3spU6NxmpWl
	 +KpF2/gVs0/FMtNFG0sfpIOxpFXCT66NMlFT9S00=
Date: Mon, 20 Oct 2025 11:25:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH 6.1.y 1/5] media: s5p-mfc: constify fw_name strings
Message-ID: <2025102014-try-superior-03d0@gregkh>
References: <2025101646-overtake-starch-c0ab@gregkh>
 <20251017144900.4007781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017144900.4007781-1-sashal@kernel.org>

On Fri, Oct 17, 2025 at 10:48:56AM -0400, Sasha Levin wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [ Upstream commit dd761d3cf4d518db197c8e03e3447ddfdccdb27e ]
> 
> Constify stored pointers to firmware names for code safety.  These are
> not modified by the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll drop this series as the 6.6.y one did not apply.

thanks,

greg k-h

