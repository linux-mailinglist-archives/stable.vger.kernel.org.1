Return-Path: <stable+bounces-58194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B363929D6A
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDE71C21ACE
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668A528E0F;
	Mon,  8 Jul 2024 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2BSkbJ0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F723774
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424696; cv=none; b=iBYYjdjlR8Bm1eqQ24sA1aKgwk8cMEKqTJqwmDRCt7JKe6KT3nRZHdYWgiqbwSPC9f24DJChaz3Q0wpOXS4x1O8gCW31libnNBr6jeSpGw1U59dpFTyx/dNoM4EBf01kUUdhR2ZjHlHl/f2EthBOBJH926WDuev8Q50rR7qEH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424696; c=relaxed/simple;
	bh=JtXonjQxfBbCHGzmeuOND8Qr4JxegSBH8TInwbZXnrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXsHgXZBP7h87ymYA5qaADEZdJpy/9d4cE2WGqERZR9QXpAYG5+V+TlpHJCsmsAwYqdaG+w9ZaYm+Epqsy0tmIXR8TcQVZRGyy7q62HEQESVlMq38+0cOgyqR6eNth+FKDu4D3DBaMY5XwhBhIM98LQtiIrhh7UrUbR69V0f2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2BSkbJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720424693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+aNJhKQ2AAmu/LKR1gLjPNlzCwSmcKQsAKuld4iwdng=;
	b=d2BSkbJ0WirixWkmy1qIXOkLzcCayOM8drOI6+SM34jOXDxi3PcGTxNiIobBGJAbTPSx9h
	PWZNVPenvGZA9/l6ne1wJf82XIGunM5NmsbTyxhmSKfSEUYW20/9424Smva/56bFhXbGKF
	83VCJwQYduQcE16MrDpCg4WtpHA9VsE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-_UiPyZRPNxqXVIpBKCCv4w-1; Mon,
 08 Jul 2024 03:44:47 -0400
X-MC-Unique: _UiPyZRPNxqXVIpBKCCv4w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACE841955F56;
	Mon,  8 Jul 2024 07:44:45 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.86])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2993919560AE;
	Mon,  8 Jul 2024 07:44:45 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9757BA80B8A; Mon,  8 Jul 2024 09:44:42 +0200 (CEST)
Date: Mon, 8 Jul 2024 09:44:42 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: Patch "igc: fix a log entry using uninitialized netdev" has been
 added to the 6.9-stable tree
Message-ID: <ZouY6i1Oz77wGC77@calimero.vinschen.de>
References: <20240705192937.3519731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705192937.3519731-1-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Sasha,

my patch should not go into the stable branches.  Under certain
circumstances it triggered kernel crashes.

Consequentially this patch has been reverted in the main
development branch:

  8eef5c3cea65 Revert "igc: fix a log entry using uninitialized netdev"

So I suggest to remove my patch 86167183a17e from the stable branches or
apply 8eef5c3cea65 as well.


Sorry and thanks,
Corinna


On Jul  5 15:29, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     igc: fix a log entry using uninitialized netdev
> 
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      igc-fix-a-log-entry-using-uninitialized-netdev.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit ee112b3c8929ec718b444134db87e1c585eb7d70
> Author: Corinna Vinschen <vinschen@redhat.com>
> Date:   Tue Apr 23 12:24:54 2024 +0200
> 
>     igc: fix a log entry using uninitialized netdev
>     
>     [ Upstream commit 86167183a17e03ec77198897975e9fdfbd53cb0b ]
>     
>     During successful probe, igc logs this:
>     
>     [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     The reason is that igc_ptp_init() is called very early, even before
>     register_netdev() has been called. So the netdev_info() call works
>     on a partially uninitialized netdev.
>     
>     Fix this by calling igc_ptp_init() after register_netdev(), right
>     after the media autosense check, just as in igb.  Add a comment,
>     just as in igb.
>     
>     Now the log message is fine:
>     
>     [    5.200987] igc 0000:01:00.0 eth0: PHC added
>     
>     Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>     Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
>     Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>     Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>     Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 58bc96021bb4c..07feb951be749 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6932,8 +6932,6 @@ static int igc_probe(struct pci_dev *pdev,
>  	device_set_wakeup_enable(&adapter->pdev->dev,
>  				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
>  
> -	igc_ptp_init(adapter);
> -
>  	igc_tsn_clear_schedule(adapter);
>  
>  	/* reset the hardware with the new settings */
> @@ -6955,6 +6953,9 @@ static int igc_probe(struct pci_dev *pdev,
>  	/* Check if Media Autosense is enabled */
>  	adapter->ei = *ei;
>  
> +	/* do hw tstamp init after resetting */
> +	igc_ptp_init(adapter);
> +
>  	/* print pcie link status and MAC address */
>  	pcie_print_link_status(pdev);
>  	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);


