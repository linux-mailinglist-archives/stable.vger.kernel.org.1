Return-Path: <stable+bounces-262758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D28GDzfVKmoXxwMAu9opvQ
	(envelope-from <stable+bounces-262758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:33:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A8673180
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HbvcFqpJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262758-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262758-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37352301062E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF77425CCE;
	Thu, 11 Jun 2026 15:33:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1B421EF4;
	Thu, 11 Jun 2026 15:33:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191986; cv=none; b=EpQMy3AXlxSalCUoqR/LJVtzZ6bl74K1YihroGjoVZzm0t0SzULbOEQmj9WLE+EIh+ZhPKwhSHGnvMZ3CgJfBxkMOyGdakfqc47i50GI6H698VpxpKiJ2E/3ZpQ/vrUkYWvyH9QEndvZDtjYgCV8HNAZ8P63llI644FjLf4M2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191986; c=relaxed/simple;
	bh=7/YFbY3zowh1b4sKJyknvz851OqdJ/w6QrAkwX9nCMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEhWAXUn3jfsLOo20R4FSgqnFAG9L5AVyhJvkPpgCIU5VnBmcrVach9qxEJltj6vNqj4+QX41VCG79XpJEpxz7gRnEyq3Kr4uA1100i9bT61l9SRDvEIc7blQe6TPwZZXpqMucY5EFEre/SFXnJ+GwTx5xk5IgBbntakE+J320c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbvcFqpJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C171F1F00893;
	Thu, 11 Jun 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191981;
	bh=FWR4YQsKWyjiXkMJgVoUFcd5HDuSNQC8Of5ssdgCtSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HbvcFqpJ/xMq4GgdTJTSBJ3xs6f8/Rb2i7rsJ5OofAoKunbLTuYk7EdGcRaQo3jBZ
	 J6lXDai7CWhZfla9S8fD/LUzXr8BkbaijfCjn4eGq/Zobc+AqHWlYJkzAJ7XE1YUFo
	 ujzsvrizFZbyMrX3/N+gAV5fiNdvweplcQtJuEi9nAaduk2f6ptet05V9Oz7zryXv2
	 pJ/3uKAPxNqrcMCMoV0YmDqG5Ie9O6hOfAT2D/WxVZHfjAokQUTSh0qXGkATcYOHam
	 7CkyBTHGGww/HVmRm4SrsxPbRyQAaUnv8hoYlWP/CpgphwtadF/U++BxAUvucOae2p
	 BD24yvSks350g==
Date: Thu, 11 Jun 2026 16:32:56 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ariele@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] bnx2x: fix resource leaks in bnx2x_init_one() error
 paths
Message-ID: <20260611153256.GU3920875@horms.kernel.org>
References: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262758-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:lihaoxiang@isrc.iscas.ac.cn,m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ariele@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,horms.kernel.org:mid,sashiko.dev:url,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C14A8673180

On Tue, Jun 09, 2026 at 03:46:10PM +0800, Haoxiang Li wrote:
> bnx2x_init_one() falls through to the common memory cleanup path for
> several failures after probe has already acquired additional resources.
> 
> If register_netdev() fails after bnx2x_set_int_mode(), MSI/MSI-X remains
> enabled. If later failures happen after bnx2x_iov_init_one(), PF SR-IOV
> state can be left allocated. Also, failures after bnx2x_vfpf_acquire()
> must release the PF resources before freeing the VF-PF mailbox allocated
> by bnx2x_vf_pci_alloc().
> 
> Add error labels matching the resource acquisition order so probe failure
> disables MSI/MSI-X, removes SR-IOV state, releases VF-PF resources,
> deallocates VF PCI resources, and then frees the common driver memory.
> Also clear PCI drvdata before freeing the netdev on probe failure.
> 
> Fixes: 6411280ac94d ("bnx2x: Segregate SR-IOV code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
>  - Unwind all resources acquired by bnx2x_init_one() on failure
>  - Clear PCI drvdata before freeing the netdev on probe failure.
>  - Modify the commit title and message.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch available on sashiko.dev.
However, I believe the issue flagged there can be looked at in the context
of possible follow-up and should not impede the progress of this patch.


