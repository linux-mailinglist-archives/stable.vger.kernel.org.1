Return-Path: <stable+bounces-245189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBNQKpLNAWrajwEAu9opvQ
	(envelope-from <stable+bounces-245189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C650DFC5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D5D4302861E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9333E2766;
	Mon, 11 May 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQAIdU3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5139183B;
	Mon, 11 May 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502581; cv=none; b=cweNuVjVGxF6923f0kMuot/NyobUXGok1oRgJq1/PhayRe++f/FYaJQfoXFEid+0kDt8WsyRtmytQo6qjrv7aCU5arw4WCmKptpbx5PmjJf+HzN6SHOeqycTYMgQ1lH587H8kXKZATcg8WMk1QY/TJWe/mY+v4BOS/+svm/l+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502581; c=relaxed/simple;
	bh=lXxuQW7T8IjxsecjRbNhRWJBRR7PMMNziLzJLX5aSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqM/Rl+mrP5ITU1jIjjH8fts6lEjAQyOWb1sxYYkCirB7qxZzi5uSenc5xZdNMfY2HX1vP02gae+wAB7htqRrQK5kygHBo/M3xUa96aopsI6m6fM2uAXHETGh8mjwXkTep99qRqLhVDfM5LvM1X80rxLSjd4QXOEawar71QgLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQAIdU3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A09C2BCB0;
	Mon, 11 May 2026 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778502580;
	bh=lXxuQW7T8IjxsecjRbNhRWJBRR7PMMNziLzJLX5aSLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQAIdU3km+kWxiiLubGGIWNUbYtpevlLfbyyYoOubGNDq3i6aPSWVL28lpLEJDARX
	 eJePFiezEecowvkhVsksvIQ6DiAEnGe1Sc/XBg6S6Tub+/ve+KFR0BrHmjaAvjcW30
	 eZIMBEbQLYfNbgUYRzv42ZoaFIStlgXHz0ME++sc=
Date: Mon, 11 May 2026 14:29:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vipoll <vipoll@mainlining.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fsa4480: Add chip id read retry loop
Message-ID: <2026051132-shove-outshine-a5de@gregkh>
References: <20260511122246.31673-1-vipoll@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511122246.31673-1-vipoll@mainlining.org>
X-Rspamd-Queue-Id: 469C650DFC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245189-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mainlining.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:22:46PM +0400, vipoll wrote:
> From: Victor Paul <vipoll@mainlining.org>
> 
> The first read attempt may fail on some devices (e.g. Xiaomi Pad 6)
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Victor Paul <vipoll@mainlining.org>
> ---
>  drivers/usb/typec/mux/fsa4480.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index c54e42c7e6a1..ae496c0fa805 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -256,6 +256,7 @@ static int fsa4480_probe(struct i2c_client *client)
>  	struct typec_switch_desc sw_desc = { };
>  	struct typec_mux_desc mux_desc = { };
>  	struct fsa4480 *fsa;
> +	int retries = 5;

why 5?  Why not 5000?

>  	int val = 0;
>  	int ret;
>  
> @@ -278,7 +279,12 @@ static int fsa4480_probe(struct i2c_client *client)
>  	if (ret && ret != -ENODEV)
>  		return dev_err_probe(dev, ret, "Failed to get regulator\n");
>  
> -	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
> +	do {
> +		ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
> +		if (!ret)
> +			break;
> +		usleep_range(1000, 1200);

Why these hard coded numbers?  And are you sure this is the correct call
for this, I thought there was a "better" one now when you want to sleep
a range of time.

And what is going to make this now "work"?  Is this needed for all calls
to this hardware?

thanks,

greg k-h

