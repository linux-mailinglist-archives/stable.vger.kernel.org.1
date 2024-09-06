Return-Path: <stable+bounces-73708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DA96ED9F
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529AE288240
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D215747D;
	Fri,  6 Sep 2024 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4CxN0OM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CB156677;
	Fri,  6 Sep 2024 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610737; cv=none; b=HUB3bwoGu3XQQxDhC0IuZHOR/LcGyWwehuQVPR0pVsieP/WUfmnptXXZpOcwRoy9WZsnAl4INvn4rATSq+R4aFXgGqMu+55jdN53gwTMqPvHmwJ7QNncmzOqhLO3m6fljtDAqs6ctWpN9MKrUzHgpMigrei25j/rnmvFX0KPfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610737; c=relaxed/simple;
	bh=LSJTC7RdTHY1Ox0sqM20UNoiY7XdIiN8dWGwQOog8Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzuN6vItJZs8ZcRiv96V/yIbZSaPCJHShO6bJSUeP1PAgeMw3yxPQYCAWudWE6vy1EABy+B9ScXR0Q30/x4V75c8PVDvgJhS5Jev/Fg6/ldsv8N1yZ6dxYB4vYfZiRdPvO7rZNeP/EAsWDtQ21rMqTLKNpyG6U0Inz1t1BpdZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4CxN0OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA52C4CEC4;
	Fri,  6 Sep 2024 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725610737;
	bh=LSJTC7RdTHY1Ox0sqM20UNoiY7XdIiN8dWGwQOog8Nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4CxN0OMSdhKQU6KKHa+C/4OzKle2p6EJGK0yoqy703pt0pzEzysrjL+/HzcLvSS5
	 inYiFfiWmcRycD+88STSiy0/cJsOp1vCFly44gJ+rU8OWLnEOCPPeSR69DKyz0LKEt
	 pkc2tflP1ELpC2hK95vSxTxWURB7wOVOBcmXUvs430ozLKbrIZU/cAquyzIqQUrzgQ
	 tlHJuehZP1OW7FNRkS5YYPlBfGGo5J75w8hOkN7G1uPZ6+b/g+zd6/hKC4sSMS2rFw
	 IDYmXJp9YFvMUnUx2B/jRJcDq2jfhYYqaMUo3lzNVy6wrCk4zYxvpxg50NiHcqDcPw
	 CLfFen23jzdvw==
Date: Fri, 6 Sep 2024 09:18:52 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@outlook.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ice: Fix improper handling of refcount in
 ice_dpll_init_rclk_pins()
Message-ID: <20240906081852.GB2097826@kernel.org>
References: <SY8P300MB0460F0F4B5D0BC6768DCA466C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY8P300MB0460F0F4B5D0BC6768DCA466C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>

On Tue, Sep 03, 2024 at 11:48:43AM +0000, Gui-Dong Han wrote:
> This patch addresses a reference count handling issue in the
> ice_dpll_init_rclk_pins() function. The function calls ice_dpll_get_pins(),
> which increments the reference count of the relevant resources. However,
> if the condition WARN_ON((!vsi || !vsi->netdev)) is met, the function
> currently returns an error without properly releasing the resources
> acquired by ice_dpll_get_pins(), leading to a reference count leak.
> 
> To resolve this, the check has been moved to the top of the function. This
> ensures that the function verifies the state before any resources are
> acquired, avoiding the need for additional resource management in the
> error path. 
> 
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and detecting potential issues where resources are not properly managed.
> In this case, the tool flagged the missing release operation as a
> potential problem, which led to the development of this patch.
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
> v2:
> * In this patch v2, the check for vsi and vsi->netdev has been moved to
> the top of the function to simplify error handling and avoid the need for
> resource unwinding.
>   Thanks to Simon Horman for suggesting this improvement.

Thanks for the update,

I agree with your analysis and that the problem is introduced by
the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>


