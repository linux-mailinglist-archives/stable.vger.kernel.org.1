Return-Path: <stable+bounces-247714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLpRJBAQB2qirAIAu9opvQ
	(envelope-from <stable+bounces-247714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:22:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760954F637
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 838C9319ADF8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1DD47ECDB;
	Fri, 15 May 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="esvo7jJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mshSwpLj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805037BE98
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846243; cv=none; b=H6fLpaKPMdWBVW201VMvk6KDp3xxPqVfnivGnO2GagTbVCT26l5qndfs8n6HNmAw5yRJeTisGKlqaF1+0wsJKnJ2jK0n3uMRF61qNHqgVeWrupGLgbccCfGm1avIDLoG7WK7l5BcC4Gzm/v232gHnd9ryzf5s4F8MQwwDDCQ+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846243; c=relaxed/simple;
	bh=3suDRmqNdfr744LDzrg/c05qFQkOng9a+k3e1elmJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEtZkjG3li7JCbVaPDCttOYudz2JJiW+VqItRTPjXxCVgms+pYaDc/FFW16cqJ+h/RERskR9moa7jTbGRjTvZbWTJe9xJ52fZaYVROnod2dVi53gB3vA5Eiu2idJncpaDN1Z9iQn4qO/UbYSlei+hgvwA3uUnNiAlYK5HbzyHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=esvo7jJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mshSwpLj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43E451400108;
	Fri, 15 May 2026 07:57:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 07:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778846241;
	 x=1778932641; bh=EiSap4plJUpUq1eNZDj08eIiMZtV5onfuWR7wBIRCcM=; b=
	esvo7jJsmf3kdYlkQVVKafNmXNDX97GFETjEOPgeQkKxNdXjENd+cxu4G2MCz+QI
	/aDBVpY1kWoTCkBfna4GSAkAk/9ANyhuz/HNu8U2t5OSddjdmFe0dkIaC1rmyrMf
	A+VA6b80c4WFz0lDEJxtbRB8xJMYzDi9DbBb7vThjUWst18UJI/N+Kar3U16Ok2W
	aTCA0jkP/C/hAjjWVa6un6x+PmgbRZtIr5sj6viwQAWgVuVqrPldF7JsOujNjdi5
	bCb5Lcg2jj8Y06gG8MlWVfCgLsmJ2NiNO3QFiFMtUxM1/ZBzLPpjWSOumVFpJqGi
	q2zXj5BuPK+yYpTMPeiV3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778846241; x=
	1778932641; bh=EiSap4plJUpUq1eNZDj08eIiMZtV5onfuWR7wBIRCcM=; b=m
	shSwpLjpLIxBlkWNMrf64kD5hX54ROOsVuJJlh/Cp1sl3N1SH3HqMaTTUe1H2ZZF
	rxwHZnVMkCK9I6rHyBuX1xSKdTUP4GwHJ1KYFMuCXQaWTnBcaaLPiEVDye2W+Bcq
	rMS4WJZu3Rt/1XcXZU9TV8eULiqgd8zOboXJ7S0XPaCFVxK+GjLGEIvuGbwqy0mJ
	ZmTroxDGUDAjRkTRUQQNZoxz41XGSlL2fNgLE46Vg1AAED/EdWxElbd1WOLNe+il
	TbC2TIWkHxzI+D8OhCXxZomatEVF/C5O+XnOReM4YCUPCtVJtiWOsSMASI8512kY
	gZ76Jsaq2QCgo6IzcAIZw==
X-ME-Sender: <xms:IAoHaruYCuFQQZShmq0Nap1mqCWDqsa60oYDaFkCEld_Qzh5Ai2EGQ>
    <xme:IAoHalx5DDGLKkGWNRbA4lTFKj9eTHvzzq2NwbS-wLrUMRpBS9yX0jZcldvxMsR8Q
    RwYTI9Wbt-dHXu6GqoEwvRwKSq9s0dlbXtNqX_PS99Dc5XAcr8YJQ>
X-ME-Received: <xmr:IAoHamAjnibmIsIPkRT6qAV_FtYyocqqgJF8MYx5jqX7r7twahMEyIjfy6TegNram0ytsS2TVkWPFN6DNcEcb8mk04OFZfkEkZcC8McSZcNWWlh6fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    fhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprg
    hlihesuggunhdrtghomhdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdr
    uggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IAoHarduzfAsUC7Mb-hvTL3mVEwpsQvhEnLoJJ0juw77u9Ca9_gH7A>
    <xmx:IAoHaokErel-Ixq03HMTrHkdoF2nU7iMK44q1NENq0vdf-maODfjiA>
    <xmx:IAoHaqEI2OvnjMWFTUzeUexAn8cVPzB76FLt_9Qcj8LTuj02FLKLVw>
    <xmx:IAoHao4ubAARYgVXMzDSSDWNtUATrd-pU6FMmaTUsntx652ufBsgsQ>
    <xmx:IQoHamNt6xUT9f8tFPMevyl2esvDxOxA1Qs3ufJ8rRFrP2Vr0ALpp2MW>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 07:57:20 -0400 (EDT)
Message-ID: <f5ce0e4e-bd77-49f7-82eb-7429242e3c12@bsbernd.com>
Date: Fri, 15 May 2026 13:57:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] fuse: fix race between ring creation and
 connection abortion
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, ali@ddn.com, horst@birthelmer.de,
 stable@vger.kernel.org
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
 <20260515045541.1171335-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260515045541.1171335-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0760954F637
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,bsbernd.com:email,bsbernd.com:mid,bsbernd.com:dkim]
X-Rspamd-Action: no action



On 5/15/26 06:55, Joanne Koong wrote:
> This fixes this race:
> - thread a: fuse_uring_cmd() gets called, passes fch->connected check
>   (connection abortion not yet triggered)
> - thread b: abort is called, calls fuse_uring_abort(),
> fuse_uring_abort() is a no-op since ring == NULL right now
> - thread a: creates ring, creates queue, creates entry
> 
> which results in
> - leaked ring, queue, ent
> - if thread a increments queue_refs before thread b calls
>   fuse_chan_wait_aborted(), then fuse_chan_wait_aborted() calls
>   "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
>   which will hang the abort/unmount thread indefinitely in unkillable
>   state, as nothing will decrement queue_refs or wake stop_waitq.
> 
> Fix this by checking fch->connected under fch->lock in
> fuse_uring_create() before publishing the ring via
> smp_store_release(&fch->ring, ring) under the same lock scope.

We had this discussion before, I still think it is covered by 2nd patch
"fuse: fix race between registration and connection abortion", because

fuse_uring_destruct() is called by delayed_release() in inode.c and that
is only called when there is nothing accessing /dev/fuse anymore.

The follow-up patch also handles ring->queue_refs going to 0.

From my point of view, what this patch really does is to avoid ring and
queue creation overhead when the connection is going down anyway, so
just the commit message is a bit confusing.

> 
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e467b23e6895..cd75f61018ec 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -244,6 +244,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
>  	max_payload_size = max(max_payload_size, fch->max_pages * PAGE_SIZE);
>  
>  	spin_lock(&fch->lock);
> +	if (!fch->connected) {
> +		spin_unlock(&fch->lock);
> +		goto out_err;
> +	}
>  	if (fch->ring) {
>  		/* race, another thread created the ring in the meantime */
>  		spin_unlock(&fch->lock);


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>



