Return-Path: <stable+bounces-227134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MBYELDwumkBdQIAu9opvQ
	(envelope-from <stable+bounces-227134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:36:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4E2C167E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31EEC31976A6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122BC3264CD;
	Wed, 18 Mar 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NWUS6Rxm"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4031311940;
	Wed, 18 Mar 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855598; cv=none; b=pKdKqVJsMclkFFhExA56ApBWBWl1YX4c80FmoUzCCurBs3fnBRHQZBsUzCdlZcta4gUrDcHsLgqip0dQFJPULk5eiwI2y38wdvcz6WEH4XZ0K4Z+Gd+LQGIWuuriy2gJo/J9u0qN0AACWGRVt2cUFUSGQpa/AQt4xCnUvJS/ZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855598; c=relaxed/simple;
	bh=YRvjaWCkh8MiPb88owJeDp4joCT7weFpIcHasW4V0PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llx4Q/Qemi/vowfSqDg8Zwso4I/SKcSJZgQm3cj4psYxMCc3c/+599nqQMofCau+bZ0/wVSxPBZFAjO5+HvP/cje/OpdZxcYgBWpfHnnrrOq7bNoQqQTh2+4033Wag3+5EuqZqSjLOyZdPc3oUw2lPUgAWx6+GYx0UQBXkPLit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NWUS6Rxm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5hNKCWgX96sgR6zjiwj8uC7SyiqM+Qdw0bwirpBOYpc=; b=NWUS6RxmSfSu3uQi2YURo3VhoQ
	DZTzs6tv5kmMS4eLx8ORFN5e9Bt+Z2Ch1+YmhToKDPYxeOwE1W8K7FOFeubzWdWJX9I4NjaRsxC2f
	gufuanabSwF9JoS9MVXMTFWNpRH2qn7FzgqTQwyReP1Qo7tJCXmdAq4PmNX0U1X49BQ9v+gTdCeyX
	sjEl94m/iskIweupFLWo1Ntl5bYwwo57fssFaGDVYn9snS2JP2DImZz7vJ8WxkGge+x6ST/poml0r
	21KmkL9AJNCoLhYpKMe7mPp8qpJ8frlH2/eD93H+W6mbimkVUTsSzcwPTv09jsISH6ILc9iGmw6r+
	T2oqNRPA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2uro-003pAQ-2W; Wed, 18 Mar 2026 17:39:34 +0000
Date: Wed, 18 Mar 2026 10:39:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Piotr Raczynski <piotr.raczynski@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ice: fix double free in ice_sf_eth_activate() error path
Message-ID: <abrjCmR_ivMRY6KJ@gmail.com>
References: <20260318151028.634828-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318151028.634828-1-lgs201920130244@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227134-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45C4E2C167E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:10:28PM +0800, Guangshuo Li wrote:
> When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
> aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).
> 
> The device release callback ice_sf_dev_release() frees sf_dev, but
> the current error path falls through to sf_dev_free and calls
> kfree(sf_dev) again, causing a double free.
> 
> Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
> avoid falling through to sf_dev_free after auxiliary_device_uninit().
> 
> Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> index 1a2c94375ca7..ec6020338b9f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> @@ -305,6 +305,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>  
>  aux_dev_uninit:
>  	auxiliary_device_uninit(&sf_dev->adev);
> +	goto xa_erase;

Do you want to xa_erase?

Isn't ice_sf_dev_release() doing the xa_erase already on put_device()
path?

