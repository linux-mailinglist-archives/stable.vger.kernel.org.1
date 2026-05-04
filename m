Return-Path: <stable+bounces-242971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKFO6Ru+GnPuQIAu9opvQ
	(envelope-from <stable+bounces-242971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:02:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 473834BB5F3
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBF93010521
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533038C2A4;
	Mon,  4 May 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nhTUC+QI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rT3hhMZ+"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445337C909
	for <stable@vger.kernel.org>; Mon,  4 May 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888709; cv=none; b=iUJRu+PM753qu+NYDrQPJIMVPwozPHa8R22MwwuhXDceB2ir33AhjoyeNJNnwF6CM9wZ6ru/YEJGlicIBzZPRWATXsTtOph37WYqZKBot3x6f0DgGnHN+yk55QCLw7IAf2ukxqelZbZQvaguk2ZBO2F60c1dX9Gi0zflPXRVXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888709; c=relaxed/simple;
	bh=NWP+12qWK8xYm8x1ye9eTVdykzYyibAxT+S9M5D9o1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2QriArroe85b6C3BsLLskdfNRCUBVfSILtHgPag1dWyu7foYOmvswNBBtdhFdCV+/tGYW8qTpwqSa8dI4TR/5PdNSOGcg6p4MEb/vzdz4O8VCmavDPnBfuEVycx/pc2nJ/frngPlXOSBG3psWETQL3hnlAMbCzXaWtSXnGdIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nhTUC+QI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rT3hhMZ+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E75FC1D000AA;
	Mon,  4 May 2026 05:58:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 04 May 2026 05:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777888706;
	 x=1777975106; bh=yYlB/RjvfILny8j9UjxW9N/Z5MBpqLhpYgnXop7vZMI=; b=
	nhTUC+QIbb9G8j7WMih1Q2l9GsD4yOZRHpHjJzM84buNDrU3n36GLMt+okM9X5Uy
	v8To+GQw2KuNcaV7ZC5dsILOCOzn0Lkr6a3SYxDfnvN9tQ7VLnDgCeOPzL2UJe00
	ixmN0fWUiujx1BssHT/VkCxQ5fVScpguXDVYepK2t+yau8XfHLa6D4e0RJJSmkB4
	8n4RIka7lUq18UXhst5C6OkIC2XlX4HA70HDBBq5i81yezsZcemodxCMD9MnDSXn
	6VCqH/btBQrGbqtLqh0xN/x3086vscig8g5jB5aOzv+uRYTU+R6MibmPbMS660pD
	PGXpWI5kuXVemTAIIhGW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777888706; x=
	1777975106; bh=yYlB/RjvfILny8j9UjxW9N/Z5MBpqLhpYgnXop7vZMI=; b=r
	T3hhMZ+Z9bjUT2ksc0GwolYLHx1ENdXDwpdSp9ebCH41Y3EUMIL/nm3JBBbnpWIG
	FruGE3BV7IWCt3nfsAN6dS0El6HPmF2vB7xPfyl1fNoxniMYmwTTod7WD7rfnVhl
	9biuuXLnpP26QW52jmBeyzZq/4gsELJs6IOrcdjacWMjsKjyGQBwjQeJ8mwHdZSM
	8XZx1rAxfoJzpGW5ApHJhsYrFlqRP5bA9SMt/7GYfUBlsDjd8OGXHPkqgEU2Gwmx
	5e07bgMSWJtAMkMgYl7jXog2/2zCsx9BC2qS2W9aMyLP6OvYnM6OAOboUiHb8mVP
	6NqUFviT8OA+ktiDXtYVg==
X-ME-Sender: <xms:wm34ae83nrdTlh1xyTW0ykdm-kewP5Xbse6slYHHbt1e3Euh6lvTpQ>
    <xme:wm34aRyMZ1f_v2dwrkoElFZTJsaaoXQ8TC9nJwYcj3iDH5zMhczR7SgwQoS02kbcg
    9rMNCy4IulBk-I6a4KdJRSQgoUzVN-Qr7HfiG_IVQorCPGz-A>
X-ME-Received: <xmr:wm34aeqn5QzUG9IlXrtPAalbNtVTpKRtNCSdDfKn5gy8_9NO1_zap5T8bMvwAiBTkrrNu7qJgsegdllteGfXlIPJoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeevveetgf
    evjeffffevleeuhfejfeegueevfeetudejudefudetjedttdehueffnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:wm34aSoyX2M720kzm5LCNqkRTpbo3_H3chKj2d1HZdF6NJ3WPnU7dA>
    <xmx:wm34aeCAEhW5t4bM9Nmgp7ZdcwZRw4PQ6tUQg8bnn61Se6ogtxgeKA>
    <xmx:wm34aQswnGkxTfZkJkHWH_LGoNz2z-eSwgGQP-c2lSzWCDJjhLHKvQ>
    <xmx:wm34adIYSagrJib1mQlbnY4FGFHkGvFhIkwgdW_eUUWPHrbFMlOmsw>
    <xmx:wm34aTNXWecfNgV0kUcykKELCvjvwANJZK7OnwSMv30LiMARiJ4qBmpq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 05:58:26 -0400 (EDT)
Date: Mon, 4 May 2026 11:58:25 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: [PATCH 6.18.y] selftests/landlock: Fix socket file descriptor
 leaks in audit helpers
Message-ID: <2026050420-overfed-obstacle-83f2@gregkh>
References: <2026050112-second-frenzied-c947@gregkh>
 <20260502130541.590744-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502130541.590744-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 473834BB5F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242971-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,digikod.net,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,digikod.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 09:05:41AM -0400, Sasha Levin wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> [ Upstream commit 9143d790337a0d066c2d632c802f69b981e6c23a ]
> 
> audit_init() opens a netlink socket and configures it, but leaks the
> file descriptor if audit_set_status() or setsockopt() fails.  Fix this
> by jumping to an error path that closes the socket before returning.
> 
> Apply the same fix to audit_init_with_exe_filter(), which leaks the file
> descriptor from audit_init() if audit_init_filter_exe() or
> audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
> audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> Link: https://lore.kernel.org/r/20260402192608.1458252-3-mic@digikod.net
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 02fd1393947a7..36a6816b47f13 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -379,19 +379,25 @@ static int audit_init(void)
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	/* Sets a timeout for negative tests. */
>  	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
>  			 sizeof(audit_tv_default));
> -	if (err)
> -		return -errno;
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
>  
>  static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> @@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
>  
>  		filter = &new_filter;
>  		err = audit_init_filter_exe(filter, NULL);
> -		if (err)
> +		if (err) {
> +			close(audit_fd);
>  			return err;
> +		}
>  	}
>  
>  	/* Filters might not be in place. */
> @@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
>  
>  	err = audit_init_filter_exe(filter, NULL);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
> -- 
> 2.53.0
> 
> 

Also does not apply :(

