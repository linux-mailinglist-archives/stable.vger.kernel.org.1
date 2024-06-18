Return-Path: <stable+bounces-52661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D890C9FD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A51C208CA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA23158873;
	Tue, 18 Jun 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ6ArSLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF41581F4;
	Tue, 18 Jun 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708886; cv=none; b=V9hkpLoocLepvyeN8TGK4gT+SR3M0sBnCLv8rqSZEKJDN7sZ9HWqfR4A+UDPDliYPlsfgIiqY7yNLXoUzGYUbXXSa7czY3pqhzEEhjpuYEWGLj5y70LKdWrLLk3RUublqQdNNE60u/0vh/SdtS7jrTVBnoKY0qNGb6X0J7oWHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708886; c=relaxed/simple;
	bh=iuju15LgOX/mkNKHdPi9+klPChsI8/gq/J6t0HcI0TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zht4uWhR8ZGJ0gI2UgaNoDVGLsdnSUFuvEMGk5NOIvcjD9E2ejqk5k7Dveo6j9Whh7Yq7piHm0DvOz/jNaaf9y7AanaDlb6qDpzxRc2FQsvlw67WodX8AjvjQYiSqTZiVrKcj7t5Lmr7taQuQE5IJeZxdljc87/X2ZX4fI2hTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ6ArSLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8F4C3277B;
	Tue, 18 Jun 2024 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718708885;
	bh=iuju15LgOX/mkNKHdPi9+klPChsI8/gq/J6t0HcI0TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJ6ArSLPlxEufwERlt1gruw+Lg/DVgnUGMgQZFd0A9uDSBhsqTkPXb7t0v5HKFYw3
	 aZ3SHG9unx+P3A/T++X9Y600nLMUNS59/Gpcvn6TpljJtUn8F7OQzUP0pnbRAoNanN
	 8IjkiYYDX8LItSR9CtbL1i3gFMhUWac23HTSm3/gfZe3rGrrQPVlE6S0El/+RlR6i6
	 MhU+XTLOKCyhe80eXqS1530danoakPtPdNwY636evgiB3lRQiZlkOQ5kief7Qn4l/R
	 Fiu332zT+N/tQMGeC/dlI7MUQ/vcRMV+sdCfEBfsJCc25BdWGb1fe84dB82WTeifS3
	 oJ1Mt5b8GyCSg==
Date: Tue, 18 Jun 2024 12:08:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: improve link status logs
Message-ID: <20240618110800.GM8447@kernel.org>
References: <20240617103405.654567-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617103405.654567-1-jtornosm@redhat.com>

On Mon, Jun 17, 2024 at 12:33:59PM +0200, Jose Ignacio Tornos Martinez wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and afer this the link is set to up, the last new log that is

nit: after

> appearing is incorrectly telling that the link is up.
> 
> In order to aovid errors, show link status logs after link_reset

nit: avoid

Nits Flagged by checkpatch.pl --codespell

> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

The nits above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

