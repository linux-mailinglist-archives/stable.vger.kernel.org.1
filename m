Return-Path: <stable+bounces-136491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF8A99C9C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93AA194091A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 00:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003C780B;
	Thu, 24 Apr 2025 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcm4O7yd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF03FC2;
	Thu, 24 Apr 2025 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453673; cv=none; b=r6NCrQS2xturA6yhg3zEglMkTr75HfOstHA7SKZ1krNL/a6Zx02FdLxqp3BwHfs8wNPdSIu0SoZ6o4eBeFG8DFKNefpqg/o9BKCPLeyAjZCDInv0gbpGfj193MEKQZEAxQ4SJk6bAQbt18SjbTaFIIgzhMl9GbAwTr4ub+psGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453673; c=relaxed/simple;
	bh=n0TSJLKak1tuBbaz0EWuvr3Cm4M4taXFEVBdU8emlyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfT9dhHt0FeO5rTBpWhXuwiBHH+1sauLGu7MfdjmGl+mBa5IJ0qnWUK3l4KtOXfnNdkT75XhkmTV5VJjoi3KKVBDnBnEWPXSV/uGYJ04gsxlS61+ynLvxoN3Pey23ijfHxERfoo+dqevbjX5cWqFegb9PHwz7bONHHQNe2o3fqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcm4O7yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EEFC4CEE2;
	Thu, 24 Apr 2025 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453673;
	bh=n0TSJLKak1tuBbaz0EWuvr3Cm4M4taXFEVBdU8emlyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcm4O7ydQT4lc96jG+a4lIofuzg6LA5ARUz8yLVSWh1DgytbaWGmbD2lfndX/Yzz1
	 +o8o4LmNud0AN+34Qujb6fIIhsO+I9km0YmXThIPxDwYL3bh07Am7UUWhG0QPwxBqn
	 NYeOjeAByZbv9QwA9073SfP+uP1lAvQU+2fAssqJ7rYyC6T+anWn941YNYLWm2Vyrt
	 M5r1zG/1uORp6m+wnCWMuinlXwOqwYC4NLOL8kaSJchy5crHl9rOt0cF75KLL7DEFN
	 BeCCECYc4M4laPRGILZ+3ok7EqArrJreKCM8oCnspwrABvub4HWlPz7oqal2hjbbxi
	 DUZXSsF8iN0LA==
Date: Wed, 23 Apr 2025 17:14:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 pkaligineedi@google.com, willemb@google.com, ziweixiao@google.com,
 shailend@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: Add adminq lock for creating and destroying
 multiple queues
Message-ID: <20250423171431.2cd8ca21@kernel.org>
In-Reply-To: <20250417204323.3902669-1-hramamurthy@google.com>
References: <20250417204323.3902669-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 20:43:23 +0000 Harshitha Ramamurthy wrote:
> Also this patch cleans up the error handling code of
> gve_adminq_destroy_tx_queue.

>  static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
>  {
>  	union gve_adminq_command cmd;
> -	int err;
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_TX_QUEUE);
> @@ -808,11 +820,7 @@ static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
>  		.queue_id = cpu_to_be32(queue_index),
>  	};
>  
> -	err = gve_adminq_issue_cmd(priv, &cmd);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return gve_adminq_issue_cmd(priv, &cmd);
>  }

You mean this cleanup? That's not appropriate for a stable fix...

Could you also explain which callers of this core are not already
under rtnl_lock and/pr the netdev instance lock?
-- 
pw-bot: cr

