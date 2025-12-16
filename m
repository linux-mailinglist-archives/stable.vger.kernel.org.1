Return-Path: <stable+bounces-202720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA0CC48C5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15E430EA620
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CE31355F;
	Tue, 16 Dec 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFto8oZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C443288502;
	Tue, 16 Dec 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904386; cv=none; b=GK7THi2TN4EBizwaz3uWglHWo5rVgvja/uEnNkqjz/ZiYCbxuC4zvcZuEzgnK6MFrnNiiqBX4PI+1qym45F2SNTRyii8RXSDrE6PI/mhCIcTOhtuFxvcGHQTpwRtlk0OOHxsrpy81IhtRfEqXi6FpnDnP0iwSl9nivswDFJS4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904386; c=relaxed/simple;
	bh=jt1/q7cE1GsiB/oCFeOCisXWO1SGjLZu25/0fHSA/Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcaYVcUcaF7vaVyi18Da5IiUFjyGpuF9QpfQwnURusoqpHO1gwRnYTItyrMYvDoTuH4uOBjhidh+9W21U2SkrInr22MNX2hx8Kt6kv91OoyqluMsiqsLpeOpXALclEIOMkQoX8z4n/WvVIMWEq9Siw/iwpwpQDZSFt9LnSKdkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFto8oZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8945C19423;
	Tue, 16 Dec 2025 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904386;
	bh=jt1/q7cE1GsiB/oCFeOCisXWO1SGjLZu25/0fHSA/Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFto8oZIW55h7Dd/jNS4jF46GRTG8xTBdN3EnqUS7RMrAQxtdGze0g0WITffuJGHi
	 ER7PQVa9dQNKXV7gVWq0qIq3udf5dxbsnuvKcV4be+db4s17AFZ8EIFxXSSvj05GHT
	 CmID1TJTkyqNu1eRnKBI8BI2MBKpPgBGZ/Cw1yBxMikUEpy++3Y4LKsiTjeFyqAjEn
	 jYnS9FOFezuo57CW5TXC+UGAbahVrbKlDCerTH7SL7xLKSrKZFyRRar4mzaN36h8WE
	 badkaKSqPiCFl2htD2eaOxQTxd58C01Fdq+72fSGRD2SGQwfmdLe7QRHMq6uibZbbN
	 +HtASkP5uuFJw==
Date: Tue, 16 Dec 2025 16:59:42 +0000
From: Simon Horman <horms@kernel.org>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] atm: mpoa: Fix UAF on qos_head list in procfs
Message-ID: <aUGP_kggEz_5-RAc@horms.kernel.org>
References: <20251204062421.96986-2-ii4gsp@gmail.com>
 <20251216120910.337436-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216120910.337436-1-ii4gsp@gmail.com>

On Tue, Dec 16, 2025 at 09:09:10PM +0900, Minseong Kim wrote:
> /proc/net/atm/mpc read-side iterates qos_head without synchronization,
> while write-side can delete and free entries concurrently, leading to
> use-after-free.
> 
> Protect qos_head with a mutex and ensure procfs search+delete operations
> are serialized under the same lock.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>

...

> @@ -1521,8 +1525,11 @@ static void __exit atm_mpoa_cleanup(void)
>  		mpc = tmp;
>  	}
>  
> +	mutex_lock(&qos_mutex);
>  	qos = qos_head;
>  	qos_head = NULL;
> +	mutex_unlock(&qos_mutex);

I don't think this is necessary.

mpc_proc_clean() is called earlier in atm_mpoa_cleanup().  So I don't think
any accesses to the procfs callbacks can be occurring at this point. So
there is no need to guard against that.


Conversely the following call chain accesses, qos_head, and uses an entry
if found there. But there doesn't seem to be protection for concurrent
access (or removal) from procfs.

MPOA_res_reply_rcvd()->check_qos_and_open_shortcut->atm_mpoa_search_qos()

In this case I'm concerned that extending the current locking approach may
result in poor behaviour if procfs holds qos_mutex for an extended period.


And I think that there is also a concurrency issue with
access to qos_head in the following call chain.

mpc_show()->atm_mpoa_disp_qos()

...

-- 
pw-bot: changes-requested

