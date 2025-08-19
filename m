Return-Path: <stable+bounces-171805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9270BB2C738
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3A93A3DDB
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96588275B1A;
	Tue, 19 Aug 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="We44xkdg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112C20299B;
	Tue, 19 Aug 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614300; cv=none; b=dRfl5rsqoyPIMsMO7qXYIxB/M+9a+Pl5kZSoPX+svza6Lk03Co54qcwPbNL1drQVzITq61y8dOMUhRt/ZeJWwSAJrz1w9jquQbOIk1+KyMpxLCsVSfKOOgILqNArh1Frf2RhQuEKVmjtmlQKlMyYjNBC3mbN8s6ob6P/ZqexJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614300; c=relaxed/simple;
	bh=nNnopTRA3K0gOqFntUPVAFNEzVwqJdj692uRxbYzQx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoNLiJDZVbJq0Ax7+roArRj9pqWWiMwQBvHxXp4Y/KJU9Z/lb15TyDfrOqOY66Bg3d0Bbyae8skpOwgUS4S8JdAwfD0eciIIcdXHpOTXK7SIQhyFXSj455rLofQIJtJI3raw/Jt8qCENLdCVG4PYs+btx2bSC9Haf7Nu+6UDzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=We44xkdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A8DC4CEF1;
	Tue, 19 Aug 2025 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755614297;
	bh=nNnopTRA3K0gOqFntUPVAFNEzVwqJdj692uRxbYzQx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=We44xkdgCQlYNWU4EgVJPC9a/ienFYVDeuPnzurClvBtGPEukkJpE5LwWOaF4sv1y
	 lFjEIKAme14UDGv/yYelkKF1mpFEcm3xH5A1wIm+Rq4xw14TQ12nAZfxvwGiVKoLs+
	 X7wmrexdeLbvbmAq51AYZaCd/RX9RYV+/+EgR4yo=
Date: Tue, 19 Aug 2025 16:38:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xu.xin16@zte.com.cn
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, johan.hedberg@gmail.com,
	chen.junlin@zte.com.cn, stable@vger.kernel.org
Subject: Re: [PATCH linux-stable 6.6] Bluetooth: hci_conn: avoid queue when
 deleting hci connection
Message-ID: <2025081914-steadfast-ruckus-22bd@gregkh>
References: <20250819221605072sYBtQfxeXfCoV3_kHWRry@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819221605072sYBtQfxeXfCoV3_kHWRry@zte.com.cn>

On Tue, Aug 19, 2025 at 10:16:05PM +0800, xu.xin16@zte.com.cn wrote:
> From: Chen Junlin <chen.junlin@zte.com.cn>
> 
> Although the upstream commit 2b0f2fc9ed62 ("Bluetooth: hci_conn:
> Use disable_delayed_work_sync") has fixed the issue CVE-2024-56591, that
> patch depends on the implementaion of disable/enable_work() of workqueue
> [1], which are merged into 6.9/6.10 and so on. But for branch linux-6.6,
> there&apos;s no these feature of workqueue.

html marker in a changelog text?

> To solve CVE-2024-56591 without backport too many feature patches about
> workqueue, we can set a new flag HCI_CONN_DELETE when hci_conn_dell() is
> called, and the subsequent queuing of work will be ignored.

How was this tested?

> 
> [1] https://lore.kernel.org/all/20240216180559.208276-1-tj@kernel.org/
> 
> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

What commit id does this fix?  Why only 6.6 for it?


> ---
> include/net/bluetooth/hci_core.h | 8 +++++++-
> net/bluetooth/hci_conn.c         | 1 +
> 2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4f067599e6e9..9a3ec55079a1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -954,6 +954,7 @@ enum {
>  	HCI_CONN_BIG_SYNC_FAILED,
>  	HCI_CONN_PA_SYNC,
>  	HCI_CONN_PA_SYNC_FAILED,
> +	HCI_CONN_DELETE,
> };
> 
> static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -1575,7 +1576,12 @@ static inline void hci_conn_drop(struct hci_conn *conn)
>  		}
> 
>  		cancel_delayed_work(&conn->disc_work);
> -		queue_delayed_work(conn->hdev->workqueue,
> +		/*
> +		 * When HCI_CONN_DELETE is set, the conn is goint to be freed.
> +		 * Don&apos;t queue the work to avoid noisy WARNing about refcnt < 0.

Again, html text in a comment?

How does that happen?

thanks,

greg k-h

