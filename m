Return-Path: <stable+bounces-124601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A0A64205
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE831890BA2
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699A42C0B;
	Mon, 17 Mar 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="A3NgsL0w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgpEWZL2"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5984A06;
	Mon, 17 Mar 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194002; cv=none; b=hjUTJLv7QhYpj8WHAvHDWqvgqaTOSVqv8jYUlVSEBM0tmJoNNs+iA43uy/XEBxwY3VVr40+mbQ8EhQDehX0q6o4TnYhRD9vDq8craS6XuOF9MYNFPATz5G1OOEZy1JGkXoYJtEn7yjBrfW38IgyfCHwgiRLcJqcwNgtboI0D3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194002; c=relaxed/simple;
	bh=cu614ic6ctY/kDmWDcv7HI+zCRTGaue3KlmYxdz8D0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+0eYw4F4S1cs0TJkaVZJaSX2hp6hvkBtqnd/a3N6TxHnZPq7R4JvyYvzCC3ywwEQQK9hUc4+36AdJeKXD+LfKdTXMzjqb0nS3bG2bR2hjEdaGIYt+wf8u12D7fSHrY/sJnwYRcAfeMsN9N+fyvOGDafN6TEEpUwB2g2/LVGuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=A3NgsL0w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgpEWZL2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F7221382CBA;
	Mon, 17 Mar 2025 02:46:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742193999; x=1742280399; bh=cJvVtHvGQT
	aqrITvkYcidpyChiVAHX0MBW0nE1HQiZY=; b=A3NgsL0wXcyqcVWoahwXFU86Ik
	i5FFMV2dWvVnyxxoax4doo+y4PU9Oc2XcvF8X3sr3o2KJ/jghCFrzTpHJnz1VBfX
	bQIVWYz/ansYqzc1gy2w7Ei/H7kEkfuQs6JoDpS4demSviSGg4ty+YfpmS0HcOb7
	XXF8wZo3vdWx1d9LMJTRGcYpRJWtt+JxwG8+MxNKpVHFin5eG1t/yobqswYzMzCD
	XL0OIyOq/n7HklxQMuYoSb2PM32tAxWRaDR1ot1Qzi3LxhOYX25bgS4Py/chPJsN
	1vm3poKVeVMciqPrJ+eoJDRe/gdMSb9nSlrNAMQt54fEFCD5qkilXp5G8w2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742193999; x=1742280399; bh=cJvVtHvGQTaqrITvkYcidpyChiVAHX0MBW0
	nE1HQiZY=; b=LgpEWZL2OI5hl8HKfDe91iqnZtImX7d6kF+4Q1Feng4q4XiH4Jm
	d6USFYvpuHutTN7vFSw0Kvx/kosSYHbqybOwfoNK/THXyhirvt5dc+mq1N6oC6yj
	l9Y96LXrGp3a7yb/b5db03+rDRxHkGTIkD7RxEmBE8SDdENnUZJML1J+XArqT03j
	KmtmRDMVzJ3+zkcLAtpohR7jOgk7GD1Rr5VyVb2OX5knu1InGZatUmVKbB7ifUZH
	JsIcrFCy9xTwSoLHYenHBpdzlRxZW+rIbBFX/3eoI0oIFDTOYw5IMJRy7f3Tnegf
	4LKMipd4QN9s0Zr3XGmUyem8rZbuM4REnkQ==
X-ME-Sender: <xms:TsXXZ16bBQO7TXqdUPk_FhB6BFzNLPy8flX6jO0aKWzKC0ZF6Ia2kw>
    <xme:TsXXZy63l1n8XQQ8PtYIlD8mZqxqadFSTZlBOqVGCs_RoLgJvMQGX6Q5AfAd7qYA5
    S9uIUNlHVi5HA>
X-ME-Received: <xmr:TsXXZ8eq9C2zooKPSid7DiJl21LT3hwvdQMvwatc5ABWu2lR2ZhaP7lu80Hu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeu
    fefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepqhhuihgtpghstghhohifughhuhesqhhuihgtih
    hntgdrtghomhdprhgtphhtthhopehmrghthhhivghurdhpohhirhhivghrsehlihhnrghr
    ohdrohhrghdprhgtphhtthhopegrnhguvghrshhsohhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhrvghmohhtvghprhhotgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TsXXZ-Ls8qilsEKTOpPO2gEeLQrAngxlgvVHCeNc3vBlLvYZKiUxDg>
    <xmx:TsXXZ5Ks3cgDKB1H5qPpPbAgYnIqcjxRtiiFSN2oFFFiGFiqvB6AMw>
    <xmx:TsXXZ3xC7OJDwdV8yWC0uDZUr4g-EKmBBXYRzFgJseSndih5BNvVIw>
    <xmx:TsXXZ1JIQSf0HODoBS8Ym6GlxMA--wigbrqPeO5qsOzwKRMmnhbHYQ>
    <xmx:T8XXZzAB-KUPfZ6oB_UZGZ6Ff2kYxjJqUg4AHpL3EZOeipp7nMMt0S4->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 02:46:38 -0400 (EDT)
Date: Mon, 17 Mar 2025 07:45:18 +0100
From: Greg KH <greg@kroah.com>
To: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] remoteproc: Add device awake calls in rproc boot and
 shutdown path
Message-ID: <2025031704-awry-subsoil-2e4c@gregkh>
References: <20250317063803.1361829-1-quic_schowdhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317063803.1361829-1-quic_schowdhu@quicinc.com>

On Mon, Mar 17, 2025 at 12:08:03PM +0530, Souradeep Chowdhury wrote:
> Add device awake calls in case of rproc boot and rproc shutdown path.
> Currently, device awake call is only present in the recovery path
> of remoteproc. If a user stops and starts rproc by using the sysfs
> interface, then on pm suspension the firmware loading fails. Keep the
> device awake in such a case just like it is done for the recovery path.
> 
> Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c2cf0d277729..908a7b8f6c7e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
>  		pr_err("invalid rproc handle\n");
>  		return -EINVAL;
>  	}
> -
> +
> +	pm_stay_awake(rproc->dev.parent);
>  	dev = &rproc->dev;
>  
>  	ret = mutex_lock_interruptible(&rproc->lock);
> @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
>  		atomic_dec(&rproc->power);
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rproc_boot);
> @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
>  	struct device *dev = &rproc->dev;
>  	int ret = 0;
>  
> +	pm_stay_awake(rproc->dev.parent);
>  	ret = mutex_lock_interruptible(&rproc->lock);
>  	if (ret) {
>  		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
>  	rproc->table_ptr = NULL;
>  out:
>  	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rproc_shutdown);
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

