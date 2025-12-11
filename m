Return-Path: <stable+bounces-200784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC74CB569B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A98300B938
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC122FB629;
	Thu, 11 Dec 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx06pQkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937211F5851;
	Thu, 11 Dec 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446607; cv=none; b=Tf3qe7+qLLqftj68vCdKLSgKyDhG3ztLSMSBwnbqP3oHYIGNMiCmy0/ZRQgfJJJmwjSiTZtUancdN4PuQlJmZfmeLMuqmvUBdk3LElvAs/qPRRkG4wnmjPkXB+/qTC385sEI+wsssQscT+c+XV3xReC0oIgI8iL94tS3uzx4VAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446607; c=relaxed/simple;
	bh=fz+ZSdSrWx849zMNBOatENIDRggiloYOCWEVBUKvZD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqqWXWGBOJZE6MbqfBA9r3iUX5u2vzhn7P2qit74QKElLgz4GaWi/HoAfhNDlru5IfHVDLiOjhdsry0CCyLqVIPj+GuxfQn8Cwm7kXHEfs+VsCURnfhRDj1+4Rm+3mS5Xq1uJ8ylbwfUaLbDVqthB9WSftCCV3CE5p8Aua7mOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx06pQkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45E5C4CEF7;
	Thu, 11 Dec 2025 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446605;
	bh=fz+ZSdSrWx849zMNBOatENIDRggiloYOCWEVBUKvZD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xx06pQkWKSb1yzMbU8wItuJnn5bCftHO3vNvL8R6lrv+bb/etVbDKIIILof1O8hha
	 gGo0s0Ig6iRoJUjsX40icQxseF2aS9lIgw+wHDRC4yrf6wCsGCntlZsPTuz6DneRK8
	 Y7M6Ut79AyMi13+eIxxSi/5EDwpsQ3R41tMFnVmqwOEJ19KLfDxMnHcMfJSEfyy/Nh
	 ZKtgmV6kw4vzz3kOqQUXiZ0qaEa9Qx0ox+D+7f0mEDUxnmnsU2H9k4Oh3Y15highhd
	 iAV2C1D/cVdRZ09m8ngBHSbovU1+pq5WhziVWv846GmH5B74R5+ZgrOnPweOVJreeF
	 OiYdB7YNXhUoA==
Date: Thu, 11 Dec 2025 18:50:02 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] atm: mpoa: Fix UAF on qos_head list in
 procfs
Message-ID: <20251211185002.44e4aee3@kernel.org>
In-Reply-To: <20251204062421.96986-2-ii4gsp@gmail.com>
References: <20251204062421.96986-1-ii4gsp@gmail.com>
	<20251204062421.96986-2-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 15:24:21 +0900 Minseong Kim wrote:
> Reported-by: Minseong Kim <ii4gsp@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>

The tags are wrong. Reported-by is only used when it's not the same as
author. And you're pointing Closes at previous version? I don't get it.

> -int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
> +static int __atm_mpoa_delete_qos_locked(struct atm_mpoa_qos *entry)
>  {
>  	struct atm_mpoa_qos *curr;
>  
> -	if (entry == NULL)
> +	if (!entry)
>  		return 0;
> +

please avoid unrelated code cleanups in fixes

>  	if (entry == qos_head) {
> -		qos_head = qos_head->next;
> -		kfree(entry);
> +		qos_head = entry->next;
>  		return 1;
>  	}
>  
>  	curr = qos_head;
> -	while (curr != NULL) {
> +	while (curr) {
>  		if (curr->next == entry) {
>  			curr->next = entry->next;
> -			kfree(entry);
>  			return 1;
>  		}
>  		curr = curr->next;

> + * Overwrites the old entry or makes a new one.
> + */
> +struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos)
> +{
> +	struct atm_mpoa_qos *entry;
> +	struct atm_mpoa_qos *new;
> +
> +	/* Fast path: update existing entry */
> +	mutex_lock(&qos_mutex);
> +	entry = __atm_mpoa_search_qos(dst_ip);
> +	if (entry) {
> +		entry->qos = *qos;
> +		mutex_unlock(&qos_mutex);
> +		return entry;
> +	}
> +	mutex_unlock(&qos_mutex);
> +
> +	/* Allocate outside lock */

Why allocate outside the lock? It makes the code more complicated,
keep it simple unless you can prove real life benefits.

> +	new = kmalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return NULL;



