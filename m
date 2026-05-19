Return-Path: <stable+bounces-249622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPkfNZt9DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:11:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA73581287
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC52E30881E9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FF3AFCEC;
	Tue, 19 May 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldRAohDE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4B3AFCE0;
	Tue, 19 May 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202969; cv=none; b=QJTzm0O+pLq9Ij8NOxWM/XaKJ55PCY1x2CLcLTNJ8144h82ioDKBDua6/HT/EBLkRbzBlt0/fIN05on6mzF6g8a1C0PuXmeTQq7qPuEXJDpWJxI1NZrWeD0Z9vWIEYf4HpXH4zLzkaFCV5iajXAC/06I5lxSCIj12aeu0n+WoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202969; c=relaxed/simple;
	bh=R3VC2kH468haxg69JMEo0Vv9IF+Tx6n6FXqEs0roD8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuGc1NRCyo2i4cj/Qj0j49Fqh5eHu4bMCGv0zhaq9bQMRc1wkTylPwDyHROvFs/zBVJGrfvGx0LNaaSki8HPsScR+77vtt2DBmv2YmGAtfDRvpb08BhEi7F+Oz7G7Iqie4CU3ns51hU9fH5TUm5Ukhxw5uJIBCSvTh0TAIyAxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldRAohDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC9DC2BCB3;
	Tue, 19 May 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202969;
	bh=R3VC2kH468haxg69JMEo0Vv9IF+Tx6n6FXqEs0roD8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ldRAohDEdoLktu19Wbzx00ntdHvL0RR++CUSTJA5Zbe16wmNnaEDeK03H4SFlmH0u
	 rMCnJ7IKap+sUYZWuexMVmIC+MNphlBzo8SbPwMsHfY+VQwpo8UzXEzpwx3/d2dROL
	 yWsh9QPmySHVeDGvuALDqeueZo2Z4rAVqr9iVEBEOKczDaeyujOaIPpE0bjBCqguYr
	 RZlDpS7crLx6oQYYqDZJhvBkKvkEzmF1zRTyYWrppIwhG2KgkpcvIpMR8fJrllk5cT
	 LkoymX+UWzpBtqdD8FWJhCWI3fPPRk9QjYn7ctNrjTTNwaHwwxs98AAr3SK8GXO7FW
	 s/Pf6cCYW7LzA==
Message-ID: <01edcfce-639c-4f8d-a767-fc6e11aceff7@kernel.org>
Date: Tue, 19 May 2026 16:02:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
 <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7CA73581287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/15/26 12:56 PM, Mathieu Dubois-Briand wrote:
> Current implementation isn't working well when device tree nodes have a
> phandle on a fixed-layout nvmem node. As the fixed layout is handled in
> nvmem core, no driver is ever associated with the layout, and the device
> consumer driver probe is deferred indefinitely.
> 
> Remove the specific handling of fixed-layout and add a layout driver.
> This makes the fixed-layout similar to all other layouts, fixing the
> whole issue.
> 
> Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  MAINTAINERS                          |  5 ++++
>  drivers/nvmem/core.c                 | 23 +---------------
>  drivers/nvmem/layouts.c              | 11 --------
>  drivers/nvmem/layouts/Makefile       |  1 +
>  drivers/nvmem/layouts/fixed-layout.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/linux/nvmem-provider.h       |  7 +++++

> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index f3b13da78aac..e7eaa9a89b8b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -176,6 +176,7 @@ int nvmem_add_one_cell(struct nvmem_device *nvmem,
>  
>  int nvmem_layout_register(struct nvmem_layout *layout);
>  void nvmem_layout_unregister(struct nvmem_layout *layout);
> +int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np);

This is not a provider level api, so this api should not belong in this
file to start with. move it to internals.h something that is inside the
drivers/nvmem
>  
>  #define nvmem_layout_driver_register(drv) \
>  	__nvmem_layout_driver_register(drv, THIS_MODULE)
> @@ -214,6 +215,12 @@ static inline int nvmem_layout_register(struct nvmem_layout *layout)
>  
>  static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
>  
> +static inline int nvmem_add_cells_from_dt(struct nvmem_device *nvmem,
> +					  struct device_node *np)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_NVMEM */

