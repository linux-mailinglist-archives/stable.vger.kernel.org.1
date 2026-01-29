Return-Path: <stable+bounces-212780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCNAA2dte2mMEgIAu9opvQ
	(envelope-from <stable+bounces-212780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:23:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C69B0E09
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB64E300603F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43EF28852E;
	Thu, 29 Jan 2026 14:23:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFEE24EF8C;
	Thu, 29 Jan 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696606; cv=none; b=UOqPo79LyOOL7q+DZeL204Txs5S5/wG9fiLEUugXoB/lV7l4cFqG1QB4ywx0eKJbhDX/DBSz+KX5EcYEXOKEK4PH7vdXxWX4gwsORjcUFm+uoaUYAa2hb2z2hcb9t84V5CHs7yzp737IFcH9uBTCa8Qee+tgbXMuLPDhwXMlnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696606; c=relaxed/simple;
	bh=E6wqNSU0UkI5iQOZQElUbcywZ1SCj734wMmqpPu9SKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIY3YxrCtBBTq9867bcIOTstbeYAAFMoA96QDtx/RJorqH2hPx7jXqEfysMg3BnvDg2UMSa2+xaM5E8zL00K1/7MfsdEss9ewO8PMS20alxP67dUiS+eLRrB2pXhBpgN4V0Qi77EiqPs6uoevwM4IegR0IMDeV3RlLoW3tUapa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841CA153B;
	Thu, 29 Jan 2026 06:23:17 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD243F632;
	Thu, 29 Jan 2026 06:23:23 -0800 (PST)
Date: Thu, 29 Jan 2026 14:23:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Reject unsupported hardware configurations
Message-ID: <aXttVVoVUQoIjWG6@J2N7QTR9R3>
References: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212780-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 83C69B0E09
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:11:22PM +0000, Robin Murphy wrote:
> So far we've been fairly lax about accepting both unknown CMN models
> (at least with a warning), and unknown revisions of those which we
> do know, as although things do frequently change between releases,
> typically enough remains the same to be somewhat useful for at least
> some basic bringup checks. However, we also make assumptions of the
> maximum supported sizes and numbers of things in various places, and
> there's no guarantee that something new might not be bigger and lead
> to nasty array overflows. Make sure we only try to run on things that
> actually match our assumptions and so will not risk memory corruption.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7819e05a0dce ("perf/arm-cmn: Revamp model detection")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 2903e01f951f..24fec53ceccc 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
>  			dn->portid_bits = xp->portid_bits;
>  			dn->deviceid_bits = xp->deviceid_bits;
> +			/*
> +			 * Logical IDs are assigned from 0 per node type, so as
> +			 * soon as we one bigger than expected, we can assume
> +			 * there are more than we can cope with.
> +			 */
> +			if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
> +				dev_err(cmn->dev, "Invalid node number: %d\n", dn->logid);
> +				return -ENODEV;

I think "Invalid" is ambiguous (it can read like we're saying the HW is
wrong), and it would be better to say "Unsupported", or something to
that effect, e.g.

	dev_err(cmn->dev, "Node number (%d) larger than supported (%d)\n",
		dn->logid, CMN_MAX_NODES_PER_EVENT)

> +			}
>  
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:
> @@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  		cmn->mesh_x = cmn->num_xps;
>  	cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
>  
> +	if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
> +		dev_err(cmn->dev, "Invalid mesh size: %dx%d\n", cmn->mesh_x, cmn->mesh_y);

Likewise:

	dev_err(cmn->dev, "Mesh size (%%dx%d) larger than supported
		(%d)\n", cmn->mesh_x, cmn->mesh_y, CMN_MAX_DIMENSION);

> +		return -ENODEV;
> +	}
>  	/* 1x1 config plays havoc with XP event encodings */
>  	if (cmn->num_xps == 1)
>  		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");

... or you could align with the wording here.

Aside from the specific wording for the messages, this looks god to me.

Mark.

