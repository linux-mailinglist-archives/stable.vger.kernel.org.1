Return-Path: <stable+bounces-238587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACq8Hohu42kyGwEAu9opvQ
	(envelope-from <stable+bounces-238587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA242102B
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9943021B37
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6E3537E0;
	Sat, 18 Apr 2026 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDAgTTSm"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA093314C2
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512581; cv=none; b=Qbq13rU4Gqre0ZkmLSpgoY2zVWdgyLXBN6qH6V2tcrcB62fUmgjgMjhCUs5zIKOLQ2yu+dIVK/T69i4UDj1MrNK/qBuyyP0oumjlycF1jHeRG1roV+LuDMLnwdYUnWFAEZVVQ5Tvh1VDtRGn32pLT163JRkA6DMAqFSiC7Bo8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512581; c=relaxed/simple;
	bh=Zk/Xbk5hbC97xGhB8xhReMX0EshM2qrPg5tkYfWm5VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flsxhmXNyi+xOER0dSbtM7m1g4bJ4quMhcERAg9d/1VY+doJ1C3dGarhqYmHgvkXWxYJUm6GW8VdO0wTPn0g9C43C0U2uNAEfYKwp3zeEmIve8KIm3Izis5LQzXRqlC0SdclSeTXhWlmmr8kS2pT7aydaBe98rf64TeJoBVLDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDAgTTSm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 18 Apr 2026 13:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776512577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJ5pOiV3uVbrwJIxnnvzTrlyc9egBQkFtQd756B21gY=;
	b=CDAgTTSmQsTHUAWzdEUMgIE7TbVCPONiZhpyuG4j9WbItNQtxW/b4JIArBSCRXQg/BoCtN
	42dzAi0IZI4AUDbtM6hFJ3PoYL7rs4/MurPcwOrSgb2y0VVfrn+6q01GoI/gqNHaox5ubu
	94vqGUyQKGNkkO84XgdO2EP/JYL7VsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in
 nvmet_setup_auth()
Message-ID: <aeNuNq8diftLnhUs@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <20260303190350.78705-4-thorsten.blum@linux.dev>
 <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDDA242102B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 08:19:59AM +0100, Hannes Reinecke wrote:
> On 3/3/26 20:03, Thorsten Blum wrote:
> > When debug logging is enabled, nvmet_setup_auth() logs the host and
> > controller DHCHAP key bytes. Remove the keys from debug logs to avoid
> > exposing key material.
> > 
> > Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/nvme/target/auth.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 2eadeb7e06f2..f24add0bb86f 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
> >   		ctrl->host_key = NULL;
> >   		goto out_free_hash;
> >   	}
> > -	pr_debug("%s: using hash %s key %*ph\n", __func__,
> > +	pr_debug("%s: using hash %s\n", __func__,
> >   		 ctrl->host_key->hash > 0 ?
> > -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
> > -		 (int)ctrl->host_key->len, ctrl->host_key->key);
> > +		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
> >   	nvme_auth_free_key(ctrl->ctrl_key);
> >   	if (!host->dhchap_ctrl_secret) {
> > @@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
> >   		ctrl->ctrl_key = NULL;
> >   		goto out_free_hash;
> >   	}
> > -	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> > +	pr_debug("%s: using ctrl hash %s\n", __func__,
> >   		 ctrl->ctrl_key->hash > 0 ?
> > -		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> > -		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> > +		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
> >   out_free_hash:
> >   	if (ret) {
> 
> Without the key the pr_debug calls are pretty much pointless anyway,
> so you might want to remove them, too.
> 
> However, these debug prints really help when trying to figure out
> authentication failures.
> I think it would be better to add a compile-time option to disable
> these outputs entirely.
> 
> I'll send a patch.

Did you ever send a patch? I couldn't find anything.  The code hasn't
changed either and the keys are still logged (same for patch 3/3).

Thanks,
Thorsten

