Return-Path: <stable+bounces-226901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DBPCpW4uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:24:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D22B2397
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F35A306F786
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DCA385534;
	Tue, 17 Mar 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="N0oQ22Ta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w6MjLQ/d"
X-Original-To: stable@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF49377003;
	Tue, 17 Mar 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778793; cv=none; b=pSBjeHiaIGZHnDc727NbRLpiwga8tObTAwXJ2pRxEQjPtwvNv8+U6hNi4beLmKa9THWLnHT5jiaNRQowUL0+wIqBV+3PCKeg8Qc5KacI3wGsXLuMuMtF/aFwZ0BJKm7eLbyhyJa4FLdeDipeKH4/hltUdmUl5JMaeHRmanOhOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778793; c=relaxed/simple;
	bh=YTq/fhrN5zvUM7mthDq79gdL3Cyeu2VTyFy/sbZo82U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzP00q6/dRVJwVFQeD8JpaQERFgBnMom+AxU2xcyvJvSmfgt2ApStY1xuiLTkWNJLQtacsyAYjcGFpeHEQeiivlL/2hA+fZztuDDHpWCp+I3LYiYtlQR4/AFsq514kL9h9wgR7P9cyDi261/qp10jfQuL8Iy0FEF+OuXXLFPBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=N0oQ22Ta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w6MjLQ/d; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 35CFA1D00124;
	Tue, 17 Mar 2026 16:19:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 16:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773778790;
	 x=1773865190; bh=BoBUFs8Ekjl8ivKjmqitPFNqrE1lGYES5mYOtWwJ3SQ=; b=
	N0oQ22TaxzGiwglhMBOfl9IdP1gFL/d6njELM+OAyf2qG3B/qwaTUWRmLTd31m3B
	me8Tx9/QsTmsSXo/yxc5rvj3jykuGB5eHRWBEn8WD2m3zoDzSXOtSFKS1i85Zvpj
	j+zm4Fq+QpjKFxmgOle+VALyZ0o9McTW0AJQ46eoyeOaDslQLJ7QX1vFFGpkOp3t
	NHGVOYncvSchCLqOyb4+ljcVQi65nPnN5fCtvtILCTmS/1EQDyMBKSUn6eaglDHp
	M5zgGYyVN2VMl/5pjYYJ7qvU5LuY2UY7GIRoFG0D8cI2iHEX06BtPvOvT/E8XjU3
	4LypdKoLiYpf6BSushdcLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773778790; x=
	1773865190; bh=BoBUFs8Ekjl8ivKjmqitPFNqrE1lGYES5mYOtWwJ3SQ=; b=w
	6MjLQ/dBuWhqsSd2j7aP/ZkLptD9KI/2ZvF3xZAlcH19asdcLt6RWWsTZ5mWQaR1
	MQv9v3z0ViOVsDGPby9WCSIgmt58UxDrVJoqm9YpmxWB5e2JN5Jl7xkBd2y9Mhtz
	4gUCa8gC47eO7UG2wfrM+LDSZXzNElZOjV6FEBwYMzg+r3Hl4PJf7kDDbqfMpr10
	6eICfIaigvZiQsgN79n0030qJWVBUyvtipgct3WHSGDJhZIvBW6cZJqFaoF+GcJw
	lNm0MDg3STkklErDRndOllawIR/8iW7wQr1DA3Un06lF+qbPq8PIhZO+lbMYODZF
	3IeIUjozajI4tp7rMPlnw==
X-ME-Sender: <xms:Zre5aYEETIPZbcte9tCAloNHhXRN5hAHZkRbIYciHnjJTNZDPqHBQA>
    <xme:Zre5aZFUICEdMDOTf7naDlGvVXFlIaKUxRgIiE8hL7sSDCyZism_vytMFb_8vW7qj
    h4ZmSGwGyVihwwhHak8-sHX9iGSunpBlCiM_vPIhegRMXVzJ7ORTQ>
X-ME-Received: <xmr:Zre5aVPDy0RlEy0ziJMbSQEMWhtqjQJ3hdHxXO_TCElfHmZNOFMqTZuvUEMPRekQRmFMeH5QcKjY0gwKQso2n8Ot9-vUj0aIB3Ez8iccTlf7sIRU4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zre5aYE9VHG-nI4PXjlLbxn9UHX3snQ5zD5TUcrRN1WCWkl4nZwtSQ>
    <xmx:Zre5acMf3-4Bi84GmMnM86b-CR7-neB0KrY3f9Fatx8g3uNy47Z3RA>
    <xmx:Zre5aZ94fPAtf1c2vWJzR0Du3evAmBGtggDUSwWHZzhvVMfkaT7lGA>
    <xmx:Zre5aYRD3LuN2K8n7dg8j1lSwL3TaVXQBMuvVHpcPxPZ4gT-dO6zwg>
    <xmx:Zre5aVrrA4eme5JRfE4GNvmfN2JUajloB7mriEjGYPzckNG6XegimPOI>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 16:19:50 -0400 (EDT)
Message-ID: <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
Date: Tue, 17 Mar 2026 21:19:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-2-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260316165320.3245526-2-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226901-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid]
X-Rspamd-Queue-Id: 7F9D22B2397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/26 17:53, Miklos Szeredi wrote:
> When sync init is used and the server exits for some reason (error, crash)
> while processing FUSE_INIT, the filesystem creation will hang.  The reason
> is that while all other threads will exit, the mounting thread (or process)
> will keep the device fd open, which will prevent an abort from happening.
> 
> This is a regression from the async mount case, where the mount was done
> first, and the FUSE_INIT processing afterwards, in which case there's no
> such recursive syscall keeping the fd open.
> 
> Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c    | 6 +++++-
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c16b94357d5..f0631c48abef 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
>  			removed = fuse_remove_pending_req(req, &fiq->lock);
>  		if (removed)
>  			return;
> +
> +		if (req->args->abort_on_kill)
> +			fuse_abort_conn(fc);
>  	}
>  
>  	/*
> @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
>  			fuse_force_creds(req);
>  
>  		__set_bit(FR_WAITING, &req->flags);
> -		__set_bit(FR_FORCE, &req->flags);
> +		if (!args->abort_on_kill)
> +			__set_bit(FR_FORCE, &req->flags);
>  	} else {
>  		WARN_ON(args->nocreds);
>  		req = fuse_get_req(idmap, fm, false);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..23a241f18623 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -345,6 +345,7 @@ struct fuse_args {
>  	bool is_ext:1;
>  	bool is_pinned:1;
>  	bool invalidate_vmap:1;
> +	bool abort_on_kill:1;
>  	struct fuse_in_arg in_args[4];
>  	struct fuse_arg out_args[2];
>  	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..84f78fb89d35 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
>  	int err;
>  
>  	if (fm->fc->sync_init) {
> +		ia->args.abort_on_kill = true;
>  		err = fuse_simple_request(fm, &ia->args);
>  		/* Ignore size of init reply */
>  		if (err > 0)


I haven't looked at the other patches yet, so basically the mount can be
aborted with ctrl-c, but no self abort in this patch yet.
Maybe worth to add to the commit message?

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

