Return-Path: <stable+bounces-231452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJgtMvbsy2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:49:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B054136C132
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DE9030BFC53
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B4A423177;
	Tue, 31 Mar 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prKcdYCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FC423A62;
	Tue, 31 Mar 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971503; cv=none; b=JLXgMz9Ifw0xZFmVPzXft1OCx9IMy9A/Vt9ycu+Q9gW5Rkxd5APvTz7BEXJbd0VhwNNc2VGflAPyiV8BzDNdN70jFj/URZBEF2DiVPeR8mP89QqrE0GJ0GS50Yb2aAq/G52sMEB1ruRqMZ2wCn3MSMD4LTAEt/b7zxvMnBEOGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971503; c=relaxed/simple;
	bh=Yb4OkI2lEqPgmQxRKGJSkL8RVqJUE5jHBisHEcfMpvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABCk9aztLjGKMrpcmuk9+ALlhEE8Henosy1TNN2AY6pR8QvZON7DKGiwYDhLc+6PTGhUtNE3YojL972p1VqkVdJYEzkj0oRvc/OQfRtN5r00mCoDnOf2jQgz8fAfcryutJygqkK28aYu1vOYGeFoihWayILxhNI7GQdGUj2GjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prKcdYCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C17C19423;
	Tue, 31 Mar 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971503;
	bh=Yb4OkI2lEqPgmQxRKGJSkL8RVqJUE5jHBisHEcfMpvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prKcdYCr9iUyZdZ03hpH+SWUzKf/iZt3M/8nLRReechb2/xcnKO/U8zPaj1FD4PRW
	 rcI/U+g8I9Fg+Uy9J0cWT42CaAJ4yHyByOfNNl9BnVlF4GVpw92otBZpe9Yul4xOra
	 r6WXTB//qE6Mq6BduC9WyguCnBztFLP7cRpOZ25mlLWzTOV/pQGBzsZ1rfwpv8Vq+0
	 0R8QMNP/cePyrMsgXBFfUJCIbRRaybE/ej0GpMR8doFNDLUiCXIjgNoMGFn0cgD9sh
	 4Z3OEV8NpzB4A4fcY0jePFPXbSyADic8kRMnpIyvQB/3mMBO6378UUsd0kC9EcDF0G
	 HvO6+kk2oZXFQ==
Date: Tue, 31 Mar 2026 17:38:18 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, netdev@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>, Rahul Sharma <black.hawk@163.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] net: enetc: fix PF !of_device_is_available()
 teardown path
Message-ID: <20260331153818.GA1992169@ax162>
References: <20260330081944.527545-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330081944.527545-1-vladimir.oltean@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231452-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B054136C132
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:19:44AM +0300, Vladimir Oltean wrote:
> Upstream commit e15c5506dd39 ("net: enetc: allocate vf_state during PF
> probes") was backported incorrectly to kernels where enetc_pf_probe()
> still has to manually check whether the OF node of the PCI device is
> enabled.
> 
> In kernels which contain commit bfce089ddd0e ("net: enetc: remove
> of_device_is_available() handling") and its dependent change, commit
> 6fffbc7ae137 ("PCI: Honor firmware's device disabled status"), the
> "err_device_disabled" label has disappeared. Yet, linux-6.1.y and
> earlier still contains it.
> 
> The trouble is that upstream commit e15c5506dd39 ("net: enetc: allocate
> vf_state during PF probes"), backported as 35668e29e979 in linux-6.1.y,
> introduces new code for the err_setup_mac_addresses and err_alloc_netdev
> labels which calls kfree(pf->vf_state). This code must not execute for
> the err_device_disabled label, because at that stage, the pf structure
> has not yet been allocated, and is an uninitialized pointer.
> 
> By moving the err_device_disabled label to undo just the previous
> operation, i.e. a successful enetc_psi_create() call with
> enetc_psi_destroy(), the dereference of uninitialized pf->vf_state is
> avoided.
> 
> Fixes: 35668e29e979 ("net: enetc: allocate vf_state during PF probes")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/linux-patches/20260330073356.GA1017537@ax162/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 99422c0b4a26..8cb4c759b165 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -1393,10 +1393,10 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	si->ndev = NULL;
>  	free_netdev(ndev);
>  err_alloc_netdev:
> -err_device_disabled:
>  err_setup_mac_addresses:
>  	kfree(pf->vf_state);
>  err_alloc_vf_state:
> +err_device_disabled:
>  	enetc_psi_destroy(pdev);
>  err_psi_create:
>  	return err;
> -- 
> 2.43.0
> 

