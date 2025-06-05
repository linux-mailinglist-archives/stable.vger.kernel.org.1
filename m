Return-Path: <stable+bounces-151545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7294ACF2BF
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C5B188A62D
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF31D432D;
	Thu,  5 Jun 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR70Wmli"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA891AC44D;
	Thu,  5 Jun 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136383; cv=none; b=NRCO6QN0F+G8TdPq1Dyw/uegvrX8q/zjBiaf2XpRpcZw6F5qxVQHRDOIgj2b78fgN0KcQE9MCu2aybvzMvMOE7jyRr4w3Ih/aTtUZUP+b3WQ3y/sIlOIQ1ZFxOmMnEZzmhpgSfQwDDAgR8+9uDCIuHSdjXMFaUs5BdZma8i49Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136383; c=relaxed/simple;
	bh=JdVHcHsY08lcMK6ICKfUDHxE6j64CtG+laE7A0bEhlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Fb5GhqaowKD2y8/UDE92gexcRkbEXXYng/GzRBWf9ztcRLoszXw+R4EncHrw/7s4AEbj3eHy5FHHc0YUtNT1EzzMYmPAIVxpAy4EwYaQqICF93OpUaiDV+FINxVCJ+Dq12W+5XhdFnTnpM6l0IkyeRyS3sWxUqCAx35W45/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR70Wmli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF91C4CEEB;
	Thu,  5 Jun 2025 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136383;
	bh=JdVHcHsY08lcMK6ICKfUDHxE6j64CtG+laE7A0bEhlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bR70Wmlia/Sth/9zcx6hEj1Y+RJ/ElDQtpRyxK6wTumhgqMGYH9YlfinW6zP7kZ+2
	 dC29ZVQzapJlnSQ8dm74QeL1y9efmLsaIfLq6vUt7TBykNMZp+aT5ACTKURRdIDolg
	 TJAsQF+rXDCz4TLUMe9cdnjuRr8E8FFzRbHZotXksTNnWwXxXssf+tTcu2Ov1hlcm5
	 cmu0OgREhuDPQcaXN0Op+dfZ9YLTr6wFXSLsbs/Zya75H5qxYBZADE2l/o62ZhpAmp
	 +pIHNQtzztj9tGhCaz5HHBPmTNJ/bzQWeO4m8697pcAabK2dQKTV6bk/eJ4dyECvlw
	 z8R4iJVVsyWdg==
Date: Thu, 5 Jun 2025 08:13:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, pkaligineedi@google.com, joshwash@google.com,
 thostet@google.com, jfraker@google.com, awogbemila@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: Fix stuck TX queue for DQ queue format
Message-ID: <20250605081301.2659870c@kernel.org>
In-Reply-To: <20250604201938.1409219-1-hramamurthy@google.com>
References: <20250604201938.1409219-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Jun 2025 20:19:38 +0000 Harshitha Ramamurthy wrote:
> +	netdev_info(dev, "Kicking queue %d", txqueue);
> +	napi_schedule(&block->napi);
> +	tx->last_kick_msec = current_time;
> +	goto out;
>  
>  reset:
>  	gve_schedule_reset(priv);

gotos at the base level of the function are too ugly to exit.

Please refactor this first to move the logic that decides whether
reset should happen to a separate helper, then you can avoid both
gotos/labels.

goto reset should turn into return true
goto out should turn into return false
-- 
pw-bot: cr

