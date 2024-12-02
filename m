Return-Path: <stable+bounces-96018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4AB9E043B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9502FB28136
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3581FE479;
	Mon,  2 Dec 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQqmChMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B651D958E
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143158; cv=none; b=bdcVGdUZUqDwg/m9V3ZU+ErA++WzKKH9S1nUhhMn4o/HYkQMP/+y/3NT5lkI4tc8e1QZfGTT0S0lYID9grAgqVpy+aVRGr3Vo243nugiBRNMBsU3gG7QjAKhpfWPyaLZkJJwc+ei0TQLa6l8g8YA3MUVz8vspo6w6pxs7VYMNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143158; c=relaxed/simple;
	bh=9IYUWYeN2WEFgHywbhA9x1iYU3ErGA29TPibX4/AmtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWGqc928XeGzndw1RQpGuXt1JPGfBJ50o9dzFwuzXy1xjtgJNKyo0HGrZ1bLjIcalE7NibQ/Fr+PH5tcT3iA613vgPbGrpwWnRTlsbKYDKhrLMWrFPYilJuZ0J2ZsL71KXEdOjK9Z7Uw5rthK6s2pQNAIOwsIzVS6I+A0JsGcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQqmChMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED857C4CED1;
	Mon,  2 Dec 2024 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733143157;
	bh=9IYUWYeN2WEFgHywbhA9x1iYU3ErGA29TPibX4/AmtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQqmChMI8cWE4VAY0YoQrd518ahcDA1B/TMObOPQKZhdYawcmw+UUXbONYDhty9rl
	 B2118rQEOXsiajJrI5AA3Tre3UQpbq7pkYlWnxld+L/7aYvaK8+ZEcz7xEYGN2n+sm
	 oXlcAVR0zqHVWD75CwYDIqI+DY0nY1CKHZdGk3XM=
Date: Mon, 2 Dec 2024 13:39:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.12 1/3] dt-bindings: net: fec: add pps channel property
Message-ID: <2024120257-commute-pastime-f108@gregkh>
References: <20241202110000.3454508-1-csokas.bence@prolan.hu>
 <20241202110000.3454508-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202110000.3454508-2-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 11:59:59AM +0100, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add fsl,pps-channel property to select where to connect the PPS signal.
> This depends on the internal SoC routing and on the board, for example
> on the i.MX8 SoC it can be connected to an external pin (using channel 1)
> or to internal eDMA as DMA request (channel 0).
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

No git id information?

That's required, please fix both of these series up and resend.

thanks,

greg k-h

