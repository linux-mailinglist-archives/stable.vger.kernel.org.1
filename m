Return-Path: <stable+bounces-240531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD2YBHhv6mmLzQIAu9opvQ
	(envelope-from <stable+bounces-240531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:14:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F114568B8
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 358EB3015536
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81A39446F;
	Thu, 23 Apr 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejy65fdy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1E394497;
	Thu, 23 Apr 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971529; cv=none; b=rTNBa4TRjBGfVG1osRD08/xRNQEvBdMj/y7pFKkr8eDYmt2HVEIXAhA+hBOmOSzRxxdiFwVQIsPGCN17bSesTsbogkMuleHBBpJt7SKwOCRd/ULGua4Vs1DaHGcjwfiPIEduUyq1q0nLAbCTLtSTnHqC9/GyxsgfzBalGadyTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971529; c=relaxed/simple;
	bh=UXHO2phP3ywPOh3DuHnUdXlBpIeOsRgfc8XdmS6LbrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMNi154BvG4+H73hFoJ/M5+HEh7CkZ53xI6tbhesjOo8QKkiW07Qoe5s0hK8ypRiH7LyMEmHYtA2mrXCtTnTI2MdzDEBZaeJQVtLu6b0PH794dGrUiqkrUaFoz2FSM5LqlNFpe1HzfdV8VZsBv8/yufvicFvSAYTTRC3lxVddLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejy65fdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A128C2BCAF;
	Thu, 23 Apr 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971529;
	bh=UXHO2phP3ywPOh3DuHnUdXlBpIeOsRgfc8XdmS6LbrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ejy65fdynVsDMFv7GNvWRCXCiQSi1wSam2V9MEvD1ivgq2/i9+oDp7evaufaIaqgv
	 oyrd2Buc4v/WKCC+/i7OT1ISE+Pf/oskXMM5cyOcxosErCMdgsicuOdh9PEk7XuFCr
	 mAB8tvktkCxD4cjzBwN1fNSmIN+dsWYS924cZtQFGWjm0Psxp/vEccpw/7PK5R5MPC
	 /UH9tj1cfYN3RcntB7IC8kbNOyGVQsgCOa2mqpcM7hA3ZRYqZhV41XjAEshc5kHwFa
	 5+fIXttg2JrG7cr+302EZhFk7vMNEuv4MgfF1rnY4MaocMv7Led3wsdUJXPxNnrAPR
	 tKCQmziTHqJ+w==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.bommarito@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com,
	fercerpav@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/6] net/ncsi: bound filter table state to software limits
Date: Thu, 23 Apr 2026 12:12:07 -0700
Message-ID: <20260423191207.3296449-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-3-michael.bommarito@gmail.com>
References: <20260422160342.1975093-3-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mendozajonas.com,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240531-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12F114568B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/ncsi: bound filter table state to software limits

The NCSI filter state uses single-word bitmaps for both MAC and VLAN
entries, but Get Capabilities and Get Parameters responses can still
feed larger counts into that state. This patch caps the stored table
sizes to the bitmap width to prevent out-of-bounds accesses.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 1fe061ede26dd..47ddf2bbb13bb 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
[ ... ]
> @@ -819,6 +829,12 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
>  	nc->caps[NCSI_CAP_VLAN].cap = rsp->vlan_mode &
>  				      NCSI_CAP_VLAN_MASK;
>  
> +	vlan_cnt = min_t(unsigned int, rsp->vlan_cnt, NCSI_FILTER_BITS);
> +	if (vlan_cnt != rsp->vlan_cnt)
> +		netdev_warn(ndp->ndev.dev,
> +			    "NCSI: VLAN filter count %u exceeds software limit %u\n",
> +			    rsp->vlan_cnt, (unsigned int)NCSI_FILTER_BITS);
> +
>  	size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;
>  	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
>  	if (!nc->mac_filter.addrs)
> @@ -827,7 +843,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
>  	nc->mac_filter.n_mc = rsp->mc_cnt;
>  	nc->mac_filter.n_mixed = rsp->mixed_cnt;
>  
> -	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
> +	nc->vlan_filter.vids = kcalloc(vlan_cnt,
>  				       sizeof(*nc->vlan_filter.vids),
>  				       GFP_ATOMIC);
>  	if (!nc->vlan_filter.vids)
> @@ -836,7 +852,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
>  	 * configuration state
>  	 */
>  	nc->vlan_filter.bitmap = U64_MAX;
> -	nc->vlan_filter.n_vids = rsp->vlan_cnt;
> +	nc->vlan_filter.n_vids = vlan_cnt;

