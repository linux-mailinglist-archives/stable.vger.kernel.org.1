Return-Path: <stable+bounces-125679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F890A6ABED
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 18:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655CD463631
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF222253E9;
	Thu, 20 Mar 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0DI3by+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8B2253A7;
	Thu, 20 Mar 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491514; cv=none; b=JDAfoWhuMv+86C2YM9zhfuJbAdPVzrCQRMn+GEiqCdGCG/g2pqhbSMvUUK/kazy2kMF38z7p8jLqyNJrRo5AN+aFYrW4sea51Xk0uV77sJ5hpFYgAp//kXcxE9+GQgXuQsVyROC6z9VaLXiJ0T6c6GV3Q6TbtYlc2C97X1WlUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491514; c=relaxed/simple;
	bh=l+5UGUfjGqgfaNep1dASsWVQz/pWBXRzNfhtgWL0xYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNiBwwQmrvMY+P2pkKRI7SrrLhWJamCqTgld0KyFvlzPczWfTmtDo183T/r51fj9oBUoY528bckDUUU2rza5yYKHKM8OvT7RidMtIT9dF9JobToJjDw34Aj6ZQSjBrPbL2h89SUezCzmXH/rrFtt8PH3J8HmwDqOSKKHjSiVmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0DI3by+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACACBC4CEDD;
	Thu, 20 Mar 2025 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491513;
	bh=l+5UGUfjGqgfaNep1dASsWVQz/pWBXRzNfhtgWL0xYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0DI3by+UNv+MqGTaN3ADT8Cq6vdP3mh9mt0PoPDCUQMg7cHN5Z0eFftbNttEFcYI
	 1Gt905fCW25woJ6ZA/4go4sB+QxOYxHwIr7V0amWp+9CYyZBZOoI4fD1AexuCgRmGK
	 YxjH9+Ln3U75nXbhaHVBp5Qp8Vixqb5k+hLvN81F1lPMFi/c7Yn6+XjGYmrxixQ5se
	 WU1fLfjqsLTxVtCXy0uV0HWfLaiOJvP7EyE3fjWFnsIKbOb5sic4tgIOZiyv+O5Gnx
	 hgW9ZYtIBeKjKOrianktg4Gu6698yq8S6lwUy3ddYEB/XOlJ8AiJWrDsCz5oiTVbfa
	 KBjzyvT3huNJw==
Date: Thu, 20 Mar 2025 17:25:08 +0000
From: Simon Horman <horms@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pkaligineedi@google.com, shailend@google.com,
	willemb@google.com, jacob.e.keller@intel.com, joshwash@google.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: unlink old napi only if page pool exists
Message-ID: <20250320172508.GD892515@horms.kernel.org>
References: <20250317214141.286854-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317214141.286854-1-hramamurthy@google.com>

On Mon, Mar 17, 2025 at 09:41:41PM +0000, Harshitha Ramamurthy wrote:
> Commit de70981f295e ("gve: unlink old napi when stopping a queue using
> queue API") unlinks the old napi when stopping a queue. But this breaks
> QPL mode of the driver which does not use page pool. Fix this by checking
> that there's a page pool associated with the ring.
> 
> Cc: stable@vger.kernel.org
> Fixes: de70981f295e ("gve: unlink old napi when stopping a queue using queue API")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


