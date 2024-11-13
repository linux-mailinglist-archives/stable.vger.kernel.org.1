Return-Path: <stable+bounces-92876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC019C66B2
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D951F23E5C
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53E18654;
	Wed, 13 Nov 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX/fanIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E68BA34;
	Wed, 13 Nov 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461322; cv=none; b=dlYftcZbRAA1sDhrKxMUA3Sf1pBvbaGXlERCOALJkSzfiUmzIBWu2ybrP6KH8TePyohfsjt8ZE256LkyM9SyRzATuTgssPBhO3HsIlBh+QU/snhA+pt5Wg9JEs1ROwJl0pxkY1W/qoFLt0mruQ8Ww2Ozbyp+YsznjWir5KKgegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461322; c=relaxed/simple;
	bh=+X+k54ktMEeVatN/itYEiydQwmUaz5SOmKOWD1vzsw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCICz5Mw7pBfUYeSmA5mmODxQJFVpgaLQ5V3FH7peYoqgQbuoosQste11BpTaAVmNHwVk9qL3V3cWp0/X56gi6S6NQexAaj92PLGGX1B7m/9V9OyJ3WH8oBU3o4ka/cV2SH9FpEteKPz5ji18LKxEfNqbvXEiyMNkYPhNQ67Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX/fanIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2994C4CECD;
	Wed, 13 Nov 2024 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731461322;
	bh=+X+k54ktMEeVatN/itYEiydQwmUaz5SOmKOWD1vzsw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AX/fanIFaupuu4/sINoxaLFKX6Hx0jUzlvQfDsRpK5Cp72DPKQ6+K50toZc8Uaucj
	 qYMEBrXmkNE0WNRQOIcGL7/MmsMZSy/n2szVOZXSkYsGK2ceJcp07XPJ3Df09M7W7B
	 pveT3GcXnsGnF9U3NKpzD+YjFSZsA7WLGTVULMwvw9vPFX5pngzuB72KobMnYNz87q
	 3zoAq5B/LuCp6qWI3A1DVS+BBgO0ua9/Ka1Xuaj92ByWpzsD3iFyFHEhsXz84Qf/Lg
	 3LcMekJ0BjE3bzKYeDyLEGzmAaEPgLzjvUG6WKfE8SIpSe6xbWEFtHasvJ+fHAmRSp
	 lmH/9MmSHP7oA==
Date: Tue, 12 Nov 2024 17:28:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 mkarsten@uwaterloo.ca, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Mina Almasry
 <almasrymina@google.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Message-ID: <20241112172840.0cf9731f@kernel.org>
In-Reply-To: <20241112181401.9689-2-jdamato@fastly.com>
References: <20241112181401.9689-1-jdamato@fastly.com>
	<20241112181401.9689-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 18:13:58 +0000 Joe Damato wrote:
> +/* must be called under rcu_read_lock(), because napi_by_id requires it */
> +static struct napi_struct *__do_napi_by_id(unsigned int napi_id,
> +					   struct genl_info *info, int *err)
> +{
> +	struct napi_struct *napi;
> +
> +	napi = napi_by_id(napi_id);
> +	if (napi) {
> +		*err = 0;
> +	} else {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
> +		*err = -ENOENT;
> +	}
> +
> +	return napi;
> +}

Thanks for the quick follow up! I vote we don't factor this out.
I don't see what it buys us, TBH, normally we factor out code
to avoid having to unlock before return, but this code doesn't
have extra returns...

Just slap an rcu_read_lock / unlock around and that's it?

Feel free to repost soon.