[ ... ]

> @@ -862,6 +881,15 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	if (!nc)
>  		return -ENODEV;
>  
> +	ncmf = &nc->mac_filter;
> +	ncvf = &nc->vlan_filter;
> +	mac_cnt = min_t(unsigned int, rsp->mac_cnt, NCSI_FILTER_BITS);
> +	mac_nbits = ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed;
> +	vlan_cnt = min_t(unsigned int, rsp->vlan_cnt, ncvf->n_vids);
> +
> +	if (rsp->mac_cnt > mac_nbits || rsp->vlan_cnt > ncvf->n_vids)
> +		return -ERANGE;

Because nc->vlan_filter.n_vids is capped to 64 in the GC response handler,
could this check entirely reject GP responses from compliant hardware that
supports and reports more than 64 VLAN filters?

>  	/* Modes with explicit enabled indications */
>  	if (ntohl(rsp->valid_modes) & 0x1) {	/* BC filter mode */
[ ... ]
> @@ -887,11 +915,11 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	/* MAC addresses filter table */
>  	pdata = (unsigned char *)rsp + 48;
>  	enable = rsp->mac_enable;
> -	ncmf = &nc->mac_filter;
>  	spin_lock_irqsave(&nc->lock, flags);
>  	bitmap = &ncmf->bitmap;
> -	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
> -		if (!(enable & (0x1 << i)))
> +	for (i = 0; i < mac_cnt; i++, pdata += 6) {
> +		if (!ncsi_filter_is_enabled(enable, i,
> +					    BITS_PER_TYPE(rsp->mac_enable)))
>  			clear_bit(i, bitmap);
>  		else
>  			set_bit(i, bitmap);

If the device reports a MAC count greater than 64 but still within the
software limit of mac_nbits, this loop will terminate at 64 due to the
mac_cnt cap.

Will this cause pdata to be advanced by only 384 bytes instead of the
actual size of the MAC array in the packet?

> @@ -902,11 +930,11 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  
>  	/* VLAN filter table */
>  	enable = ntohs(rsp->vlan_enable);
> -	ncvf = &nc->vlan_filter;
>  	bitmap = &ncvf->bitmap;
>  	spin_lock_irqsave(&nc->lock, flags);
> -	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
> -		if (!(enable & (0x1 << i)))
> +	for (i = 0; i < vlan_cnt; i++, pdata += 2) {
> +		if (!ncsi_filter_is_enabled(enable, i,
> +					    BITS_PER_TYPE(rsp->vlan_enable)))

If pdata is not advanced past all MAC addresses from the payload, does this
cause the VLAN filter loop to misinterpret the remaining MAC address bytes
as VLAN tags?


While reviewing this patch, I noticed a few pre-existing regressions in the
surrounding codebase that might be worth looking into.

In ncsi_unregister_dev(), the subsystem frees all packages and channels by
iterating and calling ncsi_remove_package(), and then calls
disable_work_sync(&ndp->work). If ncsi_dev_work is executing concurrently,
could it dereference ndp->active_package and ndp->active_channel after they
have been freed?

Also in ncsi_unregister_dev(), ndp is freed using kfree(), but it doesn't
appear to iterate over ndp->requests to cancel their associated timers via
del_timer_sync(). If a pending NCSI request times out after the device is
unregistered, could the timer callback dereference the freed ndp pointer?

Finally, ncsi_remove_package() and ncsi_remove_channel() unlink objects
using list_del_rcu(), but seem to immediately free the objects using kfree()
instead of kfree_rcu() or synchronize_rcu(). Could concurrent readers
traversing these lists under rcu_read_lock() access freed memory?

